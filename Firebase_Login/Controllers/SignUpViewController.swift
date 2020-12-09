//
//  SignUpViewController.swift
//  Firebase_Login
//
//  Created by Cooper on 2020/12/9.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    //Solve Strong Password Issue
    var s1: String = ""
    var s2: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //clear textFiled in secured
        passwordTextField.isSecureTextEntry = false
    }
    
    //每次開始輸入就將TextField初始化，並設定isSecureTextEntry = true啟用隱碼功能。
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == emailTextField) {
            emailTextField.text = ""
            emailTextField.becomeFirstResponder()
        }
        
        if (textField == passwordTextField) {
            passwordTextField.text = ""
            passwordTextField.becomeFirstResponder()
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    //每次結束輸入就將輸入值存到變數中以供送電文用，TextField欄位則設定isSecureTextEntry = false關閉隱碼功能，但是以"●"取代輸入值。
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var len = 0;
        let n = ""
        
        if (textField == passwordTextField){
            passwordTextField.isSecureTextEntry = false
            len = passwordTextField.text!.count
            
            if (len == 0){
                passwordTextField.text = ""
            }else{
                s2 = passwordTextField.text!
                let symbol2 = n.padding(toLength: len, withPad: "●", startingAt: 0)
                passwordTextField.text = symbol2
            }
        }
    }
    
    
    @IBAction func createAccountAction(_ sender: Any) {
        
        if emailTextField.text == "" {
            
            let alertController = UIAlertController(title: "錯誤", message: "請輸入郵件地址", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                self.textFieldDidBeginEditing(self.passwordTextField)
                self.textFieldDidEndEditing(self.passwordTextField)
                
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    let vc = self.storyboard?.instantiateViewController(identifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                } else {
                    
                    let alertController = UIAlertController(title: "錯誤", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultController = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultController)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
    }
    
    
    @IBAction func returnKeyboard(_ sender: Any) {
        resignFirstResponder()
    }
    
    
    
    
    
}
