//
//  User.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 10/4/22.
//
//This custom user object will be used for our database dictionary so we can have access to all user attributes
struct User{
    let fullname: String
    let email: String
    let accountType: Int
    //Initializer takes in a dictionary, then parses through that dictionary and sets all of our users attributes
    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
