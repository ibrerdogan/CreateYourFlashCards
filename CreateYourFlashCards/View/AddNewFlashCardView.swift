//
//  AddNewFlashCardView.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 20.09.2022.
//

import SwiftUI

struct AddNewFlashCardView: View {
    @ObservedObject var addNewFlasCardVM : AddFlashCardViewModel
   
    var body: some View {
        Form {
            Group{
                Section(header: Text("flash card")) {
                    TextField("Word", text: $addNewFlasCardVM.newCard.word)
                        .disableAutocorrection(true)
                    
                    TextField("Answer", text: $addNewFlasCardVM.newCard.answer)
                        .disableAutocorrection(true)
                    
                    TextField("Example", text: $addNewFlasCardVM.newCard.exampleSentence)
                        .disableAutocorrection(true)
                    
                    Button {
                        addNewFlasCardVM.addNewFlashCard()
                    } label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add New Card")
                        }
                    }

                }
                
                
            }
            
        }
    }
}
