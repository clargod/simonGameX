//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "CCBReader.h"

@implementation MainScene {
    NSMutableArray *movesArray;
    NSMutableArray *playerArray;
    OALSimpleAudio *audio;
    
    CCButton *redButton;
    CCButton *greenButton;
    CCButton *yellowButton;
    CCButton *blueButton;
}

- (id) init {
    self = [super init];
    if (self = [super init]){
        audio = [OALSimpleAudio sharedInstance];
        // [audio playBg:@"Eyes on me.mp3" loop:TRUE];
        NSLog(@"Starting Game......");
        // activate touches on this scene
        self.userInteractionEnabled = TRUE;
        
        CCSpriteFrame *redbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"red_topleft.png"];
        CCSpriteFrame *redbuttonHit = [CCSpriteFrame frameWithImageNamed:@"red_topleft2.png"];
        CCSpriteFrame *greenbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"green_topright.png"];
        CCSpriteFrame *greenbuttonHit = [CCSpriteFrame frameWithImageNamed:@"green_topright2.png"];
        CCSpriteFrame *yellowbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"yellow_bottomleft.png"];
        CCSpriteFrame *yellowbuttonHit = [CCSpriteFrame frameWithImageNamed:@"yellow_bottomleft2.png"];
        CCSpriteFrame *bluebuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright.png"];
        CCSpriteFrame *bluebuttonHit = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright2.png"];
        
        redButton = [CCButton buttonWithTitle:@"red" spriteFrame:redbuttonNotHit highlightedSpriteFrame:redbuttonHit disabledSpriteFrame:nil];
        [redButton setTarget:self selector:@selector(redHit:)];
        redButton.positionType = CCPositionTypeNormalized;
        redButton.anchorPoint = CGPointMake(1, 0);
        redButton.position = ccp(0.5f, 0.5f);
        [self addChild: redButton];
        
        greenButton = [CCButton buttonWithTitle:@"green" spriteFrame:greenbuttonNotHit highlightedSpriteFrame:greenbuttonHit disabledSpriteFrame:nil];
        [greenButton setTarget:self selector:@selector(greenHit:)];
        greenButton.positionType = CCPositionTypeNormalized;
        greenButton.anchorPoint = CGPointMake(0, 0);
        greenButton.position = ccp(0.5f, 0.5f);
        [self addChild: greenButton];
        
        yellowButton = [CCButton buttonWithTitle:@"yellow" spriteFrame:yellowbuttonNotHit highlightedSpriteFrame:yellowbuttonHit disabledSpriteFrame:nil];
        [yellowButton setTarget:self selector:@selector(yellowHit:)];
        yellowButton.positionType = CCPositionTypeNormalized;
        yellowButton.anchorPoint = CGPointMake(1, 1);
        yellowButton.position = ccp(0.5f, 0.5f);
        [self addChild: yellowButton];
        
        blueButton = [CCButton buttonWithTitle:@"blue" spriteFrame:bluebuttonNotHit highlightedSpriteFrame:bluebuttonHit disabledSpriteFrame:nil];
        [blueButton setTarget:self selector:@selector(blueHit:)];
        blueButton.positionType = CCPositionTypeNormalized;
        blueButton.anchorPoint = CGPointMake(0, 1);
        blueButton.position = ccp(0.5f, 0.5f);
        [self addChild: blueButton];
    }
    return self;
}

-(void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    //    movesArray = [[NSMutableArray alloc] init];
    movesArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:2], nil];
    // add delay
    [self scheduleOnce:@selector(startRound) delay:2.0];
}

-(void)startRound {
    [movesArray addObject:[NSNumber numberWithInt:arc4random_uniform(4)]];
   NSLog(@"The current move is: %@", movesArray);
    // Delay time is 1.0 sec
    id delayInterval = [CCActionDelay actionWithDuration:1.0f];
    id button0 = [CCActionCallBlock actionWithBlock:^{
        [audio playEffect:@"button0.wav"];
    }];
    id button1 = [CCActionCallBlock actionWithBlock:^{
        [audio playEffect:@"button1.wav"];
    }];
    id button2 = [CCActionCallBlock actionWithBlock:^{
        [audio playEffect:@"button2.wav"];
    }];
    id button3 = [CCActionCallBlock actionWithBlock:^{
        [audio playEffect:@"button3.wav"];
    }];
    
    NSMutableArray *actionMoves = [[NSMutableArray alloc] init];

    for (NSNumber* value in movesArray){
        if ([value isEqual:@0]){
            [actionMoves addObject:(button0)];
        }
        else if([value isEqual:@1]){
         [actionMoves addObject:(button1)];
        }
        else if(([value isEqual:@2])){
         [actionMoves addObject:(button2)];
        }
        else if([value isEqual:@3]){
         [actionMoves addObject:(button3)];
        }
        [actionMoves addObject:(delayInterval)];
    }
    // [actionMoves addObject:(nil)];
    [self runAction:[CCActionSequence actionWithArray:actionMoves]];
    }

-(void)redHit:(id)sender
{
    NSLog(@"Red is hit");
    // play sound effect
    [audio playEffect:@"button0.wav"];
}

-(void)greenHit:(id)sender
{
    NSLog(@"Green is hit");
    // play sound effect
    [audio playEffect:@"button1.wav"];
}
-(void)yellowHit:(id)sender
{
    NSLog(@"Yellow is hit");
    // play sound effect
    [audio playEffect:@"button2.wav"];
}

-(void)blueHit:(id)sender
{
    NSLog(@"Blue is hit");
    // play sound effect
    [audio playEffect:@"button3.wav"];
}
-(void)doNothing
{
}
@end
