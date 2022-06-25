//
//  user.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation


struct UsersData : Decodable{
    let users : [Userr]?
    private  enum CodingKeys: String, CodingKey {
     
          case users = "results"
       }
}

struct Userr : Decodable {
    let _id :   String?
    let nom : String?
    let prenom :String?
    let email : String?
    let password : String?
    let phone : String?
    let Role : String?
    let imageUrl : String?
    
  private  enum CodingKeys: String, CodingKey {
   
        case _id, email,nom,prenom,password,phone,imageUrl,Role
     }
    
   
 
}
