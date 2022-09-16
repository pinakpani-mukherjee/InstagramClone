//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    public func createUser(newUser: User, completion: @escaping (Bool) -> Void){
        let reference = database.document("users/\(newUser.username)")
        guard let data = newUser.asDictonary() else {
            completion(false)
            return 
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
}
