# coding: utf-8

require "truefalse"
 
Nodo = Struct.new :value, :next, :prev

class Lista
	attr_accessor :cabeza, :cola, :total
	
	include Enumerable
	
	def initialize(p)
		raise TypeError, "Esperada pregunta como parámetro de entrada" unless p.is_a? (Question)
		@cabeza = Nodo.new(p, nil, nil)
		@cola = @cabeza
		@total = 1
	end
	
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
	
	
	def <<(p)
		raise TypeError, "Esperada pregunta para inserción" unless p.is_a? (Question) 
		@cola.next = Nodo.new(p, nil, @cola)
		@cola = @cola.next
		@total += 1
		@cola.value
	end
	
	def push_back(*questions)
		questions.each do |p|
			@cola.next = Nodo.new(p, nil, @cola)
			@cola = @cola.next
			@total += 1
		end
		questions
	end
	
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
	
	def each
		aux = @cabeza
		while (aux != nil) do
			yield aux.value
			aux = aux.next
		end
	end
	
	def reverse(nodo, &block)
		return Lista.new(Question.new(:text => "Vacio", :right => "Vacio", :distractors => ["Vacio"])) if (nodo == nil)
		list = reverse(nodo.next, &block)
		list << nodo.value if block[nodo.value]
		list
	end
	
	def revers(&block)
		block = ->(x) {true} if !block_given?
		list = reverse(@cabeza, &block)
		list.pop
		return nil if list.total == 0
		list
	end
end
