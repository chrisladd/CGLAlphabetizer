//
//  CGLAlphabetizer.m
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLAlphabetizer.h"

NSString * const CGLAlphabetizerGroupNameKey = @"name";
NSString * const CGLAlphabetizerGroupObjectsKey = @"objects";

@implementation CGLAlphabetizer

+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects usingKeyPath:(NSString *)keyPath {
    return [self alphabetizedDictionaryFromObjects:objects
                                      usingKeyPath:keyPath
                          nonAlphabeticPlaceholder:nil];
}

+ (NSMutableArray *)findOrCreateArrayForKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    NSMutableArray *array = dictionary[key];
    
    if (!array) {
        array = [NSMutableArray array];
        dictionary[key] = array;
    }
    
    return array;
}

+ (NSMutableDictionary *)findOrCreateDictionaryForKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    NSMutableDictionary *keyedDictionary = dictionary[key];
    
    if (!keyedDictionary) {
        keyedDictionary = [NSMutableDictionary dictionary];
        dictionary[key] = keyedDictionary;
    }
    
    return keyedDictionary;
}


+ (NSString *)keyFromObject:(id)object usingKeyPath:(NSString *)keyPath placeholder:(NSString *)placeholder maxLength:(NSUInteger)maxLength validCharacterSet:(NSCharacterSet *)validCharacterSet {
    NSString *key = placeholder;
    
    if ([object respondsToSelector:NSSelectorFromString(keyPath)] || [object isKindOfClass:[NSDictionary class]]) {
        id possibleKey = [object valueForKeyPath:keyPath];
        
        if ([possibleKey isKindOfClass:[NSString class]] && [possibleKey length]) {
            key = possibleKey;
            
            if (maxLength > 0 && [key length] > maxLength) {
                key = [key substringToIndex:maxLength];
            }
            
            NSRange theRange = [key rangeOfString:@"The "];
            if (theRange.location == 0) {
                key = [[key substringFromIndex:NSMaxRange(theRange)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            
            if (validCharacterSet) {
                NSCharacterSet *keyCharacterSet = [NSCharacterSet characterSetWithCharactersInString:key];
                if (![validCharacterSet isSupersetOfSet:keyCharacterSet]) {
                    key = placeholder;
                }
            }
        }
    }
    
    return key;
    
}

+ (NSDictionary *)groupedDictionaryFromObjects:(NSArray *)objects usingKeyPath:(NSString *)keyPath sortBy:(NSString *)sortableKeyPath nonAlphabeticPlaceholder:(NSString *)placeholder {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *nonLetterPlaceholder = [placeholder length] ? placeholder : @"#";
    for (id object in objects) {
        NSString *name = [self keyFromObject:object usingKeyPath:keyPath placeholder:nonLetterPlaceholder maxLength:0 validCharacterSet:nil];
        
        NSMutableDictionary *keyedDictionary = [self findOrCreateDictionaryForKey:[name uppercaseString]
                                                                     inDictionary:dictionary];

        NSMutableArray *array = [self findOrCreateArrayForKey:CGLAlphabetizerGroupObjectsKey inDictionary:keyedDictionary];
        keyedDictionary[CGLAlphabetizerGroupNameKey] = name;
        
        [array addObject:object];
    }

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortableKeyPath ascending:YES];
    for (NSString *key in dictionary) {
        [dictionary[key][CGLAlphabetizerGroupObjectsKey] sortUsingDescriptors:@[sortDescriptor]];
    }

    return [self alphabetizedDictionaryFromObjects:[dictionary allValues]
                                      usingKeyPath:CGLAlphabetizerGroupNameKey
                          nonAlphabeticPlaceholder:placeholder];
}


+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath
                           nonAlphabeticPlaceholder:(NSString *)placeholder {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *nonLetterPlaceholder = [placeholder length] ? placeholder : @"#";
    for (id object in objects) {
        NSString *firstLetter = [self keyFromObject:object usingKeyPath:keyPath placeholder:nonLetterPlaceholder maxLength:1 validCharacterSet:[NSCharacterSet letterCharacterSet]];
        firstLetter = [firstLetter uppercaseString];
        NSMutableArray *array = [self findOrCreateArrayForKey:firstLetter inDictionary:dictionary];
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
