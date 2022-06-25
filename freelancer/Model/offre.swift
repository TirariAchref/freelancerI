//
//  transaction.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import Foundation


struct Offre : Decodable{
    
    let _id : String?
    let UserId : String?
    let subject : String?
    let description : String?
    
    let Price : String?
    let Status : String?
    let Time : String?
    let imageClient : String?
    let UserIdAccept : String?
    private  enum CodingKeys: String, CodingKey {
     
          case _id, UserId,subject,description,Price,Status,Time,imageClient,UserIdAccept
       }
      
   
   
}
