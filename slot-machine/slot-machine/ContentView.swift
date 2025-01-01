//
//  ContentView.swift
//  slot-machine
//
//  Created by Kunal 🥀 on 29/12/24.
//

import SwiftUI


struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let p1 = CGPoint(x: 0, y: 20)
            let p2 = CGPoint(x: 0, y: rect.height - 20)
            let p3 = CGPoint(x: rect.width/2, y: rect.height)
            let p4 = CGPoint(x: rect.width, y: rect.height - 20)
            let p5 = CGPoint(x: rect.width, y: 20)
            let p6 = CGPoint(x: rect.width/2, y: 0)
            
            path .move(to: p6)
            
            path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
            path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
            path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
            path.addArc(tangent1End: p4, tangent2End: p5, radius: 15)
            path.addArc(tangent1End: p5, tangent2End: p6, radius: 15)
            path.addArc(tangent1End: p6, tangent2End: p1, radius: 15)
        }
    }

}



enum Choice:Int, Identifiable {
    
    var id: Int {
        rawValue
    }
    case success, failure
    
}



struct ContentView: View {
    
    @State public var symbol = ["eating" , "happy", "love"]
    @State public var number = [0, 1, 2]
    @State public var counter = 0
    @State private var showingALert: Choice?
    @State private var count: Int = 5
    
    
    
    var body: some View {
        ZStack{
            Image("sunshine")
                .resizable()
                .ignoresSafeArea(.all)
            VStack(alignment: .center, spacing: 80){
                HStack{
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange,radius: 1, y:3)
                    Text("Slot Machine")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .shadow(color: .orange, radius: 1, y: 3)
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange,radius: 1, y:3)
                }.frame(width: .infinity, height: 50, alignment: .center)
                Text("Chances left: \(count)")
                    .font(.system(size: 20))
                    .fontWeight(.black)
                    .shadow(color: .orange, radius: 1, y: 3)
                VStack(spacing: 15){
                    HStack(spacing: 35){
                        Hexagon()
                            .fill(Color.white.opacity(1))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbol[number[2]]).resizable()
                                    .scaledToFit()
                                    .frame(width: 80,
                                           height: 70,
                                           alignment: .center)
                                    .shadow(color: .gray, radius: 4, x: 4, y:4)
                            )
                        Hexagon()
                            .fill(Color.white.opacity(1))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbol[number[0]]).resizable()
                                    .scaledToFit()
                                    .frame(width: 80,
                                           height: 70,
                                           alignment: .center)
                                    .shadow(color: .gray, radius: 4, x: 4, y:4)
                            )
                    }
                    Hexagon()
                        .fill(Color.white.opacity(1))
                        .frame(width: 100, height: 120, alignment: .center)
                        .overlay(
                            Image(symbol[number[1]]).resizable()
                                .scaledToFit()
                                .frame(width: 80,
                                       height: 70,
                                       alignment: .center)
                                .shadow(color: .gray, radius: 4, x: 4, y:4)
                        )
                    HStack(spacing: 35){
                        Hexagon()
                            .fill(Color.white.opacity(1))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbol[number[0]]).resizable()
                                    .scaledToFit()
                                    .frame(width: 80,
                                           height: 70,
                                           alignment: .center)
                                    .shadow(color: .gray, radius: 4, x: 4, y:4)
                            )
                        Hexagon()
                            .fill(Color.white.opacity(1))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbol[number[2]]).resizable()
                                    .scaledToFit()
                                    .frame(width: 80,
                                           height: 70,
                                           alignment: .center)
                                    .shadow(color: .gray, radius: 4, x: 4, y:4)
                            )
                    }
                    
                    Spacer()
                            .frame(height: 40)
                    
                    Button {
                        
                        self.number[0] = Int.random(in: 0...symbol.count - 1)
                        self.number[1] = Int.random(in: 0...symbol.count - 1)
                        self.number[2] = Int.random(in: 0...symbol.count - 1)
                        
                        counter += 1
                        self.count -= 1
                        if self.$count.wrappedValue <= 0 {
                            count = 5
                        }
                        
                        if self.number[0] == self.number[1] && self.number[1] == self.number[2] {
                            self.showingALert = .success
                            counter = 0
                            count = 5
                        }
                        
                        
                        
                        if counter > 5 {
                            self.showingALert = .failure
                            counter = 0
                            count = 5
                        }
                        
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("color"))
                            .overlay(Text("Spin")
                                .fontWeight(.black)
                                .font(.title3)
                                )
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 1, y: 4)
                                .frame(width: 200, height: 40, alignment: .center)
                    }

                }
            }
            .alert(item: $showingALert) { alert -> Alert in
                
                switch alert {
                case .success:
                    return Alert(title: Text("You won!"), message: Text("You won"), dismissButton: .default(Text("OK")))
                case .failure:
                    return Alert(title: Text("You lost!"), message: Text("You lost"), dismissButton: .default(Text("OK")))
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
