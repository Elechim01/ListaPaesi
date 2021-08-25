//
//  ContentView.swift
//  ListaPaesi
//
//  Created by Michele Manniello on 23/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gestione = Gestione()
    @FetchRequest(entity: PaesiC.entity(), sortDescriptors: [NSSortDescriptor(key: "posizione",ascending: true)]) var pesifetch : FetchedResults<PaesiC>
    @State var mostra : Bool = true
    var model = ViewModelPhone()
    @Environment(\.managedObjectContext) var context
    var body: some View {
        ZStack {
            NavigationView{
                ListaElementi()
                    .environmentObject(gestione)
                .navigationTitle("Elenco Paesi")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        Button(action: {
                                            let appDictionary = ["Array":gestione.elencoPaesi]
                                            do{
                                                try  self.model.session.updateApplicationContext(appDictionary)
                                            }catch{
                                                print(error.localizedDescription)
                                            }
                                           
                                        }, label: {
                                            Text("Carica")
                                        })
                                    , trailing:  HStack(spacing: 5){
                                        Button(action: {
                                            self.gestione.Svuota(context: context, paesi: pesifetch)
                                        }, label: {
                                            Text("Svuota")
                                        })
                                        Button(action: {
                                            self.mostra.toggle()
                                        }, label: {
                                            Image(systemName: "plus")
                                                .padding(10)
                                        })
                                    })
            }
            if mostra == true{
                Aggiungi(mostra: $mostra)
                    .cornerRadius(30)
                    .environmentObject(gestione)
            }
        }
        .onAppear{
            gestione.leggiPaesi(paesi: pesifetch)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .colorScheme(.dark)
    }
}

struct Aggiungi: View {
    @Binding var mostra : Bool
    @State var testo : String = ""
    @EnvironmentObject var gestione: Gestione
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        VStack{
            Text("Aggiungi un paese")
                .font(.title2)
                .padding(.top)
                .foregroundColor(colorScheme == .light ? .white : .black)
            TextField("Paese",text: $testo)
                
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(3)
                .padding()
                
            Divider()
            HStack(spacing:30) {
                Button(action: {
//                    salva e chiudi
                    self.gestione.AggiungiElemento(context: context, nome: testo, aggiungiArray: true)
                    self.mostra.toggle()
                    
                }, label: {
                    Text("Salva")
                        .padding(5)
                })
                .background(Color.white)
                .clipShape(Capsule())
                
                Button(action: {
                    mostra.toggle()
                }, label: {
                    Text("Chiudi")
                        .padding(5)
                        .foregroundColor(.red)
                })
                .background(Color.white)
                .clipShape(Capsule())
               
            }
            .padding(.top)
            
            
        }
        .frame(width: 200, height: 200)
        .background(Color.primary.opacity(0.9))
    }
}

