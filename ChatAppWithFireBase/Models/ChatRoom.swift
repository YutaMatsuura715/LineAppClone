//
//  ChatRoom.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/13.
//

import Foundation
import Firebase

class ChatRoom{
    
    let latestMessage: String?
    let memebers: [String]
    let createdAt: Timestamp
    
    var partnerUser: User?
    
    init(dic:[String: Any]){
        self.latestMessage = dic["latestMessage"] as? String ?? ""
        self.memebers = dic["members"] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
