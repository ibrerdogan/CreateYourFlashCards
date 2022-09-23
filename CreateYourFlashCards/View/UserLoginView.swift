//
//  UserLoginView.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 20.09.2022.
//

import SwiftUI

struct UserLoginView: View {
    
    @ObservedObject var userLoginVM = UserLoginViewModel()
    @State var createOrLogin : Bool = false
    
  
    var body: some View {
        ZStack(alignment:.center)
        {
            VStack(spacing:20){
                TextField("email", text: $userLoginVM.repository.email)
                    .userLoginViewTextFieldStyle()
                SecureField("password", text: $userLoginVM.repository.password)
                    .userLoginViewTextFieldStyle()
                
             if createOrLogin
                {
                 Button {
                     userLoginVM.createUser(email: userLoginVM.repository.email, password: userLoginVM.repository.password)
                 } label: {
                     Text("Create New User")
                         .userLoginViewButtonStyle(disable: userLoginVM.repository.disableButton,
                                                   foregroundColor: .blue, backgroundColor: .blue)
                        
                    }
                }
                else
                {
                    Button {
                        userLoginVM.signIn(email: userLoginVM.repository.email, password: userLoginVM.repository.password)
                    } label: {
                        Text("SignIn")
                            .userLoginViewButtonStyle(disable: userLoginVM.repository.disableButton,
                                                      foregroundColor: .green, backgroundColor: .green)
                    }
                }
                
                Button {
                    withAnimation(.easeInOut) {
                        createOrLogin.toggle()
                    }
                } label: {
                    if !createOrLogin{
                        Text("You Want To Join Us")
                    }
                    else
                    {
                        Text("You Have An Account")
                    }
                }

                
                

            }
            .padding()
            
        }
        .alert(userLoginVM.errorText, isPresented: $userLoginVM.errorBit, actions: {
            Button(role: .cancel) {
                userLoginVM.errorBit = false
            } label: {
                    Text("OK")
            }

        })
        .fullScreenCover(isPresented: $userLoginVM.change) {
            FlashCardListView(flasCardListVM: FlashCardListViewModel(userRepository: userLoginVM.repository ))
        }
        
    }
    
}

struct UserLoginView_Previews: PreviewProvider {
    static var previews: some View {
        UserLoginView()
    }
}
