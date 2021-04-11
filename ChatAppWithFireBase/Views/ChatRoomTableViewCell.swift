//
//  ChatRoomTableViewCell.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/08.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell{
    
    var messagetext : String?{
        didSet{
            guard  let text = messagetext else {
                return
            }
            let width = estimateFrameForTextView(text: text).width
            
            MessageTextViewWidthConstraint.constant = width
            messageTextview.text = text
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextview: UITextView!
    
    @IBOutlet weak var MessageTextViewWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 30
        messageTextview.layer.cornerRadius = 15
        backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func estimateFrameForTextView(text: String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
    }
}
