//
//  PredefinedPopups.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import SwiftUI

@ViewBuilder
public func ErrorPopup(_ errorState: ErrorState?) -> some View {
    if let errorState {
        let firstButton: PopupButton = .init(title: errorState.firstButtonTitle, action: {
            Task {
                do {
                    if let firstButtonAction = errorState.firstButtonAction {
                        try await firstButtonAction()
                    }
                } catch {
                    print("Error popup action throwed: " + error.describing())
                }
            }
        })
        let thirdButton: PopupButton = .init(title: errorState.secondButtonTitle ?? "", action: errorState.secondButtonAction ?? {})
        
        Popup(show: .constant(true), title: errorState.title, description: errorState.userMsg, detailedDescription: errorState.devMsg, backgroundColor: errorState.color, firstButton: firstButton, thirdButton: (errorState.secondButtonTitle != nil) ? thirdButton : nil)
    }
}

@ViewBuilder
public func LoadingPopup(_ item: LoadingState) -> some View {
    Popup(show: .constant(true), title: item.title, description: item.description, backgroundColor: .blue, loading: true, firstButton: item.button)
}
