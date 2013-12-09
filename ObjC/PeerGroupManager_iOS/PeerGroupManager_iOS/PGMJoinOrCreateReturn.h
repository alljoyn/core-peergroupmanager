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

// AllJoyn core headers
#import "alljoyn/Status.h"

/**
 * This class is returned by the 
 * [joinOrCreateGroupWithName:]([PGMPeerGroupManager joinOrCreateGroupWithName:]) 
 * method of the peer group manager.
 *
 */
@interface PGMJoinOrCreateReturn : NSObject

/**
 * The AllJoyn status return from either calling 
 * [joinGroupWithName:]([PGMPeerGroupManager joinGroupWithName:])  or
 * [createGroupWithName:]([PGMPeerGroupManager createGroupWithName:]) 
 * in the PeerGroupManager.
 *
 */
@property (nonatomic, readonly) QStatus status;

/**
 * A flag denoting whether the user joined or created the group.
 *
 * YES if the caller joined the group, NO if the caller created
 *         the group
 */
@property (nonatomic, readonly) BOOL isJoiner;

/*
 * Initialize a PGMJoinOrCreateReturn object with the specified QStatus
 * and join flag.
 */
- (id)initWithStatus: (QStatus)status withJoinFlag: (BOOL)isJoiner;

@end

