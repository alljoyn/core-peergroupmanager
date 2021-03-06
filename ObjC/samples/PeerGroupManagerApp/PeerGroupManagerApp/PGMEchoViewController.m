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

#import "PGMEchoViewController.h"

@interface PGMEchoViewController ()

@end

@implementation PGMEchoViewController

@synthesize peerGroupManager = _peerGroupManager;
@synthesize echoString = _echoString;
@synthesize echoButton = _echoButton;
@synthesize echoReply = _echoReply;

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
	
    self.echoString.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)echoButtonPressed:(id)sender
{
    NSString *remotePeer;
    NSString *groupName;
    
    NSMutableArray *hostedAndJoinedGroups = [[self.peerGroupManager listHostedGroupNames] mutableCopy];
    [hostedAndJoinedGroups addObjectsFromArray:[self.peerGroupManager listJoinedGroupNames]];
    
    BOOL complete = NO;
    for(NSString *group in hostedAndJoinedGroups)
    {
        if([self.peerGroupManager getNumberOfPeersInGroup:group] > 1)
        {
            NSArray *peers = [self.peerGroupManager getIdsOfPeersInGroup:group];
            for(NSString *peer in peers)
            {
                if(![peer isEqualToString:[self.peerGroupManager getMyPeerId]])
                {
                    remotePeer = [peer copy];
                    groupName = [group copy];
                    complete = YES;
                    break;
                }
            }
        }
        if(complete)
        {
            break;
        }
    }
    
    TestObjectProxy *proxy = (TestObjectProxy *) [self.peerGroupManager getRemoteObjectWithClassName:@"TestObjectProxy" forPeer:remotePeer inGroup:groupName onPath:@"/org/alljoyn/TestObject"];
    
    NSLog(@"Getting Proxy for remote peer %@ in group %@", remotePeer, groupName);
    
    NSString *replyString = [proxy echoString:self.echoString.text];
    self.echoReply.text = [NSString stringWithFormat:@"Echo from %@ - %@", remotePeer, replyString];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.echoString resignFirstResponder];
    return YES;
}

@end
