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
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        
        userData.set(false, forKey: "logIn")
        userData.synchronize()
        
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
