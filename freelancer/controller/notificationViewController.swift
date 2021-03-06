//
//  notificationViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Alamofire
class notificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//var
    var userviewmodelm = userVM()
    var questionviewmodel = offreVM()
    private let refreshControl = UIRefreshControl()
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movie : Offre?
    var data = [Offre]()
    var filteredData = [Offre]()
    var usertable : Userr?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
         
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mSegue"{
            let destination = segue.destination as! offredetailsaccept
            destination.userviewmodelm = userviewmodelm
            destination.question = movie
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                    //film.remove(at: indexPath.row)
            self.present(Alert.makeActionAlert(titre: "Success", message:  "Do you want to Delete Offre ? ", action: UIAlertAction(title: "Delete", style: .default, handler: { action in
        
                self.questionviewmodel.deletequestion(id: (self.filteredData[indexPath.row]._id)!)
              
                        self.tableView.reloadData()
                
               
            })),animated: true)
           
                }
        
        
    }
    

    
    @IBOutlet weak var imageuser: UIImageView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         movie = filteredData[indexPath.row]
        performSegue(withIdentifier: "mSegue", sender: nil)
        
    }
 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     // When there is no text, filteredData is the same as the original data
     // When user has entered text into the search box
     // Use the filter method to iterate over all items in the data array
     // For each item, return true if the item should be included and false if the
     // item should NOT be included
     filteredData = searchText.isEmpty ? data : data.filter({(dataString: Offre) -> Bool in
         // If dataItem matches the searchText, return true to include it
         return dataString.subject!.range(of: searchText, options: .caseInsensitive) != nil
     })

     tableView.reloadData()
 }
    
    
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
        imageuser.layer.masksToBounds = false
        imageuser.layer.borderColor = UIColor.black.cgColor
        imageuser.layer.cornerRadius = imageuser.frame.height/2
        imageuser.clipsToBounds = true
        imageuser.af.setImage(withURL: url)
    
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
                    
            anomalyList.forEach{ msg in if(msg.UserId == self.userviewmodelm.userToken?._id  ){self.data.append(msg)} }
            self.filteredData = self.data
            self.filteredData.reverse()
            self.tableView.reloadData()
                }, errorHandler: {
                    print("errorororoor")
                })
           
  
        //
        
       
        //
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
     
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Reload Data ...")
    }
    

   
    //action
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        filteredData.removeAll()
        data.removeAll()
        tableView.reloadData()
        questionviewmodel.getOwnerToy(successHandler: {anomalyList in
                    
            anomalyList.forEach{ msg in if(msg.UserId == self.userviewmodelm.userToken?._id  ){self.data.append(msg)} }
            self.filteredData = self.data
            self.filteredData.reverse()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
                }, errorHandler: {
                    print("errorororoor")
                })
       
              
                
            
        
    }
   
}
