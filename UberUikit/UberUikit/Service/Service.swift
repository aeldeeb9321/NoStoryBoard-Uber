//
//  Service.swift
//  UberUikit
//
//  Created by Ali Eldeeb on 10/4/22.
//

import Firebase
import FirebaseDatabase
import FirebaseAuth

let DB_REF = Database.database().reference() //This is how we can access our unique database for our application
let REF_USERS = DB_REF.child("users") //This says go to the database for our app, and access the child node "users:
struct Service{
    static let shared = Service() //static makes sure its only created on time(singleton), no need to instantiate it in homecontroller fetch func
    let currentUid = Auth.auth().currentUser?.uid
    //making an api call, getting a callback of a snapshot, and whatever happens in the completion block we have access to the snapshot. Then checked that snapshotvalue exists. Finally, casted it and stored it as a dictionary.
    func fetchUserData(completion: @escaping(User) -> Void){ //the completionblock will return us w/ a User once the api call is done
        if let currentUid = currentUid{
            //fetching some user data and stopping everything
            REF_USERS.child(currentUid).observeSingleEvent(of: .value) { snapshot,_  in //by tapping into the child we make sure we only get current user data instead of all user data
                guard let snapDict = snapshot.value as? [String: Any] else{return} //Our snapshot.value is being casted as a hash map
                let user = User(dictionary: snapDict)
                print("Debug: user email is \(user.email)")
                print("Debug: user full name is \(user.fullname)")
                
                completion(user)
            }
        }
        
    }
}
