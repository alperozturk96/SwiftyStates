//
//  ErrorState.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation
import SwiftUI

public final class ErrorState: LocalizedError, CustomStringConvertible {
   
    public var title: String?
    
    public var firstButtonTitle: String
    public var secondButtonTitle: String?
    
    public var devMsg: String?
    public var userMsg: String
    public var errorCode: String?
    public var color: Color
    
    public var secondButtonAction: (() -> ())?
    public var firstButtonAction: (() async throws -> ())?
    
    public init(title: String? = nil, userMsg: String, errorCode: String? = nil, devMsg: String? = nil, firstButtonTitle: String = "Retry", secondButtonTitle: String? = nil, color: Color = .red, secondButtonAction: (() -> ())? = nil, firstButtonAction: (() async throws -> ())? = nil) {
        self.title = title
        self.color = color
        self.errorCode = errorCode
        self.userMsg = userMsg
        self.devMsg = devMsg
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
    }
    
    public var description: String {
        return devMsg ?? self.description
    }
}
