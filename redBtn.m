//
//  redBtn.m
//  simonGameX
//
//  Created by Clarence Chow on 28/09/2014.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "redBtn.h"

@implementation redBtn

{
    OALSimpleAudio *audio;
}

-(void)redButton:(id)sender
{
    NSLog(@"red is hit");
    // play sound effect
    [audio playEffect:@"button0.wav"];
}


@end