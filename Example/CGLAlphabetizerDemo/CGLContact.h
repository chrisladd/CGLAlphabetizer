//
//  CGLContact.h
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

@interface CGLContact : NSObject
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;

@property (nonatomic, readonly) NSString *fullName;

@end
