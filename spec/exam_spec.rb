# encoding: utf-8

require 'spec_helper'
require 'exam'

class Question
	describe Exam do
	  
		before :each do
			@q = Question.new(:text => '2+2=', :right => 4 , :distractors => [9,3,5])
		end
		
		context "Cuando se crea una pregunta" do
			it "Debe tener texto y alguna pregunta" do
				expect(@q.text)=='2+2='
				expect(@q.right)==4
			end
			
			it "debe tener 3 componentes" do
				expect {Question.new(:text => '5*8=?')}.to raise_error(ArgumentError)
			end
			
			it "mostrar pregunta" do
				expect(@q).to respond_to :text
			end
			
			it "mostrar respuesta correcta" do
				expect(@q).to respond_to :right
			end
			
			it "mostrar opciones incorrectas" do
				expect(@q).to respond_to :distractors
			end
			
			it "mostrar por pantalla" do
				expect(@q).to respond_to :to_s
			end
			
			it "Debe indicar su dificultad" do
				expect(@q).to respond_to :difficulty
			end
			
			it "mostrarse correctamente" do
				expect(@q.to_s).to match(/.+\n(\w\)\s+(\w|\d)+\n)+/)
			end
			
			it "Debe incluir el modulo comparable" do
				expect(@q).to be_kind_of Comparable
			end
			
			it "Debe comparase con otra pregunta correctamente" do
				p = Question.new(:text => '1+3=', :right => 4, :distractors => [0,5,9], :difficulty => 3)
				expect(@q > p).to eq(false)
				expect(@q < p).to eq(true)
				expect(@q == p).to eq(false)
				expect(@q <= p).to eq(true)
				expect(@q >= p).to eq(false)
			end
		end
	end
end
	


class Exam
	describe Exam do
		before :each do
			@q = Question.new(:text => '2+2=', :right => 4 , :distractors => [9,3,5])
			@n = Nodo.new(@q, nil, nil)
			@l = Lista.new(@q)
		end
		
		context "Nodo" do
			it "Debe existir un nodo de la lista con sus datos con su siguiente y su anterior" do
				expect(@n.value)==@q
				expect(@n.next)==nil
				expect(@n.prev)==nil
			end
		end
		
		context "Lista" do
			it "Se puede extraer el primer elemento de la lista" do
				expect(@l).to respond_to :pop
				expect(@l.pop)== @q
			end
			
			it "Se puede insertar un elemento" do
				expect(@l).to respond_to :<<
				expect {@l << @n}.to raise_error(TypeError)
				expect {@l << @l}.to raise_error(TypeError)
				expect {@l << @q}==@q	
			end
			
			it "Se puede insertar varios elementos" do
				expect(@l).to respond_to :push_back
				expect(@l.push_back(@q, @q)).to be_instance_of(Array)
			end
			
			it "Debe existir una lista con su cabeza" do
				expect(@l).to respond_to :cabeza
			end
			
			it "Debe inicializarse con una pregunta" do
				expect {Lista.new()}.to raise_error(ArgumentError)
				expect {Lista.new(Nodo.new(@q, nil, nil))}.to raise_error(TypeError)
			end
			
			it "Debe mostrarse correctamente" do
				text = "¿Cuál es la salida del siguiente código Ruby?\nclass Xyz\n\sdef pots\n\s\s@nice\n\send\nend\n\nxyz = Xyz.new\np xyz.pots"
				exam = Lista.new(Question.new(:text => text, :right =>"nil", :distractors => ["#<Xyz:0xa000208>","0","Ninguna de las anteriores"]))
				
				text = "La siguiente definición de un hash en Ruby es válida:\nhash_raro = {\n\s[1, 2, 3] => Object.new(),\nHash.new => :toto\n}"
				exam << TrueFalse.new(:text => text, :right => false)
				
				text = %Q{¿Cuál es la salida del siguiente código Ruby?\nclass Array\n\sdef say_hi\n\s\s"HEY!"\n\send\nend\n p [1, "bob"].say_hi}
				exam << Question.new(:text => text, :right =>"HEY!", :distractors => ["1","bob","Ninguna de las anteriores"])
				
				text = "¿Cuál es el tipo del objeto en el siguiente código Ruby?\nclass Objeto\nend"
				exam << Question.new(:text => text, :right =>"Una instancia de la clase Class", :distractors => ["Una Constante", "Un Objeto", "Ninguna de las anteriores"])
				
				text = "Es apropiado que una clase Tablero herede de una clase Juego"
				exam << TrueFalse.new(:text => text, :right => false)
				
				expect(exam.to_s).to match(/(\d+\.-\)(.|\s|\n)+)+/)
			end
			
			it "Debe incluir el modulo enumerable" do
				expect(@l).to be_kind_of Enumerable
			end
			
			it "Debe ordenar correctamente" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.sort).to eq([p, @q])
			end
			
			it "Debe indicar el maximo" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.max).to eq(@q)
			end
			
			it "Debe indicar el minimo" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.min).to eq(p)
			end
			
			it "Debe saber usar all?" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.all?{|x| x.difficulty > 0}).to eq(false)
			end
			
			it "Debe saber contar" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.count(p))==1
			end
			
			it "Debe encontrar correctamente" do
				p = TrueFalse.new(:text => "¿2+2=4?", :right => true, :difficulty => 0)
				@l << p
				expect(@l.find{|x| x.difficulty == 1}).to eq(@q)
			end
			
			it "Debe existir metodo revers" do
				expect(@l).to respond_to :revers
			end
			
			it "Debe invertir correctamente la lista" do
				q1 = Question.new(:text => "2+2=", :right => 4, :distractors => [1,5,8], :difficulty => 1)
				q2 = Question.new(:text => "3+3=", :right => 6, :distractors => [1,5,8], :difficulty => 1)		
				q3 = Question.new(:text => "4+4=", :right => 8, :distractors => [1,5,7], :difficulty => 1)
				q4 = Question.new(:text => "5+5=", :right => 10, :distractors => [1,5,7], :difficulty => 1)
				
				list1 = Lista.new(q1)
				list1 << q2
				list1 << q3
				list1 << q4
				
				list2 = Lista.new(q4)
				list2 << q3
				list2 << q2
				list2 << q1
				
				expect(list1.revers)==list2
			end
			
		end
		
		context "Exam" do
			before :each do
				@e = Exam.new(@q)
			end
			
			it "Debe tener un atributo lista" do
				expect(@e).to respond_to :list
			end
			
			it "Debe mostrar por pantalla el examen" do
				expect(@e).to respond_to :to_s
			end
			
			it "Debe mostrarse correctamente el examen" do
				expect(@e.to_s).to match(/(\d+\.-\)(.|\s|\n)+)+/)
			end
			
			it "Se puede insertar un elemento" do
				expect(@e).to respond_to :<<
				expect {@e << @n}.to raise_error(TypeError)
				expect {@e << @e}.to raise_error(TypeError)
				expect {@e << @q}==@q
			end
			
			it "Se puede insertar varios elementos" do
				expect(@e).to respond_to :push_back
				expect(@e.push_back(@q, @q)).to be_instance_of(Array)
			end
			
			it "Debe inicializarse con una pregunta" do
				expect {Exam.new()}.to raise_error(ArgumentError)
				expect {Exam.new(Nodo.new(@q, nil, nil))}.to raise_error(TypeError)
			end
		end
	end
end


class TrueFalse

	describe Exam do
		before :each do
			@q = TrueFalse.new(:text => '¿2+2=4?', :right => true)
		end
		
		context "Pregunta Verdadero y Falso" do
			it "Debe tener texto y alguna pregunta" do
				expect(@q.text)=='¿2+2=4?'
				expect(@q.right)=='Cierto'
			end
			
			it "Debe heredar de Pregunta" do
				expect(@q).to be_a Question
			end
			
			it "Debe no ser instancia de Pregunta" do
				expect(@q.instance_of?Question).to eq(false)
			end
			
			it "debe tener 2 componentes" do
				expect {TrueFalse.new(:text => '5*8=?')}.to raise_error(ArgumentError)
			end
			
			it "mostrar pregunta" do
				expect(@q).to respond_to :text
			end
			
			it "mostrar respuesta correcta" do
				expect(@q).to respond_to :right
			end
			
			it "mostrar opciones incorrectas" do
				expect(@q).to respond_to :distractors
			end
			
			it "Debe indicar su dificultad" do
				expect(@q).to respond_to :difficulty
			end
			
			it "mostrar por pantalla" do
				expect(@q).to respond_to :to_s
			end
			
			it "mostrarse correctamente" do
				expect(@q.to_s).to match(/(\d|\w)+\n(\w\)\s+(\w|\d)+\n)+/)
			end
			
			it "Debe incluir el modulo comparable" do
				expect(@q).to be_kind_of Comparable
			end
			
			it "Debe comparase con otra pregunta correctamente" do
				p = TrueFalse.new(:text => '¿1+3=4?', :right => true, :difficulty => 3)
				expect(@q > p).to eq(false)
				expect(@q < p).to eq(true)
				expect(@q == p).to eq(false)
				expect(@q <= p).to eq(true)
				expect(@q >= p).to eq(false)
			end
		end
	end
end

class Interfaz
	describe Interfaz do
		before :each do
			@q = Question.new(:text => "2+2=", :right => 4, :distractors => [1, 2, 3])
			@i = Interfaz.new(@q)
		end
		
		context "Interfaz" do
			it "Tiene atributo examen" do
				expect(@i).to respond_to :exam
			end
			
			it "Inicializa con una pregunta" do
				expect {Interfaz.new()}.to raise_error(ArgumentError)
				expect {Interfaz.new(Nodo.new(@q, nil, nil))}.to raise_error(TypeError)
			end
			
			it "Tiene un metodo test" do
				expect(@i).to respond_to :test
				expect(@i.test([4])).to eq([1])
				expect(@i.test([3])).to eq([0])
				@i.exam << @q
				expect(@i.test([4, 3])).to eq([1, 0])
			end
		end
	end
end

class Quiz
	describe Exam do
		before :each do
			@q = Quiz.new("Cuestionario LPP 05/12/2014") do
			
			question "¿Cuantos argumentos de tipo bloque puede recibir un metodo?",
				right => "1",
				wrong => "2",
				wrong => "muchos",
				wrong => "los que defina el usuario"
				
				question "En Ruby los bloques son objetos que contienen codigo",
				wrong => "Cierto",
				right => "Falso"
			end
		end
	
		context "Quiz" do
			it "Contiene un examen, un contador y un titulo" do
				expect(@q.cabecera)=="Cuestionario LPP 05/12/2014"
				expect(@q.count)==1
				expect(@q.exam.instance_of?Exam).to eq(true)
			end
		
			it "Debe mostrarse correctamente el examen" do
				expect(@q).to respond_to :exam
			end
		
			it "Debe mostrarse correctamente el contador" do
				expect(@q).to respond_to :count
			end
		
			it "Debe mostrarse correctamente el titulo" do
				expect(@q).to respond_to :cabecera
			end
		
			it "Debe generar simbolo right" do
				expect(@q).to respond_to :right
				expect(@q.right.instance_of?Symbol).to eq(true)
			end
		
			it "Debe generar Array como simbolo" do
				expect(@q).to respond_to :wrong
				expect(@q.wrong.instance_of?Array).to eq(true)
			end
		
			it "Debe leer una pregunta" do
				expect(@q).to respond_to :question
				expect(@q.question("2+2=", @q.right=> "4", @q.wrong=> "5")).to be_instance_of(Exam)
			end

			it "Debe mostrarse correctamente" do
				expect(@q.to_s).to match(/\s\s.+\n#+\n\n.+/)
			end		
		end
	end
end