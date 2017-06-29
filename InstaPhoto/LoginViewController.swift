//
//  LoginViewController.swift
//  InstaPhoto
//
//  Created by Isabella Teng on 6/26/17.
//  Copyright © 2017 Isabella Teng. All rights reserved.
//


import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    var usernameFirst: Bool = true
    var passwordFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == usernameField && usernameFirst{
            usernameField.text = ""
            usernameFirst = false
            
        } else if textField == passwordField && passwordFirst {
            passwordField.text = ""
            passwordFirst = false
        }
        
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
        
        emptyCheck(user: username, pass: password)
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil )
            } else {
                let alertController = UIAlertController(title: "Error", message: "Incorrect username and/or password", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    print("User dismissed error")
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true) {
                }

            }
        }
    }
    
    func emptyCheck(user: String, pass: String) {
        if user.isEmpty || pass.isEmpty {
            let alertController = UIAlertController(title: "Empty Field", message: "Please enter your username and/or password", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("User dismissed error")
            })
            
            alertController.addAction(okAction)
            present(alertController, animated: true) {
            }
            
        }
    }

  
   
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.password = passwordField.text
        newUser.username = usernameField.text
        
        emptyCheck(user: newUser.username!, pass: newUser.password!)
        
        newUser.signUpInBackground { (success: Bool, error:Error?) in
            if success {
                print("Created a user successfully")
            } else {
                print(error?.localizedDescription)
                
                if error?._code == 202 {
                    let alertController = UIAlertController(title: "Username is taken", message: "Please choose a different username", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        print("User dismissed error")
                    })
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true) {
                    }
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
