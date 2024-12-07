//
//  ContentView.swift
//  gridView
//
//  Created by sagar on 08/12/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let imageColor: Color
}

struct ContentView: View {
    
    let spacing: CGFloat = 10
    @State var numberOfColoun = 3
    
    let iteams = [
        Item(title: "Home", image: "house", imageColor: .purple),
        Item(title: "Tree", image: "tree.fill", imageColor: .green),
        Item(title: "Car", image: "car.fill", imageColor: .red),
        Item(title: "Person", image: "person.fill", imageColor: .yellow),
        Item(title: "laptop", image: "desktopcomputer", imageColor: .cyan),
        Item(title: "Home", image: "house", imageColor: .purple),
        Item(title: "Tree", image: "tree.fill", imageColor: .green),
        Item(title: "Car", image: "car.fill", imageColor: .red),
        Item(title: "Person", image: "person.fill", imageColor: .yellow),
        Item(title: "laptop", image: "desktopcomputer", imageColor: .cyan)
    ]
    
    var body: some View {
        
        let colunms = Array(repeating: GridItem(.flexible(),spacing: spacing), count: numberOfColoun)
        
        ScrollView {
            
            //Header View
            HeaderView(numberOfColoun: $numberOfColoun)
            
            LazyVGrid(columns: colunms, spacing: spacing ) {
                ForEach(iteams) { item in
                    Button(action: {
                        
                    }, label: {
                        ItemView(item: item)
                    })
                    //with default button style is not looking good so we will create differnt view
//                    .buttonStyle(PlainButtonStyle())
                    .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                    
                }
            }
            .offset(y: -50)
            .padding(.horizontal )
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct HeaderView: View {
    
    @Binding var numberOfColoun: Int
    
    var body: some View {
        VStack {
            Image("demo")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.white ,lineWidth: 4)
                }
                .onTapGesture {
                    withAnimation(.snappy) {
                        numberOfColoun = numberOfColoun % 3 + 1
                    }
                }
            
            Text("Change the Style")
                .foregroundStyle(Color.white)
                .font(.system(size: 30, weight: .bold,design: .serif))
            
            Text("Change the world By Being yourself")
                .foregroundStyle(Color.white)
                .font(.system(size: 18,weight: .medium,design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
    }
}

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 28)
            let ImageWidth = min(50, reader.size.width * 0.6 )
            
            VStack(spacing: 5) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imageColor)
                    .frame(width: ImageWidth)
                
                Text(item.title)
                    .font(.system(size: fontSize,weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
       
    }
}

struct ItemButtonStyle: ButtonStyle {
     
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
      
    
}


#Preview {
    ContentView()
}
