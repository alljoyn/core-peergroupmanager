/******************************************************************************
 * Copyright (c) 2013, AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "PGMUnlockAndLockGroupsViewController.h"

@interface PGMUnlockAndLockGroupsViewController ()

@end

@implementation PGMUnlockAndLockGroupsViewController

@synthesize tableView = _tableView;
@synthesize peerGroupManager = _peerGroupManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numRows = [self.peerGroupManager listHostedGroupNames].count;
    if(numRows > 0)
    {
        return numRows;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LockGroupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *hostedGroups = [self.peerGroupManager listHostedGroupNames];
    NSArray *lockedGroups = [self.peerGroupManager listLockedGroupNames];
    // Configure the cell...
    if (hostedGroups.count == 0 && indexPath.row == 0)
    {
        cell.textLabel.text = @"No hosted groups";
    }
    else
    {
        cell.textLabel.text = [hostedGroups objectAtIndex:indexPath.row];
        if([lockedGroups containsObject:cell.textLabel.text])
        {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locked.png"]];
        }
        else
        {
             cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unlocked.png"]];
        }
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *lockedGroups = [self.peerGroupManager listLockedGroupNames];
    NSString *groupName = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if([lockedGroups containsObject:groupName])
    {
        [self.peerGroupManager unlockGroupWithName:groupName];
    }
    else
    {
        [self.peerGroupManager lockGroupWithName:groupName];
    }

    [self.tableView reloadData];
}


#pragma mark - Button Actions

- (IBAction)unlockAllGroupsButtonPressed:(id)sender
{
    NSArray *lockedGroups = [self.peerGroupManager listLockedGroupNames];
    for (NSString *groupName in lockedGroups)
    {
        [self.peerGroupManager unlockGroupWithName:groupName];
    }
    
    [self.tableView reloadData];
}

- (IBAction)lockAllGroupsButtonPressed:(id)sender
{
    NSArray *hostedGroups = [self.peerGroupManager listHostedGroupNames];
    NSArray *lockedGroups = [self.peerGroupManager listLockedGroupNames];
    for (NSString *groupName in hostedGroups)
    {
        if(![lockedGroups containsObject:groupName])
        {
            [self.peerGroupManager lockGroupWithName:groupName];
        }
    }
    
    [self.tableView reloadData];
}
@end
