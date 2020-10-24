//
//  LoginVC.swift
//  parstagram
//
//  Created by Jennifer Lopez on 10/23/20.
//  Copyright © 2020 Jennifer Lopez. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        pass.isSecureTextEntry = true
    }
    
    @IBAction func login(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userField.text! , password:pass.text!) {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
          }
          else {print("error - \(error!.localizedDescription)")}
        }

    }
    
    
    @IBAction func signup(_ sender: Any) {
        let user = PFUser()
        user.username = userField.text
        user.password = pass.text
        user.signUpInBackground { (success, err) in
            if (success) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {print("error - \(err?.localizedDescription)")}
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
