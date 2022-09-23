//
//  CreateYourFlashCardsTests.swift
//  CreateYourFlashCardsTests
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import XCTest
@testable import CreateYourFlashCards

class CreateYourFlashCardsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_createMockUser(){
        let repository = UserRepository()
        
        repository.createMockUser()
        
        let mockUser = repository.user
        
        XCTAssertEqual(mockUser.email, "ibrahim")
    }
    
    func test_UserViewModelCreateNewUser()
    {
        let VM = UserLoginViewModel()
        let exp = expectation(description: "Wait for async create to complete")
        
        DispatchQueue.main.async {
            VM.createUser(email: "aksdşl", password: "şaklsdş")
            XCTAssertEqual(VM.repository.userCreationErrorText, "")
            exp.fulfill()
        }
       
        wait(for: [exp], timeout: 20.0)
        

    }
    
    func test_UserRepositoryCreateUserStressTest()
    {
        
        let properEmail = "ibrahim@outlook.com"
        let properPassword = "A369121518a."
        let improperEmail = "kkk"
        let improperPassword = "sdsd"
     
        
        let testArray = [(username : "", password : ""), // both empty // expand this example to all testcases
                         (username : "", password : properPassword), // empty email
                         (username : properEmail, password : ""), // empty password
                         (username : improperEmail, password : properPassword), // wrong email
                         (username : properEmail, password : improperPassword) // wrong password
                ]

        let repo = UserRepository()
        
        
       for data in testArray
        {
           let exp =
                 expectation(description: "Wait for async signIn to complete")
           print(data.username)
           print(data.password)
           repo.createNewUser(data.username, password: data.password) {[weak self] email, error in
               XCTAssertNotNil(error)
               exp.fulfill()
           }
           wait(for: [exp], timeout: 5.0)
          
       }
       
    }
    
    
    func test_UserViewModelSignIn()
    {
        let email = "admin@admin.com"
        let password = ""
        
        let vm = UserLoginViewModel()
        let exp = expectation(description: "Wait for async create to complete")
        
        DispatchQueue.main.async {
            vm.signIn(email: email, password: password)
            XCTAssertEqual(vm.errorText, "")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 4)
    }
    
    func test_UserRepositorySignIn()
    {
        let repo = UserRepository()
        let email = "admin@admin.com"
        let password = ""
        let exp = expectation(description: "Wait for async signIn to complete")
        repo.signIn(email:email , password: password) { signResult, error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func test_UserRepositoryUpdateUser()
    {
        let repo = UserRepository()
        let exp = expectation(description: "Wait for async signIn to complete")
        repo.getUserInfo(email: "admin@admin.com") { success, error in
            if success{
                print("ok")
                repo.updateUser(user: repo.user)
                XCTAssertEqual(repo.userCreationError, false)
                exp.fulfill()
            }
        }
      
        wait(for: [exp], timeout: 5)
      
    }
    
}
