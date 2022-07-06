//
//  MockRoomTimelineController.swift
//  ElementX
//
//  Created by Stefan Ceriu on 04.03.2022.
//  Copyright © 2022 Element. All rights reserved.
//

import Combine
import Foundation

class MockRoomTimelineController: RoomTimelineControllerProtocol {
    let callbacks = PassthroughSubject<RoomTimelineControllerCallback, Never>()
    
    var timelineItems: [RoomTimelineItemProtocol] = [SeparatorRoomTimelineItem(id: UUID().uuidString,
                                                                               text: "Yesterday"),
                                                     TextRoomTimelineItem(id: UUID().uuidString,
                                                                          text: "You rock!",
                                                                          timestamp: "10:10 AM",
                                                                          shouldShowSenderDetails: true,
                                                                          isOutgoing: false,
                                                                          senderId: "",
                                                                          senderDisplayName: "Some user with a really long long long long long display name"),
                                                     TextRoomTimelineItem(id: UUID().uuidString,
                                                                          text: "You also rule!",
                                                                          timestamp: "10:11 AM",
                                                                          shouldShowSenderDetails: false,
                                                                          isOutgoing: false,
                                                                          senderId: "",
                                                                          senderDisplayName: "Alice"),
                                                     SeparatorRoomTimelineItem(id: UUID().uuidString,
                                                                               text: "Today"),
                                                     TextRoomTimelineItem(id: UUID().uuidString,
                                                                          text: "You too!",
                                                                          timestamp: "5 PM",
                                                                          shouldShowSenderDetails: false,
                                                                          isOutgoing: true,
                                                                          senderId: "",
                                                                          senderDisplayName: "Bob")]
    
    func paginateBackwards(_ count: UInt) async -> Result<Void, RoomTimelineControllerError> {
        .failure(.generic)
    }
    
    func processItemAppearance(_ itemId: String) async { }
    
    func processItemDisappearance(_ itemId: String) async { }
    
    func sendMessage(_ message: String) async { }
}
