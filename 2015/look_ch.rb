# -*- coding: utf-8 -*-
=begin
仕様-
2014の
・敵にブロックfを置く  #char
・ブロックを避ける(方向ランダム) #block
・アイテムを取りに行く(ランダム) # item
・アイテム,キャラ斜め判断,(横優先,ランダム) #item,char slanting
・go初期ランダム
・ループを避ける=ランダム
・ターンカウント
・敵保存 #char save
・敵次ターンよける #char flee
・変数出力 #debug 形debug_var(name,var)
・look #look
・looksave
・look敵奥対策 #lookchar
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
    $output_file = File.open("../../CHaser2012Server/tmp/log/var_output.log","w")
  $output_file.write("#{$day} #{name} #{var} \n")
  print("#{name} #{var}\n")
  end

#variable set
char = Array.new(4, false)
ulook = Array.new(9)
llook = Array.new(9)
rlook = Array.new(9)
dlook = Array.new(9)
go = rand(4)
mode = 0
rand = nil
tarn = 0
ifct = 0
ct = 0

loop do
  #----- ここから -----
  values = target.getReady
  if values[0] == 0
    break
  end

#loop variable
  ifct = tarn
  ifct += 1

#look char
if ulook[0] == 1  #up
  go = 0
elsif ulook[1] == 1
  target.lookUp
  tarn += 1
elsif ulook[2] == 1
  go = 0
end

if llook[0] == 1  #left
  go = 1
elsif llook[3] == 1
  target.lookLeft
  tarn += 1
elsif llook[6] == 1
  go = 1
end

if rlook[2] == 1  #right
  go = 3
elsif rlook[5] == 1
  target.lookRight
  tarn += 1
elsif rlook[8] == 1
  go = 3
end

if dlook[6] == 1  #down
  go = 2
elsif dlook[7] == 1
  target.lookDown
  tarn += 1
elsif dlook[8] == 1
  go = 2
end

#char save
  if values[1] == 1
    char[0] = true
    tarn = ct
  else
    char[0] = false
  end
  if values[3] == 1
    char[1] = true
    tarn = ct
  else
    char[1] = false
  end
  if values[7] == 1
    char[2] = true
    tarn = ct
  else
    char[2] = false
  end
  if values[9] == 1
    char[3] = true
    tarn = ct
  else
    char[3] = false
  end

#char flee
  if ct == ifct
    if char[0] == false
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
    elsif char[1] == false
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
    elsif char[2] == false
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
    elsif char[3] == false
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

#block
if go == 0           #Uo
    if values[2] == 2
      rand = rand(2)
     if  rand(2) == 0
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
     if rand(2) == 0
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
     if rand(2) == 0
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
      if rand(2) == 0
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

#cher
  if values[2] == 1
    values = target.putUp
    tarn += 1
  elsif values[4] == 1
    values = target.putLeft
    tarn += 1
  elsif values[6] == 1
    values = target.putRight
    tarn += 1
  elsif values[8] == 1
    values = target.putDown
    tarn += 1
  end

#item
  if values[2] == 3
    go = 0
  elsif values[4] == 3
    go = 1
  elsif values[6] == 3
    go = 3
  elsif values[8] == 3
    go = 2
  end

if mode == 0

#look
 case go
  when 0
    target.lookUp
    ulook[0] = values[1]
    ulook[1] = values[2]
    ulook[2] = values[3]
    ulook[3] = values[4]
    ulook[4] = values[5]
    ulook[5] = values[6]
    ulook[6] = values[7]
    ulook[7] = values[8]
    ulook[8] = values[9]
    tarn += 1
    mode = 1
  when 1
    target.lookLeft
    llook[0] = values[1]
    llook[1] = values[2]
    llook[2] = values[3]
    llook[3] = values[4]
    llook[4] = values[5]
    llook[5] = values[6]
    llook[6] = values[7]
    llook[7] = values[8]
    llook[8] = values[9]
    tarn += 1
    mode = 1
  when 2
    target.lookDown
    dlook[0] = values[1]
    dlook[1] = values[2]
    dlook[2] = values[3]
    dlook[3] = values[4]
    dlook[4] = values[5]
    dlook[5] = values[6]
    dlook[6] = values[7]
    dlook[7] = values[8]
    dlook[8] = values[9]
    tarn += 1
    mode = 1
  when 3
    target.lookRight
    rlook[0] = values[1]
    rlook[1] = values[2]
    rlook[2] = values[3]
    rlook[3] = values[4]
    rlook[4] = values[5]
    rlook[5] = values[6]
    rlook[6] = values[7]
    rlook[7] = values[8]
    rlook[8] = values[9]
    tarn += 1
    mode = 1
end

elsif mode == 1
  #go
  case go
  when 0
    target.walkUp
    tarn += 1
    mode = 0
  when 1
    target.walkLeft
    tarn += 1
    mode = 0
  when 2
    target.walkDown
    tarn += 1
    mode = 0
  when 3
    target.walkRight
    tarn += 1
    mode = 0
  end
end

if values[0] == 0
 break
end


  #----- ここまで -----
end

target.close
