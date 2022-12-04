//
//  LoginView.swift
//  app_v1
//
//  Created by Saifudden Ahmad Abdullah Nassar on 11/19/22.
//

import SwiftUI
import Firebase
//import FirebaseStorage
 
struct LoginView: View {
    
    let didCompleteLogin: () -> ()
     
    @State var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var fname = ""
    @State private var lname = ""
    @State private var StatusMessage = ""
          
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Text("Travlr.")
                        .bold()
                        .foregroundColor(.white)
                        .padding(20)
                }
  
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
             
                    if !isLoginMode {
                        Group {
                            TextField("First Name", text: $fname)
                            TextField("Last Name", text: $lname)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                         
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                            }.background(Color.green)
      
                        }.cornerRadius(10)
                    }else {
                         
                        Group {
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                         
                        Button {
                            loginUser()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Login")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                            }.background(Color.green)
      
                        }.cornerRadius(10)
                    }
                     
                    Text(self.StatusMessage)
                        .foregroundColor(Color.white)
                }
                .padding()
                 
            } //End ScrollView
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(
                        LinearGradient(gradient: Gradient(colors: [.orange, .white]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all))
             
        }// End Navigation
    }
     
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.StatusMessage = "Failed to login user: \(err)"
                return
            }
  
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
  
            self.StatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            self.didCompleteLogin()
        }
    }
     
    private func handleAction() {
        createNewAccount()
    }
     
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.StatusMessage = "Failed to create user: \(err)"
                return
            }
  
            print("Successfully created user: \(result?.user.uid ?? "")")
  
            self.StatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
  
            self.storeUserInformation()
        }
    }
     
    private func storeUserInformation() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["fname": self.fname, "lname": self.lname, "email": self.email, "uid": uid]
        Firestore.firestore().collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.StatusMessage = "\(err)"
                    return
                }
 
                print("Success")
            }
    }
}
