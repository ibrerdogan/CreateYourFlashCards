//
//  UserLoginViewModifiers.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 21.09.2022.
//

import Foundation
import SwiftUI


struct UserLoginButtonModifier : ViewModifier{
    var disable : Bool
    var foregroundColor : Color
    var backgroundColor : Color
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(disable ? .black : foregroundColor)
            .font(.title3.bold())
            .frame(maxWidth:200, maxHeight: 50, alignment: .center)
            .background(backgroundColor.opacity(disable ? 0.8 : 0.2))
            .cornerRadius(20)
           
    }
}

struct UserLoginTextFieldsModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxHeight:70)
            .background(.red.opacity(0.3))
            .cornerRadius(20)
    }
}
