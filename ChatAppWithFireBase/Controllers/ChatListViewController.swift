//
//  ChatListViewController.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/08.
//

import UIKit
import Firebase

class ChatListViewController: UIViewController{
    
    private let cellId = "cellId"
    private var user: User? {
        
        didSet{
            navigationItem.title = user?.username
        }
    }
    @IBOutlet weak var ChatListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        confirmLoggedInUser()
        fetchLoginUserInfo()
        
    }
    
    private func setupViews(){
        ChatListTableView.delegate = self
        ChatListTableView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = .rgb(red: 39, green: 49, blue: 69)
        navigationItem.title = "トーク"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        
        
        
        let rigntBarButton = UIBarButtonItem(title:"新規チャット",style: .plain, target: self, action: #selector(tappedNavRightBarButton))
        
        navigationItem.rightBarButtonItem = rigntBarButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    //ログイン認証
    private func confirmLoggedInUser(){
        //端末にログイン情報があればログイン用の画面遷移なし
        if Auth.auth().currentUser?.uid == nil{
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let signUpViewController = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func tappedNavRightBarButton(){
        let storyboard = UIStoryboard.init(name: "UserList",bundle: nil)
        let userListViewController = storyboard.instantiateViewController(identifier: "UserListViewController")
        let nav = UINavigationController(rootViewController: userListViewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    private func fetchLoginUserInfo(){
        guard let uid = Auth.auth().currentUser?.uid else { return}
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err{
                print("ユーザー情報の取得に失敗しました。\(err)")
                return
            }
            
            guard let snapshot = snapshot, let dic = snapshot.data() else { return }

            let user = User(dic: dic)
            self.user = user
        }
        
    }
    
   
}

extension ChatListViewController: UITableViewDelegate,UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatListTabelViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "ChatRoom", bundle: nil)
        
        let chatRoomViewController = storyboard.instantiateViewController(identifier: "ChatRoomViewController")
        navigationController?.pushViewController(chatRoomViewController, animated: true)
    }
    
    
}

class ChatListTabelViewCell: UITableViewCell{
    
    var user: User? {
        didSet{
            if let user = user{
            partnerLabel.text = user.username
            
            dateLabel.text = dataFomatterForDateLabel(date: user.createdAt.dateValue())
            latestMessageLabel.text = user.email
            }
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var latestMessageLabel: UILabel!
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        userImageView.layer.cornerRadius = 35
                    
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    private func dataFomatterForDateLabel(date:Date) -> String {
        let formattter = DateFormatter()
        formattter.dateStyle = .full
        formattter.timeStyle = .short
        formattter.locale = Locale(identifier: "ja_JP")
        return formattter.string(from: date)
        
    }
    
}
