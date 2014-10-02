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
    
    CCSprite *redButtonHit;
    CCSprite *greenButtonHit;
    CCSprite *yellowButtonHit;
    CCSprite *blueButtonHit;
}

- (id) init {
    self = [super init];
    if (self = [super init]){
        audio = [OALSimpleAudio sharedInstance];
        // [audio playBg:@"Eyes on me.mp3" loop:TRUE];
        NSLog(@"Starting Game......");
        CCSpriteFrame *redbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"red_topleft.png"];
        CCSpriteFrame *redbuttonHit = [CCSpriteFrame frameWithImageNamed:@"red_topleft2.png"];
        CCSpriteFrame *greenbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"green_topright.png"];
        CCSpriteFrame *greenbuttonHit = [CCSpriteFrame frameWithImageNamed:@"green_topright2.png"];
        CCSpriteFrame *yellowbuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"yellow_bottomleft.png"];
        CCSpriteFrame *yellowbuttonHit = [CCSpriteFrame frameWithImageNamed:@"yellow_bottomleft2.png"];
        CCSpriteFrame *bluebuttonNotHit = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright.png"];
        CCSpriteFrame *bluebuttonHit = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright2.png"];
        
        redButton = [CCButton buttonWithTitle:@"" spriteFrame:redbuttonNotHit highlightedSpriteFrame:redbuttonHit disabledSpriteFrame:nil];
        [redButton setTarget:self selector:@selector(redHit:)];
        redButton.positionType = CCPositionTypeNormalized;
        redButton.anchorPoint = CGPointMake(1, 0);
        redButton.position = ccp(0.5f, 0.5f);
        [self addChild: redButton];
        
        greenButton = [CCButton buttonWithTitle:@"" spriteFrame:greenbuttonNotHit highlightedSpriteFrame:greenbuttonHit disabledSpriteFrame:nil];
        [greenButton setTarget:self selector:@selector(greenHit:)];
        greenButton.positionType = CCPositionTypeNormalized;
        greenButton.anchorPoint = CGPointMake(0, 0);
        greenButton.position = ccp(0.5f, 0.5f);
        [self addChild: greenButton];
        
        yellowButton = [CCButton buttonWithTitle:@"" spriteFrame:yellowbuttonNotHit highlightedSpriteFrame:yellowbuttonHit disabledSpriteFrame:nil];
        [yellowButton setTarget:self selector:@selector(yellowHit:)];
        yellowButton.positionType = CCPositionTypeNormalized;
        yellowButton.anchorPoint = CGPointMake(1, 1);
        yellowButton.position = ccp(0.5f, 0.5f);
        [self addChild: yellowButton];
        
        blueButton = [CCButton buttonWithTitle:@"" spriteFrame:bluebuttonNotHit highlightedSpriteFrame:bluebuttonHit disabledSpriteFrame:nil];
        [blueButton setTarget:self selector:@selector(blueHit:)];
        blueButton.positionType = CCPositionTypeNormalized;
        blueButton.anchorPoint = CGPointMake(0, 1);
        blueButton.position = ccp(0.5f, 0.5f);
        [self addChild: blueButton];
        
        redButtonHit = [[CCSprite alloc] initWithSpriteFrame:redbuttonHit];
        redButtonHit.positionType = CCPositionTypeNormalized;
        redButtonHit.anchorPoint = CGPointMake(1, 0);
        redButtonHit.position = ccp(0.5f, 0.5f);
        [self addChild: redButtonHit];
        [redButtonHit setVisible:NO];
        
        greenButtonHit = [[CCSprite alloc] initWithSpriteFrame:greenbuttonHit];
        greenButtonHit.positionType = CCPositionTypeNormalized;
        greenButtonHit.anchorPoint = CGPointMake(0, 0);
        greenButtonHit.position = ccp(0.5f, 0.5f);
        [self addChild: greenButtonHit];
        [greenButtonHit setVisible:NO];
        
        yellowButtonHit = [[CCSprite alloc] initWithSpriteFrame:yellowbuttonHit];
        yellowButtonHit.positionType = CCPositionTypeNormalized;
        yellowButtonHit.anchorPoint = CGPointMake(1, 1);
        yellowButtonHit.position = ccp(0.5f, 0.5f);
        [self addChild: yellowButtonHit];
        [yellowButtonHit setVisible:NO];
        
        blueButtonHit = [[CCSprite alloc] initWithSpriteFrame:bluebuttonHit];
        blueButtonHit.positionType = CCPositionTypeNormalized;
        blueButtonHit.anchorPoint = CGPointMake(0, 1);
        blueButtonHit.position = ccp(0.5f, 0.5f);
        [self addChild: blueButtonHit];
        [blueButtonHit setVisible:NO];

    }
    return self;
}

-(void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    movesArray = [[NSMutableArray alloc] init];
    // movesArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:2], nil];
    playerArray = [[NSMutableArray alloc] init];
    // add delay
    
    [self scheduleOnce:@selector(startRound) delay:0.0];
}

-(void)startRound {
    id disableButtons = [CCActionCallBlock actionWithBlock:^{
        [redButton setEnabled:NO];
        [greenButton setEnabled:NO];
        [yellowButton setEnabled:NO];
        [blueButton setEnabled:NO];
    }];
    
    id enableButtons = [CCActionCallBlock actionWithBlock:^{
        [redButton setEnabled:YES];
        [greenButton setEnabled:YES];
        [yellowButton setEnabled:YES];
        [blueButton setEnabled:YES];
    }];
    
    [movesArray addObject:[NSNumber numberWithInt:arc4random_uniform(4)]];
   NSLog(@"The current move is: %@", movesArray);
    // Delay time is 1.0 sec
    
    id roundStartDelay = [CCActionDelay actionWithDuration:2.0f];
    id delayInterval = [CCActionDelay actionWithDuration:1.0f];
    
    id button0 = [CCActionCallBlock actionWithBlock:^{
        [redButtonHit setVisible:YES];
        [audio playEffect:@"button0.wav"];
    }];
    
    id button1 = [CCActionCallBlock actionWithBlock:^{
        [greenButtonHit setVisible:YES];
        [audio playEffect:@"button1.wav"];
    }];
    
    id button2 = [CCActionCallBlock actionWithBlock:^{
        [yellowButtonHit setVisible:YES];
        [audio playEffect:@"button2.wav"];
    }];
    
    id button3 = [CCActionCallBlock actionWithBlock:^{
        [blueButtonHit setVisible:YES];
        [audio playEffect:@"button3.wav"];
    }];
    
    id button0disable = [CCActionCallBlock actionWithBlock:^{
        [redButtonHit setVisible:NO];
    }];
    
    id button1disable = [CCActionCallBlock actionWithBlock:^{
        [greenButtonHit setVisible:NO];
    }];
    
    id button2disable = [CCActionCallBlock actionWithBlock:^{
        [yellowButtonHit setVisible:NO];
    }];
    
    id button3disable = [CCActionCallBlock actionWithBlock:^{
        [blueButtonHit setVisible:NO];
    }];
    
    NSMutableArray *actionMoves = [[NSMutableArray alloc] init];
    
    [actionMoves addObject:(disableButtons)];
    [actionMoves addObject:(roundStartDelay)];
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
        // clear the scene between nodes
        [actionMoves addObject:(button0disable)];
        [actionMoves addObject:(button1disable)];
        [actionMoves addObject:(button2disable)];
        [actionMoves addObject:(button3disable)];
    }
    [actionMoves addObject:(enableButtons)];
    
    [self runAction:[CCActionSequence actionWithArray:actionMoves]];
    }

-(void)redHit:(id)sender
{
    [playerArray addObject:[NSNumber numberWithInt:(0)]];
    NSLog(@"%@", playerArray);
    // play sound effect
    [audio playEffect:@"button0.wav"];
    [self checkIfMovesMatch];
}

-(void)greenHit:(id)sender
{
    [playerArray addObject:[NSNumber numberWithInt:(1)]];
    NSLog(@"%@", playerArray);
    // play sound effect
    [audio playEffect:@"button1.wav"];
    [self checkIfMovesMatch];
}
-(void)yellowHit:(id)sender
{
    [playerArray addObject:[NSNumber numberWithInt:(2)]];
    NSLog(@"%@", playerArray);
    // play sound effect
    [audio playEffect:@"button2.wav"];
    [self checkIfMovesMatch];}

-(void)blueHit:(id)sender
{
    [playerArray addObject:[NSNumber numberWithInt:(3)]];
    NSLog(@"%@", playerArray);
    // play sound effect
    [audio playEffect:@"button3.wav"];
    [self checkIfMovesMatch];
}
-(void)checkIfMovesMatch{
    int round = [movesArray count]-1;
    int currentPlayerMove = [playerArray count]-1;
    if (playerArray[currentPlayerMove] == movesArray[currentPlayerMove]){
        NSLog(@"Player's input is correct!");
    }
    else {
        NSLog(@"Player's input is incorrect!");
        self.userInteractionEnabled = FALSE;
    }
    
    if (currentPlayerMove == round){
        NSLog(@"All player's input is correct!");
        [playerArray removeAllObjects];
        [self startRound];
    }
}
@end
