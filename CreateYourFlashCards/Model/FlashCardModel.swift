//
//  FlashCardModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
struct FlashCard : Codable , Identifiable{
    
    @DocumentID var id : String?
    var word : String
    var answer : String
    var exampleSentence : String
    var wordType : FlashCardType
    var isActive : Bool
    var createdUser : String?
}

enum FlashCardType : String, Codable
{
    case verb = "Verb"
    case noun = "Noun"
    case adjective = "Adjective"
    case all = "All"
    
}



#if DEBUG
var testDataTask = [
    FlashCard(word: "asd", answer: "", exampleSentence: "", wordType: .adjective, isActive: false),
    FlashCard(word: "sadasd", answer: "", exampleSentence: "", wordType: .adjective, isActive: false),
    FlashCard(word: "asdasdasd", answer: "", exampleSentence: "", wordType: .adjective, isActive: false)
                ]
#endif

