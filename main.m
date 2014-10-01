//
//  main.m
//  simonGameX
//
//  Created by Clarence Chow on 28/09/2014.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "main.h"

@implementation main {
    NSMutableArray *movesArray;
    OALSimpleAudio *audio;
    CCSpriteFrame *imageOff;
    CCSpriteFrame *imageOn;
    CCButton *redButton;
}

- (id) init {
    self = [super init];
    if (self = [super init]){
        audio = [OALSimpleAudio sharedInstance];
        // [audio playBg:@"Eyes on me.mp3" loop:TRUE];
        NSLog(@"Starting Game......");
        // activate touches on this scene
        self.userInteractionEnabled = TRUE;
        
        imageOff = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright2.png"];
        imageOn = [CCSpriteFrame frameWithImageNamed:@"blue_bottomright.png"];
        
        redButton = [CCButton buttonWithTitle:@"Red" spriteFrame:imageOff highlightedSpriteFrame:imageOn disabledSpriteFrame:nil];
        [redButton setTarget:self selector:@selector(changeButtonImage)];
        redButton.position = ccp(150, 75);
        [self addChild:redButton];
    }
    return self;
}

- (void)changeButtonImage
{
    int mode = 0;
    if (mode == 0) {
        mode = 1;
        [redButton setState:CCControlStateHighlighted];    // image changed with state
    } else {
        mode = 0;
        [redButton setState:CCControlStateNormal];   // image not changed with state
    }
}
@end


