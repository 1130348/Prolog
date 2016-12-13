:-[pesquisaCaminhos].


imprimeMenu :- repeat,
                write('1 - Pesquisa de caminhos para entrega de encomendas'),nl,
                write('2 - Percurso para entrega de encomendas'),nl,
                write('0-Sair'),nl,
                write('Inserir opção: '),
                read(Opcao),
                number(Opcao),Opcao > -1, Opcao <3,
                escolher_opcao_menu(Opcao),nl,
                imprimeMenu.

escolher_opcao_menu(0):-halt.
				
escolher_opcao_menu(1) :- menu_pesquisa.

escolher_opcao_menu(2).

menu_pesquisa:- write('Pesquisa de caminhos para entrega de encomendas'),nl,
                repeat,
                write('Indique a cidade de origem: '),
                read(Corigem),nl,
                liga(Corigem,_,_,_),
                repeat,
                nl,write('Indique a cidade de destino: '),
                read(Cdestino),nl,
                Corigem\=Cdestino,
                liga(_,Cdestino,_,_),
                repeat,
				nl,write('Indique o Peso da Encomenda: '),
				read(Peso),nl,
                nl,write('1-Percurso Mais Barato'),
                nl,write('2-Percurso Mais Rapido'),
                nl,write('Selecione uma das opcoes: '),
                read(OpT),
                number(OpT),OpT<3,OpT>0,
                repeat,  
                percursoMaisBarato(Corigem,Cdestino,Percurso,Custo,Peso,OpT),
                write('Percurso : '),write(Percurso),nl,write('Custo : '),write(Custo),nl.
				


%maisBarato				
percursoMaisBarato(Corigem,Cdestino,Percurso,Custo,Peso,1):-astar_maisbarato(Corigem,Cdestino,Percurso,Custo,Peso).
		
				
:-write('ALGAV 2016-2017'),nl.
:-imprimeMenu.