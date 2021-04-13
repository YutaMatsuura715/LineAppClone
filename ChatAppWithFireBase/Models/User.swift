//
//  User.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/13.
//

import Foundation
import Firebase

class User{
    
    let email: String
    let username: String
    let createdAt: Timestamp
    let profileImageUrl: String
    
    init(dic: [String: Any]){
        self.email = dic["email"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.createdAt = dic["careatedAt"] as? Timestamp ?? Timestamp()
        self.profileImageUrl = dic["profileImageUrl"] as? String ?? ""
    }
}
