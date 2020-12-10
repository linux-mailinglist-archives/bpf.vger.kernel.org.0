Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5710A2D4F78
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 01:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLJAdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 19:33:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:36603 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgLJAdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 19:33:03 -0500
IronPort-SDR: BVW5As2ZV4YQV6actC/g2z8kKaI8RmDYIgiHdN507V0bYx5exqefeSlWIGfgymkCVo1XErE2ID
 XSTpeQ/wZtmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="153979677"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="gz'50?scan'50,208,50";a="153979677"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 16:32:21 -0800
IronPort-SDR: GA4pN0MLjoRySi8RtHJ0FG3LyfFEZy0NkXW+i/LgjbOUU/qAmAQq5nMwakKtCdZ+ndp7soU/6i
 G6LssLAuEG6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="gz'50?scan'50,208,50";a="540830292"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2020 16:32:18 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn9sY-0000XQ-4C; Thu, 10 Dec 2020 00:32:18 +0000
Date:   Thu, 10 Dec 2020 08:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Support
 BPF_FUNC_get_socket_cookie() for BPF_PROG_TYPE_SK_REUSEPORT.
Message-ID: <202012100835.jDunRMJB-lkp@intel.com>
References: <20201207132456.65472-12-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20201207132456.65472-12-kuniyu@amazon.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kuniyuki,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Kuniyuki-Iwashima/Socket-migration-for-SO_REUSEPORT/20201207-213556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: powerpc64-randconfig-r033-20201209 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1968804ac726e7674d5de22bc2204b45857da344)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d0917bd77c487a6c3d1580d4c6636f70cdefaa04
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kuniyuki-Iwashima/Socket-migration-for-SO_REUSEPORT/20201207-213556
        git checkout d0917bd77c487a6c3d1580d4c6636f70cdefaa04
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   __do_insb
   ^
   arch/powerpc/include/asm/io.h:541:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/core/filter.c:25:
   In file included from include/linux/sock_diag.h:5:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:132:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:542:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/core/filter.c:25:
   In file included from include/linux/sock_diag.h:5:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:134:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:543:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/core/filter.c:25:
   In file included from include/linux/sock_diag.h:5:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:136:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:544:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/core/filter.c:25:
   In file included from include/linux/sock_diag.h:5:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:138:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:545:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from net/core/filter.c:25:
   In file included from include/linux/sock_diag.h:5:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/powerpc/include/asm/io.h:604:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:140:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> net/core/filter.c:4639:36: warning: unused variable 'bpf_get_socket_pointer_cookie_proto' [-Wunused-const-variable]
   static const struct bpf_func_proto bpf_get_socket_pointer_cookie_proto = {
                                      ^
   13 warnings generated.

vim +/bpf_get_socket_pointer_cookie_proto +4639 net/core/filter.c

  4638	
> 4639	static const struct bpf_func_proto bpf_get_socket_pointer_cookie_proto = {
  4640		.func		= bpf_get_socket_pointer_cookie,
  4641		.gpl_only	= false,
  4642		.ret_type	= RET_INTEGER,
  4643		.arg1_type	= ARG_PTR_TO_SOCKET,
  4644	};
  4645	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICERm0V8AAy5jb25maWcAjFxRc9u4rn7fX6HZnblz7kO3jpO06b2TB1qibNaSqJKU7eRF
4zpq13eTOMd2dk///QVIySIpOt2dOT01AFEkCAIfAKq//fJbRF6Pu6f1cbtZPz7+iL43z81+
fWweom/bx+Z/o4RHBVcRTZj6HYSz7fPrf96/7P5u9i+b6Pr3i9Hvo3f7zYdo3uyfm8co3j1/
235/hRG2u+dffvsl5kXKpnUc1wsqJONFrehK3f66eVw/f4/+avYHkIsuxr/DONG/vm+P//P+
Pfz5tN3vd/v3j49/PdUv+93/NZtjdPHpw83N6Gq9+Tj+0Hz88PHq4fqhGY+/bsbj0dXXq+ub
648P68urq//+tXvrtH/t7agjZsmQBnJM1nFGiuntD0sQiFmW9CQtcXr8YjyC/6wxZkTWROb1
lCtuPeQyal6pslJBPisyVlCLxQupRBUrLmRPZeJLveRi3lMmFcsSxXJaKzLJaC25sF6gZoIS
WEyRcvgDRCQ+CpvzWzTVu/0YHZrj60u/XaxgqqbFoiYC9MBypm4vxyB+mlZeMniNolJF20P0
vDviCCfF8ZhknZJ+/TVErkllq0jPv5YkU5b8jCxoPaeioFk9vWdlLx4kJjQlVab03K1ROvKM
S1WQnN7++q/n3XPTG4m8kwtWxv1AJZdsVedfKlpZW7EkKp7VHbFXheBS1jnNubiriVIkntka
OclVkmZsElAWqeBk9a/RiyYCXqUZMDlQWtbzPareRLCH6PD69fDjcGye+k2c0oIKFmtzkTO+
7AfxOXVGFzQL83M2FUThTgbZ8czeA6QkPCescGmS5S4h5SKmSWuZzD51siRCUhSy1Wy/MqGT
appKV83N80O0++apwp+wPiGLgU47dgwWOgdNFMo6bHov8HwqFs/rieAkiYlUbz79pljOZV2V
CVG02z+1fQI/GNrC2X1dwlM8YbGtjYIjhyUZDdqaYadVlgXsTTPtwWZsOqsFlVo7IqzWwQxP
Z0VQmpcKRi2cY9HRFzyrCkXEXXCirVRglt3zMYfHOz3FZfVerQ9/RkeYTrSGqR2O6+MhWm82
u9fn4/b5e6+5BRPwdFnVJNZjGBs7vVlvpssOzCIwSF3AYVg4aw1JwW4HxpvIBFbGYwouA4Qt
6/A59eLS8t/gsKUi2ir7FQARjkJG7vQDQf1qmZXP7lQsmeXzJDt5yoRJDCKJfltrAP9A9ZZP
BF0wyTPtNuw3610UcRXJoakr2PEaePYa4WdNV3ACQvOXRth+3COh2vQY7dkLsAakKqEhuhIk
9hg4MOxKlmE4zG3/iJyCgnuTdBpPMqbdwEmV7vrdCDhhxdiaJpubvwwp2lhs8gz8KJze26c+
2uKgKfh3lqrbi482HTcoJyubP+5PHivUHGJxSv0xLs0Gys0fzcPrY7OPvjXr4+u+OWhyu7wA
1wM6MP7F+MYCOVPBq9IxboincehAGtFaxjNqobKUMFEHOXEKvpgUyZIlauZYlrIfCB6e9l0l
S+RbfJHk5C1+CoZ5T0VYpARYoOT5hSZ0wWLqqwqfa93HYLZUpG/NZlK+ydahNXTWOLrLVoYo
0s8IIRWEbHBcPa2CCFg4+wn4CijngJE4xwPde6zurVR5b4BtjOclB9vCWAZ4mYaWgZutoade
igU67iRYSkIh7MQQmJPznHoxtg46ul/LiWfokRcagQprDP2b5DCO5BXgHgudiqRDsb1pghsA
0jioEWBm92cMDnir+8Cq9TMW2Na/r7xX3kuVhCIW5xiEXScE55iXgBbYPUUgp42Oi5wUsQuN
PTEJfwm8QiNe8H0J5igxB/+LFlZTTDsKD3n+QzFEeCqD0BHTUumcE923tVFl2v8wAab/nUMM
ZGiV1nhTqnKMpQPoaMyjJ58Wn87A7ZzBZybBGMItxwNbsdl45CJn9gvCB3VCADsj8rO8YwUZ
t/cTTpalgJK7c5dsWpAsDdmDnnRq2bYGvDZBzsB526MRxoNaYLyuRBh3kWTBYB2tWi3PAkNP
iBDM3pw5itzlckipna06UbWO8Oi2QK43itBGIhkOfwaAPjBTtBONmmwVnFKGfro1Djsh8TyU
WVhi8q6AFAG8l3VcJf1iZ7mw8R4NHqdJYnstfabwWNandKa3vvhidDVAZW35pmz233b7p/Xz
ponoX80zQDwCcT1GkAcZQA/X/MHb6P8Ph7HAc25GMUh/kH90roTnJVGQVs1DXj0jE8d8s2oS
HEVmPJSB4/OwB2JKOwhsWTPyMIQjiqsFnGmeu++y+TMiEoCaYTwhZ1WaZrAtBF4E1sAhnnAR
PP88ZZmTFGv/paObo223enN6vow/XHU5U7nfbZrDYbeH5O3lZbc/mkzqJIkefn4p6w9XoZl0
fFrrEVvyKZUtLTjcy7q01BZCAY+f5wCWORyDWWgsZFt0kNUe19qg3ArjhdCQCmtV1kgJ52JC
21Pdam6ollPOl0h+acV4xMoTPGRFwogVYz5cTey6jTNPfbLznAA6LBDUAx4CuG1NKyTAituL
m7BAZ/7dQD2af0MOx7twHAJgTQMRTbYqqI3jMF/pWNqh1CkTYNPxrCrmZ+S0KYfFBJZq5O11
n1hA/AIcaMUdSJ7iuUmsZFWWbslSk2GINCNTOeRjrQVA2ZDR2eZsSdl0phybsjwmEdndMNCS
oi0S8QrSnZu+tKv16kR9LBkO6Rpf8pwp8AkAjGt9ZO1gpct3etf8OMAmVBgcg/hAMsjAPZF2
rVg9EnxiA260coiZXXCg07M8RmJ5Ow7zkrd4C+CNnFNFlta67nkB3jO3DKqcmlK0Li3K26vW
HT2ujxgZQt5IgjrDxb0OusgMMxHjRQLuag7BZFpRu+pGS1ICQCWCYJXGCYOwBp4agIvoHEAQ
K0KjoiB4GcCFK9hcY8FdOSpK982/X5vnzY/osFk/mgqUUweB2PAlWFILP90NzB4em+hhv/2r
2QPp9DokW00VrLMkmQu6W1o95Ys6IwALQiHGkcppUZ0dQtEwenOEZiRTCCIHqKLkSyrK+DT3
KNFLcgoG52VsVZmVWxRbQ/20vsCEShdw9o4Bsv7YCQK+MdpIaPeCHayDvZ+z+/piNAqqA1jj
61Eou7mvL0cjp96qRwnL3oKsVQUhaga+uBoW0k4ikBBh5Qd8aTUBjKnc7oNlwbpxAXIlK9B3
+jCUFvqwtn2MGVdlVk1/JiPgb24pdE5XNA5OVHMgVmShI4bwGiZPJq4tW+RzraZYAHCokyr3
mhC6LIdQoI9Ile2dCkggZVvXOgVdAPMY2tC0UVoLgZF7sNqsP8NKrR7F99I0o7HqtJSDROZL
6A4HCLQatWaeZXRKsi5s1AuSVfR29J/rh2b98LVpvo3Mf/bGXs11GPY8vo7Mfmmv7QO25KtT
SoF5tC+rGzS6SIiunQOuFVgAtJw1hjqZBzclT3Qbsy9z0BW42FoRwNiAYIHeu+E86B29Q6hP
4eT1EDqVGBWySRwcxn6k3/oCi+kQ6U0b0Y7/oDSepoCTQOmbkfvfKcqY5iOMId4SK2d3kkHW
dxL0BTAgVSRj913xwmnIrvebP7bHZoMV1HcPzQssCNKo0Pq5yRfOllY6vnNODYIIPPIZjhLE
jQl1KwKdwu4kGnh65jTq99E0ZTHDlK4qYHnTAktuMXY2vHOAxw3L3ooV9UQuSekdNAZpMCJb
mKvfIJ37CMhQBVVBBi/D9HaYGjBX6pWIND+tilgjMioEB0RbfKaxW2nSYqYyY1P0+vSIM8Aq
Q3SKeEJHT3MkAzUBOH+KpXddxdAbXuboWdpeur8qxH81ZKoGYLe6r0npT9ItIvglg8CqML3F
4KELxYrirQT9RGgQF4T2dF3uNRNzvXavN8cE+/SqnkI4hIdNPMCcO8jG5stPRIxzZPc+wF4S
MFpMW9AJgN4UWxCFKehgf8ymmyZJnJereOYHyyUlcwxgFItNJP5SMRF+nXbW2PHuLkwEhNq8
7h/J8iyx5EP6lTRGgTdYGKedtGXwyDlBPRT8HS/56AMwd+oYmg12jRn/vUcOd2x/IoEnyncb
EP51o//sOHB0ukhMY5bajUFgVRDatW8CP6fLhIHx6QqyOPAL+m4DGnPgBOvHdcHIsbRe2U7+
/1bxwKoLBJ62kv5zg9giXk1ACxYLSIDAS1oDxBlmdFixXMKptxhoX5JNZQXKK+xWm3lHyyad
n/RLeJdjmIXen1Ddt9MdBs9a8Taj7NEutqGscqEcJBzTmC/efV0fmofoTwMhXva7b9tH524A
Cg2C/+ndmtvGzNorBvu8IOh4cw5+6e4ncf6EkAFRYuHeDmG6ji1znOLIs197zobUAjq/jO1L
VcVbEl3ACWxd+7wU8emGl6u6ToCFCv4tE21EGKDgP9exdLvs5yPUq/vAIFh1XdY5k9Lc5Ghb
lzXLdWElVN8vwBOARd/lE+40Ilo/oa8dZBDjK6eHN0FLDWVixO2eEllc9L+qwtz/01ma3oqB
YznVgIgCvxLXIreudWkLMQ+D/vmysD2zWELOcY6pD9YZ3gmrnU8hf5JcWg+LZfjRAb1vjuSM
Lyd2HHd/nwQLnDoYX0bKEreXJIm2BL3FHbym/2k2r8f118dGX2+NdJfiaPU1JqxIc4XOe+Da
Qiz44XZrWiEZC1aqARlML3adoqAIg4J+5Nxc9ULy5mm3/xHl6+f19+bJTQ1OMfqNTLRPQnNS
QBoS4HhFX90XLeEUeVmvlc6usCRAQ6wF/IHRyM94BxI+AidS1VO7Va/3e05pqdtm7RGxL45Y
BYxQs6fMIP6USlu8rhBceTEqPlts0bhRUDyAXt+yf393WzJ0+DGooVXWyu8ezKWl7e4ellZY
DmcSn7m9Gn36YM0UgGURE0jCw9U594pAS70vOXd88v2kCjU17y9TniWOoA4zPA4IdymNKam3
OZv9LCwH0id0D/oms9EiXokIDKZzIi0wxI5tZWZwEW6K11poEc9yEmwP9qBCUYP4iNMKOn+S
evM/XUEsmuPfu/2fEMpDqTgYz5yGr+KBb18FJrdKSn25hrprssh1wkjY1iBShN8FdLwejiD9
jE7w/gzkxHifHWJhemcfdfMsGKtGaaDuvPQuT4KMwf3BtxOVh86dss7wRLBkSv3fdS7cIGqo
cZoH37PISFHfjMYXXwKvS2iMu/bk/q4Fr5x0Jcti58fYfj9E6mwefPVqfB269k7KSf/GcsaN
3fT7RSnF+V5fndu14W20bvqxFfGSQuIdJ4536eF9vb5A8wS9xSKsr9agwuYAuGOuTa1fQV7a
iAenh5R6KrlLLeSsf2gmLfV+EUr0LPwFeDXxKKoqeoqwcxCR6suwdthaOTmKuZCmjVkw7gTW
nmVsPKRVbRF4C1Le1e0dmE6VXwZ3QD4HHRYOkSKoNB9JuF4iOjaHY9cTar3NgOUxbM/SR8Jc
kEQv0HRV1ps/m2Mk1g/bHeYWx91m92gFfgL2aRsG/q4TkhO8rrA4c2ecKsHDB01w6Tyj50BW
v8MheG5X89D8td107RgbTZVfKJZcXDO9w0Yf1oHSJOQTLYFZsupto6UDYrCHuyPhCvKbEzxZ
EHFzVDg+gixDJW3gTGIrSCNhuuwnh78/X3y6/OSKMAlIBKRMlCBFlJiJJL6mUHiB03FGXKwG
pIQuXEJMshhTe7xpZ8dL5KUZHY4wFYbkLDvGP88sPI4/fhwNHkAirC8ENHp+mRGFdwPdGbCU
4f+niT9o/sYschmYtvxMzjTTNJenuvxj6R9ylGiLl5C+rTeNE7zxgRm7vLhYBU+BnkJcjq9/
zk+ToEUGXu9urG606xu/zi2fgNlYpynklVI2qUVbB2hJS4bFSDe1jtMpxqOLweE+MZ6b5uEQ
HXfR1wZmg6nIA6YhUU5iLdDbb0dBfIZoa6Z7R7rIanU0RTpnftXE8qSfQpl9TFjqbjtLhxeV
XTYMBoo8MxjkoxN7wCIN4dpSAvCBVOXJdvUstVBLtoTQ5dSQUsIy7kVl8H8KYHcXY892TdoY
0/n4gZ+w7u/FRCSDPdMFpe2mfSLiQ3RamcrZjGZl8FIAaEzlpX25qqNA8mg+wzmBOVIkJBt+
86NfkDKRL4kwzZ3hRNPt/unv9b6JHnfrB329odPeUpenbHx2IumkIMGPEazcWzcVu7dZ3cb+
Kd1tMAu2ZxoUgN0zVzTDd09Oj3QlpuAZ9xdnBWFde8Lr4eGk/6Ry7QUEW5zZo9ZJCLfIZ+jY
lmufrU1zPvxZEIoRfdW0FdZ9sDeSO110rxTXchZAo1MnZTe/a2Z/w9LSpN1+OtFyZkE/Q8T6
znBEYV+BRSAzI8LYQ2rbC7JSyAXp6ca3W3Adno9TZ9kgBCsi53yldArRJ/czhmDxbKe5G6Kv
G4F7wC6ZlcQKHtf+J4bTQnq/EPxgmvrkEHP8LifEkEykPafPjJFXTVYtK1Q1VRYahx/aNGQX
L8v1/rhFNUUv6/3BgSsoS8RHBGNavtcRMNr+v2GG34pXr7pnLSrsqb6Q9QYrgUCGOr0zRdbb
dxdnB9ANaH2FxL4bPRTDFiwvsjvbXIZr1yqp4K9RvsMPnMyVZrVfPx8e9dfuUbb+MVASx66K
sxB8J8MSEdbUiDT5qPkyjuTvAYS/Tx/Xhz+izR/blyGi1vpNma/yzxQy3HOnGAXw+pM5vf5m
ARbDe35cfylxbrvwEE4IpIj6S6r6wlWnxx2/yb1yufh+dhGgObn4iVoogDGrEOg5LSZPpG/W
SIegRYbUSrHMMzSSewTuEchEwgHWiuy+6Tu/c6Zau355wcyuJWoMpaXWG7yG7G0vR+CxQr1h
5UW6usEqIjrdpwBxcCHV5nX3UG7cayi2SEatfxPBZuD2mW/oxiE2T/296jjYDCIqfDvFlptS
SF5YeOJ4oc/UQF02pBZmr/pS3k/UbD5fbB6/vdvsno/r7TPAWRhqmL46a8GWTZoBpA1XfNHC
41k5vpyPrz+cWaaUanyd+UdPZoKEamVm8QM7hP/5NGzbKq7wlhEibV0jdrlU6C4hci/GNy22
3B7+fMef38WomnMJqV45j6eXVgIez8y/SFHn1vWxnqp0Lb37DvSnajalEkCSnscsKBLdtbdE
tCe8FbMUTFHf5jqZFrSc3a1ODjLzn8qMV+g1p8IvMjj+Ylmj7FkBgD4DAdOMimPQ1nfQj3Md
umv/BLinYhFqTQtnJRyM6L/M/4+jMs6jJ1PQDoYOLeaq9ov+d0H62NC+4ucD/+KvkYuBhRuy
7gBe6YI0/ksmZ0y+mjB3ZkCol5m+IyVn2JHw7FsLTOikLb6NRz4Pu0deN6JjTbOKTtjZPZvd
QUbgYb0OYyoL3bqeD0BNVTB15nYccMGNKOVcSwKi6ZwEWXM++ewQkruC5MyZQNfodGgOYOZ4
jwUw4AIRh93XMwwsJDs000W9c18MyLprTMV8RgW1E0Jz3QQ/uGiveumLSu6XGR3hySOAcIgG
iV3qlHQtlqz0v4oRbLAbIbK6ufn46YNtjx0L3GDwW6eWXXA9o66Su8hpJIeH06GbEL89bIZJ
BEmux9erOim5tXCLqHOlIAMTpr59UeX5nf9vorBYfrocy6vRRdCMIQ3KuKwEfvcjdFEp1Bwr
E/npZjQmmfu9tszGn0ajy1CLTrPGzpV2gEMSznWtgHd9Hb4h38lMZhcfP74toif1aRSqDc/y
+MPl9djSzP9zdiXdcevK+a9omSxuHudhkQWbZHfTIps0wVZT3vDo2cq5PpGHI/kmvv8+VQAH
DAXqnSw8dH1FoDAXgKoCc6NEURVxHEFpJ9CH/dl1mbqPwqV0u1ZAfzvYJxXHUu6MD9wjSDl8
8rCTmDN52eHpOeHUIpApGzyq021oKJ1rCCKaguePBrnJxiiJTfbUz0elv6/0cQwovWTGQaub
kvTclWw00ixL13ECeVukFVSEr3n+/fR2V31/+/X61zfu6/n259MrrPm/cG+EfHcvuIp9gRHy
9Sf+Vx5J/4+vzR5TV8yf+NnqTrfiTDDe6FtLvM/MUEnu6PPJMj9rnjCL0ikPfOVMrypWuxOW
s2rRf7ZesggIINpnyBVNfSAtUVkOO6EWXR/4AQ7tLyVOQfWRL0JGff/51y+rQNVFCVDGf0J/
lM0ABe14xAVFP1cWGN6o0YewAhemH/fa+iywBlT7akTMkBx34C8YgIY+xZ+/b9FsayfzD+0j
XqRoxSkflNuVhXjgrjBSvdkPZ8Un9+XjodUOaSkJd3AQkGGQImsJuI2z7DHJf89HPdMtg61g
oJdvaK/5meWgZUhGsxIRtUAMhlCph4syR1awOCHnE5UrTuKYzoNj6R6mHiASuLI2qrjtw951
PHcn4aEp66kZBwt8BQ25GvOqp/HD1XMd16eF4qCX0iDGT0NL2yq/JL6b2Ko9f0xyUGXdgLrq
MhlPrutY8nscBtaJEAPfbHlxFm2mtDOK1thJKuDZvZNYkaUOX9jJhFDvhc75ThrnrOnYuepL
uuxlOVj6DXpdZSPdtgIzDl4VljH3He7lR4DH64dqYFcaPLVtUVkyPsP6UXa2HgEaC3QrSkeS
uVjEHuPItSVyul7ImCxK4e6Ho+d6saXotXopq2K076jMwyeq6ZY4Fi3W5LWt4DInKEmum6hJ
Umw5C7HdyJI1DXPdgG4amCyOaJtadYHlY/6D/rhqxugK21pmmYuqSznKdyBKuvex69FZduVl
uaajWwMUveMQjs57kzf/f696zxv4rbrQYgx4Auv7sI3BAtKSipmUxG7FkMTjaJ+pbw3Mk6Ol
1nPXjxPf1h/5/6vBc/13OxDIzkf8ezMO8HmOMy7zqZXD0k0EGO6BsbU0Ap6qd4Xsm0m9pFFm
iKouLRb/Khv7l0YeG1zP996blYbmKF+AaVhnqUrYzB6zvPTVy0SFY0yi0FbXHYtCJx5tFfGp
HCLPo7a8Chf3o6Bz6NtzM6/21j5YfWTh+N6s/QnNY+VlYdYZK3nKELQk6ZoEOmB7AaVTzlTA
oDC5AZXdDHO1J886MV0Znx9A5bDs52fl2B8dKPIwkBbPizI/xnGU+rA8d4MayHRlSNI0nnF7
OmJ0T92tFzma8jZNlgS7AvPLhAOsq+T1usRTlBhkTJqlJOyhOvSZjuRdjs6qq3BGMe/H4UNq
1+exe3puohRPbayx86Clu/LeLPhwqwPHd7aP7fnMnGQZrmLnp1G7/Bg6ke9j/B1in5cfkzCm
Tjdm/NbMFU58CxgXZKfF+vvECbFg0MHfa9i+xVizePTV0oEvBK/QNdcxY2IhjYm1Z5IdL5dh
NtZ+MBotJsjzIZ8xNAVoO7YQXDBfeFFKGdnNva7JfEWFUcjq8eJcwP7Bi6AfidFGbNw5QxQu
DPZa5HzxmtBmydFUgbYicpJWDZxmK70AGypeF4eOjhQgd6GIJVvL1SvmEyCd33UNiqdTfMeg
qJETBY1qHwGF4XJ0cH56/cJNg6p/tHd43qK46vSyxkccpy8c0qkWEKYqcQJqtRVol/X3B8XI
UtDr6tAx+2d9JjmVCdJ8QDp2bIIvdXQ+PCMQIKHf0NYk8wd9zrl1cncQVE1ePrY1iTezNpue
dsqaUr1xWCjThYVhQtDrQL4Co1psDTROHaCJk6A/n16fPv96fpVuAzZVYHi0VHtWc+Oww1Ua
SDxAlWpOWHf8srUlb9S7Tj2/6ppqEnEopc7PqXh5rkVyFXQeAosbKCkTw4axwRK0kfOI80Zu
psF1NU0YOeS0IDBu3CmTeKD9oj1pZB4mqD0eNbEORpbUrcFtC92nk0RIy6pVLsY29JAFvrJ9
3iB0Ryc73saS50Ov+s5s2Fh157KnZg4okSIN/L5X/fEexO3Flmp2OfEIuKI0lHqZw59Osh6Q
KqCTkuZ8+BaGfkAk6LaUK2YcA23kKe/J2EgLC6wLQhOV1GoJqoByKWV9SEYv14dW0wUR5ulZ
8nyAEuNR5/hoJskG3//UeYEdUddUA1XOJmHarB/FkF6lW2hTq4ViXsy9jflDWm7mFuuvbOCh
y4RNqnm8Dzs181RfCS3uYRy1rC/w9l8l60ZEnMZDWz6oxOY6LqaCzV8vv77+fHn+DWJj5ty0
hJIApv6DmM8hybouLyelm83J2oJ4bbDI2/iuHvLAJ084Fg7Q0tMwcKXZRQF+U6l21QUGMtWd
Fo6+PKkpFqX0oZlZU495VxeK8dJeFcrfz+bK6gsqCIC6JK8evLbrU3vYrMox3XVVQ5PVrYm2
fsMD09/9Ew1aZzuqf/v24+3Xy993z9/++fzly/OXu3/MXH/8+P4HGlj9u9rGOXZvbEK9TjCy
MDcNV7VDDeReSmrRJFRyKVEaqmzKB0qnQcyUhXfB5cGYD5qVLm+lThstLcqsqstAhV6zSmTJ
vL/3R62hqmaQL5qRJjSsZTyVv2EC+P70gi3yD2hXaIynL08/+ayg2/VwMVbjCv55++tP0Yvm
b6XGVL87skrug9b+oRYao81ZCru0ncpfcxcHcXe88x03P0YLGr3x0bhd9bPf6NjFKfrhqnjR
yFOiJJ1PnTeI86VNCe0qe2R8wFYrXpnG12tx9wtbnObpDdsu//H91+uPF3wdwTC4w6+EIq2m
lI0V/xemSgyq9k3GYGgfsstJI14HVIXqR5Wcw0pxyUs18W1cGQW+TQXpRT6Dqp0+EkVfkgiX
seMeaMpxHQLzcFTyq5vYmeqaNskTydf2K37AWwzdeqGPCBDv2/web9ssRWK5m1Qscjy1DKCf
YpRwhdaMsgUWUkZ8AkSvQTGiLdl9erx8bLrp9FHRF3h7N4XSc6RlwbQcQGmuo8zfzf6gc5fT
Ohj8UbYIvObbtkO/Fz769GYZ6jLyRou9Diaoe5TKvUQ3VlMdPs7ybgB+KPqI2DKz6u7zOmTe
llWKk1++orGIEp4TkkA9hdwYqSHQO7bjQXYZOuQwlCqkzdmaLYFJ5jUPe3fPdXDJ8G2DTBu4
DZsHxZrV/BDfj1djle6GDgT58fm/daDkLnp33fkR3xpDIwmbOz/69L09P9/BOgELyxfu6QCr
DU/17T+U8KxGZqvss3Kzea7M3kIzMK3vumwfiM5q8qNOtETbU7/A/9FZKICY8w2RFlEy5see
R9DxTFW6ml/o6MnpMydRlX0DVQavjpoIhh1SAzGuyOiG5GXuyjA0x9GUnx+Omhm1eVm3q9bX
Q096e3q7+/n1++dfry+KnfviwGBh0ROu2/x8yU5ZTxQbdyKZKWLOgrh2QwuQSACOAOi4BoHb
8XYYDFcY+kpBxdujGDfGJ1X/cX6aTvOR03cWm7cUaoQ8urwdzmmbIo4Zj0xxKl5++M46Q8/B
Rr49/fwJajSXhfA64F/GwTjyVdaW4aosaDKKdd5eiOKWdfQDCUIpHvAfx6V27HJBN0VcLfGp
N1tkOte3QiPV7anKH6TRJerrkEQsHjUqy5osLDzoOu3hqqXDqtZgf2S58mBhtx5hyuubqMWm
mI76o41qaBiqtdbtEqc+//4Jsy3VilnRhWGSWNuwuHR6/d2mrtYrS3Qjh6J6eun5RpZvOVRR
ZjoODZs4nEX19Z/peMdDzU8cHroq9xLX0fVtrW7ECDgWZp0ZNebpRc366lN7yTTqoYid0EuM
ogLdTbzE3skPBZTTbW7W0TybI+kJi9sh20d1l8S+3hzzvKhXaZ+HQ5jQlgiiE+NFuLXGcz9M
0lGrjuUO0RCbA6l9SM+4p6f3sRmTSCvPfIGosepmGQsxTZUjdaL1V831nZEE86Eb0aFzlsHg
u6lr7aRiCLn6EMp9P0n00nQVa1lvVOPYowUeZSIg0to8hhcrXrNYaq8+nfryhO/A6J2Gh9nd
iDdJ7ps75VvAaPeP//06b9Y3jX8VG3jF7nQqmBck1PmIzOLeGiWfGZgndCJVdqrImZOQSpaW
vTz9j+wmAQnOBwDnUj3ZWREGO2qy8VcOLKFDjU2VIyGTFxB3BdZjAFCssq2nmkZkATxfqdkV
QP3tb4tAPr3vUnkoIzeVwyar7095n9tzp1YtmSN0RrpMsTygVMC11ELpBLZ2SUo33utkc2da
1Uu8KOIOT+p7Hxt53g1Q2rbEpGoxOsJfGcx6axb1kHtp+F4ezRD5cseQsS0DAtQ1HBOTL8xm
pr7kTu8YCVI5qxD8EkpIjQ5PjZaCkjdGJq0faapQvS3Y+aY8ntoVmcDNTV9W5BjkDOYdKZ/Z
JgMHLZ8wty4kAJ4WbbaGYTDsMB4lnPCcHfQRJ6JG2SyLsPzZxthKvnmOqwTiWhAcCRG1GMsM
8hhS6K6F7pl0dtAeyRRFAjKReZPBzk6gZmEOH714HBWlUoMsBuM617n4SFYJ17eI7xeZgQG2
yKZgOn1tNm4tRWUlECKrxcCK9z4lflrnJcl0vOKb89n1RI2PJXG0PI6dgBB0RjyqCjnmkbrL
Up7FCEsWbMG4AZ1D65ILz6y27fKg/urFO0LoisD64eBHITVEJAndIOQuIcbH61sCnClSneip
snJrwn2mzos8ytZuYYDeGLihtHwpQOrQgBfGZkdDIPZDql0ACiGXXVGRBxrvXZ40IaOcLSO6
OfgBWbvznoBq1aX38T4tVix+MWp0z1NbF8fKEgBhYeqH0PEp3XiRpB/SIAyJmp03cVQFFmma
WuJl9pdwiNBeUp/BZ1xbV/jP6UF5zoeT5tslcVgknH6ffsEm37wwW/1Ti9h3JQsBiR64inmY
glDq1MbQoIMSlSYCUq2pQGQDUloMgEiFUeZwZc8tCUhBu6WAIR5dC+DbgMAlHYgFtC8gcESa
jZgEvedazHmoTcLKAbohJTTL48hzCWDEOAMX/uhF39akYKwrbY+CLizD2NEOMAtHDn/hO+c5
7Qa1sBUson2z0VHa26vZ2ShWuNCZn9sOPhaGYxz6ccio8p8Yeck6o4tZN2ZsdP9THbqJHBxb
AjyHBECzykgpoP12xJgNAi5U4c/VOXJ9av5dOKpDk5UNlS0gXUkvASsLHpDiXLSTwYdc1RwW
Osx+vet5+70eo3FlpNqycqzn+kaFinUhNNtGALEVUO9OdFAzF1Ngy3Io8cDivdeXkcNziVmT
A55nAYKQqmIOkeq6yuFSH3NPtN0ZDTkiJyKE5YibmnXIgSihv0iJFuFnY3gBZkF8h2oLDDWg
zRk0j0+pWgpHQGcdRSE5WXEojd/LGSRP99qlyTtfrKrG10MehZTPwvppH8ME41OrVz6ORLdu
IoIZjRrILtXElKYkwdR4a6iFGagJnUXyzihqkn0ZkpAcoE2y3y51s9smAJOrN9D3xUlDzw+o
8gMQEAuzAIh6vAy5OGesmGL1teL5AJtvYo64dHkTU43Pr0dSSYauOchvT658jWYLKqtdXkSZ
LSocMTFJHGBT2slhaaWFZ8qPx47MsLqw7tpPVcc6+rpzZez90NvVG4AjcSKiZaq+Y2HgEEpt
xeoogVWf7gce7HP3qoIvEXFiWT38xA3fmzdwvt0d/Hx+dYhOBYjniOmSREL6G5ioEqInIhIE
lFaNO/oooWb4DspOJNWNJawVhFyw/wucgFryAAn9KCZ3Cte8SB3LW7cyj/cOz1h0pUsetS4c
n2oQm5AbXcOOqm/5ArHz4O6pooDTkz4A/u9deYEj31/wStBX6TsgicODbZZZJAAiPBM0m4I1
LA/ixk2JZmLDwLBfGcmxpoH1k55OctdLiuSdLSeLEy8x0+VATG11QP7EI9Wc6pJ5Tro/kwAL
6fkqMfgetcUa8pjYbQ/nJg9JvWVoOtgB7+TEGYjlmtOJQQd0ch5DOrVpB3ro+lQ93RI/jn3S
kFTiSNzCFAKB1C3M3Djg2b6wipHuDSFgqGHKkoPwqlDErU7NhPmhO5EwX3Az5VWNmbQTGX3h
4M/PstlbUcPKpuxP5SV/XC88pqKss8epYXLk+YXd2GcZHKpbhgZi4EnxHnVfdYQ0S4g8fBWd
DWU33SpWUoWWGY+4r+cRrXcFkz8Rz6h2tLvT8oGatimsLiQBo3Ux/4uGNzFUQ6sHfPZ+4dwt
FPm8ucYzmxpvd/HSfdBeHosnGdXP2QH6C2OV+hoZOyg/JlZU7bnl10Qr79bnJQZ65gOGOcC6
xZ/lkDcZIQeSpQsEZOJSsFY5m+EAM0LTyuiSfZPlU95c1Cxk4Yx0DfvYzc/nv/76/pkHvLY9
+9Ici8Vcf00UaVk+JGkQ0t7enIH5MblZXkDFhrPhfWCxFlITygYviR0j8JDKxKMf8DdSLE/f
bFznOi+oUyzkgPoKU2eUbhM4dTEx2lqSJ7fcSxk09bwE6bpJ5Uaz8aoWqbwdVvNLpVSc7FNL
wIom9EeWw5kNp910eWvhKaJPmrkuqGpzhYnO55Ka6b/JoLi3rXSjDEiNaBFXmNLuZlC5a0Ta
KRtKNLHmx5xaU+WuP47KHaRE3inRwmE2Mr/X0hM8VxGoIbwOyXKBTjt1Gaty+tIMYcipq6k3
sjD96iOLvFGvyPuysX8iwpI4an0IYqiLz8kReSMrOrZ5dTjT4ziynHxuDJZoIBtDQgbtXmFV
gVrpSUBX5syQpA59SrLi5BNyK5rG+qhHYqIRh8iPHJOWxkaXKy9Hzz00dP8oP3HvR/JZXRzV
3LxBq4S+HK4W/vWmepuplwAiyhn/SlUtbXjq/C5RowmDSY14nzharcz3grrArMxtYeg4XAVx
NBpuzxyqvWRndLAmdFwjNyTabc05y/1jAh2b2qdkhzF0HGMJzQ6+65hrmpwmD560eAMNzdfP
rz+eX54//3r98f3r57c7YVNaLZEzqQiWnMViyyGwxTtusXH817NRRNUsmJCmxA7TLqIQrzs/
3Rl3aL5AmlrPadfNVW/bLqubjD4Bw4tz17Hc3otgUi49tyyRpqyCCoaENnTYGMhz1BX23Nio
vdUAWU1NAGFkm3Iou+GVnkS2mXmxKtbEMGyJZeq8TJvZIGZfEYEFlhNfOhxY4hipbqGcd0ay
a6HqtQBETvCOUnirXS/29wZZ3fihPjkZ9ticqJlP84/NizauAa7m7aruKciW4ShzKD6Wqy7m
BSrx1oSuY2hYSLV0ZQHjemTJn4OJnksS6Gv/bB9O0EzFbaZrXrgLEjo71bFanMsLAg/Lhh4B
uoq+ILMPAfmNZ64kA2patl3K4qilyp0XqR/QE0LPrZu7/V7J372ZGteZjEVcDh9g25lJuZUn
3HC3tM1jb66RmxhlUWVTXubLI/Q7XASHeKTu9ennn7hCGP6ThexHBD8wtmY1FYeKojKlYyC9
6GC4j0uYCqJpOBO39Gm0jASVlfWR+78q2H3DtufjNPrxQELzC23d1OCLKG3X1u3pEapdeVcP
+I4HDPezHn9QIL7DwB+w+k9Y9tXyCoa6zO7Fs+JW63hkxiAhE7RLsT6WZ2UFuaGFLfV3KpuJ
n0VYasSGPayu8Dhwn79//vHl+fXux+vdn88vP5/FEz1vSleYY47EjqOEtF8QVtUueYGzMKDn
+QC7tTQZqe9XWN8cSL5LNjHF67d9Q0V34hXRwhDIyGTlr9SPHk47zfcAdWspa59nPTrjn4tG
GygcqR8Krdd1mXiwcnkH6OfL09933dP35xejIJwV1pdm9xEniZNd2fTJcaDXN2EXTpfBD8NU
Wv421kNbwqYV9zRenBaEhJxjeHAd93Ztpksd6eNdcGH5rNUmWFiFj2m9w1TWVZFN94UfDi5p
wrixHstqrC7TPYg2VY13yNTlVGF8xMPT46MTO15QVF6U+Q75uPf6TVVXQ3kP/6S+5+kdV2Op
0iRx6f2cxH25tDXGoXHi9FNOxppaeT8UoCYOIGxTOmpU5I3nvrqciop1eL5+XzhpXMiRbaWG
KbMCxayHe0jr7LtBdKOaWeKDLM8FLLcplR7LGnaFyqyLVNhWU50B4IPjhx/Jqx+V7xSEsU9l
dIHl7VInTpCca9clOf6Psmtpbhv58V9F9T/NHGaH78dhDxRJSYxJkSYpWc5F5XGUxDW2lbXl
qsl++gW6+Wg0QWX2kJT1A/rBfqLRaKDcR1hlMbxNtpUUltAwZ8ZuEW3bDB0BRSvD9e9S1p5p
ZC/zrEgPxzxO8M/tDgZhyZVd1lmD9tSbY9miBiaMuHYvmwT/wSBuLTfwj66t3vSMfPB/1JTo
9m2/P5jGyrCdrWHwH1RHTbVM6/oevUaMzmyvflUd3ScZzPC68HxTNaBgWQJLlSoVlnK7LI/1
EsZuYrMc/fhpvMT0kl+wpPYmsn7B4tmfjIPBDiHCVbADRGPRbeHmGUHyudqeCn8QRHAEKhrH
tdKVwQ5llTuKZqZVk2Y35dGx7/Yrk7tJUThB+KqO+S2MqtpsDjNlSqbGcOzWzNMZpqyFPoXZ
0bS+T5Urc0zXV23CG4R7ttBye3+M4oNjOdFNxfZ/xwEH6eim4GvVViWIFoYVtDAJr09pwVrR
UA0Ktd7l990m6h/vbg/riGPbZw1Ij+UB50dohSFXb1grqhT6+VBVhuvGlm+pb1Q1KUBNvqyz
ZJ2y+3NPIYLEqPFZvj19+TYVjuJk2+iDmDJsoJ/wqIPCn82reoSc2m1CcR9i94rwC+ssrB95
G3rs1ZJgAkHiiD6DY+24gTGYNlmFVhhJdUCd/Do9LgPX2NvHlbalbe/y8XxCugrlzard2o43
WXrqKEmPVRN4qnGmRnK0VCD+wr8s0Cy9JSkLDYs/aPZ0y54TnaWwxHZ7u8GIvu0m9mxoLNOw
HL1oDEeULSOpCuFtrRk2RyuGUn3aJho1uJbWd/X1rIV9aVU57Cv4jt5sPRd6L5icOjBtlZhW
Y7CWR8gCWyW6tDjAHwfPdibFq3Q/YC1hCFtScUeXKNn77uw4FvOr2CRV4Dqa5D2eEuhEkrB+
6pusDtOpTfNJ2220z/azAy+q42rN3RiIaXbQjikArJSrePTrhfDmENiur5jA9AQUhy3L5Qm2
Q+OfKCRnRgfb8xQZrOT2LRfNsWep0yoiJ96eAFuNq2r/FNy33Zr2jh7sTTTpQfgkXpV1F5ab
E+Rq9B0lNAjH211W32hc6ApncH0rVuPV28PLafHXx9ev6IROj1e4WvbRu8d8ANuWbba6VyHl
706nIDQMJFUM/1ZZnmPA7gkhLqt7SBVNCHAuXKfLPKNJmvuGzwsJbF5I4POCFk2z9faYbpOM
PvgA4rJsNx2F6XVkyNZ8SiimhdXzWlrxFaVqOLRCB8YrEJvT5KjeggFeRDE+tKbMiHRKlkYr
H0/o+K2t5p952u3fexePE8sNyIaGNAVgv45MfpoAcbdPG+5ciRlV6Ie/1j6gMRN5K05AcYf2
oiBovbw+tI5LjxtA4R4jKpXN6nYX5bTNUpT+yoKOafQ0ZGn16DD0M8Uy67cXQKlq9D2dwTzl
fSrh183rIJAK5zBbvy3uVl92sor+XD48/v389O37BUP0xsk0lN9QBB4Z4zxqms5TNmcqFMU3
uXA3rzKODTDSb9rEcm2O0t2KkNejPa2647VbI8fs8++R5VYEispTZfkfibr7mZEycSdESEHg
zZN8ljS93iaN4NlGNEsKWQrs1i5b9wpXburiayRefdjbM+meNpVS99Aq/oy/zZFtmXimcb0M
2NoP8XbLfYDsrWE4/2LQ9un3WZKW2kLXkXQRBkQlPirn5KZBueEud0ww7k2WTG8lAFRbD36O
rhXaGs5ULf8mGhjr6I4l7bCgaXNi1r0Huc4JZPPj9Pj08CxqNlmokT9yUNGjVzCK6x0bOhdp
FSxEY0cJaAcbZz75yjS/ybhNDInxBtU8NBs4JcEvHSx30lUgyRv2tSjPeUetIpW4Q5or+74S
wa5JOdDY63KLmi9Vquqxo+oDBdlTvL1Z0SzSPIX1Ra9q+nku6Izsr2KZ1bO9uaoLWsY6B3Gt
3GmVB6k5ypOMglDsJCSTwO/5fQRpd1HelpwRjywlvROaPD3H9X09Z3+L5AzdCdK6Za0GfIpI
KCGE2rtsu6GvN+RnbdEHJh+fCBnyuPe+oYLqmi+BbbkvNQwOTd10YFD8USk+WgacBpRAuN4V
yxyE+sQCIlNN5FmHjsEkvdukad7wyeTIX2exiPxKa1lAz9VqgAMJ3gvTXoqCnCgGtsabxXXZ
lKtWg1GXUtO4YALf5W0mxtdMRbetNh7hICLCTikQbE5ofA1jWukdBZxMuypto/x+e9CygXUD
9gIWlOcMUvWeMuwxM1/Q89GoxYKSR1uhDYwbvV2qGi+lZnJsomzSBp0GVc9HvPefedMg6G0a
aWsDQDB0YPlPteUB8q9yfc2oC61/1qhqj5pMmYYDpA1UkWkR1e2n8h5znl1P2mzPRjdBEpxh
Un1WoopoPVlC2w0Gq5Du4maL2uF2eawaTosrlrYsK0p92Tlk26LUi/uc1qX+VSr5PoH9UZ8+
8vXKcbNbsngMHwCyp/yl7Z55976yN4Zj9uwx8gInYoiIDhkRkya8Q0AiBezT7xo4aW3ijB4/
1Q5HDsYgo6MWhaLzrO7qJr2FDbJQ7TQlKE8ximlNER87iwn5NKCI/2ySP/FFxGJzfr/wzu5H
Q5EivuKDG6lNAp/F13g4BBJDG0wz4yAeaTvIMPPqMmfN6oAhvoUC6Qdumlu9iKLlpnUBQgXG
6ybcHTb3lkJ4l20uT49/M08o+rS7bROtUnTttisGhbuadL6tu6y26Z22DOIvedTjsKPcdjiK
2DhgYS2Jb0zBsBQRY7cgm2FooRgjEqVTKRtYp98q0kdRa1ohuYSS+NY2LDfk34xIjsb2tEcl
hIxPLm3tc5Zx4dnq48cRdXW0t38mWG0YpkPiAws8zU10G0CCQQuCOB4bk1YTMHfuHal61fEg
qbpTGMBQ9QQ8oIapo53TQQpK58B6th2qWWgLEg2pIotD81yHAd1JdSvXOExqCwf1A5pgF8Rx
00BTn4aO4KR5APSsCRhoRto9HLCOPcaPd/VadijXJEjy1FgvAu2tGduopY//BXVW8dFRY9Ny
GoM+xZGF3XGhVOQwTiziv0B+a2u7od7rE+WIHCDTMMoCb+MI7Zrnim3z2A1N+t5F5nfNZVvP
MWNjOswD9x+t7qiK8kL9M7PGNle5bYaHSYt1JO0RsrYsLb6e3xZ/PT+9/v2b+fsCts5FvV4K
OqT5QBe+3B6/+G0UgH4nyjfRHygK8howQZem8HMfX+QHEl1KgPjwUvtyEfrlvk0n3y0t37t5
daUW68I2HYNtm/bt6ds3bQOXecOqv05rTtyK4jjFh41osXTfb1zQdg9/f/zAqB7v5+fT4v3H
6fT4XY1EMMPR55rClDhGII5hKMK43ikXEYLUCToUVUek4JLXLVe8/QuuuZg/ggi7QqjeONVt
fCTBCxDQ9liENnFbQrks2Cte//N2eTT+ozIAsQUpj6bqwPlUmttVhLZ7JTIRAIun/mKPdC6y
Ztt2daWJBpaqLnk7tIGDN8kVNaz3RIhE0RdrNZEReuYu3jVtdyREy6X7OW1s+rmSkpafQy7F
IaAeQgfKxD/whCVppkp7hoWNi6wweL7FVWBzXwSuxy+YPQ/6SApn3G8oPGief6UOk9dmPUF7
WTXAjRvbfKWzJjct41phkkO1dNAoHpfvASjcpXtPF953VIGGEAxvjmJ7NlecoP2i7QXPjPP+
oWUds51xwdSzdE8Prnzb8ta2bqb1n/jgHwj9kxzmw/o3NFerxIQlYDiIV7Ke0ICwGhrRlLCC
jYXKvkNeMANZewyFwQ3MaZaYUPWK2eNpAacFny1qDxQ+IoTKYl+f9vU+CFhbs6ERElgWgkGF
D8fRq8sZDpKQGaACd7jvEAvPv1ibrs0YZHDYwS8onBymMoTMwBOrkekxPRX6BtuBjuxYZkx4
c6+RyCLk/GJZg8XRmtYTZq5lcotFEVd+qI0oYXCzTbqXSEOPYmCtX25USQOHLKYCEte909Lq
ccsxDt8wtmaHdjh1bSKDhT0/XECmfdFqO8kkLkpOilP63QqY7gXcNZn+Rdxlmhn3vMA9rqIi
UwMUUvLMuPcC3sOQwuJbAe/9S+Vx/gVPEPxiAvkOs42JCBAOg/eeDTjcZZbS9sb02yjg5kfh
BO2M2ZLKwvp2UBlcZgkvmsKzHKaiy1sn4KZTXbmxwU5jHJPXVnb9xl6ZAdr1ek+RIRP7pfX8
+kdc7a7PwUlIrmGwd7Ewp1tVC38Z/P7ZeWW41qz943u9lWjgmaEWXdyA4f65OcGZ5+1XM/Wq
N+4E/YDgcWAavxBIy91qcf6BLwRVt9b32xhtq1RHOHcCJcaCIvWxKPdpZw42Vz6y9c/pZp7n
SKZNGuneB3urQ1rV4Ui5O3SGv6pFgONgrISh0W8aw1SD78nfR3EqNP6x/UAjCG9R/z1ElMuK
NTp7zjI0nCH3Jq3p3bCvg7qojt3jKvUuTDyhkCEfDQ2uS9Hk7liAJEjN6bGAs7PmsndgxFeO
4g4MnVWtfsnCaRYUuqbt1T6iYxyBHTUo2WG0pG6uaYHFCE+C4UOmPGou9a4h+jE05TpKF0Xc
zoRk+r5bIujsYsfWY59UnJZ4L3wrZWWbK9c/AtR+ipzHlpLYNiUxUyWIt7FNdxXTKRum6n/0
mvB+/npZbH7+OL39sV98+zi9X4gJV/+29xesfY3WdapHm2/aaK3ZA/bMzBVKjx2rjI09tsG3
ynF+MzYC/BAvUcsSw6/81BnRPA5mgLK0SDWUlsmATbYFhQQyXeio8SIVWn9aHSfASGsy13bY
4BSUR/WxSEmqs39KcWYp1PGvQouTOPXZEPUak1QvsVk0loGOQHjjLYVx8DbwK0Zem6ww7GOX
/dL+XT1HW2WHNNECRW/uQILeQr1ueok6FsFlm/PHG3ElNt6ioW0DPsKAQdl6zpLdMNhMlDyi
LF+W/LOIDCq8m32xXp9ezpfTj7fzI7slp3gtPVWADVFVJ4llpj9e3r8xYktVNGsi+yIwF9NY
EpVVsC+UZD7s6Gj0dpfVo3eY88frlzuMnzUagUsCfMxvzc/3y+llUb4u4u9PP35HLezj09en
R+V2UT6Efnk+fwO4OcdcWFmOLNOhWvfLbLIpVRq9vp0fvjyeX+bSsXQZ0uNQ/bl6O53eHx+e
T4vb81t2q2XStdPtLovjPta60qq/ykCU8vRfxWGubhOaIN5+PDxDhWe/iKUrq7sIej4ZtIen
56fXfyZ5dolkIFSY0Tt20HKJB+X8vxobgyhR9K4g+0HX/Vysz8D4eqb16t1GCreU8iVSuU3S
ItrysTNU/iqtMRRttGXtmwkn2pc10Z64eVIZ8Gpl4lmTLzRqmoxGPydfObmJHxvkmO7TrXpL
cWjjMaZj+s/l8fzaTcxpNpJZuL/8FMU3ei7HVRPBRknOMB1lxg1lR+U8rY0k23b5Y/PIMrnl
m3BQXXOHV+3WNV1jgtdtEPp2xHxHU7gu+8y7o6PJi+7VEgTQsr5n0mTq/oSxOODosVKv10bs
GC9ZGM4rc/iwlEypaCdRbtGuQyvsZpWtBBeFu8s22FO5Gso/V4qlmJJmwipKbXDeDCyWsidi
/Nm7+QcDHb1PyZUItZRjvDvfRo+Pp+fT2/nldCGDOYITnelZ9Ha+B3l9T5QcctufuIua0GcC
0hWRqZ4X4bdlkckCiDNzsbIsYhip4m4z5xaayArom8zI5h/rFVGdaM5NBMRF0hAU9ZWwYpsm
anK0iZm66J22J0WHjDs+3RyaRHmOIH7qD9ElqDWjQo0/oR+MGYdssW2xIXOKIvJJHLAO0PxA
daDuBApgz5vxVVVEAe9PDyih65q6rzCJatkDNPNBhxhGBetC7RB7lks9sceRrfnPHw5kN3DC
Uf28A7CMXBI8W5sscgK9PoAwtbicF1+evj1dHp7xihw2Bn06wd65Fv578zaic8o3QrPmPgBI
pkXiryISsq4JE9/yPC1fK+QvlQRpLpdQ0dFgfDTfI789OjskcsxWsDGLt9F5zs5AwqcNZ6D5
bGQJQQiOJqkAUSrh71BbogDhRwqQgoC7RAFCqBos4W8n1KoYhmxsyiR0PF9NmonQY9JLYg9K
P8LEy2YXvJJgQvFIk0rXtrBpEsZ0u0/zskqHGI3qGhQ4tnIm3Bx8U9FxSm//tAwM3OH4RFss
oBl1vKCFXH9JiqJoRckF7/0IYMq4EsohEDH+ChBplsOPYqTZMxfCqJPQ3AooK2Bl84FGkeKo
1+AIhOo1inT0S3ttG+1oXBrxIq6piuyYScah6JGyjxJ+9R5ZgIO9K+jiK+oB4RIheBZlMvUj
N6xo6CZUq1IrCjI0n0Ua0ba4JE5jzEShkhymZbKxqjuqETTo9PBFg62gIXcyHeyZjWd5Gjdk
QCP5StTXHIgRYmCryqEOIzFduqyFgZ+euXSDGrE+x9EZQR47Lg3W2bu9LGYSofNLe5zho8Zy
5ZnGTEndUfHQj4F+e7q2Famb1ert/HpZpK9flB0qk8Gz4yhPmTyVFJ2C4cczHC61PS6wPaWL
NkXsdLqyQe8wpJInzO+nlyc4uXc3LGpebR6BGLzprft/UkL6uRzt/hUpMPVmTDviuAlYiS+L
bqn4URWNb5AwMXHS+zMlkgSiM/54BQ1fjUSKyh7rm9XoEaBZV9TuoqkaVibbfw46g8len6Y3
mLyjevrS31FBLy7i88vL+ZW+SezEUnnKEIa8nNSqnkyUbuPzVwdO0YzhYoS4KFVWTdWnG+pE
peGm6tJtdrwCcZoFOeu0WrE8jThh1Whd53f+cuSsgQn0IIc9L8q5GFdLkUFcdPdNflMZxXUs
TUZxHYcXeIAQqtKE64ZWfVxGaiCQDiUluKFdUw7DIb89y6lpQyAYePrvKU/oUYf3gPnq5bj4
TRZKRNjI7ILgaE3h+wavB0dayGfj2waR14JAvchNqhKfrit1ThrHUZ3ugqSCkcSoDOTZ1AWv
Z9nsGwAQLlyT+r0HJGCjsYEE4fj0wgChcMaMEbYQqLcRWGhbzm8xQHdd3yRbGGC+rYp5Heap
Bxq5ofRmt4MfmStDXpp+woz/8vHy8rNTO6pq0Amt82lx+p+P0+vjz0Xz8/Xy/fT+9L9oi50k
zZ9Vnvcqank1sD69nt4eLue3P5On98vb018feLWsTrZQ2hBqVwoz6aRpzfeH99MfObCdvizy
8/nH4jco9/fF16Fe70q91DUpSlYgPPM7iKD5JrtK/X9LHP1IXG0psih9+/l2fn88/zhB0fpm
KdQyBlUtStCcCS3fU/lVSGh51OkRJYe6sUKDTl3AHFbSWhZr0yO6HPxNl5EOI4FRVoeoseB4
oK7lI0bXeAUnS5ayna3v61LTwRTVzjZmXVV3e4NMhwoaqkLrSWh/doWMFv86uV3blkF0CfP9
Kvf008Pz5bsiGPXo22VRP1xOi+L8+nShw2CVOg5ZFwWgut2ODrZBwvp1iKXWjC1EIar1krX6
eHn68nT5yYzMwrLVeL/JpjWJdLzBgwB7GAOKZdBw5ORNaJElWcvpjTdtY6nR3+RvOvg6jAy+
TbsjUe4yEAOp8ggQPa5J3yp6C8ilE9aoCz5JeTk9vH+8nV5OIEN/QItO5q5jEIFBQHT+CUgN
NNpBVGWamcRvivitO8fpUN6p/+pQNoGvPpPrEX32dSiZezfFwVNaPtvuj1lcYJRm0o8qPjcT
VRYqvwEFZrEnZjG5IlAJamerBE4UzJvCS5rDHM6Klj1NC7pxpcfVDLDv6KsUFR2vEeRDH+GZ
hVn0P8FssE2iHduhvkUdN7ltmPQ3rEPk6iaqkia0WZ2oIIUe3VYa37bYk9RyY/o08CMiAZdx
XEAegTLZEFBfOcJv8hYyxheTLuH3PNUwZF1ZUWVQp88Sg881DM7zgwifZEKTMBGBsyaH3c5k
Yk5KikXkXYGZbOQg9Uognzg26ChVPWMD8amJTMvkZNC6qg2Xj6YqX6ey6rmauPPK9zA2HDV4
I+wGsGGQGBESUWxSt2WEZuwjUFYtDB8l3woqLR7bqiE4M9O0acxLQBw21mV7Y9vqoIXptttn
jfqqa4C0YPYDrKmY27ixHZN79CMoPheGFzrVVR+pCCDQAN+3COC4tvLVu8Y1AzUE6D7e5rSB
JWIrY3ufFkIlpFi5CcQnc2ufe+aMruMz9Ah0AC+q0tVEWrw9fHs9XeSlBrPO3AShr54l8bd6
/LsxQqIj7e7iimi9ZcGuy/S7O0Ga9RPwf5U9S3MbOY/3/RWunHarMl9ZsuzYhxyo7pbUo36Z
zbZkX7oUW5OoxpZcll2T2V+/ANkPkEQr2UscASCbTxAAQUDML0bsixSyjbCGSOVppCJpxL62
dBpcXI5puNaGi+tvGlGNRfWCHovuBT1v9WAS3OsJm+S1QQ3Zjhwq68BqkTK9YJMzG7izJ2xc
uzFaF0Zu7vuUkq/P25+OjqTNPdWaXVxWmUYEenze7b21xXHBOAuSOOumj10HhNxcgtcyV16c
JHIcM1/Xn29fzp79cXZ83+yfQPXdb21j6EKqOCX38M5NLqZ+kbIqVEswoE8ojL+Q5HkxVJF+
yslV0nWDb2wjHOxBWtdPXzb77x/P8P/Xw3Gnk814W1mfeBNMbEqXwO9UYWmir4d3EGt2jMvA
5Zhy0rAEDkX4JVpJJo6NBUHXrOFEY+yMeQGmex64KALcaOANHeIuL4asMyNHyVBFcj5yX3I5
OpszAuzowExROT9Ji5vROa8C2kWMDeNte0QBkuHH0+L86jydU95ajG01AH+72raGuRHtkwUc
LANuXAUIl7/guG7Mt4Jqn3FQjBxls0hGVBs0vx0HAwOz86UWyYVdsLy8ouYu89vJy2lgdgIu
gF1YlruGneuOcNLB5eTcepC3KMbnVxzffigESLDEnNoA7N61QEdt8Ga7F/z3u/13ZhGUFzcX
l/YudombdXT4uXtBzRT399MO+cfjluPEWoi9POe2CaZhkRjIKKrv7O07HY1ZE2kR09TUchZ+
+TKxhfNSzs45eaxc39jC3/rGiTWLJXkmgLLUwPOmu+TyIjnvA8V2A39yeBpX4+PhGUNQ/NLF
Y1zeWDr7uByNm7vuzvP4ZF3maNq+vKJtk939moWfCzh0opTGzVPB+MZKwgliSWqycOdBXpkI
UdwxivVwnDFZ35xfUQd7A6FPJ1VamERQ9Le1uxScbeyK0ohxaJ0NF6Pryys6WNxAdAtsRdKF
wQ9zitqgNsxC1xwEzsqknik+6gfimwEexOtgMqxtXreiSfRpFVErziOmwTRRFI2wJG91Nism
Gpm8RVd7qsjXM/qCrk0/LW8tc4RbIdnuhQiW9ZSNyAbMMFLojahkniTUS9FgpjJISzVtrotp
dw3eZMWbrwarxpD+Js9o0/NicX9Wfnw7ahfmvtttRnlA920gwCavg0H3CkWA6b4yge6mYyTj
Rh8KN68Na5VLaXn9UqSu/IXDlDHIf4IvVYrkzvJyRSQuvThdX6e32LKBRqXxOkqsfhFksRb1
+DpL60UZB3arOhR22kblQZTkeOMpTdTynvtZo04ai77YTuJhIk1ZTTfTt33Dt8yad74YkzH3
XuoUWbdARNkavsT+6e2we7IuaLJQ5nHICmcteSd+CvL8pY2vQn+6PKMBou9NGepAkMa6vTp7
f9s86qPV3Zew36mdIkVTjsrxvpZuzh6BwWSUjQirNL23QWVeSVhEAClz6/lnj1tEQqppJKxH
bgQ/U1LwLsJ6byrreVkLq524yS66HCiWllwGiQ5dKMt820B77tza0P1x7r81K+ZsOHua0gV+
6KB6+PAty0OLDyPOBLsccrYnFFbASQIXOoCojSqd8MQaNo3QU5w7VjFQHxzG6968S3RmJtxg
hc5G8y83Y8tm24DL0WRAEkKC4SzXgMTXX79S4b3HSkVa5wU5hMo4t+L04G88UoaGuEzidEpj
piLAeLwFSlrBrrV2HZgsQpwBOa+QgNxHwNK/rUSIqYJ6oaJ7oqaCKfDmQlVOGvG8VOwoOE88
zLX2DsNeaV5JZuhOoHQMkjHo8IWQVvwvBOUlppYJrFPSZBCZYQSyHA7hvOAOYXyGjA8Fl5Yo
ja9u0L3v3sWTBVjDESTvi4Ho0YC/g/NT3VvtNCBfZOpR0yqGtZuhG3MmcCDZRpduSpKwA5C5
1SD9ooddoDPhv2RvULdVrsiZq3/iW18M5WYWDXoYWyevBHBDuBIyc17d9o6XmmIottjtLFX1
nWVvNyBO+9FVBcqac1GpfFZO6hkbk00ja/pIZFZhhHQrl0gAIF7vMQ+sBwKCYbpazMk180MP
BJvHH3aAsRlIdMEiYjdFQ21O/OP24+lw9hfsCW9L4LtLp+katBxI3q2Rd6njhtcDW1MfnJSF
VynKkSphO67xhcBX+3kW8z6xmgZYRBKCCEguMiOZUdGglRR6zSYt2Jk0f8xcUknLHy7CheLS
BHrAwHERm1QWVvgql0tKReSWxP6BmWsEHDRfP+2Oh+vry5s/Rp8oGhOq6WGZXHyxC3aYL8MY
egdtYa4vLTXdwXH7xCG5PFGcc9u3Sa5OfP2KNww6RL9u4tXFiW9MfucbnOLokFyd+Ab/8Moi
umF9emwS+qjPKUx0Bxuj/RIH2vVluO9xmeMSrHk5xapmNB5wvXKphmdTRwj5ZVs4iwTFW97u
FMHdqlL8xB7WFnzJg6948Jehr3Nv0KxuXfAVjibuzHWYoeW4zOPrWroN0VBO1EdkKoJa5qnI
7AWEYNA/lZ3hosfAkV1JTljsSGQulAmd7mLuZZwkVBFuMXMR8XAZRUt3MBABx0vivGd2KbIq
Vn6Nusds60BEWsblwu11pWb8VqiyGNc4e/Jaoqdxrd4+fryh3dILG7SM7q2TCn/XMrqtIgyA
4h/u7UEYyTKGgwVkJSgBMtOclyYUpg2IdCaUgRCtRvg8RQKIOlxgIjKT44R9Bwk0WgqMA0ND
b0GDykiraVRqk5KSMU0/1xL4kBlXTXO4MphCKBKCRwdPWQgZRhn0DqVXTHBXiwSkcJTJKaVD
dAIF0m6STK334j4Ncr6yoMtsBhoECtFG37fs43ghGuiymKzJ5Gpib5qbXqo8ze9zpvsGgbZZ
/Wi1UDC5St5/HZ9Prk8SV2GsMPPKV0xIOkSZp0DUveoHcjRh2hfmdoE405CoV0UiL6meW1QU
oJSldG48FAy3HW2Hp2ilKnZF+0WGFImO8l6kgv0q5hWAnrlWLpcMVb8wX2XoisZSojY0l46P
ZH+9Z3rjDjLTYo+SjOlwdaHgbsmgrV8/oQP30+Gf/ed/Ny+bz8+HzdPrbv/5uPlrC5S7p88Y
+vg7MrfPm9fXzdvL4e3zcfu823/8/Hx82Tz+/fn98HL49/D52+tfnww3XG7f9ttnnT9xq+/A
eq74X31ehrPdfofOebv/3dhO5kGAM6y1MNDnpckbWOiEYmTHsVSY14QatwAE+w+U+izPrF1J
ULDf29oHJs4ixU8M02HACWRA3QywSn9LOoMDkFBSFWVgjFr08BB3T3XcI6kbODwP8tbeFbz9
+/p+OHs8vG3PDm9nP7bPr/pRgUUMfZoLenNrgcc+PBIhC/RJy2UQFwtqpnEQfpGFFYmNAH1S
SY01PYwl7PS0F7fhgy0RQ41fFoVPvaTGuraGIE8ZUpBixJypt4H7BXSkexoGy6LHROBimkS1
F2yQJ4/WSgo3nW5DM5+NxtdplXiIrEp4oN/aQv/1Blr/Cf3xr9QissMsNhhs4XBvupgixkTy
8e159/jH39t/zx71mv+OuQ//9Za6LAXzpZCzxLffCQKvh1EQLryORIEMS+Gv9NQfIWDbd9H4
8nJ0012/fLz/QLeUx8379uks2utOoFPQP7v3H2fieDw87jQq3LxvvF4FQeo1Z87AggWIpGJ8
XuTJvfYr9XfxPMYgt34votv4jlmCEdQH/M4KbW/CVOmXQy+HJ5pZuW3G1B/SgKZTbmFKMpMV
nFrjUeBXk8gVU00+424FuyXMNHGtSm9EQXJeSeHv/GzRjbG34DEgoqr82cFMEXfdRdjm+GNo
+EDj8TmkAbq9XENH2POswd+ltujQeldtj+/+d2VwQZ1+KNiDrtcLK29fA54mYhmNpwPwkllh
UL0anYcx51XeLnX2U2SRe4wz5LxhOqQ/ZwCriyLgeHAMO0BfIp8cZ5mGIzbIPcHTR1w9eHx5
xfQAEBes7027Xxdi5G9iAOpuMAjzGQ98ORozXwcEZ53pON6FX5UCYWiazzk2P5d8mJUGvyqw
Ec22CHavP6xLu45x+WcZwGqaw7EFZ9U09neykMHEq2Ka5KtZzK5jg/AeeLerVqRRktBUhB0C
LQNOeieC89ceQrklELKXQg1yZs5gT0hZiAcRcjMqklKcWlDt0cGcDBFbYSQLUGBPrZIJs51U
xHsDtehV7kZ9Nsvi8PKKbn22ptGO0ywRNG9ieyw85Ey7rycnlmLywLUZoAtO/2rQD6XqnI7k
Zv90eDnLPl6+bd/ad7Vco0VWxnVQyGzutTuU07kThZdiFtzpYDCcZK0x5qD1ER7wzxg1KTRM
WHYWIqbWwvZ6dVC6EcNj1ZF1ioPb+46CGxqKhH1zVzAT3NGgxvIbLYkyLVvnU3QPsTNLdbxN
nBJJtD0jzmauUva8+/a2ASXw7fDxvtsz5zy+TuP4moZz3Eo/ZzMHKcmjPUjD4sw+96PGeyR8
6U6wPV1DL/9ytYQR37b2RAcpPn6Ivo5OkZz6/KD42/eOyMhcSwYOzMXK30boH7MeAONBYNy6
ObxQcIa4D3g8POgnw2uvJ8MWn0/8WUOKJn4u/xW0kK35SH+EKgjgfGcrFylmhQ7q+TphDzGL
YtCSJ8r7NI3Q9KyN1ere9vwk6KKaJg1VWU2R0D8t8N3oX1rXOupcd8fd971xfX38sX38e7f/
Tq/pzR0wNcbLAUOoIYTthXmZy864b11t2xSaOeD/vn76RC7/f6OBbZXTOBPy3nhezL52z1iH
eEsCSrOQtcQA+2SXoYOq1dJpDBIbRp0nbgKtMygIc1mAxnSZp04WPkqSRNkANotUXamYXqUH
uQwtN0sZp1GdVekU2tCTmTsMQUwRwAkX+BlQi4p1sJhrW62MZnRLBbA+4eSi6zMYOTJVUPtq
hoWOVVXz8kxwYan48LPL/WBvKo2B1RlN73ldgBBMnOYhRsgVSDJDLQQKmDW+3ivrtAgm1lAQ
9wNgbr6aFxB7QKPXkQnJwjylPe5QIErBfvZZ3ANyUDgQtVRmQ1tZrW/PQ84wSYRyNYMk1lO/
UCjbDhDMGHINJvQdYv2AYDIU+ne9vrZWUgPVbr0FG0/MEMTCDs7TgIXkgtD3SLWALeG1oSxg
G3jQafCnB2sWZQPsu1nPH6jLO0EYOZmDT/ydzdzPTQOiPsEP7WqrdPxK6lgjyjIPYtjedxH0
U1rpTUSJEeqpT7EB6YwjKTW/INwKRAw/0OfPA9TT+8LKS5mBHlOXBg+ca04vIzUOEfAtLe7R
AFHIfxAnwlDWqr6awCa0PweDlgiJPsaLqHF+7+9ysCT6nw9dYc0TM6jk4kMH6zdXjWRXF1Ut
rbEIbwmbnCf5lH4Xf3d7lr2KF8rSCpKHWgmriljeoijFSQZpEVsRF+DHLCSjksdhLdHWiDec
9lDiDBboG25dSXQowMgIpwHXoVAwNvE8Y+gqk3q1niVVudA38QyRvu5NLedxOAfDqMgtv3E8
wyl/I+/AnGPWviBrJQkNfX3b7d//Nk+fXrZHem1mu08ua3wKy7rPaWwg7GcigfFcxyvgBE7s
pLvp+DJIcVvFkfraXRY3eXb8GiZknd5nAvPNDq1TC+8EGQbhbJqjUBZJCVRWyMPBYen0+t3z
9o/33Usj+hw16aOBv3GDaFqACteAy4TW59IK7TCLKOAS2c+ANUXagdW+foeVUACjwscMqeX3
IUGX1NWKkmPfiwiv20u8VFeC3qOYtpZRgFIN+iamQgWE8bgY3aY6zxLLx9fUMsv1W4QqM0X0
xqgvxlN2FGiRVSSWOgg65hJjfVF/dxb0NGirxu6x3Qbh9tvH9+94iRnvj+9vHxilhTrdCxT9
QS7Wj6l8YHeBaubt6/nPEUfVxH9kazA4vMKodMKzT5/s4bedTVuY5ror/PfUAJb68k1Tpugm
z17pWxU2d9XdeaWPO5jZ5Ty0uCv+5hShjsFNS5GBSJjFCpTh2iyr3sEJsdxKxO8tAyyKDDRO
Gi+QZqZ/a+7sjqH3bpT4I4iOtp7m1dx7d/USP2ZkQNFaYdzO5q7cqg7x+hzkHaqwdL7KWN8b
jSzyuMwzx33fxsDUmPFk37DZpI0rAtNI4AW8DmFI8umfUTCUEs5wg0RwE69nrhlyOAQT2LQu
H/kVHA9P6EMOe0HbT67Oz88HKF0x0UJ2Pg2zmT8GHZX23SgDwftdNH3VjheVm+Wt5X7An8OG
JspCw679L95xLLfbJw1NLFUlPM7bg93VqxNlaFeOE81vmCaKhZwBkEyZ7gQ+DpgBD/D4P49s
fGCWAnerb88yWHSmM2u3ZwUgiBpFx/U36fedNxELJymduQhE+rP88Hr8fIYBFz9eDeNfbPbf
bcEFvh2gz0vOv6+x8PiMp4r6ZICosFdFH169P/3ymfKR3Uenea60FkEJ9ZeYFgwTu81Bh0Dn
qzq1DmXaHgVRd7oPETL9od+haRozovODX6gXFUyyEiUnrqxuQS4A6SDMiQEHd3AztPSd9+kp
Ne6ucMQ/feC5zvBpsyfbp0sWsLFxU5g2jdOFyNVtbwYUfpdR1AQ1MNYsdCXoz6L/Pr7u9uhe
AF14+Xjf/tzCf7bvj//5z3/+hxi68LWXrnKuxXeT26xvXyExi6f35suApViZCjIYRefQ0HDs
2OBZj0pppaI1td0326zP+2azG558tTIYOBPyle0f23xpVVqvUwxUt9BRGrUHY1T4nK5BDHYG
lHmU68skGiqNw6vvbLh8p3TQYJ/gW7baNhP1nfQsSGUwswv1RqkyNHWuRKz8563/nxXTbRh8
xItK7SwRc+q6jNxZI0mbUQxHf8Eqw/tPWPzGDsYch+bAH2Ctfxs562nzvjlDAesRbbxEOm4G
OS6VX3OB4FNnK//0ziCNtzefVFSLKVkdCiVQkcOwS7Htvniy8XbbAwnDk6nYRP4zl6BBxUqA
ZucF5F6TXzBAUuvQ+QycXy2IAbGMlrJweIZrzUxzn7xSX8eEA+t6B154Iy66Lf0VaHfS2da3
jeYltfhgMRcBEnBwr3JuQ2Y6rhU0xPJ+vyNK32nsXIpiwdO06vvMWeimArM1Uv0QGAYSbfUO
Cb4M1OOHlCAmZ9S30CRCbQqaWsgc6+ZoV3bn2+argc0vtS3GTf2lk2xpeouXwx/gK6ouVzHq
zm7HCxlFKaxtUBHZZnv1tUZOt6KG0D9jutG0ZBZcY20ZzvgwNJm/mMehKeyKNemWpcPa+oqo
ZQ+kpFmDGZTM/YKLVSLUcLFmITWLpfQWQZmBIL3ILWbnoDqZu1wJbo9MgRHDXDd99TzDW7jI
Moxlh2nkdIGI18gqoJ9GZn2xT7D5nUGuDjO1YIr3A4aXgE04OjYmlq7frO84w5PEGTS9aOsp
MI1FKiS/UTh0W7FItFHbTn0+DzCzYzNU/iJup1EJYLaF56fbM07ShCFify/qXOQOky4FpsKk
h7IG0OEpXeoGaaymA0hz0eDimjPbh2OgCQ/aJKhNYpPor597gza/2PfLPUXWJpZyS9/NMAIk
3pKnId64njQJARlq+HFjaopCutPx1VZDYW313MZ5gsrr4Z/t2+ujdWL326kIOu/zVSQl/+wb
iAyS8l5ctob/gPQJku3VhNJHKWZWMtq/sh/m5yEmPwOGTq3y7Pr7s0oLOFGnUVLPIh1GwZgQ
BnYy5mquCtvQ32DTMsa7VX39M3xngg3HFYwaJoYxWbp60try+sNfnamd3gRqOIxqCcL9NOGs
UbRoLXPMREW2r9F6bM6sB1XI5N634Pf7WsSJuV0a6FyhurAArfneWx30CkRtj+8of6OCGWC6
2833LV0+y2rIvtLKp7VeNw3rG4ixoQeho7AYFXRowJym+6rtdY6i5FRHXxXaAzVDpeXX7aFG
Zlo8TYP2pejwx3vdAzm0FYSl2/VLYNaeWaiEQw14eMMCSfca6n4KkKy5E9FXahJNnOwjUaTE
GwxZpXgcWRcZBglrX8hIGPPi+U8MvnxOjgM4I7XoY3Rq7cPI3R1GqXvPdnI5eY+mzLXb/wHQ
TpI71mMBAA==

--pWyiEgJYm5f9v55/--
