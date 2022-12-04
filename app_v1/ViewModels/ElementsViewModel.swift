//
//  ElementsViewModel.swift
//  app_v1
//
//  Created by Emma Herrera on 12/3/22.
//

import Foundation
import Combine

class ElementsViewModel: ObservableObject {
  @Published var elemViewModel: [ElemViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var elemRepositroy = TripElementRepository()
  @Published var library: [Trip] = []
  
  init() {
	  elemRepositroy.$elements.map { elements in
	  elements.map(ElemViewModel.init)
	}
	.assign(to: \.elemViewModel, on: self)
	.store(in: &cancellables)
  }

  func add(_ element: Element) {
	  elemRepositroy.add(element)
  }
}
