//
//  PopupButton.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation

public struct PopupButton {
    let title: String
    let action: (() ->())
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
