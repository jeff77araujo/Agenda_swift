//
//  Filter.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 23/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class Filter: NSObject {
    
    func filtrarAlunos(listaAlunos: [Aluno], texto: String) -> [Aluno] {
        let alunosEncontrados = listaAlunos.filter { (aluno) -> Bool in
            guard let nome = aluno.nome else { return false }
            return nome.contains(texto)
        }
        return alunosEncontrados
    }
}
