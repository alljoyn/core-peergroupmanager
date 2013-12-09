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

#import <Foundation/Foundation.h>

// AllJoyn Objective-C Framework headers
#import "AllJoynFramework/AJNSessionOptions.h"

// Status Types 
typedef enum {
    PGMInvalid,
    PGMHostedAndUnlocked,
    PGMHostedAndLocked,
    PGMJoinedAndUnlocked,
    PGMJoinedAndLocked,
    PGMFound                 // Not hosted, not joined. Advertisement seen
} PGMStatus;

/* Invalid Session Port */
#define PGMBadSessionPort 0
 
/*
 * PGMGroup is a class that contains the data representing a group. This class is
 * only used by the PGMGroupRegistry.
 */
@interface PGMGroup : NSObject  

/* The session id of the group. */
@property (nonatomic) AJNSessionId sessionId;

/* The session port of the group. */
@property (nonatomic) AJNSessionPort sessionPort;

/* 
 * Flag denoting that the group is a Legacy AllJoyn group which does not advertise
 * a name which follows the naming convention of PeerGroupManager groups.
 */
@property (nonatomic) BOOL isLegacyGroup;

/* The status or state of the group in respect to the user of the PeerGroupManager. */
@property (nonatomic) PGMStatus status;

/* The name of the group. */
@property (nonatomic, copy) NSString *groupName;

/* An array of peer ids (NSStrings) of all the peers in the group. */
@property (nonatomic, strong) NSMutableArray *idsOfPeers;

/*
 * An array of peer ids (NSStrings) of all the peers allowed in the group.
 * This property is to be used for controlling who is allowed to join the 
 * group in the acceptance policy once createPrivateGroup: is implemented.
 */
@property (nonatomic, strong) NSMutableArray *idsOfAllowedPeers;

@end
