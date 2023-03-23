//
//  AuthManager.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//
import FirebaseAuth
import Foundation
//for authentication

final class AuthManager {
    //singleton
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()

}
