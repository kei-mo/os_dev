#include "bootpack.h" // ヘッダファイルをinclde

void wait_KBC_sendready(void){
    //キーボード
    for(;;){
        if((io_in8(PORT_KEYSTA) & KEYSTA_SEND_NOTREADY) ==0) break;
    }
}

void init_keyboard(void){
    //キーボードコントローラ初期化
    wait_KBC_sendready();
    io_out8(PORT_KEYCMD,KEYCMD_WRITE_MODE);
    io_out8(PORT_KEYDAT, KBC_MODE);
}

void enable_mouse(void){
    //
    io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
    wait_KBC_sendready();
    io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
}

void HariMain(void){
    char *vram;                  // vramのアドレス、vramにはcharが入る binfoのvramと違う
    char str[32];                // 文字を格納する配列 
    char mcursor[16 * 16];       //カーソル変数を定義 charの配列
    char keybuf[KEYBUF_SIZE];    //バッファ変数 ch
    char mousebuf[MOUSEBUF_SIZE];
    int mx;
    int my;
    int i;
    int j;

    struct BOOTINFO *binfo = (struct BOOTINFO * ) ADR_BOOTINFO; //キャスト
    // ADR_BOOTINFO番地からstruct BOOTINFO分をbinfoとして扱う

    fifo8_init(&keyfifo, sizeof(keybuf), keybuf);      //なんだっけ?
    fifo8_init(&mousefifo, sizeof(mousebuf),mousebuf);

    init_gdtidt(); //GDT,IDT初期化
    init_pic();    //PIC初期化
    init_keyboard(); //キーボード(ハードウェア)初期化
    enable_mouse();  //マウス(ハードウェア)初期化

    io_sti(); //割り込み受付完了を開始　いつ割り込み禁止した?

    init_palette();  //パレットの初期化
    init_screen(binfo->vram, binfo->scrnx, binfo->scrny);

    init_mouse_cursor8(mcursor, COL8_008484); //カーソル配列（の番地）と色を与えてマウスの文字をメモリに書き込む
    mx = (binfo->scrnx - 16) /2 ; // マウスの位置x
    my = (binfo->scrny -28 -16) /2 ;
    putblock8_8(binfo->vram,binfo->scrnx,16,16,mx,my,mcursor,16);

    _sprintf(str,"(%d,%d)", mx, my); //メモリのstrに表示したい文字を書き込む
    putfonts8_asc(binfo->vram, binfo->scrnx,0,0,COL8_FFFFFF,str); //strに入っている文字を画面に表示する(vramに書き込む)

    putfonts8_asc(binfo->vram, binfo->scrnx,33,33, COL8_000000,"Haribote OS.");
    putfonts8_asc(binfo->vram, binfo->scrnx,32,32, COL8_FFFFFF,"Haribote OS.");

    io_out8(PIC0_IMR, 0xf9); //PIC1とキーボードを許可 なんだっけ?
    io_out8(PIC1_IMR, 0xef); //マウスを許可

    for(;;){
        io_cli();
        if(fifo8_status(&keyfifo)+fifo8_status(&mousefifo) ==0){
            io_stihlt();
        }
        else{
            if(fifo8_status(&keyfifo)!=0){
                i = fifo8_get(&keyfifo);

                io_sti();
                _sprintf(str, "%02X", i);

                boxfill8(binfo->vram, binfo->scrnx, COL8_000000,0,16,15,31);
                putfonts8_asc(binfo->vram, binfo->scrnx, 0,16,COL8_FFFFFF,str);

                _sprintf(str,  "keybuf(r,w) = (%d : %d)", keyfifo.q, keyfifo.p);
                boxfill8(binfo->vram, binfo->scrnx, COL8_008484,0,92,binfo->scrnx,107);
                putfonts8_asc(binfo->vram, binfo->scrnx,0,92, COL8_FFFFFF,str);
            }
            else if(fifo8_status(&mousefifo) !=0){
                i = fifo8_get(&mousefifo);
                io_sti();
                _sprintf(str, "%02X",i);

                boxfill8(binfo->vram, binfo->scrnx,COL8_008484,32,16,47,31);
                putfonts8_asc(binfo->vram,binfo->scrnx,32,16,COL8_FFFFFF,str);

                _sprintf(str,"mousebuf(r,w) = (%d : %d)",mousefifo.q, mousefifo.p);
                boxfill8(binfo->vram, binfo->scrnx, COL8_008484, 0, 109, binfo->scrnx, 125);
                putfonts8_asc(binfo->vram, binfo->scrnx, 0, 109, COL8_FFFFFF, str);
            }
        }
    }
}
