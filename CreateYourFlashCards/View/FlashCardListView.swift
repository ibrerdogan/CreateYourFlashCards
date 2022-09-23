//
//  FlashCardListView.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 19.09.2022.
//

import SwiftUI

struct FlashCardListView: View {
    @ObservedObject var flasCardListVM : FlashCardListViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack{
                
                Color.white
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            flasCardListVM.userRepository.signOut()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "person.fill")
                        }.padding()
                    }
                   

                    Spacer()
                    if flasCardListVM.FlashCards.count != 0
                    {
                        ScrollView(.horizontal)
                        {
                            HStack{
                                ForEach(flasCardListVM.FlashCards){ flashCardVM in
                                    GeometryReader{reader in
                                       
                                      //  FlashCardCellView(flashCardCellVM: flashCardVM)
                                        FlashCardCellView(flashCardCellVM: flashCardVM) { card in
                                            self.flasCardListVM.repository.setInActiveFlashCard(card: card)
                                        }
                                            
                                    }
                                    .frame(width: 350, height: 600)
                                    .padding()
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                    else
                    {
                        Text("Please Add New Flashcard...")
                    }
                    Spacer()
                    NavigationLink(destination: AddNewFlashCardView(addNewFlasCardVM: AddFlashCardViewModel(repository: flasCardListVM.repository))) {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add New Card")
                        }
                    }
                   // Button(action: {
                   //    // flasCardListVM.addNewCard(newCard: FlashCard(word: "", answer: "", exampleSentence: "", ////wordType: .adjective, isActive: .random()))
                   //     }, label: {
                   //         HStack{
                   //             Image(systemName: "plus")
                   //             Text("Add New Card")
                   //         }
                   //     })
                    }
            }
            .navigationBarHidden(true)
        }

    }
}

struct FlashCardListView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardListView(flasCardListVM: FlashCardListViewModel(userRepository: UserRepository()))
    }
}
