//
//  receipeModel.swift
//  ScratchApp
//
//  Created by HTS-676 on 08/03/25.
//


struct receipeModel: baseSwiftyJSON {
    var id: Int
    var name: String
    var ingredients: [String]
    var image: String
    var rating: String

    init(json: LocalJSONObject) {
        id = json["id"].intValue
        name = json["name"].stringValue
        ingredients = json["ingredients"].arrayValue.map({$0.stringValue})
        image = json["image"].stringValue
        rating = json["rating"].stringValue
    }
}

struct receipeListModel: baseSwiftyJSON{
    var receipeList: [receipeModel]
    init(json: LocalJSONObject) {
        receipeList = json["recipes"].arrayValue.map({ receipeModel.init(json: $0) })
    }
}

