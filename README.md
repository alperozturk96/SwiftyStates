# SwiftyStates

Introducing... **SwiftyStates** – The Ultimate State Management Library for Your SwiftUI Apps 🚀✨

Have you ever struggled with managing various screen states in your SwiftUI apps? Say goodbye to repetitive code and welcome SwiftyStates! With SwiftyStates, you can handle different screen states like Loading, Error, or even create custom states with ease, all while keeping your codebase clean and maintainable.

**Key Features:**

🌟 **Elegant State Management:** Say farewell to spaghetti code! With SwiftyStates, managing loading, error, or custom states becomes a breeze. Simply set the state and let the magic unfold.

🌟 **Seamless Network Calls:** Want to make a network call without dealing with the complexities? BaseViewModel is here to save the day! Set the state and use the viewState modifier in your view, and the rest is taken care of by SwiftyStates.

🌟 **Error Handling Excellence:** Errors? No problem! SwiftyStates empowers you to handle errors gracefully, offering features like retry actions and dismiss actions to ensure a seamless user experience.

**Getting Started:**

1. Add SwiftyStates to your project using Swift Package Manager or CocoaPods.

2. Create your ViewModel by inheriting from BaseViewModel, where you can easily manage your state and network calls.

3. Use viewState modifier in your SwiftUI view to observe changes in the state and automatically update the UI accordingly.

**Sample Code:**

```swift
// Create a ViewModel inheriting from BaseViewModel
final class ExampleViewModel: BaseViewModel {
    // Make your network call here and set the state accordingly
    func fetchComments() {
        self.state = .Loading(item: .init(title: "Fetching comments please wait..."))
        
        // Simulated network call (replace with your actual API call)
        let response = ["I love this library 😊", "Very useful solution 👏", "I ♥️ SwiftUI"]
        
        // 5 Second delay
        DelayedMainThread {
            self.state = .Initial // reset state
            self.comments = response
        }
    }
}

// In your SwiftUI view:
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
        .viewState($viewModel.state) // Add viewState modifier bottom of your view
    }
}
```

**SwiftyStates** makes your app shine with clean and maintainable code, seamless network calls, and outstanding error handling. Say hello to happy coding and happy users!

Are you ready to elevate your SwiftUI app to the next level with SwiftyStates? Start using SwiftyStates today and unlock the full potential of state management! 🚀✨
