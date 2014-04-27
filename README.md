## CGLAlphabetizer

A simple class to easily alphabetize an array of objects.

You might use it to sort an array into alphabetized sections, for use in a tableView like the Phone, Contacts, and Music apps in iOS.

![Demo app](https://raw.githubusercontent.com/chrisladd/CGLAlphabetizer/master/Example/demo.gif)

### Installation

If you're using Cocoapods, like you should, add this to your podfile:

`pod 'CGLAlphabetizer', '~> 0.1'`

Otherwise, you can just download and drag in `CGLAlphabetizer.h` and `CGLAlphabetizer.m` from the `Classes` folder.

### Usage

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

````obj-c

NSDictionary *sortedContacts = [CGLAlphabetizer alphabetizedDictionaryFromObjects:contacts 
                                                                     usingKeyPath:@"lastName"];

// => @{
        @"E" : @[larry],
        @"G" : @[bill],
        @"J" : @[steve, eric]
        }

````

Or even like so:

````obj-c

NSDictionary *sortedContacts = [CGLAlphabetizer alphabetizedDictionaryFromObjects:contacts 
                                                                     usingKeyPath:@"firstName"];

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

### Easy-as-pie Alphabetized UITableView

Putting these pieces together to alphabetize the contents of a UITableViewController might then look something like this:

````obj-c

static NSString * const CGLContactsCellIdentifier = @"CGLContactsCellIdentifier";

@interface CGLContactsTableViewController ()
@property (nonatomic) NSDictionary *alphabetizedDictionary;
@property (nonatomic) NSArray *sectionIndexTitles;
@end

@implementation CGLContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CGLContactsCellIdentifier];
}

- (void)setContacts:(NSArray *)contacts {
    _contacts = contacts;
    self.alphabetizedDictionary = [CGLAlphabetizer alphabetizedDictionaryFromObjects:_contacts usingKeyPath:@"lastName"];
    self.sectionIndexTitles = [CGLAlphabetizer indexTitlesFromAlphabetizedDictionary:self.alphabetizedDictionary];
    
    [self.tableView reloadData];
}

- (CGLContact *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionIndexTitle = self.sectionIndexTitles[indexPath.section];
    return self.alphabetizedDictionary[sectionIndexTitle][indexPath.row];
}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionIndexTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionIndexTitle = self.sectionIndexTitles[section];
    return [self.alphabetizedDictionary[sectionIndexTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CGLContactsCellIdentifier forIndexPath:indexPath];
    
    CGLContact *contact = [self objectAtIndexPath:indexPath];
    cell.textLabel.text = contact.fullName;

    return cell;
}

@end

````
