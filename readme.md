# 30日で作る自作OS
## 環境
- Ubuntu 18.04
- バイナリエディタ: gHex 
- エミュレータ:  virtual box or qemu
- アセンブラ: nasm
- エディタ: VSCode

- その他
OSの起動はディスクを使うのではなく、エミュレータを使うことにより実行した


## Day 1 PCの仕組みからアセンブラ入門
### 環境のセットアップ (バイナリエディタ, エミュレータ, アセンブラ、エディタ)
- バイナリエディタ gHex  
```code:
sudo apt install ghex
```
- エミュレータ qemu

- エミュレータ virtual box
https://qiita.com/nao18/items/e1b9b77f154e4d5239e5

- アセンブラ nasm

```
sudo apt-get install nasm build-essential
```

- vscode  
ASM Code Lensというエクステンションでアセンブリ言語のハイライトを表示できる

### バイナリデータでHello World

- ファイルの作製
```code:linux
touch helloos.img
```
- バイナリエディタで指定のコードを作製  

- エミュレータで実行
```
qemu-system-i386 helloos.img 
```

### アセンブリ言語でHello World
- ファイルの作製  
nasmを使う場合は拡張子は.asm  
```
touch helloos.asm
```
- VSCodeでアセンブラコードを作製
- nasmでバイナリコードに変換
```
nasm helloos.asm -o helloos.img
```
- エミュレータで実行
```
qemu-system-i386 helloos.img 
```


### 備考
#### 参考
- エミュレータでの起動 https://qiita.com/nao18/items/e1b9b77f154e4d5239e5
- 

#### 疑問
- Q. DB命令の文字コードってなに？  
A. ASCII
- Q. CPUのにはどのような種類がある?CPUごとにアセンブラは異なる?  
A. x86, x86-64,ARM等の種類があり、
- Q. なぜ0で埋めている?  
A. ディスクの容量の分に合わせている? ブートセクター(一番最初のセクタ)の最後の2バイトは55 AAである必要がある。
- Q. セクタとは?
A. まとめて読み書きする
