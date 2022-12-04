//
//  Trip.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Trip: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var destination: String
    var startDate: Date
    var endDate: Date
    var element: [String]?
    var userID: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case destination
        case startDate
        case endDate
        case element
        case userID
    }
    
    
}
