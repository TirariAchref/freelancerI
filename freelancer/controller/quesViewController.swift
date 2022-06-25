//
//  quesViewController.swift
//  doctor
//
//  Created by User on 01.01.2022.
//

import UIKit
import Cosmos
import TinyConstraints
class quesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var userviewmodelm = userVM()
    var questionviewmodel = offreVM()
    var question : Offre?
    var usertable : Userr?
    var filteredData = [Offre]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           tableView.backgroundColor = UIColor(hex: 0xE6FAF0)
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           let Time = contentView?.viewWithTag(4) as! UILabel
           let Price = contentView?.viewWithTag(5) as! UILabel
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
           Time.text = "Time :" +  filteredData[indexPath.row].Time!
           Price.text = "Price :" +  filteredData[indexPath.row].Price!
           label.text = filteredData[indexPath.row].subject
           text.text = filteredData[indexPath.row].description
           userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row].UserId)! , successHandler: {anomalyList in
               self.usertable = anomalyList
               print("alamofire :")
               print(self.usertable!)
               var path = String("http://localhost:3000/"+(self.usertable?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
               imageView.af.setImage(withURL: url)
                   }, errorHandler: {
                       print("errorororoor")
                   })
           
           
           
           return cell!
           
       }
       
       
       
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
           return
       }

    @IBOutlet weak var reponse: UIButton!
    lazy var cosmosView : CosmosView = {
            var view = CosmosView()
            //maadch aandk l hak t modifi
            //view.settings.updateOnTouch = false
            view.settings.fillMode = .half
            view.settings.starMargin = 4
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData.append(question!)
       
     
    }
    

   
    @IBAction func reponsebutton(_ sender: Any) {
        questionviewmodel.updadteoffre(id: (question?._id!)!, UserId: (question?.UserId)!, subject: (question?.subject)!, description: (question?.description)!, Price: (question?.Price)!, Status: "true", Time: (question?.Time)!, imageClient: (question?.imageClient)!, UserIdAccept: (userviewmodelm.userToken?._id)!)
        prompt(title: "Succes", message: "Offre Updated successfully")
                                       
    }
    
  
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
}
