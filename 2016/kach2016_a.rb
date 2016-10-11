# -*- coding: utf-8 -*-
=begin
機能
・敵にブロックを置く  #char
・ブロックを避ける(方向ランダム) #block
・アイテムを取りに行く(ランダム) # item
・アイテム,キャラ斜め判断,(横優先,ランダム) #item,char slanting
・go初期ランダム
・ループを避ける(ランダムなだけ)
・ターンカウント
・変数出力 #debug 形debug_var(name,var)
・look #look
・look敵奥対策 #lookchar
・loolitem
・lookblock
・****スタート時周りにアイテムがあったらlそのままなかったらsearch#start item check****
=end

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows
require 'date'
require 'fileutils'

# サーバに接続
target = CHaserConnect.new("ktch") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

#debug
  def debug_var(name,var)
    $day = Time.now
    $output_file = File.open("../var_output.log","w")
    $output_file.write("#{$day} #{name} #{var} \n")
    print("#{name} #{var}\n")
  end
  
#variable set
ulook = Array.new(9)
llook = Array.new(9)
rlook = Array.new(9)
dlook = Array.new(9)
usearch = Array.new(9)
lsearch = Array.new(9)
rsearch = Array.new(9)
dsearch = Array.new(9)
go = rand(4)
mode = 0 #0:look,1:go,10:なし
rand = nil
tarn = 0
ifct = 0

loop do
  #----- ここから -----
  values = target.getReady
  if values[0] == 0
    break
  end

  if mode == 10
    mode = 0
  end

#loop variable
  ifct = tarn
  ifct += 1

#look block

 #look item
if ulook[0] == 3 || ulook[1] == 3 || ulook[2] == 3 || ulook[3] == 3 || ulook[4] == 3 || ulook[5] == 3
  go = 0
elsif llook[0] == 3 || llook[1] == 3 || llook[3] == 3 || llook[4] == 3 || llook[6] == 3 || llook[7] == 3
  go = 1
elsif dlook[3] == 3 || dlook[4] == 3 || dlook[5] == 3 || dlook[6] == 3 || dlook[7] == 3 || dlook[8] == 3
  go = 2
elsif rlook[1] == 3 || rlook[2] == 3 || rlook[4] == 3 || rlook[5] == 3 || rlook[7] == 3 || rlook[8] == 3
  go = 3
end

#look char
if ulook[0] == 1 ||ulook[1] == 1|| ulook[2] == 1 #up
  go = 0
elsif ulook[3] == 1 ||ulook[4] == 1|| ulook[5] == 1
  target.lookUp
  tarn += 1
  mode = 10
end

if llook[0] == 1 || llook[3] == 1|| llook[6] == 1#left
  go = 1
elsif llook[1] == 1 || llook[4] == 1 || llook[7] == 1
  target.lookLeft
  tarn += 1
  mode = 10
end

if rlook[2] == 1 || rlook[5] == 1 ||rlook[8] == 1  #right
  go = 3
elsif rlook[1] == 1 || rlook[4] == 1 || rlook[7] == 1
  target.lookRight
  tarn += 1
  mode = 10
end

if dlook[6] == 1 || dlook[7] == 1 || dlook[7] == 1  #down
  go = 2
elsif dlook[3] == 1 || dlook[4] == 1 || dlook[5] == 1
  target.lookDown
  tarn += 1
  mode = 10
end

#char slanting
if values[1] == 1
  rand = rand(2)
  if rand == 0
    go = 3
    if values[6] == 2
      go = 2
    end
  else
    go = 2
    if values[8] == 2
      go = 3
    end
  end
  elsif values[3] == 1
    rand = rand(2)
      if rand == 0
        go = 1
        if values[4] == 2
          go = 2
        end
      else
        go = 2
        if values[8] == 2
          go = 1
        end
      end
  elsif values[7] == 1
    rand = rand(2)
    if rand == 0
      go = 0
      if values[2] == 2
        go = 3
      end
    else
      go = 3
      if values[6] == 2
        go = 0
      end
    end
  elsif values[9] == 1
    rand = rand(2)
    if rand == 0
      go = 0
      if values[2] == 2
        go = 1
      end
    else
      go = 1
      if values[4] == 2
        go = 0
      end
    end
end

#item slanting
if values[1] == 3
    rand = rand(2)
    if rand == 0
      go = 0
      if values[2] == 2
        go = 1
      end
    else
      go = 1
      if values[4] == 2
        go = 0
      end
    end
  elsif values[3] == 3
    rand = rand(2)
    if rand == 0
      go = 0
      if values[2] == 2
        go = 3
      end
    else
      go = 3
      if values[6] == 2
        go = 0
      end
    end
  elsif values[7] == 3
    rand = rand(2)
    if rand == 0
      go = 1
      if values[4] == 2
        go = 2
      end
    else
      go = 2
      if values[8] == 2
        go = 1
      end
    end
  elsif values[9] == 3
    rand = rand(2)
    if rand == 0
      go = 3
      if values[6] == 2
        go = 2
      end
    else
      go = 2
      if values[8] == 2
        go = 3
      end
    end
end
  
if values[2] == 2 && values[4] == 2 && values[6] == 2
  go = 2
elsif values[4] == 2 && values[2] == 2 && values[8] == 2
  go = 3
elsif values[2] == 2 && values[6] == 2 && values [8] == 2
  go = 1
elsif values[8] == 2 && values[4] == 2 && values[6] == 2
  go = 0 
end

#block
if go == 0           #Up
    if values[2] == 2
      rand = rand(2)
     if  rand == 0
         go = 1
      if values[4] == 2
        go = 3
        if values[6] == 2
          go = 2
        end
      end
     else
       go = 3
       if values[6] == 2
         go = 1
          if values[4] == 2
           go = 2
          end
       end
     end
    end
end

  if go == 1             #Left
    if values[4] == 2
      rand = rand(2)
     if rand == 0
          go = 0
        if values[2] ==2
          go = 2
          if values[8] ==2
            go = 3
          end
        end
     else
       go = 2
        if values[8]
            go = 0
            if values[2] == 2
              go = 3
            end
        end
     end
    end
  end

  if go == 2               #down
    if values[8] == 2
    rand = rand(2)
     if rand == 0
       go = 1
       if values[4] == 2
          go = 3
          if values[6] == 2
              go = 0
          end
       end
     else
       go = 3
       if values[6] == 2
          go = 1
            if values[4] == 2
                go = 0
            end
       end
     end
    end
  end

  if go == 3               #right
    if values[6] == 2
    rand = rand(2)
      if rand == 0
          go = 0
          if values[2] ==2
            go = 2
            if values[8] ==2
              go = 1
            end
          end
      else
          go = 2
          if values[8]
              go = 0
              if values[2] == 2
                go = 1
              end
          end
      end
    end
  end

#item
  if values[2] == 3 && ulook.count(1) == 0
    go = 0
  elsif values[4] == 3 && llook.count(1) == 0
    go = 1
  elsif values[6] == 3 && dlook.count(1) == 0
    go = 3
  elsif values[8] == 3 && rlook.count(1) == 0
    go = 2
  end
  
#cher
  if values[2] == 1
    values = target.putUp
    tarn += 1
    mode = 10
  elsif values[4] == 1
    values = target.putLeft
    tarn += 1
    mode = 10
  elsif values[6] == 1
    values = target.putRight
    tarn += 1
    mode = 10
  elsif values[8] == 1
    values = target.putDown
    tarn += 1
    mode = 10
  end

  if mode == 0
  #look
    case go
      when 0
        target.lookUp
        i = 0
        l = 1
        for i in 0..8
          ulook[i] = values[l]
          l += 1
        end
        tarn += 1
        mode = 1
      when 1
        target.lookLeft
        i = 0
        l = 1
        for i in 0..8
          llook[i] = values[l]
          l += 1
        end
        tarn += 1
        mode = 1
      when 2
        target.lookDown
        i = 0
        l = 1
        for i in 0..8
          dlook[i] = values[l]
          l += 1
        end
        tarn += 1
        mode = 1
      when 3
        target.lookRight
        i = 0
        l = 1
        for i in 0..8
          rlook[i] = values[l]
          l += 1
        end
        tarn += 1
        mode = 1
    end
  elsif mode == 1
    #go
    case go
      when 0
        mode = 0
        if values.count(3) != 0
          mode = 1
        end
        target.walkUp
        tarn += 1
      when 1
        mode = 0
        if values.count(3) != 0
          mode = 1
        end
        target.walkLeft
        tarn += 1
      when 2
        mode = 0
        if values.count(3) != 0
          mode = 1
        end
        target.walkDown
        tarn += 1
      when 3
        mode = 0
        if values.count(3) != 0
          mode = 1
        end
        target.walkRight
        tarn += 1
    end
  end

if values[0] == 0
 break
end
  #----- ここまで -----
end

target.close
