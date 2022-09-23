//
//  AddFlashCardViewModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 20.09.2022.
//

import Foundation

class AddFlashCardViewModel : ObservableObject
{
    var repository : FlashCardRepository
    @Published var newCard : FlashCard
    
    init(repository : FlashCardRepository)
    {
        self.repository = repository
        self.newCard = FlashCard(word: "", answer: "", exampleSentence: "", wordType: .verb, isActive: false)
    }
    
    func addNewFlashCard()
    {
        newCard.createdUser = repository.user.email
        repository.createNewFlashCard(card: self.newCard)
    }
    
    
}
