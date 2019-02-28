//
//  GameScene.m
//  tetris
//
//  Created by Richard Zheng on 2/18/19.
//  Copyright © 2019 Richard Zheng. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKSpriteNode *boop;
    int counter;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"Count"];
    
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    [_label setText:[NSString stringWithFormat: @"Score"]];
    counter = 0;
    CGFloat w = (self.size.width + self.size.height) * 0.05;
  
    [boop initWithImageNamed:@"maddenMillion.png"];
  
  
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
    
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:up];
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

-(void)score {
  [_label setText:[NSString stringWithFormat: @"%d", counter]];
  if(counter < 5) counter++;
  else if(counter >= 5 && counter < 10) counter = counter + 5;
  else if(counter >= 10 && counter < 20) counter = counter + 10;
  else if(counter >= 20 && counter < 50) counter = counter + 20;
  else if(counter >= 50 && counter < 100) counter = counter + 50;
  else if(counter >= 100 && counter < 500) counter = counter + 100;
  else if(counter >= 500 && counter < 1000) counter = counter + 500;
  else if(counter >= 1000 && counter < 10000) counter = counter + 1000;
  else if(counter >= 10000 && counter < 100000) counter = counter + 10000;
  else if(counter >= 100000 && counter < 1000000) counter = counter + 100000;
  else counter = counter + 99999999;
}

-(void)swipe:(UISwipeGestureRecognizer *) sender {
  if(sender.direction == UISwipeGestureRecognizerDirectionUp) {
    //
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    [self score];
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
  
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
