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
    var correctPassword = false
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //We need to override this method to specify the conditions to trigger the segue
    //This is needed because we have a connection between storyboard with a segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if correctPassword {
            return true
        }
        
        return false
    }

    @IBAction func logInAction(_ sender: UIButton) {
        
        //First I need to retrieve the user entity to check password later
        lookForUserEmail { (done) in
            if done {
                //We have to check if the fetch found something
                if currentUser.count == 0 {
                    
                    print("User not found")
                    
                } else {
                    
                    //Since we know we have an user, lets get its password
                    let validPassword = currentUser[0].password
                    //Check if password are the same
                    if validPassword == passwordLabel.text {
                        //Set the defaull to true
                        userData.setValue(true, forKey: "logIn")
                        //Synchronize
                        userData.synchronize()
                        //Let the controller know that the password is correct
                        //The idea of this is to prevent the segue to be launch
                        //With a wrong password, for that we need to override shouldPerformSegue
                        correctPassword = true
                    } else {
                        correctPassword = false
                        print("Pasword do not match")
                    }
                }
            }
        }

    }
    
    
    func lookForUserEmail(completion:(_ done: Bool )->()) {
        
        let email = emailLabel.text!
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        //Request for all the user in our app
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //Predicates are like filter for the fetch request
        let predicate = NSPredicate(format: "email == %@", email)
        //Set the predicate to our request
        userFetch.predicate = predicate
        
        do {
            //Ask the app to retrieve the specific user and save it in a variable
            currentUser =  try context.fetch(userFetch) as! [User]
            print(currentUser)
            //Completion will allow me to continue the process
            completion(true)
            
        } catch {
            
            print("Failed to find user with that email address: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
}

