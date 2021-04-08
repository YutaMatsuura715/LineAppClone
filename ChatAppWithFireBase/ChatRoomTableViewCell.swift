//
//  ChatRoomTableViewCell.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/08.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell{
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 30
        messageTextview.layer.cornerRadius = 15
        backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
