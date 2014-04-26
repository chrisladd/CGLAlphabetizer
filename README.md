CGLAlphabetizer
============

A simple class to easily alphabetize an array of objects.

You might use it to sort an array into alphabetized sections, for use in a tableView like the Phone, Contacts, and Music apps in iOS.

![Demo app](https://raw.githubusercontent.com/chrisladd/CGLAlphabetizer/master/Example/demo.gif)

The CGLAlphabetizer object accepts an array of objects and a key path to alphabetize by, and returns an NSDictionary keyed by first letter, with arrays of objects tied to each.

Assuming you had an object:

````obj-c

@interface CGLContact : NSObject
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;

@property (nonatomic, readonly) NSString *fullName;

@end

````

And you had an array of said objects

````objc-c
CGLContact *steve = [CGLContact contactWithFirstName:@"Steve" lastName:@"Jobs"];
CGLContact *bill = [CGLContact contactWithFirstName:@"Bill" lastName:@"Gates"];
CGLContact *larry = [CGLContact contactWithFirstName:@"Larry" lastName:@"Ellison"];
CGLContact *eric = [CGLContact contactWithFirstName:@"Eric" lastName:@"Jones"];

NSArray *contacts = @[steve, bill, larry, eric];
````

You could sort them like so:

````objc-c

NSDictionary *sortedContacts = [CGLAlphabetizer alphabetizedDictionaryFromObjects:contacts usingKeyPath:@"lastName"];

// => @{
        @"E" : @[larry],
        @"G" : @[bill],
        @"J" : @[steve, eric]
        }

````

Or even like so:

````objc-c

NSDictionary *sortedContacts = [CGLAlphabetizer alphabetizedDictionaryFromObjects:contacts usingKeyPath:@"firstName"];

// => @{
        @"B" : @[bill],
        @"E" : @[eric],
        @"L" : @[larry],
        @"S" : @[steve]
        }

````

And, if you were planning on using them for a tableView, there's a handy method for that, too:

````objc-c

NSArray *indexTitle = [CGLAlphabetizer indexTitlesFromAlphabetizedDictionary:sortedContacts];

// => @[@"B", @"E", @"L", @"S"]

````
