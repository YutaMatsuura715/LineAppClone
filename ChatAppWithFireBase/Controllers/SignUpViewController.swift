//
//  SignUpViewController.swift
//  ChatAppWithFireBase
//
//  Created by Y M on 2021/04/11.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alreadyHaveAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageButton.layer.cornerRadius = 85
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240).cgColor
        registerButton.layer.cornerRadius = 15
        
        profileImageButton.addTarget(self, action: #selector(tappedProfileImageButton), for: .touchUpInside)
        profileImageButton.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        registerButton.isEnabled = false
        registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        
    }
    
    @objc private func tappedProfileImageButton(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController,animated: true, completion: nil)
    }
    
    @objc private func tappedRegisterButton(){
        guard  let email = emailTextField.text else { return }
        guard  let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Auth情報の保存に失敗しました。\(err)")
                
                return
            }

            
                guard let uid = res?.user.uid else { return }
                guard let username = self.usernameTextField.text else { return }
                let docData = [
                    "email": email,
                    "username": username,
                    "careatedAt": Timestamp()
                ] as [String : Any]
                
                Firestore.firestore().collection("users").document(uid).setData(docData){
                    (err) in
                    if let err = err{
                        print("Firebasestoreへのデータベースへの保存に失敗しました。\(err)")
                        return
                    }
                    print("Firebasestoreへの情報の保存が成功しました")
                    self.dismiss(animated: true, completion: nil)
                    
                }
            
            }
            
        }
    }
    
    
    

 
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = emailTextField.text?.isEmpty ?? false
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? false
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? false
    
    
    if emailIsEmpty || passwordIsEmpty || usernameIsEmpty {
        registerButton.isEnabled = false
        registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
    } else {
        registerButton.isEnabled = true
        registerButton.backgroundColor = .rgb(red: 0, green: 200, blue: 0)
    }
        
    }
}

extension SignUpViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage{
            profileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info[.originalImage] as? UIImage{
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        profileImageButton.setTitle("", for: .normal)
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
}
    
