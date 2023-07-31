//
//  ExampleView.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import SwiftUI

struct ExampleView: View {
    @StateObject private var viewModel = ExampleViewModel()
    
    init(viewModel: ExampleViewModel = ExampleViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                ForEach(viewModel.comments, id: \.self) { comment in
                    Text(comment)
                        .font(.title)
                }
            }
        }
        .onAppear {
            viewModel.fetchComments()
        }
        .viewState($viewModel.state)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView(viewModel: .init(exampleState: .success))
            .previewDisplayName("Success State")
        
        ExampleView(viewModel: .init(exampleState: .error))
            .previewDisplayName("Error State")
        
        ExampleView(viewModel: .init(exampleState: .custom))
            .previewDisplayName("Custom State")
    }
}
