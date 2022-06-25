//
//  newquestionViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class newquestionViewController: UIViewController {

    var userviewmodelm = userVM()
    var questionviewmodel = offreVM()

    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var time: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if(subject.text == ""){
            prompt(title: "warning", message: "Subject is empty")
        }else  if(question.text == ""){
            prompt(title: "warning", message: "Description is empty")
        }else  if(price.text == ""){
            prompt(title: "warning", message: "price is empty")
        }else  if(time.text == ""){
            prompt(title: "warning", message: "time is empty")
        }else {
            questionviewmodel.createtransaction(UserId: (userviewmodelm.userToken?._id)!, subject: subject.text!, description: question.text!, Price: price.text! + " DT", Status: "false", Time: time.text! + " Days", imageClient: "String", UserIdAccept: "String")
           
            prompt(title: "Succes", message: "Offre added successfully")
        }
        
    }
    
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

}
