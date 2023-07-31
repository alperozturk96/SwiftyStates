//
//  ViewStateModifier.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//
import SwiftUI

public struct ViewStateModifier: ViewModifier {
    
    @Binding var state: ViewState
    
    public func body(content: Content) -> some View {
        content
            .addPopup(hide: state == ViewState.Initial) {
                if case let .Loading(item) = state {
                    LoadingPopup(item)
                } else if case let .Error(errorState) = state {
                    ErrorPopup(errorState)
                } else if case let .Custom(popupContent) = state {
                    popupContent
                }
            }
    }
}

public extension View {
    func viewState(_ state: Binding<ViewState>) -> some View {
        modifier(ViewStateModifier(state: state))
    }
}
