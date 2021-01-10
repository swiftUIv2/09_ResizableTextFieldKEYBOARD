//
//  ContentView.swift
//  ResizableTextFieldKEYBOARD_09
//
//  Created by emm on 10/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State var txt = ""
    @State var height: CGFloat = 0
    @State var KeyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Example Chat keyboard hiding and dynamic textField")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }.padding()
            .background(Color.white.opacity(0.1))
            
            ScrollView(.vertical, showsIndicators: false) {
                // Chat Content...
                Text("")
            }
            
            HStack(spacing: 8) {
                ResizableTF(txt: self.$txt, height: self.$height)
                    .frame(height: self.height < 150 ? self.height : 150 )
                    .frame(height: self.height)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15)
                
                Button(action: {
                    
                }) {
                    Image(systemName:"scribble.variable")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .foregroundColor(.black)
                        .padding(13)
                }
                .background(Color.white)
                .clipShape(Circle())
            }
            .padding(.horizontal)
            
        }
        .padding(.bottom, 8)
        .background(Color.primary.opacity(0.06).edgesIgnoringSafeArea(.bottom))
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) {
                (data) in
                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                as! NSValue
                
                self.KeyboardHeight = height1.cgRectValue.height - 0
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) {
                (_) in
            
                self.KeyboardHeight = 0
            }
            
        }
    }
}


struct ResizableTF: UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return ResizableTF.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context)-> UITextView {
        
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Enter Message"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizableTF
        init(parent1 : ResizableTF){
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.txt == "" {
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.txt == "" {
                textView.text = "Enter Message"
                textView.textColor = .gray
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
