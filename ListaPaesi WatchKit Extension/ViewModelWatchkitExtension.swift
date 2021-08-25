//
//  ViewModelWatchkitExtension.swift
//  ListaPaesi WatchKit Extension
//
//  Created by Michele Manniello on 24/08/21.
//

import Foundation
import SwiftUI
import WatchConnectivity
class ViewModelWatch: NSObject,WCSessionDelegate,ObservableObject {
    var session : WCSession
    @Published var paesi : [String] = []
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.paesi = applicationContext["Array"] as? [String] ?? []
        }
    }
}

struct Paesi : Identifiable {
    var id = UUID().uuidString
    var nome : String
}
