//
//  PopupModifier.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation
import SwiftUI

public struct PopupModifier<Popup: View>: ViewModifier {
    
    var hide: Bool
    @ViewBuilder private let popup: Popup
    
    public init(hide: Bool, @ViewBuilder popup: () -> Popup) {
        self.hide = hide
        self.popup = popup()
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .center) {
                if !hide {
                    ZStack {
                        DimmingView()
                        popup
                    }
                }
            }
    }
}

public extension View {
    func addPopup<Popup: View>(hide: Bool, @ViewBuilder _ popup: @escaping () -> Popup) -> some View {
        modifier(PopupModifier(hide: hide, popup: popup))
    }
}
