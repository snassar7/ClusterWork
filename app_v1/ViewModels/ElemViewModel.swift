//
//  ElemViewModel.swift
//  app_v1
//
//  Created by Emma Herrera on 12/3/22.
//

import Foundation
import Combine

class ElemViewModel: ObservableObject, Identifiable {
	
	private let elemRepository = TripElementRepository()
	@Published var element: Element
	private var cancellables: Set<AnyCancellable> = []
	var id = ""
	
	init(element: Element) {
		self.element = element
		$element
			.compactMap { $0.id }
			.assign(to: \.id, on: self)
			.store(in: &cancellables)
	}
	
}
