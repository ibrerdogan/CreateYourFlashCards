//
//  FlashCardSwipeView.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 20.09.2022.
//

import SwiftUI

struct FlashCardSwipeView: View {
    @ObservedObject var flasCardListVM = FlashCardListViewModel(userRepository: UserRepository())
    
    @State var offset : CGFloat = 0.0
    @GestureState var isDragging : Bool = false
    var body: some View {
        VStack{
            
            VStack{
                ZStack{
                    ForEach(flasCardListVM.FlashCards){ flashCardVM in
                        GeometryReader{reader in
                            FlashCardCellView(flashCardCellVM: flashCardVM)
                                .offset(x: offset)
                                .gesture(
                                    DragGesture().updating($isDragging, body: { value, state, trans in
                                        state = true
                                    })
                                    .onChanged({ value in
                                        offset = value.translation.width
                                    })
                                    .onEnded({ value in
                                      
                                    })
                                )
                                
                        }
                        .frame(width: 350, height: 600)
                        .padding()
                       
                    }
                }
               
            }
            
            
        }
        .padding(.vertical)
    }
}

struct FlashCardSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardSwipeView()
    }
}
