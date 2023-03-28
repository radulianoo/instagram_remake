//
//  Storage.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import Foundation
import FirebaseStorage
//for saving info 

final class StorageManager {
    //singleton
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()

    public func uploadProfilePicture(username: String, data: Data?, completion: @escaping (Bool)-> Void) {
        guard let data = data else {
            return
        }
        storage.child("\(username)/profile_picture.png").putData(data, metadata: nil) { _, error in
            completion(error == nil)
        }
    }
}
