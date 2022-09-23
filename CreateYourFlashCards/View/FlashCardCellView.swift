//
//  FlashCardCellView.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 19.09.2022.
//

import SwiftUI

struct FlashCardCellView: View {
    
    @ObservedObject var flashCardCellVM : FlashCardViewModel
    
    var onChangeIsActive : (FlashCard) -> () = { _ in }
    
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .cardViewRectangleStyle(isActive: flashCardCellVM.isActive)
                .overlay {
                    if !flashCardCellVM.changeFace
                    {
                        VStack {
                            Text(flashCardCellVM.flashCard.word)
                                .font(.title)
                        }
                        .padding()
                    }
                    else
                    {
                        VStack{
                           
                            VStack{
                                Spacer()
                                Text(flashCardCellVM.flashCard.answer)
                                    .padding()
                                    .font(.title)
                                Text(flashCardCellVM.flashCard.exampleSentence)
                                    .font(.title2)
                                    .padding()
                                Button {
                                    flashCardCellVM.flashCard.isActive.toggle()
                                    
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .cardViewCheckmarkStyle()
                                        .onChange(of: flashCardCellVM.flashCard.isActive) { newValue in
                                            self.onChangeIsActive(flashCardCellVM.flashCard)
                                        }
                                }
                                Spacer()
                              
                            }
                            .padding()
                          Spacer()
                            HStack{
                                Spacer()
                                Text(flashCardCellVM.flashCard.wordType.rawValue)
                                    .padding()
                            }
                            .padding()
                            Spacer()
                        }
                        .padding()
                    }
                  

                }
                .onTapGesture {
                    flashCardCellVM.showAnswer()
                   // self.flashCardCellVM.flashCard.isActive.toggle()
                }
            
           // RoundedRectangle(cornerRadius: 20)
           //     .frame(height:200)
           //     .foregroundColor(.gray)
           //     .padding()
           //     .shadow(radius: 20)
           //     .overlay {
           //         VStack{
           //             VStack{
           //                 Text("ansver")
           //                     .padding()
           //                 Text("Example")
           //                     .padding()
           //             }
           //             .padding()
           //             Spacer()
           //             HStack{
           //                 Spacer()
           //                 Text("Verb")
           //                     .padding()
           //             }
           //             .padding()
           //         }
           //     }
           //
                
        
        }
    }
}

