//
//  MemberVC.swift
//  schedule
//
//  Created by 陳彥甫 on 2020/10/30.
//  Copyright © 2020 TimeCity. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class MemberVC: UIViewController ,UITextFieldDelegate,SignUpDelegate{
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func signUp(emailAccount: String,password:String) {
        email.text = emailAccount
        self.password.text = password
    }
    

    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                let alert = UIAlertController.init(title: "提醒", message: "登入成功", preferredStyle:.alert)
                let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
                    self.email.text = ""
                    self.password.text = ""
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let alert = US.alertVC(message: "帳號或密碼錯誤", title: "登入失敗")
                self.present(alert, animated: true, completion: nil)
                return
                print("Login Error")
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Member", bundle: Bundle.main)
        let signVC = sb.instantiateViewController(withIdentifier: "Sign") as! SignUpVC
        signVC.delegate = self
        self.present(signVC, animated: true, completion: nil)
        
    }
    
    @IBAction func signGoogle(_ sender: Any) {
    }
    
    @IBAction func signFacebook(_ sender: Any) {
        let fbLoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            
            if error != nil {
                print("FB login fail \(error?.localizedDescription)")
                return
            }
            
            if AccessToken.current == nil{
                print("failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}
