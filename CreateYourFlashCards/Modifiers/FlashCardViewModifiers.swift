//
//  FlashCardViewModifiers.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 21.09.2022.
//

import Foundation
import SwiftUI

struct FlashcardRectangleModifier : ViewModifier {
    var isActive : Bool
    
    func body(content: Content) -> some View {
        content
            .frame(height:600)
            .frame(maxWidth:.infinity)
            .foregroundColor(isActive ? .green : .gray)
            .padding()
            .shadow(radius: 20)
    }
}


struct FlashcardCheckMarkModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .clipShape(Circle())
    }
}
