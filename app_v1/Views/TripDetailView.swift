//
//  TripDetailView.swift
//  app_v1
//
//  Created by Varshaa SJ on 11/10/22.
//

import SwiftUI

struct TripDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	var trip: Trip
	let date = Date.now
	@State private var presentAdd = false

	var dateComponent = DateComponents()
    var body: some View {
      VStack {
          HStack{
            Text("Duration:")
            Text(trip.startDate.toString())
                  .bold()
            Text("-")
            Text(trip.endDate.toString())
                  .bold()
            Spacer()
          }
          .navigationBarTitleDisplayMode(.inline)
          .navigationTitle(trip.name)
          .navigationBarBackButtonHidden(true)
          .navigationBarItems(leading: backButton)
		  .toolbar {
			  ToolbarItem(placement: .primaryAction) {
				  Button(action: {presentAdd.toggle()}, label: {
					  Image(systemName: "plus").foregroundColor(.white)
				  })
			  }
		  }.sheet(isPresented: $presentAdd) {
			  NewElementView(trip: trip, days: daysBetween(start: trip.startDate, end: trip.endDate))
			  //NewDayView()
		  }
		  HStack{
			Text("\nGroup: @abc, @def")
			// later change to user icons or something
		  }
      ScrollView {
		  ForEach(1..<(daysBetween(start: trip.startDate, end: trip.endDate)+1)) { day in
        
          VStack{
        
            RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.gray, lineWidth: 1)
                  .frame(width: 280, height: 50)
                  .shadow(color: .gray, radius: 2, x: 0, y: 2)
                  .padding()
                  .overlay(
                        VStack(alignment: .leading) {
                        
                        Text("Day " + String(day))
                            .multilineTextAlignment(.leading)
                          
                          
                        Text("Detail")
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            
    
                        }
                )
        }
      }
      }
    }
}
    var backButton: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            })
        }
}



