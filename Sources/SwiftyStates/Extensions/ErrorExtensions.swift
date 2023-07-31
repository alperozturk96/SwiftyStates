//
//  ErrorExtensions.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation

public extension Error {
    func describing() -> String {
        return String(describing: self)
    }
    
    func getErrorState() -> ErrorState {
        return self as? ErrorState ?? ErrorState(userMsg: "", devMsg: self.describing())
    }
}
