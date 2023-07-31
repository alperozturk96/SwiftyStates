//
//  ViewState.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//
import SwiftUI

public enum ViewState: Equatable {
    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.Initial, .Initial):
            return true
        case let (.Loading(item1), .Loading(item2)):
            return item1.title == item2.title
        case let (.Error(error1), .Error(error2)):
            return error1.getErrorState().describing() == error2.getErrorState().describing()
        case (.Custom(_), .Custom(_)):
            return false
        default:
            return false
        }
    }
    
    case Initial
    case Loading(item: LoadingState)
    case Error(error: ErrorState)
    case Custom(content: AnyView)
}
