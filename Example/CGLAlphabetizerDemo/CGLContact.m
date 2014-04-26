//
//  CGLContact.m
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLContact.h"

@implementation CGLContact

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (CGLContact *)contactWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    CGLContact *contact = [[CGLContact alloc] init];
    contact.firstName = firstName;
    contact.lastName = lastName;
    
    return contact;
}

@end
