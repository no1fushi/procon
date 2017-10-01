# -*- coding: utf-8 -*-
require 'CHaserConnect.rb' # CHaserConnect.rb

# default-set
target = CHaserConnect.new("ktch") #name
values = Array.new(10)
random = Random.new # rand-generator

# arr-set
ulook = Array.new(10)
llook = Array.new(10)
dlook = Array.new(10)
rlook = Array.new(10)

# var-set
tar = nil # 0=put,1=walk,2=look
put = nil # 0=U,1=L,2=D,3=R
look = nil # 0=U,1=L,2=D,3=R
go = random.rand(0..3) # 0=U,1=L,2=D,3=R
tarn = 0

loop do # loop-start

#-----Non-rewritable-----
  values = target.getReady
  if values[0] == 0
    break
  end
#-----Non-rewritable-end-----
  
#var-init
  tar = nil
  look = go
  i = 0
  j = 1
  thr = 0 # 0=look,1=look-through,3=go-through

#tarn-rand
  if (tarn != 0) && (tarn % 50 == 0)
    print "\n50tarn\n\n"
    go = random.rand(0..3)
  end
  
# item-sle
  if values[1] == 3
    rand = random.rand(0..1)
    if rand == 0
      go = 0 # U
      tar = 1
      thr = 1
      if values[2] == 2
        go = 1 # L
        tar = 1
        thr = 1
      end
    else
      go = 1 # L
      tar = 1
      thr = 1
      if values[4] == 2
        go = 0 # U
        tar = 1
        thr = 1
      end
    end
    elsif values[3] == 3
      rand = random.rand(0..1)
      if rand == 0
        go = 0 # U
        tar = 1
        thr = 1
        if values[2] == 2
          go = 3 # R
          tar = 1
          thr = 1
        end
      else
        go = 3 # R
        tar = 1
        thr = 1
        if values[6] == 2
          go = 0 # U
          tar = 1
          thr = 1
        end
      end
    elsif values[7] == 3
      rand = random.rand(0..1)
      if rand == 0
        go = 1 # L
        tar = 1
        thr = 1
        if values[4] == 2
          go = 2 # D
          tar = 1
          thr = 1
        end
      else
        go = 2 # D
        tar = 1
        if values[8] == 2
          go = 1 # L
          tar = 1
          thr = 1
        end
      end
    elsif values[9] == 3
      rand = random.rand(0..1)
      if rand == 0
        go = 2 # D
        tar = 1
        thr = 1
        if values[8] == 2
          go = 3 # R
          tar = 1
          thr = 1
        end
      else
        go = 3 # R
        tar = 1
        thr = 1
        if values[6] == 2
          go = 2 # D
          tar = 1
          thr = 1
        end
      end
    end
  
# item
  if values[2] == 3
    go = 0
    tar = 1
    thr = 1
  elsif values[4] == 3
    go = 1
    tar = 1
    thr = 1
  elsif values[6] == 3
    go = 3
    tar = 1
    thr = 1
  elsif values[8] == 3
    go = 2
    tar = 1
    thr = 1
  end

#look-char
  if (go == 0) && (ulook[1] == 1 || ulook[2] == 1 || ulook[3] == 1)
    go = 0
    tar = 1
    thr = 1
  elsif (go == 0) && (ulook[4] == 1 || ulook[5] == 1 || ulook[6] == 1)
    look = 0
    tar = 2
    thr = 3
  elsif (go == 1) && (llook[1] == 1 || llook[2] == 1 || llook[3] == 1)
    go = 1
    tar = 1
    thr = 1
  elsif (go == 1) && (llook[4] == 1 || llook[5]== 1 || llook[6] == 1)
    look = 1
    tar = 2
    thr = 3
  elsif (go == 2) && (dlook[1] == 1 || dlook[2] == 1 || dlook[3] == 1)
    go = 2
    tar = 1
    thr = 1
  elsif (go == 2) && (dlook[4] == 1 || dlook[5] == 1 || dlook[6] == 1)
    look = 2
    tar = 2
    thr = 3
  elsif (go == 3) && (rlook[1] == 1 || rlook[2] == 1 || rlook[3] == 1)
    go = 3
    tar = 1
    thr = 1
  elsif (go == 3) && (rlook[4] == 1 || rlook[5] == 1 || rlook[6] == 1)
    look = 3
    tar = 2
    thr = 3
  end
  
# char-sle
  if values[1] == 1
    rand = random.rand(0..1)
    if rand == 0
      go = 3 # R
      tar = 1
      thr = 1
      if values[6] == 2
        go = 2 # D
        tar = 1
        thr = 1
        if values[8] == 2
          look = 0 # U
          tar = 2
          thr = 3
        end
      end
    else
      go = 2 # D
      tar = 1
      thr = 1
      if values[8] == 2
        go = 3 # R
        tar = 1
        thr = 1
        if values[6] == 2
          look = 0 # U
          tar = 2
          thr = 3
        end
      end
    end
    elsif values[3] == 1
      rand = random.rand(0..1)
      if rand == 0
        go = 1 # L
        tar = 1
        thr = 1
        if values[4] == 2
          go = 2 # D
          tar = 1
          thr = 1
          if values[8] == 2
            look = 0 # U
            tar = 2
            thr = 3
          end
        end
      else
        go = 2 # D
        tar = 1
        thr = 1
        if values[8] == 2
          go = 1 # L
          tar = 1
          thr = 1
          if values[4] == 2
            look = 0 # U
            tar = 2
            thr = 3
          end
        end
      end
    elsif values[7] == 1
      rand = random.rand(0..1)
      if rand == 0
        go = 3 # R
        tar = 1
        thr = 1
        if values[6] == 2
          go = 0 # U
          tar = 1
          thr = 1
          if values[2] == 2
            look = 2 # D
            tar = 2
            thr = 3
          end
        end
      else
        go = 0 # U
        tar = 1
        thr = 1
        if values[2] == 2
          go = 3 # R
          tar = 1
          thr = 1
          if values[6] == 2
            look = 2 # D
            tar = 2
            thr = 3
          end
        end
      end
    elsif values[9] == 1
      rand = random.rand(0..1)
      if rand == 0
        go = 1 # L
        tar = 1
        thr = 1
        if values[4] == 2
          go = 0 # U
          tar = 1
          thr = 1
          if values[2] == 2
            look = 2 # D
            tar = 2
            thr = 3
          end
        end
      else
        go = 0 # U
        tar = 1
        thr = 1
        if values[2] == 2
          go = 1 # L
          tar = 1
          thr = 1
          if values[4] == 2
            look = 2 # D
            tar = 2
            thr = 3
          end
        end
      end
  end
  
# block
  if (go == 0) && (thr != 3) # Up
    if values[2] == 2
      rand = random.rand(0..1)
      if rand == 0
        go = 1 # L            
        tar = 1
        if values[4] == 2
          go = 3 # R            
          tar = 1
          if values[6] == 2
            go = 2 # D            
            tar = 1
          end
        end
      else
        go = 3 # R            
        tar = 1
        if values[6] == 2
          go = 1 # L            
          tar = 1
          if values[4] == 2
            go = 2 # D            
            tar = 1
          end
        end
      end
    end
    tar = 1
  end

  if (go == 1) && (thr != 3) # Left
    if values[4] == 2
      rand = random.rand(0..1)
      if rand == 0
        go = 0 # U            
        tar = 1
        if values[2] == 2
          go = 2 # D            
          tar = 1
          if values[8] == 2
            go = 3 # R            
            tar = 1
          end
        end
      else
        go = 2 # D            
        tar = 1
        if values[8] == 2
          go = 0 # U
          tar = 1
          if values[2] == 2
            go = 3 # R
            tar = 1
          end
        end
      end
    end
    tar = 1
  end

  if (go == 2) && (thr != 3) # Down
    if values[8] == 2
      rand = random.rand(0..1)
      if rand == 0
        go = 1 # L
        tar = 1
        if values[4] == 2
          go = 3 # R
          tar = 1
          if values[6] == 2
            go = 0 # U
            tar = 1
          end
        end
      else
        go = 3 # R
        tar = 1
        if values[6] == 2
          go = 1 # L
          tar = 1
          if values[4] == 2
            go = 0 # U
            tar = 1
          end
        end
      end
    end
    tar = 1
  end

  if (go == 3) && (thr != 3) # Right
    if values[6] == 2
      rand = random.rand(0..1)
      if rand == 0
        go = 0 # U
        tar = 1
        if values[2] == 2
          go = 2 # D
          tar = 1
          if values[8] == 2
            go = 1 # L
            tar = 1
          end
        end
      else
        go = 2 # D
        tar = 1
        if values[8] == 2
          go = 0 # U
          tar = 1
          if values[2] == 2
            go = 1 # L
            tar = 1
          end
        end
      end
    end
    tar = 1
  end

#look
  if (tarn % 2 == 0) && (thr == 0)
    tar = 2
  else
    tar = 1
  end
  
# cher
  if values[2] == 1
    put = 0
    tar = 0
  elsif values[4] == 1
    put = 1
    tar = 0
  elsif values[6] == 1
    put = 2
    tar = 0
  elsif values[8] == 1
    put = 3
    tar = 0
  end
  
# target
  case tar
    when 0
      case put
        when 0
          values = target.putUp
          tarn += 1
        when 1
          values = target.putLeft
          tarn += 1
        when 2
          values =  target.putDown
          tarn += 1
        when 3
          values =  target.putRight
          tarn += 1
      end
    when 1
      case go
        when 0
          values = target.walkUp
          tarn += 1
        when 1
          values = target.walkLeft
          tarn += 1
        when 2
          values =  target.walkDown
          tarn += 1
        when 3
          values =  target.walkRight
          tarn += 1
      end
    when 2
      case look
      when 0
        values = target.lookUp
        for i in 1..9
          ulook[i] = values[j]
          j += 1
        end
        tarn += 1
      when 1
        values = target.lookLeft
        for i in 1..9
          llook[i] = values[j]
          j += 1
        end 
        tarn += 1
      when 2
        values =  target.lookDown
        for i in 1..9
          dlook[i] = values[j]
          j += 1
        end
        tarn += 1
      when 3
        values =  target.lookRight
        for i in 1..9
          rlook[i] = values[j]
          j += 1
        end
        tarn += 1
      end
  end

#-----Non-rewritable-----
  if values[0] == 0
    break
  end

end #loop end
target.close
#-----Non-rewritable-end-----
