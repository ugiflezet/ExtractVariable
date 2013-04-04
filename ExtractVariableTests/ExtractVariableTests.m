//
//  ExtractVariableTests.m
//  ExtractVariableTests
//
//  Created by Danny Shmueli on 4/3/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "ExtractVariableTests.h"

#import "ReplacementCode.h"

@implementation ExtractVariableTests

- (void)setUp
{
    [super setUp];
    self.mainExtractor = [[MainExtractor alloc] init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [self.mainExtractor release];
    [super tearDown];
}

-(void)testMainExtractor_WhenInstanceObject
{
    //[Manager shared] ==> id manager = [Manager shared]
    ReplacementCode *result = [self.mainExtractor extract:@"[Manager sharedInstance]"];
    STAssertEqualObjects(result.extractedCode, @"Manager *manager = [Manager sharedInstance]", @"should match");
}

-(void)testMainExtractor_WhenInstanceObject2
{
    //[UIColor clearColor]; ==> UIColor *color = [UIColor clearColor];
    ReplacementCode *result = [self.mainExtractor extract:@"[UIColor whiteColor]"];
    STAssertEqualObjects(result.extractedCode, @"UIColor *color = [UIColor whiteColor]", @"should match");
}

-(void)testMainExtractor_WhenInstanceObject3
{
    //[self calcHieght]; ==> id *calcHeight = [self calcHieght];
    ReplacementCode *result = [self.mainExtractor extract:@"[self calcHieght]"];
    STAssertEqualObjects(result.extractedCode, @"UIColor *color = [UIColor whiteColor]", @"should match");
}


-(void)testMainExtractor_WhenPropertyOfObject
{
    //self.gamesArray.count ==> id count = self.gamesArray.count
    ReplacementCode *result = [self.mainExtractor extract:@"self.gamesArray.count"];
    STAssertEqualObjects(result.extractedCode, @"id count = self.gamesArray.count", @"should match");
}


@end
