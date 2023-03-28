//
//  Database.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import Foundation
import FirebaseFirestore
//for database

final class DatabaseManager {
    //singleton
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()

    public func createUser(newUser: User, completion: @escaping(Bool) -> Void ) {
        //how to add something to the database
        let reference = database.document("users/\(newUser.username)")
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
    
}
