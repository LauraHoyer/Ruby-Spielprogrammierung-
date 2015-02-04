class Schlangen_teil
 
 def initialize()
  @x = 0
  @y = 0
  @kopf = false  
 end
 
 def get_x
  return @x
 end

 def get_y
  return @y
 end

 def set_x(x)
  @x = x
 end

 def set_y(x)
  @y = x
 end

 def get_binichkopf()
  return @kopf
 end

 def set_binichkopf(x)
  @kopf = x
 end
end

class Futter

 def initialize()
  @x = 0
  @y = 0
 end

 def get_x
  return @x
 end

 def get_y
  return @y
 end

 def set_x(x)
  @x = x
 end

 def set_y(x)
  @y = x
 end

end

#Globale variablesn
$schlange = nil
$aktuelles_futter = nil
$game_over = false
$richtung = 0
$score = 0

#Constanten
FENSTER_HOEHE = 500
FENSTER_BREITE = 500
Spielfeld_max_x = 500
Spielfeld_max_y = 500
ZELLE_x = 32
ZELLE_y = 32

def Zeichne()
 if $game_over == false
  fill black
  rect(0, 0, Spielfeld_max_x, Spielfeld_max_y )
  $schlange.each{ |teil|
   if (teil.get_binichkopf == true)
    fill yellow 
   else
    fill red  
   end
   rect(teil.get_x * ZELLE_x, teil.get_y * ZELLE_y, ZELLE_x, ZELLE_y)
  }
  fill green
  x1 = $aktuelles_futter.get_x  * ZELLE_x
  x2 = $aktuelles_futter.get_y * ZELLE_y
  rect(x1, x2, ZELLE_x, ZELLE_y)
  
  score = $schlange.count - 1
  title("Score #{score}",
      top:    0,
      align:  "left",
      font:   "Trebuchet MS",
      stroke: white)
  
    else
  if confirm("Sie haben verloren. wollen sie erneut spielen?")
   StarteSpiel()
  else
   exit
  end   
 end
end

def StarteSpiel()
 $game_over = false
 $schlange = []
 kopf = Schlangen_teil.new
 kopf.set_x(5)
 kopf.set_y(5)
 kopf.set_binichkopf(true)
 $schlange.push(kopf)
 $aktuelles_futter = Futter.new
 $aktuelles_futter.set_x(rand(Spielfeld_max_x / ZELLE_x))
 $aktuelles_futter.set_y(rand(Spielfeld_max_y / ZELLE_y))
 $richtung = 0
end

Shoes.app :height => 500, :width => 500, :title => "Snake"  do

 StarteSpiel()
 
    keypress do |key|
  case key # 0 = runter, 1 = hoch, 2 = rechts, 3 = links
   when :up then $richtung = 1
   when :down then $richtung = 0
   when :right then $richtung = 2
   when :left then $richtung = 3
  end
    end

    animation = animate (10) do |animatei|

  i = $schlange.count - 1
  while i >= 0 do
   if $schlange[i].get_binichkopf == true #Kopf teil
    case $richtung
     when 1 then $schlange[i].set_y($schlange[i].get_y - 1)
     when 0 then $schlange[i].set_y($schlange[i].get_y + 1)
     when 2 then $schlange[i].set_x($schlange[i].get_x + 1)
     when 3 then $schlange[i].set_x($schlange[i].get_x - 1)
    end

    if $schlange[i].get_x < 0
     $game_over = true
    end

    if $schlange[i].get_x >= (Spielfeld_max_x / ZELLE_x)
     $game_over = true
    end

    if $schlange[i].get_y < 0
     $game_over = true
    end

    if $schlange[i].get_y >= (Spielfeld_max_y / ZELLE_y)
     $game_over = true
    end

    if $game_over == false
     $schlange.each {|teil|
      if teil.get_binichkopf == false then
       if teil.get_x == $schlange[i].get_x && teil.get_y == $schlange[i].get_y then
        $game_over = true
       end
      end
     }
     if $aktuelles_futter.get_x == $schlange[i].get_x then
      if $aktuelles_futter.get_y == $schlange[i].get_y then
       neuesTeil = Schlangen_teil.new
       neuesTeil.set_x($schlange[$schlange.count - 1].get_x)
       neuesTeil.set_y($schlange[$schlange.count - 1].get_y)
       neuesTeil.set_binichkopf(false)
       $schlange.push(neuesTeil)
       $aktuelles_futter = Futter.new
       $aktuelles_futter.set_x(rand(Spielfeld_max_x / ZELLE_x))
       $aktuelles_futter.set_y(rand(Spielfeld_max_y / ZELLE_y))
      end
     end
    end
   else 
    if (i != 0)
     $schlange[i].set_x($schlange[i - 1].get_x)
     $schlange[i].set_y($schlange[i - 1].get_y)
    end
   end
   i = i - 1
  end
  Zeichne()
 end
end
