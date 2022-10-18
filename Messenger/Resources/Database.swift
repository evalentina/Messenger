//
//  Database.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 18.10.2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func inserUserInDatabase(user: User) {
        database.child(user.email).setValue([
            "name" : user.name,
            "lastname" : user.lastname
        ])
    }
    
    public func checkIfEmailExists(email: String, completion: @escaping ((Bool) -> () )) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "#", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "[", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "]", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "$", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}

struct User {
    let name : String
    let lastname: String
    let email : String
    
    var safeEmail : String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "#", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "[", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "]", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "$", with: "-")
        return safeEmail
    }
}


