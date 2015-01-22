class Schlangen_teil

  # -- get-Methoden --
  def get_x
    return @@x
  end

  def get_y
    return @@y
  end

  # -- set-Methoden --
  def set_x(x)
    @@x = x
  end

  def set_y(x)
    @@y = x
  end

  def get_binichkopf()
    return @@kopf
  end

  def set_binichkopf(x)
    @@kopf = x
  end
end

class Futter

  def set_x(x)
    @@x = x
  end

  def set_y(x)
    @@y = x
  end

  def get_x
    return @@x
  end

  def get_y
    return @@y
  end
end

$schlange = []
$aktuelles_futter = Futter.new
$richtung = 0  # 0 = runter, 1 = hoch, 2 = rechts, 3 = links
$game_over = false
$letztetaste = nil

FENSTER_HOEHE = 500
FENSTER_BREITE = 500

Spielfeld_max_x = 320
Spielfeld_max_y = 240

ZELLE_x = 16
ZELLE_y = 16

def Zeichne()
  if $game_over == false
    $schlange.each do |teil|
      fill black
      rect(teil.get_x * ZELLE_x, teil.get_y * ZELLE_y, ZELLE_x, ZELLE_y)
    end
    fill black
    x1 = $aktuelles_futter.get_x  * ZELLE_x
    x2 = $aktuelles_futter.get_y * ZELLE_y
    rect(x1, x2, ZELLE_x, ZELLE_y)
    fill black
    rect(0, 0, Spielfeld_max_x, Spielfeld_max_y )
  else
    alert "Sie haben Verloren. Drücken Sie Enter um erneut zu spielen"
  end
end

def StarteSpiel()
  $game_over = false
  $schlange = []
  kopf = Schlangen_teil.new
  kopf.set_x(5)
  kopf.set_y(5)
  kopf.set_binichkopf(true)
  $schlange.push kopf
  $letztetaste =:down
end

def GibMirRichtung()
  if $letztetaste ==:up
    $richtung = 1
  end
  if $letztetaste ==:down
    $richutng = 0
  end
  if $letztetaste ==:right
    $richtung = 2
  end
  if $letztetaste ==:left
    $richtung = 3
  end
end

Shoes.app :height => 600, :width => 800, :title => "Snake"  do

  StarteSpiel()

  keypress do |key|
    $letztetaste = key
  end

  animation = animate (250) do |i|
    if $game_over==true
      if $letztetaste ==:enter           # Wenn die Schlange game over ist, kann man mit enter das Spiel neu starten
        StarteSpiel()
      end
    else
      GibMirRichtung()
      $schlange.to_a.reverse.each{|i|
        if $schlange[i].get_binichkopf == true
          if $schlange[i].get_x == 0  # Schlange läuft gegen oberen Spielfeldrand
            $game_over = true
          end
          if $schlange[i].get_x >= (Spielfeld_max_x/ZELLE_x) # Schlange läuft gegen unteren Spielfeldrand
            $game_over = true
          end
          if $schlange[i].get_y == 0 #Schlange läuft gegen linken Spielfeldrand
            $game_over = true
          end
          if $schlange[i].get_y >= (Spielfeld_max_y/ZELLE_y) # Schlange läuft gegen rechten Spielfeldrand
            $game_over = true
          end
          if $game_over == false
            $schlange.each do |teil|
              if teil.get_binichkopf = false then
                if teil.get_x == schlange[i].get_x && teil.get_y == schlange[i].get_y then
                  $game_over = true
                end
              end
            end
            alert "1"
            if $aktuelles_futter.get_x == $schlange[i].get_x && $aktuelles_futter.get_y == $schlange[i].get_y then
              neuesSchlagenTeil = Schlangen_teil.new
              neuesSchlagenTeil.set_x($schlange.last.get_x)
              neuesSchlagenTeil.set_y($schlange.last.get_y)
              neuesSchlangenTeil.set_ichbinkopf(false)
              $schlange.push neuesSchlagenTeil

              $aktuelles_futter.set_x = rand(Spielfeld_max_x / ZELLE_x)
              $aktuelles_futter.set_y = rand(Spielfeld_max_y / ZELLE_y)
            end
          end

        else
          $schlange[i].set_x = $schlange[i-1].get_x
          $schlange[i].set_y = $schlange[i-1].get_y
        end
      }
      alert "ende"
    end

    Zeichne()
  end

end