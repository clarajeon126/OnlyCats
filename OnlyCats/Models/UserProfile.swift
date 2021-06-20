//
//  UserProfile.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import Foundation

public class UserProfile {
    static var currentUserProfile:UserProfile?
    
    var uid: String
    var firstName: String
    var lastName: String
    var profilePhotoURL: URL
    var paws: Int
    
    init(uid: String, firstName: String, lastName: String, profilePhotoURL: URL, paws: Int){
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.profilePhotoURL = profilePhotoURL
        self.paws = paws
    }
    
    static func parse(data:[String: Any], completion: @escaping (_ user: UserProfile) -> ()) {
        print("data before parsing: \(data)")
        if let uid = data["uid"] as? String,
           let firstName = data["firstName"] as? String,
           let lastName = data["lastName"] as? String,
           let paws = data["paws"] as? Int,
           let profilePhotoString = data["profilePhoto"] as? String,
           let profilePhotoURL = URL(string: profilePhotoString) {
            
            let userProfile = UserProfile(uid: uid, firstName: firstName, lastName: lastName, profilePhotoURL: profilePhotoURL, paws: paws)
            
            return completion(userProfile)
        }
    }
}
