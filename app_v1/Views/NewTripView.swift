//
//  NewTripView.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import SwiftUI

struct NewTripView: View {
        
    @ObservedObject var libraryViewModel = LibraryViewModel()
    @ObservedObject var vm = MainTripsViewModel()

    
    @State private var name = ""
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var userID = ""
//    @State private var element = [String?]()

    
    
    var body: some View {
        NavigationView{
        VStack {
            Form{
                DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: [.date]
                    )
                DatePicker(
                        "End Date",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )
                        TextField("Trip Name", text: $name)
                        TextField("Destination", text: $destination)
                      
                      
                      Button{
                        print("add a friend to trip")
                        
                      } label: {
                          Text("Add Friends")
//                        Image(systemName: "plus.circle" )
//                          .foregroundColor(Color.black)
                      }
                if self.isValidTrip() {
                          Button("Add Trip") {
                            addTrip()
                            clearFields()
            }
            }
    }
}
        .navigationTitle("New Trip")
        .navigationBarTitleDisplayMode(.inline)
            
}
    }
    
    private func isValidTrip() -> Bool {
        if name.isEmpty { return false }
        if destination.isEmpty { return false }
        return true
      }

      private func clearFields() {
        name = ""
        destination = ""
      }
      
      private func addTrip() {
          let trip = Trip(name: name, destination: destination, startDate: startDate, endDate: endDate, userID: vm.user?.uid ?? "nil")
        libraryViewModel.add(trip)
      }
}
