//
//  ExtractVariable.h
//  ExtractVariable
//
//  Created by Danny Shmueli on 4/1/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface ExtractVariable : NSObject
+(ExtractVariable *)sharedPlugin;

@property (nonatomic, retain) NSTextView *textView;
@property (nonatomic, retain) NSString *selectedTextInLine;
@end
