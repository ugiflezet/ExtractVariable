//
//  Extractor.m
//  PlayingWithRegex
//
//  Created by Danny Shmueli on 4/1/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "MainExtractor.h"
#import "Extractor.h"
#import "objc/runtime.h"

@interface MainExtractor ()
@property (nonatomic, retain) NSArray *extractors;
@end

@implementation MainExtractor

-(id)init
{
    self = [super init];
    if (!self) return nil;
    
    self.extractors = ClassGetSubclasses(Extractor.class);
    
    return self;
}

-(ReplacementCode *)extract:(NSString *)selectedText
{
    for (Class clazz in self.extractors)
    {
        Extractor *extractorInstance = [[clazz alloc] init];
        ReplacementCode *replacementCode = [extractorInstance extract:selectedText];
        if (replacementCode)
            return replacementCode;
    }
    return nil;
}


NSArray *ClassGetSubclasses(Class parentClass)
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    classes = malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);
        
        if (superClass == nil)
        {
            continue;
        }
        
        [result addObject:classes[i]];
    }
    
    free(classes);
    
    return result;
}

@end
