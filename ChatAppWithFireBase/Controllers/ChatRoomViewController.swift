//
//  ChatRoomViewController.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/08.
//

import UIKit

class ChatRoomViewController: UIViewController{
    
    private let cellId = "cellId"
    private var messages = [String]()
    private lazy var chatInputAccesoryView: ChatInputAccessaroyView = {
        let view = ChatInputAccessaroyView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        view.delegate = self
        return view
    }()
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        //chatRoomTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        chatRoomTableView.register(UINib(nibName: "ChatRoomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        chatRoomTableView.backgroundColor = .rgb(red: 110, green: 140, blue: 180)
        
    }
    
    override var inputAccessoryView: UIView?{
        get {
            return chatInputAccesoryView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
}

extension ChatRoomViewController: ChatInputAccessaroyViewDelegate{
    func tappedSendButton(text: String) {
        messages.append(text)
        chatInputAccesoryView.removeText()
        chatInputAccesoryView.chatTextView.text = ""
        chatRoomTableView.reloadData()
    }
    
    
}

extension ChatRoomViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath) as! ChatRoomTableViewCell
        //cell.messageTextview.text = messages[indexPath.row]
        cell.messagetext = messages[indexPath.row]
        return cell
    }
    
    
}
