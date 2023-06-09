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
    //singleton, this constant it belongs to the class itself not to the instance
    //ensuring only one shared instance of the class exist
    static let shared = AuthManager()
    //to access this instance we will make it only with the shared property
    private init() {}
    //handling the authentication
    let auth = Auth.auth()

    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signIn(email: String, password: String, completion: @escaping(Result<User, Error>) -> Void) {
        
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil , error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }
                
                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                completion(.success(user))
            }
        }
        
        
    }
    
    public func signUp(email: String, username: String, password: String, profilePicture: Data?, completion: @escaping(Result<User, Error>) -> Void) {
        let newUser = User(username: username, email: email)
        //create the user account
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil , error == nil else {
                completion(.failure(AuthError.newUserCreation))
                return
            }
        
        //insert new user account to database
            DatabaseManager.shared.createUser(newUser: newUser) { succes in
                if succes {
                    StorageManager.shared.uploadProfilePicture(username: username, data: profilePicture) { uploadSucces in
                        if uploadSucces {
                            completion(.success(newUser))
                        }
                        else {
                            completion(.failure(AuthError.newUserCreation))
                        }
                    }
                }
                else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }
}
