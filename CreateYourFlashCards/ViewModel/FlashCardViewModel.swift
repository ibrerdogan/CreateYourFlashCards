//
//  FlashCardViewModel.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import Foundation
import Combine
import SwiftUI

class FlashCardViewModel : ObservableObject , Identifiable
{
    @Published var flashCard : FlashCard
    @Published var changeFace = false
    var id = ""
    var isActive : Bool = false
    private var cancellable = Set<AnyCancellable>()
    
    var onChangeIsActive : (FlashCard) -> () = { _ in }
    
    init(flasCard : FlashCard)
    {
        self.flashCard = flasCard
        
        $flashCard.compactMap({ card in
            card.id
        })
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
        
        
        $flashCard.compactMap { card in
            card.isActive
        }
        .assign(to: \.isActive, on: self)
        .store(in: &cancellable)
        
       // $flashCard.map { card in
       //     card.isActive
       // }.sink { active in
       //     print(active.description)
       // }
       // .store(in: &cancellable)
        
      //  $flashCard
      //      .dropFirst()
      //      .debounce(for: 0.8, scheduler: RunLoop.main)
      //      .sink { card in
      //      print(card.id as Any)
      //      self.repository.setInActiveFlashCard(card : self.flashCard)
      //  }
      //  .store(in: &cancellable)
        
    }
    
    func showAnswer()
    {
        withAnimation(.easeOut(duration: 0.2)) {
            self.changeFace.toggle()
        }
    }
    
    
}
