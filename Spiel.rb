# Programmfenster
FENSTER_HOEHE = 600
FENSTER_BREITE = 500

# Spielfeld
FELD_GROESSE = 500

# Größe einer Zelle
ZELLE = 20

#  Spielfeld anlegen
class Spielfeld

      #Anlegen des Rasters in Form eines 2D Arrays
      @spielfeld = Array.new (25) {Array.new(25,0)}

      # Füllen des Arrays mit Werten "M", steht für "Mauer"
      25.times do |i|
      @spielfeld[i][0]="M"
      @spielfeld[i][24]="M"
      @spielfeld[0][i]="M"
      @spielfeld[24][i]="M"
      end
end
      # Spielfeld grafisch darstellen
      def spielfeld_grafisch()
        fill gray
        rect(0,100,FENSTER_BREITE, FENSTER_HOEHE-100)
        fill ivory
        rect(20,120,FENSTER_BREITE-40,FENSTER_HOEHE-140)
      end

class Schlange
  # Die Schlange im Array
  def initialize
    @spielfeld[13][13]="S"
  end
end

def schlange_grafisch()
  fill black
  x = 12*ZELLE
  y = 12*ZELLE
  speed = 1
  schlange = rect(13*ZELLE,13*ZELLE,ZELLE,ZELLE)
  animation = animate (60) do |i|
    y += speed
    schlange.move(x, y)
  end
end


Shoes.app :height => FENSTER_HOEHE, :width => FENSTER_BREITE, :title => "Snake"  do
  background indianred


 puts spielfeld_grafisch()
 puts schlange_grafisch()


 end





