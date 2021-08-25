//
//  PaesiC+CoreDataProperties.swift
//  ListaPaesi
//
//  Created by Michele Manniello on 25/08/21.
//
//

import Foundation
import CoreData


extension PaesiC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaesiC> {
        return NSFetchRequest<PaesiC>(entityName: "PaesiC")
    }

    @NSManaged public var nome: String?
    @NSManaged public var posizione: Double

}

extension PaesiC : Identifiable {

}
