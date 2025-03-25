//
//  User.swift
//  ScratchApp
//
//  Created by HTS-676 on 07/03/25.
//


struct User{
    var id: Int
    var name: String
    var email: String
    var password: String
    var address: String
    
    init(id: Int, name: String, email: String, password: String, address: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.address = address
    }
}
