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
・敵,アイテム保存 #char,item save
・敵次ターンよける #char flee
・一定ターンアイテムがなかったらlookで多い方(実装予定)
=end

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("hoge") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

#variable set
go = rand(4)
rand = nil
item = Array.new(7, false)
char = Array.new(4, false)
tarn = 0
ifct = 0
lokif = 0
lokend = 0
lokended = 0
lokmode = 0
lokupitem = 0
lokrigitem = 0
lokleftitem = 0
lokdownitem = 0
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

#item save
  if values[2] == 3
    item[1] = true
  else
    item[1] = false
  end
  if values[4] == 3
    item[3] = true
  else
    item[3] = false
  end
  if values[6] == 3
    item[4] = true
  else
    item[4] = false
  end
  if values[8] == 3
    item[6] = true
  else
    item[6] = false
  end
  if values[1] == 3
    item[0] = true
  else
  item[0] = false
  end
  if values[3] == 3
    item[2] = true
  else
    item[2] = false
  end
  if values[7] == 3
    item[5] = true
  else
    item[5] = false
  end
  if values[9] == 3
    item[7] = true
  else
    item[7] = false
  end
  
if item[0] ==false&& item[1] ==false&& item[2] ==false&& item[3] ==false&& item[4] ==false&& item[5] ==false&& item[6] ==false&& item[7] ==false && lokmode == 0
  lokif += 1
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
  
#look
if lokif == 3 && values[1] != 1&& values[2] != 1&& values[3] != 1&& values[4] != 1&& values[5] != 1&& values[6] != 1&& values[7] != 1&& values[8] != 1&& values[9] != 1 && tarn == lokended
  if lokmode == 0
    target.lookUp
    tarn +=1
    lokmode += 1
    #look item save UP
    if values[1] == 3
      lokupitem += 1
    elsif values[2] == 3
      lokupitem += 1
    elsif values[3] == 3
      lokupitem += 1
    elsif values[4] == 3
      lokupitem += 1
    elsif values[5] == 3
      lokupitem += 1
    elsif values[6] == 3
      lokupitem += 1
    elsif values[7] == 3
      lokupitem += 1
    elsif values[8] == 3
      lokupitem += 1
    elsif values [9] == 3
      lokupitem += 1
    end
  elsif lokmode == 1
    target.lookRight
    tant += 1
    lokmode += 1
    #look item save Right
    if values[1] == 3
      lokrigitem += 1
    elsif values[2] == 3
      lokrigitem += 1
    elsif values[3] == 3
      lokrigitem += 1
    elsif values[4] == 3
      lokrigitem += 1
    elsif values[5] == 3
      lokrigitem += 1
    elsif values[6] == 3
      lokrigitem += 1
    elsif values[7] == 3
      lokrigitem += 1
    elsif values[8] == 3
      lokrigitem += 1
    elsif values [9] == 3
      lokrigitem += 1
    end
  elsif lokmode == 2
    target.lookLeft
    tarn += 1
    lokmode += 1
 #look item save Left
    if values[1] == 3
      lokleftitem += 1
    elsif values[2] == 3
      lokleftitem += 1
    elsif values[3] == 3
      lokleftitem += 1
    elsif values[4] == 3
      lokleftitem += 1
    elsif values[5] == 3
      lokleftitem += 1
    elsif values[6] == 3
      lokleftitem += 1
    elsif values[7] == 3
      lokleftitem += 1
    elsif values[8] == 3
      lokleftitem += 1
    elsif values [9] == 3
      lokleftitem += 1
    end
  elsif lokmode == 3
    target.lookDown
    tarn += 1
    lokmode += 1
    lokif = 0
#look item save Down
    if values[1] == 3
      lokdownitem += 1
    elsif values[2] == 3
      lokdownitem += 1
    elsif values[3] == 3
      lokdownitem += 1
    elsif values[4] == 3
      lokdownitem += 1
    elsif values[5] == 3
      lokdownitem += 1
    elsif values[6] == 3
      lokdownitem += 1
    elsif values[7] == 3
      lokdownitem += 1
    elsif values[8] == 3
      lokdownitem += 1
    elsif values [9] == 3
      lokdownitem += 1
    end
  elsif lokmode == 4
    if lokupitem >= lokrigitem && lokupitem >= lokleftitem &&  lokupitem >= lokdownitem
      go = 0
    elsif  lokrigitem >= lokupitem &&  lokrigitem >= lokleftitem &&   lokrigitem >= lokdownitem
      go = 3
    elsif lokleftitem >= lokupitem &&  lokleftitem >=  lokrigitem &&    lokleftitem >= lokdownitem
      go = 1
    elsiflokdownitem >= lokupitem &&  lokdownitem >=  lokrigitem &&    lokdownitem >= lokleftitem
    go = 3
    end
    mode = 0
    lokupitem = 0
    lokrigitem = 0
    lokleftitem = 0
    lokdownitem = 0
    lokend = tarn
    lokended = lokend + 4
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