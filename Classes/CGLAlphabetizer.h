//
//  CGLAlphabetizer.h
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

@interface CGLAlphabetizer : NSObject

/**
 *  Accepts an arbitrary array of objects and a key path to alphabetize by, and returns an NSDictionary keyed by first letter, with arrays of objects tied to each.
 *
 *  @param objects an array of objects to alphabetize, each of which should respond to keyPath
 *  @param keyPath a key path to drive alphabetization. @note that each object should respond to valueForKeyPath: with an NSString.
 *
 *  @return an NSDictionary keyed by first letter, containting sorted arrays of objects
 */
+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath;

/**
 *  Identical to [CGLAlphabetizer alphabetizedDictionaryFromObjects:usingKeyPath:], except this method allows supplying a custom placeholder for strings that don't begin with letters. # by default.
 */
+ (NSDictionary *)alphabetizedDictionaryFromObjects:(NSArray *)objects
                                       usingKeyPath:(NSString *)keyPath
                           nonAlphabeticPlaceholder:(NSString *)placeholder;

/**
 *  Generates a sorted array of index titles from an alphabetized dictionary. 
 *
 *  You might use these to respond to the tableView datasource method sectionIndexTitlesForTableView.
 *
 *  @param alphabetizedDictionary an alphabetized dictionary
 *
 *  @return an array of index titles
 */
+ (NSArray *)indexTitlesFromAlphabetizedDictionary:(NSDictionary *)alphabetizedDictionary;

@end
