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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        if checkPasswordMatch() {
            
            guard let context = appDelegate?.persistentContainer.viewContext else {
                return
            }
            
            let newUser = User(context: context)
            newUser.username = usernameLabel.text
            newUser.email = emailLabel.text
            newUser.password = passwordMainLabel.text
            
            userData.set(true, forKey: "registered")
            userData.set(true, forKey: "logIn")
            
            userData.synchronize()
            
            do {
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
    
    func checkPasswordMatch() -> Bool{
        
        if passwordMainLabel.text == passwordConfirmLabel.text {
            return true
        } else {
            return false
        }
        
    }
    
}
