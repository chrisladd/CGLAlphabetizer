//
//  CGLAlphabetizer.h
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

@interface CGLAlphabetizer : NSObject

+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath;

+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath
                         nonAlphanumericPlaceholder:(NSString *)placeholder;

+ (NSArray *)indexTitlesFromAlphabetizedDictionary:(NSDictionary *)alphabetizedDictionary;

@end
