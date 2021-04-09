//
//  ChatInputAccessoryView.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/08.
//

import UIKit

class ChatInputAccessaroyView: UIView{
    
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibInit()
        setupViews()
        autoresizingMask = .flexibleHeight
    }
    
    private func setupViews(){
        chatTextView.layer.cornerRadius = 15
        chatTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        chatTextView.layer.borderWidth = 1
        
        sendbutton.layer.cornerRadius = 15
        sendbutton.imageView?.contentMode = .scaleAspectFill
        sendbutton.contentHorizontalAlignment = .fill
        sendbutton.contentVerticalAlignment = .fill
        sendbutton.isEnabled = false

        
        
        
    }
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    private func nibInit(){
        let nib = UINib(nibName: "ChatInputAccessoryView", bundle: nil)
        guard  let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
    
    
    view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



