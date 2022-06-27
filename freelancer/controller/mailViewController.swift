//
//  mailViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
import CometChatPro
class mailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    var userviewmodelm = userVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
        
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.af.setImage(withURL: url)
        name.text = (userviewmodelm.userToken?.nom)!
    }
    
    @IBAction func button(_ sender: Any) {
        let uid    = userviewmodelm.userToken?.phone
        let authKey = "4335de000f7d766c122f24d76b705efd5b45c133"

        CometChat.login(UID: uid!, apiKey: authKey, onSuccess: { (user) in
          print("Login successful: " + user.stringValue())
        }) { (error) in
          print("Login failed with error: " + error.errorDescription);
        }
        DispatchQueue.main.async {
        let cometChatUI = CometChatUI()
        cometChatUI.setup(withStyle: .formSheet)
        self.present(cometChatUI, animated: true, completion: nil)
        }
    }
}
