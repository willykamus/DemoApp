//
//  ViewController.swift
//  DemoApp
//
//  Created by William Ching on 2019-04-21.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
var userData = UserDefaults.standard

class LogInViewController: UIViewController {

    var currentUser = [User]()
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInAction(_ sender: UIButton) {
        
        lookForUserEmail { (done) in
            if done {
                
                userData.setValue(true, forKey: "logIn")
                userData.synchronize()
                
                print("LogIn succesful")
            } else {
                print("LogIn fail")
            }
        }
        
    }
    
    
    func lookForUserEmail(completion:(_ done: Bool )->()) {
        
        let email = emailLabel.text!
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let predicate = NSPredicate(format: "email == %@", email)
        
        userFetch.predicate = predicate
        
        do {
            
            try currentUser = context.fetch(userFetch) as! [User]
            completion(true)
            
        } catch {
            
            print("Failed to find user with that email address: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
}

