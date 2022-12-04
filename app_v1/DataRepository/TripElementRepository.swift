//
//  TripElementRepository.swift
//  app_v1
//
//  Created by Emma Herrera on 12/3/22.
//

import Foundation

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class TripElementRepository: ObservableObject, Identifiable {
	
	private let path: String = "elements"
	private let store = Firestore.firestore()
	
	@Published var elements: [Element] = []
	private var cancellables: Set<AnyCancellable> = []
	
	init() {
		self.retrieve()
	}
	
	func retrieve() {
		store.collection(path).addSnapshotListener { querySnapshot, error in
			if let error = error {
				print("Error getting elements: \(error.localizedDescription)")
				return
			}
			
			self.elements = querySnapshot?.documents.compactMap { document in try? document.data(as: Element.self)
			} ?? []
		}
	}
	
	func add(_ elem: Element) {
		do {
			let newElem = elem
			_ = try store.collection(path).addDocument(from: newElem)
		} catch {
			fatalError("Unable to add element: \(error.localizedDescription).")
		}
	}
	
}
