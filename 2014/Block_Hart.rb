=begin
-*- coding: utf-8 -*-

仕様
・ブロックを避ける
・アイテムを取る
=end

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("テスト1") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない
dir = 0
loop do # 無限ループ
  #----- ここから -----

  values = target.getReady
  if values[0] == 0 # 先頭が0になったら終了
    break
  end
  
  #ブロックチェック
  if dir == 0
    if values[2] == 2
      dir = 1
      if values[4] == 2
        dir =3
      end
      if values[6] == 2
        dir =1
      end
    end
  end
  
  if dir == 1
    if values[4] == 2
      dir = 2
      if values[2] ==2
        dir = 2
      end
      if values[8] ==2
        dir = 0
      end
    end
  end
  
  if dir == 2
    if values[8] == 2
      dir = 3
      if values[4] == 2
        dir = 3
      end
    if values[6] ==2
      dir = 1
    end
    end
  end
  
  if dir == 3
    if values[6] == 2
      dir = 0
      if values[2] ==2
        dir =2
      end
      if values[8] ==2
        dir = 0
      end
    end
  end
  #ブロックチェックここまで
#アイテム行動
 if values[2]==3
   target.walkUp
 elsif values[4]==3
   target.walkLeft
 elsif values[8]==3
   target.walkDown
 elsif values[6] == 3
   target.walkRight
  #ブロック行動
 elsif dir == 0
    target.walkUp
  elsif dir == 1
    target.walkLeft
  elsif dir == 2
    target.walkDown
  elsif dir == 3
    target.walkRight
  end

  
if values[0] == 0
   break
 end
  #----- ここまで -----
end

target.close # ソケットを閉じる
