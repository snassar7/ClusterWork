//
//  LibraryViewModel.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import Foundation
import Combine

class LibraryViewModel: ObservableObject {
  @Published var tripViewModel: [TripViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var tripRepositroy = TripRepository()
  @Published var library: [Trip] = []
  
  init() {
      tripRepositroy.$trips.map { trips in
      trips.map(TripViewModel.init)
    }
    .assign(to: \.tripViewModel, on: self)
    .store(in: &cancellables)
  }

  func add(_ trip: Trip) {
      tripRepositroy.add(trip)
  }
}
