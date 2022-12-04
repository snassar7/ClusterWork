//
//  ContentView.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import SwiftUI
import Firebase
import FirebaseStorage

let coloredNavAppearance = UINavigationBarAppearance()

struct TripsView: View {
    
    init() {
        coloredNavAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.configureWithTransparentBackground()
        coloredNavAppearance.backgroundColor = .orange
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance

    }
    
    @ObservedObject var viewModel = TripRepository()
    @ObservedObject var vm = MainTripsViewModel()
    @ObservedObject var library = LibraryViewModel()
    

    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var presentAdd = false
    @State var shouldShowLogOutOptions = false
    @State private var stateTag = true
    

//    "dLw810A8kqVuONCkovk9ZMsX7O53"
    
    var body: some View {
        NavigationView {
            ScrollView {
               
                  VStack {
                              Picker("Current or past trip", selection: $stateTag) {
                                
                                  Text("Current").tag(true)
                                  Text("Past").tag(false)
                                  
                              }.pickerStyle(SegmentedPickerStyle())

                            
                          }
              
                    Text("Welcome Back \(vm.user?.fname ?? "")")
                        .foregroundColor(.orange)
            if stateTag {
                    Spacer()
              VStack {
                    Text("Current Trips")
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                      ForEach (viewModel.trips) { trip in
                          CurrentRowView(trip: trip)
                  }
              }.padding()
          
            }else{
                ScrollView {
                    VStack{
                        Text("Past Trips")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        ForEach (viewModel.trips) { trip in
                            PastRowView(trip: trip)
                        }
                    }.padding()
                }
              
            }
              
              
              
            }.padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Trips")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {presentAdd.toggle()}, label: {
                            Image(systemName: "plus").foregroundColor(.white)
                        })
                    }
                }
                .sheet(isPresented: $presentAdd) {
                    NewTripView()
                }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            shouldShowLogOutOptions.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(.white))
                        }
                    }
                }
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Settings"), message: Text("Are you sure you want to sign out?"),
                          buttons: [.destructive(Text("Sign Out"), action: {
                        print("handle sign out")
                        vm.handleSignOut()
                    }),
                                    .cancel()
                                   ])
                }
                .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
                    LoginView(didCompleteLogin: {
                        self.vm.isUserCurrentlyLoggedOut = false
                        self.vm.fetchCurrentUser()
                        
                    })
                }
            
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripsView()
//    }
//}

