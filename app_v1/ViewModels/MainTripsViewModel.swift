//
//  MainTripsViewModel.swift
//  app_v1
//
//  Created by Saif Nassar on 29/11/2022.
//

import Foundation
import Firebase
import FirebaseStorage

class MainTripsViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var trip: Trip?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument {
            snapshot, error in if let error = error {
                print("Failed to fetch current user", error)
                return
            }
            
            guard let data = snapshot?.data() else { return }
            print(data)
            //            self.errorMessage = "\(data.description)"
            
            //            decoding...
            let uid = data["uid"] as? String ?? ""
            let fname = data["fname"] as? String ?? ""
            let lname = data["lname"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            
            self.user = User(uid: uid, fname: fname, lname: lname, email: email)
            
        }
    }
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
    
}
