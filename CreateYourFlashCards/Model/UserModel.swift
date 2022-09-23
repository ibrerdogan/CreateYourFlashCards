//
//  UserModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation
import FirebaseFirestoreSwift


struct User : Identifiable , Codable {
    @DocumentID var id : String?
    var email : String
    var cardCount : Int
    var eliminatedCardCounr : Int
   
}

