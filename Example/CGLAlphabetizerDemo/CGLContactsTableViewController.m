//
//  CGLContactsTableViewController.m
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLContactsTableViewController.h"
#import "CGLContact.h"
#import "CGLAlphabetizer.h"

static NSString * const CGLContactsCellIdentifier = @"CGLContactsCellIdentifier";

@interface CGLContactsTableViewController ()
@property (nonatomic) NSDictionary *alphabetizedDictionary;
@property (nonatomic) NSArray *sectionIndexTitles;
@end

@implementation CGLContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Human Space Travelers", nil);
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space-background"]];

    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithRed:1.000 green:0.573 blue:0.471 alpha:1.0];
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

    cell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:17.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionIndexTitles[section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        UILabel *textLabel = [(UITableViewHeaderFooterView *)view textLabel];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-HeavyItalic" size:18.0];
    }
}

@end
