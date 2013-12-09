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
#import "AllJoynFramework/AJNTransportMask.h"

/**
 * The PeerGroupDelegate is a protocol to be implemented if the app wishes to listen
 * to AllJoyn call-back methods. The call-back methods in this protocol are
 * equivalent to the didFindAdvertisedName:withTransportMask:namePrefix:, 
 * didLoseAdvertisedName:withTransportMask:namePrefix:, sessionWasLost:,
 * didAddMemberNamed:toSession:, and didRemoveMemberNamed:toSession: call-backs of AllJoyn.
 */
@protocol PGMPeerGroupDelegate <NSObject>

@optional
/**
 * Called when a new group advertisement is found. 
 *
 * This will not be triggered for locked groups or your own hosted groups.
 *
 * @param groupName  the groupName that was found.
 *
 * @param transport  the transport that the groupName was discovered on.
 */
- (void)didFindAdvertisedName:(NSString *)groupName withTransport:(AJNTransportMask)transport;

/**
 * Called when a group that was previously reported through
 * didFindAdvertisedName:withTransport: has become unavailable. 
 *
 * This will not be triggered for your own hosted groups. This will get
 * triggered for a group that was previously unlocked and has now become
 * locked.
 *
 * @param groupName  the group name that has become unavailable.
 *
 * @param transport  the transport that stopped receiving the groupName
 *                   advertisement.
 */
- (void)didLoseAdvertisedName:(NSString *)groupName withTransport:(AJNTransportMask)transport;

/**
 * Called when a group becomes disconnected.
 *
 * @param groupName  the group that became disconnected.
 */
- (void)groupWasLost:(NSString *)groupName;

/**
 * Called when a new peer joins a group.
 *
 * @param peerId     the id of the peer that joined.
 *
 * @param groupName  the group that the peer joined.
 *
 * @param numPeers   the current number of peers in the group.
 */
- (void)didAddPeer:(NSString *)peerId toGroup:(NSString *)groupName forATotalOf:(int)numPeers;

/**
 * Called when a new peer leaves a group.
 *
 * @param peerId     the id of the peer that left.
 *
 * @param groupName  the group that the peer left.
 *
 * @param numPeers   the current number of peers in the group.
 */
- (void)didRemovePeer:(NSString*)peerId fromGroup:(NSString *)groupName forATotalOf:(int)numPeers;
@end