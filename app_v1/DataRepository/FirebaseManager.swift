//
//  FirebaseManager.swift
//  app_v1
//
//  Created by Saif Nassar on 29/11/2022.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore =  Firestore.firestore()
        
        super.init()
    }
}
