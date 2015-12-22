=begin
-*- coding: utf-8 -*-

仕様
2014の
・敵にブロックを置く  #char
・ブロックを避ける(方向ランダム) #block
・アイテムを取りに行く(ランダム) # item
・アイテム,キャラ斜め判断,(横優先,ランダム) #item,char slanting
・go初期ランダム
・ループを避ける=ランダム
・ターンカウント
・敵保存 #char save
・敵次ターンよける #char flee
=end

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("ktch") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

#variable set
go = rand(4)
rand = nil
char = Array.new(4, false)
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

#go
  case go
  when 0
    target.walkUp
    tarn += 1
  when 1
    target.walkLeft
    tarn += 1
  when 2
    target.walkDown
    tarn += 1
  when 3
    target.walkRight
    tarn += 1
  end

if values[0] == 0
 break
end


  #----- ここまで -----
end

target.close
