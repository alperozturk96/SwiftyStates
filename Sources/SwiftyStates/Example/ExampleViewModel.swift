//
//  ExampleViewModel.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import Foundation
import SwiftUI

final class ExampleViewModel: BaseViewModel {
    
    private let response = ["I love this library 😊", "Very useful solution 👏", "I ♥️ SwiftUI"]
    
    @Published var comments: [String] = .init()
    private let exampleState: ExampleState
    
    init(exampleState: ExampleState = .success) {
        self.exampleState = exampleState
    }
    
    func fetchComments() {
        startTask { [weak self] in
            guard let self else { return }
            
            setViewState()
            
            if exampleState != .error {
                finishTaskWithDelay()
            }
        } handleError: { error in
            
        }
    }
}

// MARK: - Private Methods
extension ExampleViewModel {
    private func setViewState() {
        MainThread {
            switch self.exampleState {
            case .success:
                self.state = .Loading(item: .init(title: "Fetching comments please wait..."))
            case .error:
                self.state = .Error(error: .init(userMsg: "Error catched while fetching comments", firstButtonAction: {
                    MainThread {
                        self.state = .Initial
                        self.comments = self.response
                    }
                }))
            case .custom:
                self.state = .Custom(content: AnyView(Popup(show: .constant(true), title: "Warning", description: "This a warning state", backgroundColor: .yellow)))
            }
        }
    }
    
    private func finishTaskWithDelay() {
        DelayedMainThread {
            self.state = .Initial
            self.comments = self.response
        }
    }
}

enum ExampleState {
    case success, error, custom
}
