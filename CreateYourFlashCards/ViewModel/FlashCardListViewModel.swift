//
//  FlashCardListViewModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 19.09.2022.
//

import Foundation
import Combine

class FlashCardListViewModel : ObservableObject
{
    @Published var FlashCards : [FlashCardViewModel] = []
    @Published var repository : FlashCardRepository
    @Published var testFlashCard = FlashCardViewModel(flasCard: FlashCard(word: "sad", answer: "asd", exampleSentence: "asd", wordType: .verb, isActive: .random()))
    @Published var userRepository : UserRepository
    
    private var cancellable = Set<AnyCancellable>()
    
    init(userRepository : UserRepository)
    {
        self.userRepository = userRepository
        self.repository = FlashCardRepository(userRepository: userRepository)
        self.repository.$flashCards.compactMap { cards in
            cards.map { card in
                FlashCardViewModel(flasCard: card)
            }
        }
        .assign(to: \.FlashCards, on: self)
        .store(in: &cancellable)
        
        self.$userRepository.map { userRepository in
            userRepository.user
        }
        .assign(to: \.repository.user, on: self)
        .store(in: &cancellable)
        
       
        
        
    }
    
    func addNewCard(newCard : FlashCard)
    {
        repository.createNewFlashCard(card: FlashCard(word: "asdşlka", answer: "aşskdş", exampleSentence: "aşsdkşasd", wordType: .verb, isActive: false))
    }
}

