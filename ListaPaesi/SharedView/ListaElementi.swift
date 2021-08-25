//
//  ListaElementi.swift
//  ListaPaesi
//
//  Created by Michele Manniello on 24/08/21.
//

import SwiftUI

struct ListaElementi: View {
    @EnvironmentObject var gestione : Gestione
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: PaesiC.entity(), sortDescriptors: [NSSortDescriptor(key: "posizione",ascending: true)]) var pesifetch : FetchedResults<PaesiC>
    var body: some View{
        List{
            ForEach(gestione.elencoPaesi,id: \.self){ paese in
                Text("\(paese)")
                    .font(.title2)
                    .padding(.top)
                    .gesture(
                        DragGesture(minimumDistance: 20)
                            .onChanged({ value in
                                
                            }))
            }
            .onDelete(perform: { indexSet in
                gestione.eliminaPaese(context: context, paesi: pesifetch,index: indexSet)
//                print(elencoPaesi[indexSet.count - 1])
            
            })
            .onMove(perform: { indices, newOffset in
//                elencoPaesi.move(fromOffsets: indices, toOffset: newOffset)
            })
        }
    }
}

//struct ListaElementi_Previews: PreviewProvider {
//    static var previews: some View {
//        ListaElementi()
//    }
//}
