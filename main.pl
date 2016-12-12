

imprime_menu :- repeat,
                write('1 - Pesquisa de caminhos para entrega de encomendas'),nl,
                write('2 - Percurso para entrega de encomendas'),nl,
                write('0-Sair'),nl,
                write('Inserir opção: '),
                read(Opcao),
                number(Opcao),Opcao > -1, Opcao <3,
                escolher_opcao_menu(Opcao),nl,
                imprime_menu.

escolher_opcao_menu(0):-halt.
				
escolher_opcao_menu(1) :- menu_pesquisa.

escolher_opcao_menu(2) :- menu_percurso.

menu_pesquisa:- write('Pesquisa de caminhos para entrega de encomendas'),nl,
                repeat,
                write('Indique a cidade de origem: '),
                read(Corigem),nl,
                validaCidade(Corigem),
                repeat,
                nl,write('Indique a cidade de destino: '),
                read(Cdestino),nl,
                verifica_cidades_diferentes(Corigem,Cdestino),
                validaEstacao(Cdestino),
                repeat,
                write('Indique a hora de partida(HH:MM): '),
                read_line_to_codes(user_input,String),
                atom_codes(Atom, String),
                atomic_list_concat(Hora, ':', Atom),
                horas_para_minutos(Hora,Min),
                repeat,
                nl,write('1-Dia Normal'),
                nl,write('2-Sabado'),
                nl,write('3-Domingo'),
                nl,write('Selecione uma das opcoes: '),
                read(OpT),
                number(OpT),OpT<4,OpT>0,
                escolher_opcao_tempo(OpT,Min,TipoDia),
                repeat,
                write('Que caminho deseja:'),nl,
                write('1-Mais barato'),nl,
                write('2-Mais rapido'),nl,
                write('Escolha uma opcao: '),
                read(OpTipo),
                number(OpTipo),OpTipo > 0, OpTipo < 3,
                cria_percurso(OpTipo,TipoDia,Min,Eorigem,Edestino,Percurso),
                imprime_percurso(Percurso,Min).
				
				
:-write('ALGAV 2016-2017'),nl.
:-imprime_menu.
