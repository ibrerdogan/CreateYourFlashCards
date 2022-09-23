//
//  Extensions.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 21.09.2022.
//

import Foundation
import SwiftUI

extension View{
    func userLoginViewButtonStyle(disable : Bool,foregroundColor : Color, backgroundColor : Color) -> some View
    {
        modifier(UserLoginButtonModifier(disable: disable, foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
    
    func userLoginViewTextFieldStyle() -> some View
    {
        modifier(UserLoginTextFieldsModifier())
    }
    
    func cardViewRectangleStyle(isActive : Bool) -> some View
    {
        modifier(FlashcardRectangleModifier(isActive: isActive))
    }
    
    func cardViewCheckmarkStyle() -> some View
    {
        modifier(FlashcardCheckMarkModifier())
    }
}
