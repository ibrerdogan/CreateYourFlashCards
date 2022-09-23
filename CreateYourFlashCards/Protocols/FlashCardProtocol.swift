//
//  FlashCardProtocol.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation


protocol FlashCardProtocol {
    func getFlashCards() 
    func setInActiveFlashCard(card : FlashCard) 
    func createNewFlashCard(card : FlashCard)
}
