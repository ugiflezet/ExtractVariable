//
//  Extractor.h
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/2/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplacementCode.h"
@interface Extractor : NSObject

-(ReplacementCode *)extract:(NSString *)selectedText;
-(NSArray *)getMatchesWithPattern:(NSString *)pattern fromText:(NSString *)text;

@end
