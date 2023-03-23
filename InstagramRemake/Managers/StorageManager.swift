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
    static let storage = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage()

}
