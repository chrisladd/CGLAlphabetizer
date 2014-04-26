//
//  CGLContactParser.h
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLContactParser : NSObject

+ (NSArray *)contactsWithContentsOfFile:(NSString *)filePath;

@end
