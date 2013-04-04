//
//  ExtractorPropertyOfObject.m
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/3/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "ExtractorPropertyOfObject.h"

@implementation ExtractorPropertyOfObject

-(ReplacementCode *)extract:(NSString *)selectedText
{
    //self.gamesArray.count ==> id count = self.gamesArray.count
    NSString *pattern = @"(\\w+\\.)+(\\w+)";
    NSArray *matches = [self getMatchesWithPattern:pattern fromText:selectedText];
    if (!matches) return nil;
    
    NSTextCheckingResult *match = matches[0];
    NSString *lastProperty = [selectedText substringWithRange:[match rangeAtIndex:match.numberOfRanges-1]];
    
    ReplacementCode *replacementCode = [[ReplacementCode alloc] init];
    replacementCode.extractedCode = [NSString stringWithFormat:@"id %@ = %@", lastProperty, selectedText];
    replacementCode.replaceCode = lastProperty;

    
    return replacementCode;
}

@end
