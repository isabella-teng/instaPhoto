//
//  LoginViewController.swift
//  InstaPhoto
//
//  Created by Isabella Teng on 6/26/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//

//TO DO: alert if login/sign up isn't successful. alert if is successful

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        usernameField.text = ""
        passwordField.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    

    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil )
            }
        }
    }
  
   
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.password = passwordField.text
        newUser.username = usernameField.text
        
        newUser.signUpInBackground { (success: Bool, error:Error?) in
            if success {
                print("Created a user successfully")
            } else {
                print(error?.localizedDescription)
                
                if error?._code == 202 {
                    print("Username is taken")
                }
            }
        }
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
