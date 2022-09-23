//
//  CreateYourFlashCardsApp.swift
//  CreateYourFlashCards
//
//  Created by İbrahim Erdogan on 16.09.2022.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CreateYourFlashCardsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //FlashCardListView()
            UserLoginView()
        }
    }
}
