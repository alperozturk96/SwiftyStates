//
//  Popup.swift
//  
//
//  Created by Alper Ozturk on 31.7.23..
//

import SwiftUI

public struct Popup: View {
    
    // MARK: - States
    @State private var debounceFirstButtonAction: Bool = false
    
    @Binding var show: Bool
    let icon: String?
    let title: String?
    let description: String?
    let boldDescription: String?
    let detailedDescription: String?
    let backgroundColor: Color
    let loading: Bool
    let firstButton: PopupButton?
    let secondButton: PopupButton?
    let thirdButton: PopupButton?
    
    public init(show: Binding<Bool>, icon: String? = nil, title: String? = nil, description: String? = nil, boldDescription: String? = nil, detailedDescription: String? = nil, backgroundColor: Color = Color.blue, loading: Bool = false, firstButton: PopupButton? = nil, secondButton: PopupButton? = nil, thirdButton: PopupButton? = nil) {
        _show = show
        self.icon = icon
        self.title = title
        self.description = description
        self.boldDescription = boldDescription
        self.detailedDescription = detailedDescription
        self.backgroundColor = backgroundColor
        self.loading = loading
        self.firstButton = firstButton
        self.secondButton = secondButton
        self.thirdButton = thirdButton
    }
    
    public var body: some View {
        if $show.wrappedValue {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 5)
                
                if let icon {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                }
                
                if let title {
                    Text(title)
                        .foregroundColor(.white)
                }
                
                Group {
                    if let description {
                        Text(description)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    if let boldDescription {
                        Text(boldDescription)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                    }
                }
                
                if loading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                
                Group {
                    if let firstButton {
                        FirstButton(firstButton)
                    }
                    
                    if let secondButton {
                        SecondButton(secondButton)
                    }
                    
                    if let thirdButton {
                        ThirdButton(thirdButton)
                    }
                }
               
                Spacer()
                    .frame(height: 5)
            }
            .onChange(of: debounceFirstButtonAction) { shouldDebounce in
                if shouldDebounce {
                    DelayedMainThread(second: 10) {
                        debounceFirstButtonAction = false
                    }
                }
            }
            .onChange(of: show) { showPopup in
                if !showPopup {
                    debounceFirstButtonAction = false
                }
            }
            .padding(.all, 20)
            .frame(width: UIScreen.width * 0.85)
            .background(backgroundColor)
            .cornerRadius(16)
        }
    }
}

// MARK: - Buttons
extension Popup {
    @ViewBuilder
    private func FirstButton(_ button: PopupButton) -> some View {
        Button {
            button.action()
            debounceFirstButtonAction = true
        } label: {
            Text(button.title)
                .frame(width: UIScreen.width * 0.70, height: 40)
                .foregroundColor(backgroundColor)
                .background(.white)
                .cornerRadius(30)
        }
        .disabled(debounceFirstButtonAction)
        .opacity(debounceFirstButtonAction ? 0.6 : 1)
    }
    
    @ViewBuilder
    private func SecondButton(_ button: PopupButton) -> some View {
        Button {
            button.action()
        } label: {
            Text(button.title)
                .frame(width: UIScreen.width * 0.70, height: 40)
                .foregroundColor(.white)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 1)
                )
        }
    }
    
    @ViewBuilder
    private func ThirdButton(_ button: PopupButton) -> some View {
        Button {
            button.action()
        } label: {
            Text(button.title)
                .foregroundColor(.white)
        }
    }
}

struct Popup_Previews: PreviewProvider {
    static var previews: some View {
        let description = "Copy Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor."
        
        Popup(show: .constant(true), title: "Headline", description: description, loading: true, firstButton: .init(title: "1st Button", action: {}), secondButton: .init(title: "2nd Button", action: {}), thirdButton: .init(title: "3rd Button", action: {}))
            .previewDisplayName("Three Button Loading")
        
        Popup(show: .constant(true), title: "Headline", description: description, loading: false, firstButton: .init(title: "1st Button", action: {}), secondButton: .init(title: "2nd Button", action: {}), thirdButton: .init(title: "3rd Button", action: {}))
            .previewDisplayName("Three Button")
        
        Popup(show: .constant(true), title: "Headline", description: description, loading: false, firstButton: .init(title: "1st Button", action: {}), secondButton: .init(title: "2nd Button", action: {}))
            .previewDisplayName("Two Button")
        
        Popup(show: .constant(true), title: "Headline", description: description, loading: false, firstButton: .init(title: "1st Button", action: {}))
            .previewDisplayName("One Button")
        
        Popup(show: .constant(true), title: "Headline", description: description, backgroundColor: .red, loading: false, firstButton: .init(title: "1st Button", action: {}), secondButton: .init(title: "2nd Button", action: {}), thirdButton: .init(title: "3rd Button", action: {}))
            .previewDisplayName("Three Button Red Background")
        
        Popup(show: .constant(true), description: description, loading: true)
            .previewDisplayName("Loading")
      
        Popup(show: .constant(true), description: description, boldDescription: "10'000 SAT = (EUR 2.25)", firstButton: .init(title: "1st Button", action: {}))
            .previewDisplayName("Bold Description")
        
        Popup(show: .constant(true), description: description, firstButton: .init(title: "1st Button", action: {}))
            .previewDisplayName("First Button Loading")
        
        Popup(show: .constant(true), title: "Error", description: description, backgroundColor: .red, loading: false, firstButton: .init(title: "1st Button", action: {}))
            .previewDisplayName("Error Popup")
        
        Popup(show: .constant(true), title: "Error", description: description, backgroundColor: .red, loading: false, firstButton: .init(title: "1st Button", action: {}))
            .previewDisplayName("Hided Error Popup")
    }
}
