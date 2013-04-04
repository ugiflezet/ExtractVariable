//
//  ExtractVariable.m
//  ExtractVariable
//
//  Created by Danny Shmueli on 4/1/13.
//  Copyright (c) 2013 Danny Shmueli. All rights reserved.
//

#import "ExtractVariable.h"
#import "NSView+Dumping.h"
#import "MainExtractor.h"

@interface ExtractVariable ()
@property (nonatomic, retain) MainExtractor *mainExtractor;
@end

@implementation ExtractVariable

static ExtractVariable *mySharedPlugin = nil;


+(void)pluginDidLoad:(NSBundle *)plugin
{
    //plugin entery point
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mySharedPlugin = [[self alloc] init];
	});
}

+(ExtractVariable *)sharedPlugin
{
	return mySharedPlugin;
}

-(id)init {
	if (self = [super init])
    {
        self.mainExtractor = [[MainExtractor alloc] init];
        [self activateTextListening];
        
		[NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent *(NSEvent *event) {
			unsigned short keyCode = [event keyCode];
//            NSLog(@"keycode: %i", keyCode);
            if (keyCode == 14)
                [self extractTheVariable];
            return event;
        }];
    }
	return self;
}

- (void)activateTextListening
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionDidChange:) name:NSTextViewDidChangeSelectionNotification object:nil];
    
    if (!self.textView) {
    NSResponder *firstResponder = [[NSApp keyWindow] firstResponder];
	if ([firstResponder isKindOfClass:NSClassFromString(@"DVTSourceTextView")] && [firstResponder isKindOfClass:[NSTextView class]]) {
		self.textView = (NSTextView *)firstResponder;
		}
	}
	if (self.textView) {
		NSNotification *notification = [NSNotification notificationWithName:NSTextViewDidChangeSelectionNotification object:self.textView];
		[self selectionDidChange:notification];
	}
}

-(void)extractTheVariable
{
    NSLog(@"ctrl + cmd + e pressed");
    ReplacementCode *replacementCode = [self.mainExtractor extract:self.selectedTextInLine];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:replacementCode.extractedCode];
    NSUInteger loc = [self beginingOfSelectedLine];
    if (loc == 0 ) return;
    [self.textView.textStorage insertAttributedString:str atIndex:loc];
}

-(NSUInteger)beginingOfSelectedLine
{
    NSRange selectedRange = [self.textView.selectedRanges[0] rangeValue];
    if (selectedRange.length == 0 ) return 0;
    NSRange lineRange = [self.textView.textStorage.string lineRangeForRange:selectedRange];
    return lineRange.location;
}

-(void)selectionDidChange:(NSNotification *)notification
{
    self.textView = (NSTextView *)[notification object];
    NSString *text = self.textView.textStorage.string;
    if (text.length == 0) return;
    if (self.textView.selectedRanges.count >= 1) {
        NSRange selectedRange = [self.textView.selectedRanges[0] rangeValue];
        if (selectedRange.length == 0 ) return;
        NSRange lineRange = [text lineRangeForRange:selectedRange];
        NSRange selectedRangeInLine = NSMakeRange(selectedRange.location - lineRange.location, selectedRange.length);
        NSString *line = [text substringWithRange:lineRange];
        NSString *selectedTextInLine = [line substringWithRange:selectedRangeInLine];
        if (selectedTextInLine.length == 0) return;
        self.selectedTextInLine = selectedTextInLine;
        NSLog(@"SELECTED: %@", selectedTextInLine);
    }

}

@end
