//
//  MainViewController.swift
//  DemoApp
//
//  Created by William Ching on 2019-04-22.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        print(userData.bool(forKey: "logIn"))
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
