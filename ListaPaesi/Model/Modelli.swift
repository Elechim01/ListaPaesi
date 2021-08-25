//
//  Modelli.swift
//  ListaPaesi
//
//  Created by Michele Manniello on 23/08/21.
//

import SwiftUI
import CoreData
import WatchConnectivity

class Gestione: ObservableObject {
//    Paesi(nome: "Malnate"),Paesi(nome: "Cango"),Paesi(nome: "Concagno")
   @Published var elencoPaesi : [String] = []
//    serve per tenere conto della posizione
   @AppStorage("indice") var indice : Double = 0
    //    Aggiunta Paese:
    func AggiungiElemento(context: NSManagedObjectContext,nome : String,aggiungiArray: Bool){
        print("Indice\(indice)")
        self.indice += 1
        print("Indice\(indice)")
        let nuovoPaese = PaesiC(context: context)
        nuovoPaese.nome = nome
        nuovoPaese.posizione = indice
        print(nuovoPaese.nome)
        do {
            try context.save()
            if aggiungiArray == true{
                self.elencoPaesi.append(nome)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
//    funzione che elimina i paesi
//    Elimino tutto per poi riscriverlo..
    func eliminaPaese(context: NSManagedObjectContext,paesi: FetchedResults<PaesiC>, index : IndexSet ){
        context.perform {
            for e  in paesi {
                context.delete(e)
            }
            do {
                try context.save()
                print("Indice\(self.indice)")
                self.indice = 0
                self.elencoPaesi.remove(atOffsets: index)
                print(self.elencoPaesi)
                for elem in self.elencoPaesi{
                    self.AggiungiElemento(context: context, nome: elem,aggiungiArray: false)
                   
                   
                }
            } catch  {
                print(error.localizedDescription)
            }
            print("Indice\(self.indice)")
        }
       
    }
//    Funzione che svuta coredata, l'array, e il contator
    func Svuota(context: NSManagedObjectContext,paesi: FetchedResults<PaesiC>) {
        context.perform {
            for e in paesi{
                context.delete(e)
            }
            do{
                try context.save()
                self.elencoPaesi = []
                self.indice = 0
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
//    lettura Elementi Core Data
    func leggiPaesi(paesi: FetchedResults<PaesiC>){
        indice = 0
        for elem in paesi {
            indice += elem.posizione ?? 0
            print("Indice\(self.indice)")
            self.elencoPaesi.append(elem.nome ?? "")
        }
       
    }
    
}

class ViewModelPhone: NSObject,WCSessionDelegate {
    var session: WCSession
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
}
