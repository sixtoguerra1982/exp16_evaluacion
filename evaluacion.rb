def limpiar_pantalla
 for i in 0..50
  puts "\n"
 end
end

def opc_invalida
 limpiar_pantalla
 puts 'OPCIÓN INVALIDA !!!' 
 gets
end

def archivo_no_existe
 limpiar_pantalla
 puts 'ARCHIVO DE BD NO EXISTE' 
 gets
end

def agregar_promedio(nombre, promedio)
 # nuevo archivo
 if File.exist?('promedio.csv')
  file = File.open('promedio.csv' , 'a')
  file.puts nombre + ' ' + promedio
  file.close
 else
  file = File.open('promedio.csv' , 'w')
  file.puts nombre + ' ' + promedio
  file.close
 end 
end

def menu_principal
 limpiar_pantalla
 puts '–––––––––––––––––––––––––––––––––––––––––––––––––––––'
 puts '          [1] Generar Archivo promedio.csv'
 puts '          [2] Informe de Inasistencias'
 puts '          [3] Informe de Aprobados'
 puts '          [4] Salir'
 puts '_____________________________________________________'
 puts '                                                     '
 puts '          Ingrese opción de [1-4]' 
 puts '–––––––––––––––––––––––––––––––––––––––––––––––––––––'
end

def menu_sub_opc1
 #GENERAR UN NUEVO ARCHIVO CON EL PROMEDIO DE LAS NOTAS
 #LIMPIO ARCHIVO PROMEDIO
 file = File.open('promedio.csv' , 'w')
 file.close
 ######
 #1) leer archivo de registros
 filename = 'registros.csv'
 if File.exist?(filename)
  file = File.open(filename , 'r')
  arreglo_principal = file.read.split("\n")
  file.close
  auxiliar = []
  arreglo_principal.each { |elemento| auxiliar << elemento.to_s.split(', ') }
  auxiliar.each do |elemento|
   aux2 = elemento[1..elemento.length].map {|e| e.to_i}
   suma = aux2.inject(0){|suma, x| suma + x}
   largo = elemento[1..elemento.length].length
   prom = suma.to_f / largo
   agregar_promedio(elemento[0], prom.to_s)
  end
   #MOSTRAR EL ARCHIVO
  limpiar_pantalla
  puts "\n DESEA VER ARCHIVO promedio.csv [S/N]"
  op2 = gets.chomp.to_s
  if op2 == 'S' || op2 == 's'
   limpiar_pantalla
   file = File.open('promedio.csv', 'r')
   arreglo_principal = file.read.split("\n")
   file.close
   puts arreglo_principal
   gets
   end
 else
  archivo_no_existe
 end 
end

def menu_sub_opc2
 limpiar_pantalla
 filename = 'registros.csv'
 if File.exist?(filename)
  file = File.open(filename)
  arreglo_principal = file.read.split("\n")
  file.close
  aux = []
  arreglo_principal.each { |elemento| aux << elemento.split(', ') }
  puts "Informe de Inasistencias \n"
  aux.each_with_index do |elemento, i|  
   separa_a = elemento.select {|x| (x == 'A')} 
   puts "\n #{elemento[0]} : #{separa_a} #{separa_a.length}" if separa_a.length > 0
  end
 else
  archivo_no_existe
 end 
end

def menu_sub_opc3(nota_aprobar)
 limpiar_pantalla
 filename = 'registros.csv'
 if File.exist?(filename)
  file = File.open(filename)
  arreglo_principal = file.read.split("\n")
  file.close
  aux = []
  arreglo_principal.each { |elemento| aux << elemento.split(', ') }
  puts "Informe de Aprobados \n \n"
  aux.each do |elemento|
   aux2 = elemento[1..elemento.length].map {|e| e.to_i}
   suma = aux2.inject(0){|suma, x| suma + x}
   largo = elemento[1..elemento.length].length
   prom = suma.to_f / largo
   puts "\n #{elemento[0]} APROBADO con NOTA FINAL : #{prom} \n" if prom >= nota_aprobar
  end
 else
   archivo_no_existe
 end 
end

#INICIO
opc = 0
while opc != 4
 menu_principal
 opc = gets.chomp.to_i
 case opc
  when 1 
   menu_sub_opc1
  when 2
   menu_sub_opc2
   gets  
  when 3
   menu_sub_opc3(5.0)
   gets  
 else
   opc_invalida if opc !=4	
 end
end
#FIN

