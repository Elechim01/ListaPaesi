//
//  ContentView.swift
//  ListaPaesi WatchKit Extension
//
//  Created by Michele Manniello on 23/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    var body: some View {
        NavigationView{
            ListaElementi(elencoPaesi: $model.paesi)
        }.navigationTitle("Elenco paesi")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ListaElementi: View {
    @Binding var elencoPaesi : [String]
    var body: some View{
        List{
            ForEach(elencoPaesi,id: \.self){ paese in
                Text("\(paese)")
                    .font(.title2)
                    .padding(.top)
                    .gesture(
                        DragGesture(minimumDistance: 20)
                            .onChanged({ value in
                                
                            }))
            }
            .onDelete(perform: { indexSet in
                print(indexSet.count)
                print(elencoPaesi[indexSet.count - 1])
            
                elencoPaesi.remove(atOffsets: indexSet)
            })
            .onMove(perform: { indices, newOffset in
                elencoPaesi.move(fromOffsets: indices, toOffset: newOffset)
            })
        }
    }
}
