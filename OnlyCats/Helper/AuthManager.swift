//
//  AuthManager.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    //get user id (mostly for google sign in and stuff)
    public func getUserId() -> String?{
        guard let uid = Auth.auth().currentUser?.uid else {
            return "not signed in"
        }
        return uid
    }

    //to log out a user
    public func logOut(completion: (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            UserProfile.currentUserProfile = nil
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}
