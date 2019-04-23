//
//  MainViewController.swift
//  DemoApp
//
//  Created by William Ching on 2019-04-22.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var currentUser:[User]!
    var listUser = [User]()
    let cellid = "CellId"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let email = userData.value(forKey: "userEmail") as? String else {return}
        
        lookForUserEmail()
        
        fetchUsers { (done) in

            print(listUser)

            if done {
                var i = 0
                for user in listUser{
                    if user.email == email{
                        listUser.remove(at: i)
                        i = i - 1
                    }
                    i = i + 1
                }
            }

        }
        
        navigationItem.title = currentUser[0].username

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        
        //Set the user default as false
        userData.set(false, forKey: "logIn")
        //ALWAYS synchronize to save the data
        userData.synchronize()
        /////////////////////
        //Need to ask why the dimiss return to the previous screen with the information
        //dismiss(animated: true, completion: nil)
        /////////////////////
        
        
        //How to launch a view controller without a segue in storyboard
        
        //Look for the storyboard it is in
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Save the controller as a variable of the type of that controller if we are going to set anything
        //Inside that controller
        let registerView = storyboard.instantiateViewController(withIdentifier: "UserTabViewController") as! UserTabViewController
        //In this example, I set the var to UserTab because I want to display an specific index
        registerView.selectedIndex = 1
        
        //Finally we call that viewcontroller.. It is important that the view and the view controller
        //Are asociated
        self.present(registerView, animated: true, completion: nil)
        
    }
    
    
}

extension MainViewController {
    
    func lookForUserEmail() {
        
        guard let email = userData.value(forKey: "userEmail") as? String else {return}
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        //Request for all the user in our app
        var userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //Predicates are like filter for the fetch request
        let predicate = NSPredicate(format: "email == %@", email)
        //Set the predicate to our request
        userFetch.predicate = predicate
        
        do {
            //Ask the app to retrieve the specific user and save it in a variable
            currentUser =  try context.fetch(userFetch) as! [User]
    
            //Completion will allow me to continue the process
            
            
        } catch {
            
            print("Failed to find user with that email address: ", error.localizedDescription)
            
        }
        
    }
    
    func fetchUsers(completion:(_ done: Bool )->()){
            
            guard let context = appDelegate?.persistentContainer.viewContext else { return }
            
            //Request for all the user in our app
            var userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

            do {
                
                listUser =  try context.fetch(userFetch) as! [User]
                print(listUser)
                completion(true)
                
            } catch {
                
                print("Failed to find user with that email address: ", error.localizedDescription)
                completion(false)
            }
        
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! UserTableViewCell
        
        cell.usernameLabel.text = listUser[indexPath.row].username
        cell.emailLabel.text = listUser[indexPath.row].email
        
        return cell
        
    }
    
    
    
}
