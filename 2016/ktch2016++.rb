# -*- coding: utf-8 -*-
=begin 機能 メソッド
壁よけ block
隣敵 charput
隣アイテム取り item
斜めアイテム itemSle
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
tarn = 0#target.の命令後+される
go = rand(4)#0:U,1:L,2:D,3:R
put = nil#0:U,1:L,2:D,3:R
$itarn = 0#trand

#method
def debug_var(name,var,tarn)#debug 変数出力
  day = Time.now
  tarn += 1
  dir = Dir.open("TEMP/")
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

def block(go,values)#ブロック判定
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
  return go
end

def trand(go,values)# 9ターンアイテムなかったらランダム
  if values.count(3) == 0
    $itarn += 1
  else
    $itarn = 0
  end
  
  if $itarn == 10
    $itarn = 1
  end
  
  if $itarn == 9 && (go == 0 || go == 2)#上or下
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
  elsif $itarn == 9 && (go == 1 || go == 3)#左or右
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

loop do # 無限ループ
  #----- ここから -----
  print(tarn+1,"ターン目\n")
  values = target.getReady
  if values[0] == 0             # 先頭が0になったら終了
    break
  end
  
#処理
  put = charput(values)#隣敵
  go = trand(go,values)#9ターンアイテムなかったらランダム
  go = itemSle(go,values)#斜めアイテム
  go = item(go,values) #隣アイテム
  go = block(go,values)#ブロックの判定

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
#walk
  case go
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
if values[0] == 0
 break
end
  #----- ここまで -----
end

target.close # ソケットを閉じる
