//
//  ResetPasswordViewController.swift
//  Firebase_Login
//
//  Created by Cooper on 2020/12/9.
//

import UIKit
import Firebase
import FirebaseAuth


class ResetPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var resetEmailAddressTestField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if resetEmailAddressTestField.text == "" {
            
            let alertController = UIAlertController(title: "錯誤", message: "請輸入正確的郵件地址", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().sendPasswordReset(withEmail: resetEmailAddressTestField.text!) { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error"
                    message = (error?.localizedDescription)!
                } else {
                    title = "成功"
                    message = "請至郵箱收取修改密碼信件"
                    self.resetEmailAddressTestField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    
    @IBAction func returnKeyboard(_ sender: Any) {
        resignFirstResponder()
    }
    
    
}
