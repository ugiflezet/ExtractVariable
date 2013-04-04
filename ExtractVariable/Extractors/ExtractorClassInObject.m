//
//  ExtractorClassInObject.m
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/3/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "ExtractorClassInObject.h"

@implementation ExtractorClassInObject

-(NSString *)extract:(NSString *)selectedText
{
    return nil;
//    NSString *pattern = @"\\[(\\w+\\.)+ (\\w+)";
//    NSArray *matches = [self getMatchesWithPattern:pattern fromText:selectedText];
//    if (!matches) return nil;
//    
//    NSTextCheckingResult *match = matches[0];
//    int numberOfRanges =  match.numberOfRanges;
//    NSString *lastProperty = [selectedText substringWithRange:[match rangeAtIndex:numberOfRanges-1]];
//    
//    //    NSString *lowerCasedType = [self removeUIAndNSPrefix:[type lowercaseString]];
//    NSString *returnString = [NSString stringWithFormat:@"id %@ = %@", lastProperty, selectedText];
//    return returnString;
}


@end
