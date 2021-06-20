//
//  AppDelegate.swift
//  OnlyCats
//
//  Created by Clara Jeon on 6/20/21.
//

import UIKit
import Firebase
import GoogleSignIn
import Kommunicate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //firebase
        FirebaseApp.configure()
        
        //google sign in
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        Kommunicate.setup(applicationId: "168b157c6261ba66ce468994213834b28")
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // access token
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
            }
            
            let isNewUser = authResult?.additionalUserInfo?.isNewUser
            
            if isNewUser ?? false {
                let firstName = user.profile.givenName ?? "firstName"
                let lastName = user.profile.familyName ?? "lastName"
                let profilePhotoImage = GIDSignIn.sharedInstance()?.currentUser.profile.hasImage
                
                var profilePhotoUrl: URL?
                
                //when user has a google profile image
                if (profilePhotoImage ?? false){
                    let googleProfilePhotoUrl = GIDSignIn.sharedInstance()?.currentUser.profile.imageURL(withDimension: 400)?.absoluteString
                    
                    StorageManager.shared.uploadGoogleUrlProfilePhoto(googleProfilePhotoUrl!) { (url) in
                        profilePhotoUrl = url
                        DatabaseManager.shared.insertNewUser(firstName: firstName, lastName: lastName, uid: "googleid", profilePhotoURL: url!) { success in
                            // Post notification after user successfully sign in
                            NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
                            
                        }
                    }
                }
                else {
                    let defaultProfilePhoto = #imageLiteral(resourceName: "defaultpp")
                    
                    StorageManager.shared.uploadGeneralProfilePhoto(defaultProfilePhoto) { (url) in
                        profilePhotoUrl = url
                        
                        DatabaseManager.shared.insertNewUser(firstName: firstName, lastName: lastName, uid: "googleid", profilePhotoURL: url!) { success in
                            // Post notification after user successfully sign in
                            NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
                            
                        }
                    }
                }
            }
            else {
                NotificationCenter.default.post(name: .returnUserSignInGoogleCompleted, object: nil)
            }
            
            
            
        }
    }
}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



