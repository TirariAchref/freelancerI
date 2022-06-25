//
//  OnBoardViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
import CometChatPro
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
class OnBoardViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    var emailfb : String?
    var namefb : String?
    var fb = false
    @IBOutlet weak var txtTitle: UITextField!
    let songNames = ["user","doctor"]
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
       {
               return songNames[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
       {
           let obj = songNames[row]
           txtTitle.text = obj

       }

       func numberOfComponents(in pickerView: UIPickerView) -> Int {

           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
       {
           return songNames.count

       }
    

    @IBOutlet weak var Picker: UIPickerView!
    
    var nom : String?
     var userviewmodelm = userVM()
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var conpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        if(fb == true){
            name.text = namefb
            email.text = emailfb
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
       
        if(name.text == ""){
            prompt(title: "warning", message: "name is empty")
        }else  if(email.text == ""){
            prompt(title: "warning", message: "email is empty")
        }else  if(password.text == ""){
            prompt(title: "warning", message: "password is empty")
        }else  if(conpassword.text == ""){
            prompt(title: "warning", message: "password is empty")
        }else  if(number.text == ""){
            prompt(title: "warning", message: "number is empty")
        }else{
            if validateEmail(enteredEmail: email.text!) {
                if(password.text == conpassword.text){
                   
                    userviewmodelm.createuser(nom: name.text!, prenom: name.text!, email: email.text!, password: password.text!, phone: number.text!,imageUrl: "profile", Role: "String")
                        sleep(2)
                    
                    userviewmodelm.getuserconec(Owneruser: email.text!, Ownerpass: password.text! ,successHandler: {anomalyList in
                        self.userviewmodelm.userToken = anomalyList
                        
                        let uid = anomalyList.phone
                        let name = anomalyList.nom
                         let authKey = "4335de000f7d766c122f24d76b705efd5b45c133"

                         let newUser : User = User(uid: uid!, name: name!)
                       

                         CometChat.createUser(user: newUser, apiKey: authKey, onSuccess: { (User) in
                               print("User created successfully. \(User.stringValue())")
                           }) { (error) in
                              print("The error is \(String(describing: error?.description))")
                         }
                         

                        self.performSegue(withIdentifier: "login", sender: sender)
                            }, errorHandler: {
                                print("errorororoor")
                            })
                           
                        
                        
                      
                      
           
                   
                }else{
                    prompt(title: "warning", message: "password don't match")
                }
            }else{
                prompt(title: "warning", message: "email No valide")
            }
           
          
        }
   
      
        
    }
    
 
   
    
    
    @IBAction func sign(_ sender: Any) {
        performSegue(withIdentifier: "signin", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let destination = segue.destination as! tabbarViewController
            destination.userviewmodelm = userviewmodelm
           
        }
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
}
