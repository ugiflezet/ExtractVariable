//
//  Extractor.m
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/2/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "Extractor.h"

@implementation Extractor


-(NSArray *)getMatchesWithPattern:(NSString *)pattern fromText:(NSString *)text
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    if (matches.count != 1)
        return nil;
    return matches;
}
@end
