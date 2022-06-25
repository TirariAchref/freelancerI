//
//  transactionviewmodel.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation
import Alamofire

class offreVM {
    var AllTransaction = [Offre]()
    
    func getOwnerToy(successHandler: @escaping (_ anomalyList: [Offre] ) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/alloffre"
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of:  [Offre].self, decoder: JSONDecoder()) { apiResponse in
                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
                
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                    successHandler(try! apiResponse.result.get())

                    
                    case 500:
                    errorHandler()
               
                default:
                  errorHandler()
                    
                }
                
            }
            
        }
    func updadteoffre(id:String,UserId:String,subject:String,description:String,Price:String,Status:String,Time:String,imageClient:String,UserIdAccept:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updateoffre/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
        let postString = "UserId="+UserId+"&"+"subject="+subject+"&"+"description="+description+"&"+"Price="+Price+"&"+"Status="+Status+"&"+"Time="+Time+"&"+"imageClient="+imageClient+"&"+"UserIdAccept="+UserIdAccept+"&"
             request.httpBody = postString.data(using: .utf8)
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 guard let data = data, error == nil else {                                                 // check for fundamental networking error
                     print("error=\(String(describing: error?.localizedDescription))")
                     return
                 }

                 if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                     print("statusCode should be 200, but is \(httpStatus.statusCode)")
                     print("response = \(String(describing: response))")
                 }

                 let responseString = String(data: data, encoding: .utf8)
                 print("responseString = \(String(describing: responseString))")

                 if(responseString?.contains("true"))!{
                     print("status = true")
                 }
                 else{
                     print("Status = false")
                 }
             }

             task.resume()
         }
    
    func getalltransaction()  {
       
        
        let jsonUrlString = "http://localhost:3000/alloffre"
            guard let url = URL(string: jsonUrlString) else
            { return }

            URLSession.shared.dataTask(with: url) { (data, response, err) in

                guard let data =  data else{ return }

                do {
                    self.AllTransaction.removeAll()

                    let reponses = try JSONDecoder().decode([Offre].self, from: data)
                 
                    reponses.forEach { user in self.AllTransaction.append(user) }
                    
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }

            }.resume()
    }
    

   
    func createtransaction(UserId:String,subject:String,description:String,Price:String,Status:String,Time:String,imageClient:String,UserIdAccept:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createoffre")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "UserId="+UserId+"&"+"subject="+subject+"&"+"description="+description+"&"+"Price="+Price+"&"+"Status="+Status+"&"+"Time="+Time+"&"+"imageClient="+imageClient+"&"+"UserIdAccept="+UserIdAccept+"&"
          
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")

                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
    func deletequestion(id : String){
        var request = URLRequest(url: URL(string: "http://localhost:3000/deleteoffre/"+id)!)
            request.httpMethod = "delete"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
        let postString =
       "description=update&" +
       "datecreation=2020-12-12T08:00:00.000Z&"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")

                if(responseString?.contains("true"))!{
                    print("status = true")
                }
                else{
                    print("Status = false")
                }
            }

            task.resume()
        }
}
