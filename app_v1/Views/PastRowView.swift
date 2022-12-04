//
//  TripRowView.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import SwiftUI

struct PastRowView: View {
    @State private var dragAmount = CGSize.zero
    @ObservedObject var vm = MainTripsViewModel()

    
    var trip: Trip
    let date = Date.now
    var body: some View {
        if trip.endDate.toString() < date.toString() {
            if vm.user?.uid ==  trip.userID {
                
                VStack {
                    RoundedRectangle(cornerRadius: 10).fill(.white)
                        .frame(width: 300, height: 400)
                        .shadow(radius: 3)
                    
                    //                    .background(LinearGradient(colors: [.orange, .red],
                    //                                       startPoint: .top,
                    //                                       endPoint: .center))
                        .overlay(alignment: .top){
                            VStack(alignment: .leading) {
                                Image("roadtrip-image")
                                    .resizable()
                                    .frame(width:300, height:200)
                                    .cornerRadius(10, corners: [.topLeft, .topRight])
                                VStack(alignment: .leading) {
                                    
                                    Text(trip.name)
                                        .font(.title).foregroundColor(Color.green)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size:16, weight: .bold))
                                    Text(trip.destination).multilineTextAlignment(.leading).font(.headline)
                                        .foregroundColor(.secondary)
                                    Divider()
                                    HStack() {
                                        VStack(alignment: .leading){
                                            Text(trip.endDate.formatted(date: .long, time:.omitted))
                                                .multilineTextAlignment(.leading)
                                            Text("Group: @abc, @def")
                                                .font(.system(size: 12, weight:.light))
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.leading)
                                        }
                                        
                                        Divider().padding()
                                        NavigationLink(destination: TripDetailView(trip: trip)) {
                                            Text("View Details").multilineTextAlignment(.trailing)
                                        }
                                    }
                                    
                                }.padding()
                            }
                        }
                    
                    
                }.offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged{dragAmount = $0.translation}
                            .onEnded{ _ in dragAmount = .zero }
                        
                    )
                    .animation(.spring(), value: dragAmount)
            }
    }
}
}




  /*
   This is the source code to use customizable modifiers for rounded corners source code extension is in current trip views
   source: https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui
   */


