//
//  DatabaseManager.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/18/21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private let userDatabase = Database.database().reference().child("users")
    
    //inserts a new user into the database
    public func insertNewUser(firstName: String, lastName: String, uid: String, profilePhotoURL: URL, completion: @escaping (Bool) -> Void){
        
        UserProfile.currentUserProfile = UserProfile(uid: uid, firstName: firstName, lastName: lastName, profilePhotoURL: profilePhotoURL, paws: 500)
        
        
        userDatabase.child(uid).setValue(["uid": uid, "firstName": firstName, "lastName": lastName,
                                          "profilePhoto": profilePhotoURL.absoluteString,"paws": 500]) { (error, _) in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
    //create a copy with a diferent user id for google sign in
    public func changeUid(completion: @escaping ((_ success: Bool) -> ())) {
        let uid = Auth.auth().currentUser!.uid
        print("new uid from google sign in: \(uid)")

        userDatabase.child("googleid").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let firstName = dictionary["firstName"] as! String
                let lastName = dictionary["lastName"] as! String
                let profilePicString = dictionary["profilePhoto"] as! String
                let profilePicUrl = URL(string: profilePicString)
                let paws = dictionary["paws"] as! Int
                
                DatabaseManager.shared.insertNewUser(firstName: firstName, lastName: lastName, uid: uid, profilePhotoURL: profilePicUrl!) { success in
                    
                    if success {
                        let ref = self.userDatabase.child("googleid").ref
                        
                        ref.removeValue()
                        
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
        }
        
    }
    
    public func observeUserProfile(_ uid: String, completion: @escaping ((_ userProfile: UserProfile?) -> ())) {
        let userRef = database.child("users/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            
            let dict = snapshot.value as! [String: Any]
            UserProfile.parse(data: dict) { userProfile in
                completion(userProfile)
            }
            
        })
    }
    
    //get cats from firebase database
    public func getCats(completion: @escaping ((_ cats: [Cat]) -> ())){
        let catRef = database.child("cats")
        
        var queryCats: DatabaseQuery {
            var catQueryRef: DatabaseQuery
            catQueryRef = catRef.queryOrdered(byChild: "name")
            return catQueryRef
        }
        
        queryCats.observeSingleEvent(of: .value) { snapshot in
            var cats = [Cat]()
            var numOfChildThroughFor = 0
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    if let data = childSnapshot.value as? [String: Any]{
                        Cat.parse(data: data) { cat in
                            numOfChildThroughFor += 1
                            cats.append(cat)
                            if numOfChildThroughFor == snapshot.childrenCount {
                                return completion(cats)
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
}
