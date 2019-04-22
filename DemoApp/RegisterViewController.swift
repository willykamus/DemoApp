//
//  RegisterViewController.swift
//  DemoApp
//
//  Created by William Ching on 2019-04-21.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordMainLabel: UITextField!
    @IBOutlet weak var passwordConfirmLabel: UITextField!
    
    var newUser:User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerAction(_ sender: UIButton) {
        
        // Before saving the user I have to check if the passwords match
        if checkPasswordMatch() {
            
            //If the passwords match let save the user in the coredata
            //Get the context
            guard let context = appDelegate?.persistentContainer.viewContext else {
                return
            }
            
            //Create the user entity with the context
            let newUser = User(context: context)
            
            //Set the values
            newUser.username = usernameLabel.text
            newUser.email = emailLabel.text
            newUser.password = passwordMainLabel.text
            
            //Set the userdefault values
            
            //This default will allow me to display the log in when the user returns
            userData.set(true, forKey: "registered")
            //This default will allow me to launch the app if the user is sign in
            userData.set(true, forKey: "logIn")
            
            //ALWAYS synchronize the data
            userData.synchronize()
            
            //Every attempt to modify coredata should be do with do try and catch
            do {
                //This will try to save the new user into the coredata
                //Similar to commit!
                try context.save()
                print("Saved user")
            } catch {
                print("Unable to save user")
            }
            
            
        } else {
            
            print("Passwords do not match")
            // Show some kind of message
            
        }
        
    }
    
}

extension RegisterViewController {
    
    //Lets check the passwords and return the result as boolean
    func checkPasswordMatch() -> Bool{
        
        if passwordMainLabel.text == passwordConfirmLabel.text {
            return true
        } else {
            return false
        }
        
    }
    
}
