# -*- coding: utf-8 -*-
=begin 機能 メソッド
壁よけ block
隣敵 charput
隣アイテム取り item
斜めアイテム itemSle
斜め敵 charSle
一定ターン(9)アイテムなかったらランダム trand
デバッグ(変数出力) debug_var
=end

#req
require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows
require "date"
require "time"

# サーバに接続
target = CHaserConnect.new("ktch") # この名前を4文字までで変更する

#変数宣言
values = Array.new(10) # 書き換えない
ulook = Array.new(10)
llook = Array.new(10)
rlook = Array.new(10)
dlook = Array.new(10)
usearch = Array.new(10)
lsearch = Array.new(10)
rsearch = Array.new(10)
dsearch = Array.new(10)

tarn = 0#target.の命令後+される
go = rand(4)#0:U,1:L,2:D,3:R
put = nil#0:U,1:L,2:D,3:R
look = nil#0:U,1:L,2:D,3:R
search = nil#0:U,1:L,2:D,3:R
$itarn = 0#trand
$lib == 0

#method
def debug_var(name,var,tarn)#debug 変数出力
  day = Time.now
  tarn += 1
  dir = Dir.open("../TEMP/")
    io = File.open("TEMP/var_output.log","a")
      io.write("#{$day} #{name} #{var}#{tarn}ターン目 \n")
    io.close
  dir.close
  print("#{name} #{var}\n")
end

def charput(values) #隣敵put
  if values[2] == 1
    put = 0
  elsif values[4] == 1
    put = 1
  elsif values[6] == 1
    put = 3
  elsif values[8] == 1
    put = 2
  end
  return put
end

def item(go,values)  #item
  if values[2] == 3
    go = 0
  elsif values[4] == 3
    go = 1
  elsif values[6] == 3
    go = 3
  elsif values[8] == 3
    go = 2
  end
  return go
end

def itemSle(go,values)#values斜めアイテム
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
  return go
end

def charSle(go,values)#敵斜め
  if values[1] == 1
    rand = rand(2)
    if rand == 0
      go = 2
      if values[8] == 2
        go = 3 
        if values[6] == 2
          go = 100
        end
      end
    else
      go = 3
      if values[8] == 2
        go = 2
        if values[6] == 2
          go == 100
        end
      end
    end
  elsif values[3] == 1
    rand = rand(2)
    if rand == 0
      go = 2
      if values[8] == 2
        go = 1
        if values[4] == 2
          go = 100
        end
      end
    else
      go = 1
      if values[4] == 2
        go = 2
        if values[8] == 2
          go = 100
        end
      end
    end
    elsif values[7] == 1
      rand = rand(2)
      if rand == 0
        go = 0
        if values[2] == 2
          go = 3
          if values[6] == 2
            go = 100
          end
        end
      else
        go = 3 
        if values[6] == 2
          go = 0
          if values[2] == 2
            go = 100
          end
        end  
      end
    elsif values[9] == 1
      rand = rand(2)
      if rand == 0
        go = 0
        if values[2] == 2
          go = 1
          if values[4] == 2
            go = 100
          end
        end
      else
        go = 1
        if values[4] == 2
          go = 0
          if values[2] == 2
            go == 100
          end
        end
      end
    end
    return go
end

def trand(go,values)# 19ターンアイテムなかったらランダム
  if values.count(3) == 0
    $itarn += 1
  else
    $itarn = 0
  end
  
  if $itarn == 20
    $itarn = 1
  end
  
  if $itarn == 19 && (go == 0 || go == 2)#上or下
    rand = rand(2)
    if rand == 0
      go = 1
      if values[4] == 2
        go = 3
      end
    else
      go = 3
      if values[6] == 2
        go = 1
      end
    end
  elsif $itarn == 19 && (go == 1 || go == 3)#左or右
    rand = rand(2)
    if rand == 0
      go = 0
      if values[2] == 2
        go = 2
      end
    else
      go = 2
      if values[8] == 2
        go = 0
      end
    end
  end
  return go
end

def confinedMode(values)#自閉対策look判定
  if values[1] == 2 && values[2] == 3 && values[3] == 2
    look = 0
  elsif values[1] == 2 && values[4] == 3 && values[7] == 2
    look = 1
  elsif values[7] == 2 && values[8] == 3 && values[9] == 2
    look = 2
  elsif values[3] == 2 && values[6] == 3 && values[9] == 2
    look = 3
  end
  return look
end

def lookItem(ulook,llook,dlook,rlook,values,go)
 if $lib == 0 ||$lib == 1
   $lib += 1
   if ulook[7] == 2 && ulook[5] == 2 && ulook[8] == 3 && ulook[9] == 2
     rand = rand(2)
     if rand == 0
       go = 1
       if values[4] == 2
         go = 3
         if values[6] == 2
           go = 2
           if values[8] == 2
             go = 100
           end
         end
       end
     else
       go = 3
       if values[6] == 2
         go = 1
         if values[4] == 2
           go = 2
           if values[8] == 2
             go= 100
           end
         end
       end
     end
     elsif llook[3] == 2 && llook[6] == 3 && llook[9] == 2 && llook[5] == 2
       rand = rand(2)
       if rand == 0
         go = 0
         if values[2] == 2
           go = 2
           if values[8] == 2
             go = 3
             if values[6] == 2
               go = 100
             end
           end
         end
       else
         go = 2
         if values[8] == 2
           go = 0
           if values[2] == 2
             go = 3
             if values[6] == 2
               go = 100
             end
           end
         end
       end
     elsif dlook[1] == 2 && dlook[2] == 3 && dlook[3] == 2 && dlook[5] == 2
       rand = rand(2)
       if rand == 0
         go = 1
         if values[4] == 2
           go = 3
           if values[6] == 2
             go = 0
             if values[2] == 2
               go = 100
             end
           end
         end
       else
         go = 3
         if values[6] == 2
           go = 1
           if values[4] == 2
             go = 0
             if values[2] == 2
               go = 100
             end
           end
         end
       end
       elsif rlook[1] == 2 && rlook[4] == 3 && rlook[7] == 2 && rlook[5] == 2
         rand = rand(2)
         if rand == 0
           go = 0
           if values[2] == 2
             go = 2
             if values[8] == 2
               go = 1
               if values[4] == 2
                 go = 100
               end
             end
           end
         else
           go = 2
           if values[8] == 2
             go = 0
             if values[2] == 2
               go = 1
               if values[4] == 2
                 go = 100
               end
             end
           end
         end
   end
 elsif $lib == 2
   ulook == nil
   ulook == nil
   ulook == nil
   ulook == nil
 end
 return go
end

def block(go,values)#ブロック判定
  if go == 0           #Up
      if values[2] == 2
        rand = rand(2)
       if rand == 0
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
          if values[2] == 2
            go = 2
            if values[8] == 2
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
    
    #はまるので緊急で決め打ち
    if values[2] == 2&& values[4] == 2 && values[6] == 2
      go = 2
    elsif values[4] == 2&& values[2] == 2 && values[8] == 2
      go = 3
    elsif values[8] == 2 && values[4] == 2 &&values[6] == 2
      go = 0
    elsif values[4] == 2 && values[2] == 2 && values[8] == 2
      go = 1
    end
  return go
end

loop do # 無限ループ
  #----- ここから -----
  print(tarn+1,"ターン目\n")
  values = target.getReady
  if values[0] == 0             # 先頭が0になったら終了
    break
  end
  
  #初期化
  if go == 4
    go = swap
  end
  
#処理
  go = trand(go,values)#19ターンアイテムなかったらランダム
  go = itemSle(go,values)#斜めアイテム
  go = item(go,values) #隣アイテム
  put = charput(values)#隣敵
  lg = charSle(go,values)#敵斜めlg
  look = confinedMode(values)  #自閉対策
  lg = lookItem(ulook,llook,dlook,rlook,values,go)  #自閉対策
  
  #ダブり回避
  if put != nil
    swap = go
    go = 4
  elsif lg >= 100#lg
    swap = go
    look = lg
    go = 4
  elsif lg ==0||lg ==1||lg ==2||lg ==3
    go = lg
  elsif look != nil
    swap = go
    go = 4
  end
  
go = block(go,values)#ブロックの判定

#命令セット
  case go#walk
    when 0
      values = target.walkUp
      tarn += 1
    when 1
      values = target.walkLeft
      tarn += 1
    when 2
      values = target.walkDown
      tarn += 1
    when 3
      values = target.walkRight
      tarn += 1
  end
#put
  case put
    when 0
      values = target.putUp
      tarn += 1
    when 1
      values = target.putLeft
      tarn += 1
    when 2
      values = target.putDown
      tarn += 1
    when 3
      values = target.putRight
      tarn += 1
  end
#Look
  case look
    when 0
      ulook = target.lookUp
      tarn += 1
    when 1
      llook = target.lookLeft
      tarn += 1
    when 2
      dlook = target.lookDown
      tarn += 1
    when 3
      rlook = target.lookRight
      tarn += 1
  end
#search
  case search
    when 0
      usearch = target.searchUp
      tarn += 1
    when 1
      lsearch = target.searchLeft
      tarn += 1
    when 2
      dsearch = target.searchDown
      tarn += 1
    when 3
      rsearch = target.searchRight
      tarn += 1
  end
if values[0] == 0
 break
end
  #----- ここまで -----
end

target.close # ソケットを閉じる
