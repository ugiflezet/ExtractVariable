//
//  ExtractorSimpleInstance.m
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/2/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "ExtractorSimpleInstance.h"

@implementation ExtractorSimpleInstance

-(ReplacementCode *)extract:(NSString *)text
{
    //[UIColor clearColor]; ==> UIColor *color = [UIColor clearColor];
    NSString *pattern = @"\\[+(\\w+) (\\w+)\\]";
    NSArray *matches = [self getMatchesWithPattern:pattern fromText:text];
    if (!matches) return nil;
    
    NSTextCheckingResult *match = matches[0];

    NSString *type = [text substringWithRange:[match rangeAtIndex:1]];
    NSString *lowerCasedType = [self removeUIAndNSPrefix:[type lowercaseString]];

    ReplacementCode *replacementCode = [[ReplacementCode alloc] init];
    replacementCode.extractedCode = [NSString stringWithFormat:@"%@ *%@ = %@", type, lowerCasedType,text];
    replacementCode.replaceCode = type;
    return replacementCode;
}

-(NSString *)removeUIAndNSPrefix:(NSString *)str
{
    NSMutableString *mutable = [NSMutableString stringWithString:str];
    [mutable replaceOccurrencesOfString:@"ui" withString:@"" options:0 range:NSMakeRange(0, 2)];
    [mutable replaceOccurrencesOfString:@"ns" withString:@"" options:0 range:NSMakeRange(0, 2)];
    return mutable;
}

@end
