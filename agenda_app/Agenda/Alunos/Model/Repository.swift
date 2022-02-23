//
//  Repository.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 22/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class Repository: NSObject {
    
    func recuperarAlunos(completion: @escaping(_ listaAlunos: [Aluno]) -> Void) {
        var alunos = AlunoDAO().recuperarAlunos()
        if alunos.count == 0 {
            AlunoAPI().recuperarAlunos {
                alunos = AlunoDAO().recuperarAlunos()
                completion(alunos)
            }
        } else {
            completion(alunos)
        }
    }
    
    func salvarAluno(aluno: [String:String]) {
        AlunoAPI().salvarAlunosServer(parameters: [aluno])
        AlunoDAO().salvarAluno(dicionarioAluno: aluno)
    }
    
    func deletarAluno(aluno: Aluno) {
        guard let id = aluno.id else { return }
        AlunoAPI().deletarAluno(id: String(describing: id).lowercased())
        AlunoDAO().deletarAluno(aluno: aluno)
    }
    
    func sincronizarAlunos() {
        let alunos = AlunoDAO().recuperarAlunos()
        var listaParametros: [[String:String]] = []
        
        for aluno in alunos {
            guard let id = aluno.id else { return }
            
            let parametros: [String:String] = [
                "id": String(describing: id).lowercased(),
                "nome": aluno.nome ?? "",
                "endereco": aluno.endereco ?? "",
                "telefone": aluno.telefone ?? "",
                "site": aluno.site ?? "",
                "site": "\(aluno.nota)" 
            ]
            listaParametros.append(parametros)
        }
        AlunoAPI().salvarAlunosServer(parameters: listaParametros)
    }
}
