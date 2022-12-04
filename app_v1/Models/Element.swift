//
//  Element.swift
//  app_v1
//
//  Created by Saifudden Ahmad Abdullah Nassar on 11/19/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Element: Identifiable, Codable {
	@DocumentID var id: String? = UUID().uuidString
	var title: String
	var elemType: String
	var time: Date
	var description: String
	var day: Int
	var tripID: String

	
	enum CodingKeys: String, CodingKey {
		case title
		case elemType
		case time
		case description
		case day
		case tripID

	}
	
	
}
