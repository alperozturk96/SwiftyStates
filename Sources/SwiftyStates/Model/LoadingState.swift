//
//  LoadingState.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//
import Foundation

public struct LoadingState {
    public var title: String?
    public var description: String?
    public var button: PopupButton?
    
    public init(title: String? = nil, description: String? = nil, button: PopupButton? = nil) {
        self.title = title
        self.description = description
        self.button = button
    }
}
