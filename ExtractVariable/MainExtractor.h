//
//  Extractor.h
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/1/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplacementCode.h"
@interface MainExtractor : NSObject

-(ReplacementCode *)extract:(NSString *)selectedText;

@end
