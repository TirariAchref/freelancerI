//
//  welcomeViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
import CoreData
import CometChatPro
class welcomeViewController: UIViewController {

    var userviewmodel = userVM()
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "signup", sender: sender)
    }
    
    @IBAction func login(_ sender: Any) {
        if(email.text == ""){
            prompt(title: "warning", message: "email is empty")
        }else  if(password.text == ""){
            prompt(title: "warning", message: "password is empty")
        }else{
        
            userviewmodel.getuserconec(Owneruser: email.text!, Ownerpass: password.text! ,successHandler: {anomalyList in
                self.userviewmodel.userToken = anomalyList
               
                self.performSegue(withIdentifier: "login", sender: sender)
                
             
            }, errorHandler: {
                self.prompt(title: "warning", message: "email or MDP Incorrect !! ")
            })
           
             
          
       
        }
    }
   
    
    @IBAction func forgetpass(_ sender: Any) {
        performSegue(withIdentifier: "find", sender: sender)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
          let destination = segue.destination as! tabbarViewController
        destination.userviewmodelm = userviewmodel
           
        }
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
}
