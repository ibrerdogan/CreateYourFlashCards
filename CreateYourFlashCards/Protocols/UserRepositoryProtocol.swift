//
//  UserRepositoryProtocol.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 21.09.2022.
//

import Foundation


protocol UserProtocol {
    func createMockUser()
    func createNewUser(_ email : String, password   : String,result: @escaping (_ email : String, _ error : Error?)->())
    func createNewUserTable(user : User)
    func signIn(email : String , password : String , result: @escaping (_ signResult : Bool , _ error : Error?)->())
    func checkCurrentUser(result : @escaping (_ complated : Bool, _ error : Error?) -> ())
    func signOut()
    func updateUser(user : User)
    func getUserInfo(email : String , result : @escaping (_ success : Bool, _ error : Error?) ->())
}
