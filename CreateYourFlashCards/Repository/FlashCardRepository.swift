//
//  FlashCardRepository.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FlashCardRepository : FlashCardProtocol , ObservableObject {
    
    private let cardCollection : String = "cards"
    private var database = Firestore.firestore()
    @Published var userRepository : UserRepository
    
    @Published var user : User
    @Published var flashCards : [FlashCard] = []
    @Published var userOk : Bool = false
    
    @Published var flasCardScreenError : Bool = false
    @Published var flasCardScreenErrorText : String = ""
    
    
    
    init(userRepository : UserRepository)
    {
        self.userRepository = userRepository
        self.user = userRepository.user
        
        getFlashCards()
    }
    
    
    
    /// get new or updated flash cards oniine,
    ///
    func getFlashCards() {
        database.collection(cardCollection).whereField("createdUser", isEqualTo: user.email).whereField("isActive", isEqualTo: false ).addSnapshotListener { querySnaphot, error in
            if let error = error {
                
                self.flasCardScreenError.toggle()
                self.flasCardScreenErrorText = error.localizedDescription
            }
            else
            {
                if let querySnaphot = querySnaphot {
                    self.flashCards = querySnaphot.documents.compactMap { snapShot in
                        try? snapShot.data(as: FlashCard.self)
                    }
                   
                }
               
            }
        }
    }
    
    /// - set the flas card deactive, and dont show anymore.
    /// - Parameter card: deactivated flash card
    func setInActiveFlashCard(card : FlashCard) {
    
      if let cardID = card.id
        {
          self.user.eliminatedCardCounr = self.user.eliminatedCardCounr + 1
          try? database.collection(cardCollection).document(cardID).setData(from: card)
          userRepository.updateUser(user: self.user)
      }
        else
        {
            self.flasCardScreenError.toggle()
            self.flasCardScreenErrorText = "card update error"
        }
    }
    
    /// - saved new card for current user
    /// - Parameter card: created card
    func createNewFlashCard(card : FlashCard){
        
        var flashCard = card
        flashCard.createdUser = self.user.email
        do{
            _ = try database.collection(cardCollection).addDocument(from: flashCard)
            self.user.cardCount = self.user.cardCount + 1
            userRepository.updateUser(user: self.user)
        }
        catch
        {
            self.flasCardScreenError.toggle()
            self.flasCardScreenErrorText = error.localizedDescription
            
        }
    }
    
    
}
