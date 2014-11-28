# coding: utf-8

require "truefalse"
 
Nodo = Struct.new :value, :next, :prev
# Clase de Lista doblemente enlazada
class Lista
	attr_accessor :cabeza, :cola, :total
	
	include Enumerable
	# Instancia de la clase Lista desde una pregunta.
	def initialize(p)
		raise TypeError, "Esperada pregunta como parámetro de entrada" unless p.is_a? (Question)
		@cabeza = Nodo.new(p, nil, nil)
		@cola = @cabeza
		@total = 1
	end
	# Método para extraer un elemento de la lista. Si la lista está vacía genera un error.
	def pop
		raise IndexError, "Lista vacía, imposible hacer pop" unless @total > 0
		head = nil
		if @cola == @cabeza
			head = @cabeza
			@cola = @cabeza = nil
			head.next = head.prev = nil
		else
			head = @cabeza
			@cabeza = @cabeza.next
			@cabeza.prev = nil
			head.next = nil
		end
		
		@total -= 1
		head.value
	end
	
	# Método para insertar preguntas de la lista, sobrecargando el operador <<.
	def <<(p)
		raise TypeError, "Esperada pregunta para inserción" unless p.is_a? (Question) 
		@cola.next = Nodo.new(p, nil, @cola)
		@cola = @cola.next
		@total += 1
		@cola.value
	end
	
	# Método para insertar una o varias preguntas.
	def push_back(*questions)
		questions.each do |p|
			@cola.next = Nodo.new(p, nil, @cola)
			@cola = @cola.next
			@total += 1
		end
		questions
	end
	
	# Método para mostrar la lista.
	def to_s
		aux = @cabeza
		s = ''
		i = 1
		while (aux != nil) do
			s += "#{i}.-) #{aux.value}\n"
			aux = aux.next
			i += 1
		end
		s
	end
	
	# Método para el manejo de métodos del módulo enumerable.
	def each
		aux = @cabeza
		while (aux != nil) do
			yield aux.value
			aux = aux.next
		end
	end
	
	# Método para invertir la lista recursivamente.
	def reverse(nodo, &block)
		return Lista.new(Question.new(:text => "Vacio", :right => "Vacio", :distractors => ["Vacio"])) if (nodo == nil)
		list = reverse(nodo.next, &block)
		list << nodo.value if block[nodo.value]
		list
	end
	
	# Método para invertir la lista.
	def revers(&block)
		block = ->(x) {true} if !block_given?
		list = reverse(@cabeza, &block)
		list.pop
		return nil if list.total == 0
		list
	end
end
