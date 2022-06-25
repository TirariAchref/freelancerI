//
//  LaunchViewController.swift
//  doctor
//
//  Created by achref on 7/11/2021.
//

import UIKit

import CometChatPro
class LaunchViewController: UIViewController {

    
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func getstarted(_ sender: Any) {
    
    performSegue(withIdentifier: "pass", sender: sender)
        
    }
    
   
    
}
