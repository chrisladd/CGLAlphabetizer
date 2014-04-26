//
//  CGLContactParser.m
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLContactParser.h"
#import "CGLContact.h"

@implementation CGLContactParser

+ (NSArray *)contactsWithContentsOfFile:(NSString *)filePath {
    __block NSMutableArray *contacts = [NSMutableArray array];
    NSString *contactString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    [contactString enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        // assume the last "word" is the last name
        NSRange finalSpaceRange = [line rangeOfString:@" " options:NSBackwardsSearch];
        if (finalSpaceRange.location != NSNotFound) {
            CGLContact *contact = [[CGLContact alloc] init];
            contact.firstName = [line substringToIndex:finalSpaceRange.location];
            contact.lastName = [line substringFromIndex:NSMaxRange(finalSpaceRange)];
            
            if ([contact.firstName length] && [[contact lastName] length]) {
                [contacts addObject:contact];
            }
        }
    }];
    
    return [contacts copy];
}

@end
