//
//  AppView.swift
//  app_v1
//
//  Created by Saif Nassar on 05/11/2022.
//

import SwiftUI

struct AppView: View {
    var body: some View {
      TabView {
          TripsView()
          .tabItem {
            Image(systemName: "house")
            Text("Home")
          }
          FriendView()
          .tabItem {
            Image(systemName: "person.3.fill")
            Text("Friends")
          }
          ProfileView()
          .tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
          
          
        
           }
    }
}
