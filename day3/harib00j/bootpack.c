extern void _io_hlt(void);

void HariMain(void)
// > 「30日でできる!OS自作入門」 p66
// > おっと大事なことを忘れていました。関数名HariMainですが、これは非常に意味ある名前で、この名前の関数から
// > プログラムが始まるということになっています。だからこれを違う名前に変えることはできません。
{
fin:
  _io_hlt();
  goto fin;
}