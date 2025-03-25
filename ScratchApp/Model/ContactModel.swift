//
//  ContactModel.swift
//  ScratchApp
//
//  Created by HTS-676 on 04/01/25.
//

import UIKit
import SwiftyJSON

struct ContactModel {
    var name: String
    var phoneNumber: String
    var image: UIImage? // Optional image property
    
    init(name: String = "", phoneNumber: String = "", image: UIImage? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
    }
}


struct ContactResponseModel{
    var id: String!
    var age: Int!
    var name: String!
    var gender: String!
    var company: String!
    var email: String!
    var photo: String!
    var phone_no: String!
    
    init(fromjson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].stringValue
        age = json["age"].intValue
        name = json["name"].stringValue
        gender = json["gender"].stringValue
        company = json["company"].stringValue
        email = json["email"].stringValue
        photo = json["photo"].stringValue
        phone_no = json["phone_no"].stringValue
        
    }
}

/*
 {
     "id": "5b2eee0a8fdd5b71c8148490",
     "age": 29,
     "name": "Campos York",
     "gender": "male",
     "company": "AVENETRO",
     "email": "camposyork@avenetro.com",
     "photo": "https://randomuser.me/api/portraits/men/3.jpg"
 }
 */
