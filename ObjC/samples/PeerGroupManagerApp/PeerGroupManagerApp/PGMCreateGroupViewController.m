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

#import "PGMCreateGroupViewController.h"

@interface PGMCreateGroupViewController ()

@property (nonatomic, strong) NSMutableArray *randomNames;

@end

@implementation PGMCreateGroupViewController

@synthesize groupName = _groupName;
@synthesize lockStatus = _lockStatus;
@synthesize peerGroupManager = _peerGroupManager;
@synthesize randomNames = _randomNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)randomNames
{
    if(!_randomNames)
    {
        _randomNames = [[NSMutableArray alloc] initWithObjects:@"Test",@"Testing",@"Sample",@"Example",@"Trial",@"Hello",@"AllJoyn",@"PGM",@"Peer",nil];
    }
    return _randomNames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.groupName setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createGroupButtonPressed:(UIButton *)sender
{
    BOOL lock = [self.lockStatus selectedSegmentIndex];
    NSLog(@"pressed create button");
    NSString *groupName = self.groupName.text;
    QStatus status = [self.peerGroupManager createGroupWithName:groupName andLock:lock];
    self.groupName.text = @"";
    [self.groupName resignFirstResponder];
    [self createdGroup:groupName WithStatus:status];
}
- (IBAction)createGroupWithRandomNameButtonPressed:(UIButton *)sender
{
    NSLog(@"Pressed Create Group With Random Name");
    NSInteger prefixIndex = arc4random()%self.randomNames.count;
    NSInteger suffix = 0;
    NSString *groupName = [NSString stringWithFormat:@"%@Group%u",[self.randomNames objectAtIndex:prefixIndex],suffix];
    BOOL lock = [self.lockStatus selectedSegmentIndex];
    QStatus status;
    while((status = [self.peerGroupManager createGroupWithName:groupName andLock:lock]) != ER_OK)
    {
        suffix++;
        groupName = [NSString stringWithFormat:@"%@Group%u",[self.randomNames objectAtIndex:prefixIndex],suffix];
        
        if(suffix == NSIntegerMax)
        {
            // No Group Could be Made, abort
            break;
        }
    }
    [self createdGroup:groupName WithStatus:status];
    
}

- (void)createdGroup:(NSString *)groupName WithStatus:(QStatus)status
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Created Group" message:[NSString stringWithFormat:@"%@ - %s", groupName, QCC_StatusText(status)] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.groupName resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.groupName resignFirstResponder];
    return YES;
}


@end
