//
//  userdetails.swift
//  freelancer
//
//  Created by User on 27.06.2022.
//

import UIKit
import Cosmos
import TinyConstraints
class userdetails: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var userviewmodelm = userVM()
    var questionviewmodel = offreVM()
    var question : Offre?
    var useraccep : Userr?
    var usertable : Userr?
    var filteredData = [Userr]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           let Time = contentView?.viewWithTag(4) as! UILabel
        
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
           Time.text = "Phone :" +  filteredData[indexPath.row].phone!
       
           label.text = filteredData[indexPath.row].nom
           text.text = "Email :" +  filteredData[indexPath.row].email!
           userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row]._id)! , successHandler: {anomalyList in
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

   
    override func viewDidLoad() {
        super.viewDidLoad()
     
        filteredData.append(useraccep!)
        // Do any additional setup after loading the view.
    }
    
    
  
 


}
