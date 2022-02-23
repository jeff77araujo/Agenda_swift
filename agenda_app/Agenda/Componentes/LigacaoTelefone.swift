//
//  LigacaoTelefone.swift
//  Agenda
//
//  Created by Jefferson Oliveira de Araujo on 23/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefone: NSObject {
    
    func fazLigacao(_ alunoSelecionado: Aluno) {
        guard let numeroDoAluno = alunoSelecionado.telefone else { return }
        if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
