//
//  UserRepository.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 20.09.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class UserRepository : ObservableObject , UserProtocol
{
    private let userCollection : String = "users"
    private var auth = FirebaseAuth.Auth.auth()
    private var database = Firestore.firestore()
    
    
    @Published var user = User(email: "", cardCount: 0, eliminatedCardCounr: 0)
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var disableButton : Bool = false
    @Published var userCreationError : Bool = false
    @Published var userCreationErrorText : String = ""
    @Published var changePage : Bool = false
    
    /// for test
    func createMockUser()
    {
        self.user = User(email: "admin@admin.com", cardCount: 10, eliminatedCardCounr: 2)
    }
    
    /// add new user to firebase.
    /// - Parameters:
    ///   - email: from UI
    ///   - password: from UI
    ///   - result:
    func createNewUser(_ email : String, password   : String,result: @escaping (_ email : String, _ error : Error?)->())
    {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error
            {
                self?.userCreationError = true
                self?.userCreationErrorText = error.localizedDescription
                result("",error)
            }
            else
            {
                if let authresult = authResult
                {
                    self?.user.email = authresult.user.email ?? ""
                    self?.createNewUserTable(user: self!.user)
                    result((self?.user.email)!,nil)
                   
                }
                
            }
        }
    }
    
    /// every user has one user table, and contains user informations
    /// - Parameter user: new user
    func createNewUserTable(user : User)
    {
        do{
            let _ =  try database.collection(userCollection).addDocument(from: user)
            self.changePage = true
        }
        catch{
            self.userCreationError = true
            self.userCreationErrorText = error.localizedDescription
        }
    }
    
    /// - for sign and get user information
    /// - Parameters:
    ///   - email: <#email description#>
    ///   - password: <#password description#>
    ///   - result: <#result description#>
    func signIn(email : String , password : String , result: @escaping (_ signResult : Bool , _ error : Error?)->())
    {
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error
            {
                self?.userCreationError = true
                self?.userCreationErrorText = error.localizedDescription
                result(false,error)
            }
            else
            {
                
                if let authResult = authResult
                {
                   
                    self?.getUserInfo(email: authResult.user.email ?? "") { success, error in
                        if success {
                            result(true, nil)
                        }
                        else
                        {
                            self?.userCreationError = true
                            self?.userCreationErrorText = error?.localizedDescription ?? "sigin error"
                            result(false, error)
                        }
                    }
                }
            }
        }
    }
    
    func checkCurrentUser(result : @escaping (_ complated : Bool, _ error : Error?) -> ())
    {
        let email = auth.currentUser?.email.map({ email in
            email
        })
        getUserInfo(email: email ?? "") { [weak self] success, error in
            if success {
                result(true,nil)
            }
            else
            {
                result(false,error)
                self?.userCreationError = true
                self?.userCreationErrorText = error?.localizedDescription ?? "get user info error"
            }
        }
    }
    
    func signOut()
    {
        do{
           try auth.signOut()
            changePage = false
            self.user = User(email: "", cardCount: 0, eliminatedCardCounr: 0)
           
        }
        catch
        {
            self.userCreationError = true
            self.userCreationErrorText = error.localizedDescription
        }
    }
    
    func updateUser(user : User)
    {
        if let userID = user.id
        {
            do{
                try database.collection(userCollection).document(userID).setData(from: user)
            }
            catch
            {
                self.userCreationError = true
                self.userCreationErrorText = "update error"
            }
        }
        else
        {
            self.userCreationError = true
            self.userCreationErrorText = "there is no userID"
        }
    }
    
    func getUserInfo(email : String , result : @escaping (_ success : Bool, _ error : Error?) ->())
    {
        database.collection(userCollection).whereField("email", isEqualTo: email).addSnapshotListener { [weak self] snapShot, error in
            if let snapShot = snapShot
            {
               let _ = snapShot.documents.compactMap { snapshot in
                    do{
                        self?.user = try snapshot.data(as: User.self)
                        self?.changePage = true
                        result(true,nil)
                    }
                    catch{
                        self?.userCreationError = true
                        self?.userCreationErrorText = error.localizedDescription
                        result(false,error)
                    }
                
                }
                

            }
            else
            {
                self?.userCreationError = true
                self?.userCreationErrorText = error?.localizedDescription ?? "get user info error"
                result(false, error)
            }
        }
    }
}
