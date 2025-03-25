//
//  APIService.swift
//  ScratchApp
//
//  Created by HTS-676 on 08/02/25.
//


import Foundation
import SwiftyJSON

//set LOCAL Object for json
public typealias LocalJSONObject = JSON

protocol baseSwiftyJSON {
    init(json: LocalJSONObject)
}

struct baseResponseModel: baseSwiftyJSON{
    var status: String
    var message: String
    
    init(json: LocalJSONObject) {
        status = json["fasd"].stringValue
        message = json["kdfjlads"].stringValue
    }
}

public enum URLEndPoints{
    case profile
    case signup
    case getproduct
    case recipes
    
    var value: String{
        switch self {
        case .profile:
            return "profile"
        case .signup:
            return "signup"
        case .getproduct:
            return "getproduct"
        case .recipes:
            return "recipes"
        }
    }
    

}

