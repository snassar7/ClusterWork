//
//  TripRepository.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class TripRepository: ObservableObject, Identifiable {

    private let path: String = "trips"
    private let store = Firestore.firestore()

      @Published var trips: [Trip] = []
      private var cancellables: Set<AnyCancellable> = []

      init() {
        self.get()
      }

      func get() {
        store.collection(path).addSnapshotListener { querySnapshot, error in
            if let error = error {
              print("Error getting books: \(error.localizedDescription)")
              return
            }

            self.trips = querySnapshot?.documents.compactMap { document in
              try? document.data(as: Trip.self)
            } ?? []
          }
      }
    
    func add(_ trip: Trip) {
        do {
          let newTrip = trip
          _ = try store.collection(path).addDocument(from: newTrip)
        } catch {
          fatalError("Unable to add book: \(error.localizedDescription).")
        }
      }
    
}
