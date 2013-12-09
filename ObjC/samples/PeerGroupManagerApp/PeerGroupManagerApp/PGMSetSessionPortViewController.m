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

#import "PGMSetSessionPortViewController.h"

@interface PGMSetSessionPortViewController ()

@end

@implementation PGMSetSessionPortViewController

@synthesize peerGroupManager = _peerGroupManager;
@synthesize sessionPort = _sessionPort;
@synthesize setSessionPortButton = _setSessionPortButton;


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
	
    self.sessionPort.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setSessionPortButtonPressed:(UIButton *)sender
{
    AJNSessionPort sessionPort = (uint16_t)[self.sessionPort.text integerValue];
    [self.peerGroupManager setSessionPort:sessionPort];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Session Port" message:[NSString stringWithFormat:@"Setting Session Port to %@", self.sessionPort.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    self.sessionPort.text = @"";
    [self.sessionPort resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Support the backspace key
    if([string isEqualToString:@""]) {
        return YES;
    }
    
    // Ensure that all the characters are numeric
    NSCharacterSet *numericCharacters = [NSCharacterSet decimalDigitCharacterSet];
    int i;
    for(i=0; i < [string length]; i++)
    {
        unichar character = [string characterAtIndex:i];
        if([numericCharacters characterIsMember:character])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.sessionPort resignFirstResponder];
    return YES;
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.sessionPort resignFirstResponder];
}

@end
