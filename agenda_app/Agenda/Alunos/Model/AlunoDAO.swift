//
//  AlunoDAO.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 22/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoDAO: NSObject {
    
    var gerenciadorDeResultados: NSFetchedResultsController<Aluno>?
    
    var contexto: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func salvarAluno(dicionarioAluno: [String:Any]) {
        
        var aluno: NSManagedObject?
//        let aluno = Aluno(context: contexto)
        guard let id = UUID(uuidString: dicionarioAluno["id"] as! String) else { return }
        
        let alunos = recuperarAlunos().filter() { $0.id == id }
        if alunos.count > 0 {
            guard let alunoEncontrado = alunos.first else { return }
            aluno = alunoEncontrado
        } else {
            let entidade = NSEntityDescription.entity(forEntityName: "Aluno", in: contexto)
            aluno = NSManagedObject(entity: entidade!, insertInto: contexto)
        }
        
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(dicionarioAluno["nome"] as? String, forKey: "nome")
        aluno?.setValue(dicionarioAluno["endereco"] as? String, forKey: "endereco")
        aluno?.setValue(dicionarioAluno["telefone"] as? String, forKey: "telefone")
        aluno?.setValue(dicionarioAluno["site"] as? String, forKey: "site")

        guard let nota = dicionarioAluno["nota"] else { return }
        
        if (nota is String) {
            aluno?.setValue(dicionarioAluno["nota"] as? String, forKey: "nota")
        } else {
            let converterNota = String(describing: nota)
            aluno?.setValue((converterNota as NSString).doubleValue, forKey: "nota")
        }
        
        atualizaContexto() // salvando local
    }
    
    func deletarAluno(aluno: Aluno) {
        contexto.delete(aluno)
        atualizaContexto()
    }
    
    func atualizaContexto() {
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperarAlunos() -> [Aluno] {
                
        let pesquisaAluno: NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let listaAlunos = gerenciadorDeResultados?.fetchedObjects else { return [] }
        
        return listaAlunos
    }
    
}
