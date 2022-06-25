//
//  userviewmodel.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation

import Alamofire

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}


class userVM {
  
    var userdata = [Userr]()
    var tokenString : String?
    var useronhold: Userr?
    var userToken : Userr?
    var userByemail : Userr?
    var userByid : Userr?
    var regestirUser : Userr?
    @Published var isAuthenticated : Bool = false
    func getOwnerToy(OwnerId:String, successHandler: @escaping (_ anomalyList: Userr) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/getuser/"+OwnerId
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of: Userr.self, decoder: JSONDecoder()) { apiResponse in
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
    func getuserconec(Owneruser:String,Ownerpass:String, successHandler: @escaping (_ anomalyList: Userr) -> (),errorHandler: @escaping () -> ())
        { var request = URLRequest(url: URL(string: "http://localhost:3000/loginClient")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let postString = "email="+Owneruser+"&"+"password="+Ownerpass+"&"
            request.httpBody = postString.data(using: .utf8)
            AF.request(request).validate().responseDecodable(of: Userr.self, decoder: JSONDecoder()) { apiResponse in
                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
                
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                    let responseString = String(data: apiResponse.data!, encoding: .utf8)
                    print(responseString as Any)
                    successHandler(try! apiResponse.result.get())

                    case 500:
                    errorHandler()
               
                default:
                  errorHandler()
                    
                }
                
                
            }
           
        }
    //alomofire update toy
        func updateToys(Image:UIImage,toy:Userr?,successHandler: @escaping (_ toy: Userr?) -> (),errorHandler: @escaping () -> ())
        {
            let urlApi = "http://localhost:3000/updateImageClient/"+(toy?._id)!
            print(urlApi)
            let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]

            
        AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(Image.jpegData(compressionQuality: 0.5)!, withName: "Image" , fileName: "Image.jpeg", mimeType: "Image/jpeg")

              
        },to: urlApi, method: .post , headers: headers).responseDecodable(of: Userr.self, decoder: JSONDecoder()) { apiResponse in

                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
        
                switch apiResponse.response?.statusCode {
                    case 200:
                        successHandler(try! apiResponse.result.get())
                    case 500:
                    print("Error 500 update toy")
                        errorHandler()
                default:
                    errorHandler()
                }
            }
        
        }
    
    
    func getOwnermail(OwnerId:String, successHandler: @escaping (_ anomalyList: [Userr]) -> (),errorHandler: @escaping () -> ())
        {
            let url = "http://localhost:3000/getuserEmail/"+OwnerId
            print("getOwnerToy : "+url)
            
            AF.request(url, method: .get).validate().responseDecodable(of: [Userr].self, decoder: JSONDecoder()) { apiResponse in
                guard apiResponse.response != nil else{
                    errorHandler()
                    return
                }
                
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                   // let responseString = String(data: apiResponse.data!, encoding: .utf8)
              
                    successHandler(try! apiResponse.result.get())

                    case 500:
                    errorHandler()
               
                default:
                  errorHandler()
                    
                }
                
            }
            
        }
    func signout() {
               
               let defaults = UserDefaults.standard
               defaults.removeObject(forKey: "jsonwebtoken")
               DispatchQueue.main.async {
                   self.isAuthenticated = false
                   print(self.isAuthenticated)
               }
               
           }
    func getbyemail(email : String){
         
          
          let jsonUrlString = "http://localhost:3000/getuserEmail/"+email
              guard let url = URL(string: jsonUrlString) else
              { return }

              URLSession.shared.dataTask(with: url) { (data, response, err) in

                  guard let data =  data else{ return }

                  do {

                      let Allusers = try JSONDecoder().decode([Userr].self, from: data)
                     
                      Allusers.forEach { user in self.userByemail = user }
                  
                      
           
                  } catch let jsonErr {
                      print("Error serializing json:", jsonErr)
                  }

              }.resume()
        

         
      }
      
    
    func createuser(nom : String,prenom:String,email:String,password:String,phone:String,imageUrl:String,Role:String){
            var request = URLRequest(url: URL(string: "http://localhost:3000/createuser")!)
            request.httpMethod = "post"
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("its working")
            let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"password="+password+"&"+"phone="+phone+"&"+"imageUrl="+imageUrl+"&"+"Role="+Role+"&"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error?.localizedDescription))")
                    return
                }


                do {

                    let Allusers = try JSONDecoder().decode(Userr.self, from: data)
                   
                   
                    DispatchQueue.main.async {
                        self.regestirUser = Allusers
                    }
                    print("name = " + Allusers.nom!)
                    print("email = " + Allusers.email!)
                    print("phone = " + Allusers.phone!)
                    print("imageurl = " + Allusers.imageUrl!)
                   
         
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }

            task.resume()
        }
    
    
    func updateuser(id:String,nom : String,prenom:String,email:String,password:String,phone:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updateuser/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"password="+password+"&"+"phone="+phone+"&"
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
    
    func updateuserpass(id:String,nom : String,prenom:String,email:String,phone:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/updateuserpass/"+id)!)
             request.httpMethod = "put"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "nom="+nom+"&"+"prenom="+prenom+"&"+"email="+email+"&"+"phone="+phone+"&"
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
    
    func sendsms(code:String){
         var request = URLRequest(url: URL(string: "http://localhost:3000/sendsms")!)
             request.httpMethod = "post"
             request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
             print("its working")
         let postString = "code="+code+"&"
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
