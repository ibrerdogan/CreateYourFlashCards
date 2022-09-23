//
//  UserViewModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation
import Combine

class UserLoginViewModel: ObservableObject {
    
    @Published var repository = UserRepository()
    @Published var change : Bool = false
    @Published var errorBit : Bool = false
    @Published var errorText : String = ""
    private var cancellable = Set<AnyCancellable>()
    
    init()
    {
        repository.$email
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] text in
               if  text.count > 4
                {
                   self?.repository.disableButton = true
               }
                else
                {
                    self?.repository.disableButton = false
                }
            }
            .store(in: &cancellable)
        
        repository.$changePage
            .dropFirst()
            .sink { change in
                if change
                {
                    self.change = true
                }
            }
            .store(in: &cancellable)
        
        repository.$userCreationError.compactMap { error in
            error
        }.sink(receiveValue: { err in
            self.errorBit = err
        })
        .store(in: &cancellable)
        
        repository.$userCreationErrorText.compactMap { error in
            error
        }.sink(receiveValue: { err in
            self.errorText = err
        })
        .store(in: &cancellable)
        
        repository.checkCurrentUser { complated, error in
            if complated {
                print("ok")
            }
        }
            
    }
    
    func createUser(email : String , password : String)
    {
        repository.createNewUser(email, password: password) { [weak self] email, error in
            if let error = error {
                self?.repository.userCreationError.toggle()
                self?.repository.userCreationErrorText = error.localizedDescription
            }
            else
            {
                
            }
        }
    }
    
    func signIn(email : String , password : String)
    {
        repository.signIn(email: email, password: password){ [weak self] ok, error in
            if ok {
                self?.change = true
            }
            else
            {
                self?.repository.userCreationError = true
                self?.repository.userCreationErrorText = error?.localizedDescription ?? "sign error"
            }
        }
    }
    
    
    func checkCurrentUser()
    {
        repository.checkCurrentUser { complated, error in
            if complated{
                self.change = true
            }
            else{
                
            }
        }
    }
    
    
}
