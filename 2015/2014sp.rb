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
・ある構想準備のためターンカウント
*メモ-ゲットレディ以外の行動終了=1ターン
=end

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("ktch") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

#variable set
go = rand(4)
rand = nil
tarn = 0

loop do
  #----- ここから -----
  values = target.getReady
  if values[0] == 0
    break
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

#char
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