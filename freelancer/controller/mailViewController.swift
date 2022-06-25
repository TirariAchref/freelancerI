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

    var userviewmodelm = userVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid    = userviewmodelm.userToken?.phone
        let authKey = "4335de000f7d766c122f24d76b705efd5b45c133"

        CometChat.login(UID: uid!, apiKey: authKey, onSuccess: { (user) in
          print("Login successful: " + user.stringValue())
        }) { (error) in
          print("Login failed with error: " + error.errorDescription);
        }
        DispatchQueue.main.async {
        let cometChatUI = CometChatUI()
        cometChatUI.setup(withStyle: .pageSheet)
        self.present(cometChatUI, animated: true, completion: nil)
        }
    }
    
}
