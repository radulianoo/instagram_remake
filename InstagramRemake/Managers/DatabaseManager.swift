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

}
