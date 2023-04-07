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
    
    //now that we have tha data on the database we will take it and use it in the users feed
    public func post(for username: String, completion: @escaping(Result<[Post], Error>) -> Void) {
        let ref = database.collection("users").document(username).collection("posts")
        ref.getDocuments { snapshot, error in
            guard let posts = snapshot?.documents.compactMap({ Post(with: $0.data())
            }), error == nil else {
                return
            }
            completion(.success(posts))
        }
    }

    public func findUser(with email: String, completion: @escaping(User?) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data())}), error == nil else {
                completion(nil)
                return
            }
            let user = users.first(where: {$0.email == email })
            completion(user)
        }
    }
    
    public func createPost(newPost: Post, completion: @escaping(Bool) -> Void) {
        //how to add a new post
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }
        let reference = database.document("users/\(username)/posts/\(newPost.id)")
        guard let data = newPost.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
        
    }

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
