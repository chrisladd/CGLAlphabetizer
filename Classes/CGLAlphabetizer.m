//
//  CGLAlphabetizer.m
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLAlphabetizer.h"

@implementation CGLAlphabetizer

+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects usingKeyPath:(NSString *)keyPath {
    return [self alphabetizedDictionaryFromObjects:objects
                                      usingKeyPath:keyPath
                          nonAlphabeticPlaceholder:nil];
}

+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath
                           nonAlphabeticPlaceholder:(NSString *)placeholder {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *nonLetterPlaceholder = [placeholder length] ? placeholder : @"#";
    for (id object in objects) {
        NSString *firstLetter = nonLetterPlaceholder;
        
        if ([object respondsToSelector:NSSelectorFromString(keyPath)]) {
            id possibleFirstLetter = [object valueForKeyPath:keyPath];
            
            if ([possibleFirstLetter isKindOfClass:[NSString class]] && [possibleFirstLetter length]) {
                NSString *letter = [[possibleFirstLetter substringToIndex:1] uppercaseString];
                
                if ([[NSCharacterSet letterCharacterSet] characterIsMember:[letter characterAtIndex:0]]) {
                    firstLetter = letter;
                }
            }
        }
        
        NSMutableArray *array = dictionary[firstLetter];
        
        if (!array) {
            array = [NSMutableArray array];
            dictionary[firstLetter] = array;
        }
        
        [array addObject:object];
    }
    
    // now sort all the arrays
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keyPath ascending:YES];
    for (NSString *key in dictionary) {
        [dictionary[key] sortUsingDescriptors:@[sortDescriptor]];
    }
    
    return dictionary;
}

+ (NSArray *)indexTitlesFromAlphabetizedDictionary:(NSDictionary *)alphabetizedDictionary {
    return [[alphabetizedDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

@end
