Return-Path: <bpf+bounces-13002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCAC7D36CB
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3028159A
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8218E22;
	Mon, 23 Oct 2023 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336018E36
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 12:35:00 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F9D79
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 05:34:55 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b5019515c4so165096b6e.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 05:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064494; x=1698669294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRS5xANO8vafxZXyDUnidxpNFo1RE7nX/ilAWCtrloU=;
        b=UI4DOzpGBvXlfkr9zz58SG4QunAdOOOESPWULvwbP7rQqz/50UgSUHcjgRCu42hL8R
         aVMhCMBnfcNmZNk5zyLAPNI9IUxpSQNrDaZigqXKfaHUdcRULfCYODUpa8giz5vIPILP
         j42ZTIlkaCU3IvS+0oehSk69AaSZ6ONq2kuBjHk38QVOWhFQDxL3sA+NEATP+dMdvyxX
         8C3j545yaULK1O6sEw/lPqC/4osYB3z634cevadoR/8Ao7iMxjS5IdK70zhE7DSNl+Z9
         t1xsMCs+Y2Or2grLilED3wIYgaJ0/4XTRvXsJqcyx0xb62N7CeFP2agsdawXjnuye5KK
         W+rA==
X-Gm-Message-State: AOJu0Yym4eRscHq0kMpax9kjgpMr9kUL6qOApVKUBIWfzckE2PnKDsW0
	hGqPnnC/UmAfnnA9khwoYIZe3prJmuFTWURPBGKCKUIlNvm7gvtfpw==
X-Google-Smtp-Source: AGHT+IFyo2gqaTqYj6bCNKGHV61KXmLQKTnn3f0Rw3ezQRe7+x+P/Jq7jLgT/YG9YvNce4wgjx9TN9YQecGjs8ej1C/E59ph1CEo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198a:b0:3b2:ead3:a0ac with SMTP id
 bj10-20020a056808198a00b003b2ead3a0acmr3360045oib.0.1698064494715; Mon, 23
 Oct 2023 05:34:54 -0700 (PDT)
Date: Mon, 23 Oct 2023 05:34:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000038db106086173b9@google.com>
Subject: [syzbot] [net?] Internal error in fib6_node_lookup
From: syzbot <syzbot+1a41112f0c2c178b8b47@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58720809f527 Linux 6.6-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1799d5c5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f68ef77c3f04996a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a41112f0c2c178b8b47
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-58720809.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16ca5c4a62e2/vmlinux-58720809.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c794184c5790/zImage-58720809.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a41112f0c2c178b8b47@syzkaller.appspotmail.com

Insufficient stack space to handle exception!
Task stack:     [0xdfddc000..0xdfdde000]
IRQ stack:      [0xdf800000..0xdf802000]
Overflow stack: [0x82cb6000..0x82cb7000]
Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 13109 Comm: syz-executor.1 Not tainted 6.6.0-rc6-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at fib6_node_lookup+0x4/0x90 net/ipv6/ip6_fib.c:1630
LR is at fib6_table_lookup+0x58/0x354 net/ipv6/route.c:2179
pc : [<8160f694>]    lr : [<81606540>]    psr: 60000013
sp : dfddc010  ip : dfddc010  fp : dfddc084
r10: 84743300  r9 : 00000002  r8 : 00000031
r7 : dfddc0a8  r6 : 00000002  r5 : dfddc1e8  r4 : dfddc0a8
r3 : dfddc228  r2 : dfddc228  r1 : dfddc218  r0 : 84ed3090
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 8bc16c40  DAC: fffffffd
Register r0 information: slab kmalloc-128 start 84ed3080 pointer offset 16 size 128
Register r1 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r2 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r3 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r4 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r5 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r6 information: non-paged memory
Register r7 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r8 information: non-paged memory
Register r9 information: non-paged memory
Register r10 information: slab net_namespace start 84743300 pointer offset 0 size 3264
Register r11 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Register r12 information: 2-page vmalloc region starting at 0xdfddc000 allocated at kernel_clone+0xac/0x424 kernel/fork.c:2909
Process syz-executor.1 (pid: 13109, stack limit = 0xdfddc000)
Stack: (0xdfddc010 to 0xdfdde000)
c000:                                     00000000 00000000 00000000 00000000
c020: 00000000 00000000 00000000 84ed3080 00000000 82f78000 00000000 00000000
c040: 00000031 dfddc228 00000000 00000000 00000000 b2db8ff9 00000000 dfddc0a8
c060: 84743300 00000002 dfddc1e8 00000031 82f78000 00000080 dfddc0ec dfddc088
c080: 81607720 816064f4 dfddc0a8 00000002 00000000 00000000 00000000 84ed3080
c0a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
c0c0: 00000000 84743300 00000084 dfddc1e8 00000000 81607b48 00000000 dfddc228
c0e0: dfddc104 dfddc0f0 81607b74 8160769c 00000000 00000084 dfddc164 dfddc108
c100: 81642b70 81607b54 00000084 00000000 00000000 00000000 00000000 00000000
c120: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
c140: 00000000 dfddc1e8 aa1414ac 84743300 00000000 dfddc218 dfddc194 dfddc168
c160: 81600234 81642b28 81607b48 00000000 82db0780 00000050 84fae000 00000001
c180: 84743300 84570240 dfddc27c dfddc198 80bd3b50 81600184 00000000 00000000
c1a0: 82db0780 00000000 00000000 00000000 00000000 00000000 00000000 00000000
c1c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
c1e0: 00000000 00000000 00000031 00000001 00000000 00000000 01840000 00000000
c200: 00000000 00000000 00000000 00000000 00000000 00000000 00000120 00000000
c220: 00000000 01000000 00000000 00000000 00000000 aa1414ac bcda2b00 00000000
c240: 00000000 00000000 00000000 b2db8ff9 dfddc378 856b9800 000000ca 856b9800
c260: 82f78000 00000000 844df400 00000000 dfddc29c dfddc280 80bd4138 80bd36a4
c280: 82db0780 81b68b28 856b9800 82f78000 dfddc2ec dfddc2a0 81370a10 80bd412c
c2a0: 83fd9000 00000000 dfddc2ec dfddc314 8260c494 824b32ca 8260eeb8 000000ca
c2c0: 82db0780 82db0780 824b32c8 856b9800 844df400 dfddc2f0 83fd9000 00000000
c2e0: dfddc35c dfddc2f0 81370eec 81370934 dfddc404 8577e810 dfddc3dc 00000000
c300: 81655e60 00000001 824b1f84 855548c0 00c16840 fffffff4 00000004 8577e840
c320: 8577e800 8260c5f0 821635d8 b2db8ff9 dfddc3d4 00000000 82db0780 847ec400
c340: 0000000e 00000010 85164a00 84e62000 dfddc3bc dfddc360 815e9b14 81370d24
c360: 82db0780 00000000 00000000 84743300 00000000 00000000 00000000 00000000
c380: 00000000 00000000 00000000 b2db8ff9 00000000 82db0780 85164a00 84743300
c3a0: 00000000 000005dc 84fae000 dfddc4f8 dfddc3fc dfddc3c0 815edd30 815e98a0
c3c0: 8553a850 dfddc4f8 dfddc3fc dfddc3d8 814710d8 82db0780 84743300 85164a00
c3e0: 00000001 856b9800 84fae000 dfddc4f8 dfddc444 dfddc400 815edec0 815edb08
c400: 8166f2c0 00000a04 84fae000 856b9800 85164a00 84743300 815edafc b2db8ff9
c420: 82db0780 84743300 85164a00 00000001 84743300 84570240 dfddc464 dfddc448
c440: 8166f35c 815ede54 82db0780 00000000 84fae000 00000001 dfddc54c dfddc468
c460: 80bd3ba8 8166f328 00000000 00000000 82db0780 00000000 00000000 00000000
c480: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
c4a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000031 00000001
c4c0: 00000000 00000000 01840000 00000000 00000000 00000000 00000000 00000000
c4e0: 00000000 00000000 00000120 00000000 00000000 01000000 00000000 00000000
c500: 00000000 aa1414ac bcda2b00 00000000 00000000 00000000 00000000 b2db8ff9
c520: dfddc648 856b9800 000000ca 856b9800 82f78000 00000000 844df400 00000000
c540: dfddc56c dfddc550 80bd4138 80bd36a4 82db0780 81b68b28 856b9800 82f78000
c560: dfddc5bc dfddc570 81370a10 80bd412c 83fd9000 00000000 dfddc5bc dfddc5e4
c580: 8260c494 824b32ca 8260eeb8 000000ca 82db0780 82db0780 824b32c8 856b9800
c5a0: 844df400 dfddc5c0 83fd9000 00000000 dfddc62c dfddc5c0 81370eec 81370934
c5c0: dfddc6d4 8577e810 dfddc6ac 00000000 81655e60 00000001 824b1f84 855548c0
c5e0: 00c16840 fffffff4 00000004 8577e840 8577e800 8260c5f0 821635d8 b2db8ff9
c600: dfddc6a4 00000000 82db0780 847ec400 0000000e 00000010 85164a00 84e62000
c620: dfddc68c dfddc630 815e9b14 81370d24 82db0780 00000000 00000000 84743300
c640: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
c660: 00000000 82db0780 85164a00 84743300 00000000 000005dc 84fae000 dfddc7c8
c680: dfddc6cc dfddc690 815edd30 815e98a0 8553a850 dfddc7c8 dfddc6cc dfddc6a8
c6a0: 814710d8 82db0780 84743300 85164a00 00000001 856b9800 84fae000 dfddc7c8
c6c0: dfddc714 dfddc6d0 815edec0 815edb08 8166f2c0 00000a04 84fae000 856b9800
c6e0: 85164a00 84743300 815edafc b2db8ff9 82db0780 84743300 85164a00 00000001
c700: 84743300 84570240 dfddc734 dfddc718 8166f35c 815ede54 82db0780 00000000
c720: 84fae000 00000001 dfddc81c dfddc738 80bd3ba8 8166f328 00000000 00000000
c740: 82db0780 00000000 00000000 00000000 00000000 00000000 00000000 00000000
c760: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
c780: 00000000 00000000 00000031 00000001 00000000 00000000 01840000 00000000
c7a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000120 00000000
c7c0: 00000000 01000000 00000000 00000000 00000000 aa1414ac bcda2b00 00000000
c7e0: 00000000 00000000 00000000 b2db8ff9 dfddc918 856b9800 000000ca 856b9800
c800: 82f78000 00000000 844df400 00000000 dfddc83c dfddc820 80bd4138 80bd36a4
c820: 82db0780 81b68b28 856b9800 82f78000 dfddc88c dfddc840 81370a10 80bd412c
c840: 83fd9000 00000000 dfddc88c dfddc8b4 8260c494 824b32ca 8260eeb8 000000ca
c860: 82db0780 82db0780 824b32c8 856b9800 844df400 dfddc890 83fd9000 00000000
c880: dfddc8fc dfddc890 81370eec 81370934 dfddc9a4 8577e810 dfddc97c 00000000
c8a0: 81655e60 00000001 824b1f84 855548c0 00c16840 fffffff4 00000004 8577e840
c8c0: 8577e800 8260c5f0 821635d8 b2db8ff9 dfddc974 00000000 82db0780 847ec400
c8e0: 0000000e 00000010 85164a00 84e62000 dfddc95c dfddc900 815e9b14 81370d24
c900: 82db0780 00000000 00000000 84743300 00000000 00000000 00000000 00000000
c920: 00000000 00000000 00000000 b2db8ff9 00000000 82db0780 85164a00 84743300
c940: 00000000 000005dc 84fae000 dfddca98 dfddc99c dfddc960 815edd30 815e98a0
c960: 8553a850 dfddca98 dfddc99c dfddc978 814710d8 82db0780 84743300 85164a00
c980: 00000001 856b9800 84fae000 dfddca98 dfddc9e4 dfddc9a0 815edec0 815edb08
c9a0: 8166f2c0 00000a04 84fae000 856b9800 85164a00 84743300 815edafc b2db8ff9
c9c0: 82db0780 84743300 85164a00 00000001 84743300 84570240 dfddca04 dfddc9e8
c9e0: 8166f35c 815ede54 82db0780 00000000 84fae000 00000001 dfddcaec dfddca08
ca00: 80bd3ba8 8166f328 00000000 00000000 82db0780 00000000 00000000 00000000
ca20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ca40: 00000000 00000000 00000000 00000000 00000000 00000000 00000031 00000001
ca60: 00000000 00000000 01840000 00000000 00000000 00000000 00000000 00000000
ca80: 00000000 00000000 00000120 00000000 00000000 01000000 00000000 00000000
caa0: 00000000 aa1414ac bcda2b00 00000000 00000000 00000000 00000000 b2db8ff9
cac0: dfddcbe8 856b9800 000000ca 856b9800 82f78000 00000000 844df400 00000000
cae0: dfddcb0c dfddcaf0 80bd4138 80bd36a4 82db0780 81b68b28 856b9800 82f78000
cb00: dfddcb5c dfddcb10 81370a10 80bd412c 83fd9000 00000000 dfddcb5c dfddcb84
cb20: 8260c494 824b32ca 8260eeb8 000000ca 82db0780 82db0780 824b32c8 856b9800
cb40: 844df400 dfddcb60 83fd9000 00000000 dfddcbcc dfddcb60 81370eec 81370934
cb60: dfddcc74 8577e810 dfddcc4c 00000000 81655e60 00000001 824b1f84 855548c0
cb80: 00c16840 fffffff4 00000004 8577e840 8577e800 8260c5f0 821635d8 b2db8ff9
cba0: dfddcc44 00000000 82db0780 847ec400 0000000e 00000010 85164a00 84e62000
cbc0: dfddcc2c dfddcbd0 815e9b14 81370d24 82db0780 00000000 00000000 84743300
cbe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
cc00: 00000000 82db0780 85164a00 84743300 00000000 000005dc 84fae000 dfddcd68
cc20: dfddcc6c dfddcc30 815edd30 815e98a0 8553a850 dfddcd68 dfddcc6c dfddcc48
cc40: 814710d8 82db0780 84743300 85164a00 00000001 856b9800 84fae000 dfddcd68
cc60: dfddccb4 dfddcc70 815edec0 815edb08 8166f2c0 00000a04 84fae000 856b9800
cc80: 85164a00 84743300 815edafc b2db8ff9 82db0780 84743300 85164a00 00000001
cca0: 84743300 84570240 dfddccd4 dfddccb8 8166f35c 815ede54 82db0780 00000000
ccc0: 84fae000 00000001 dfddcdbc dfddccd8 80bd3ba8 8166f328 00000000 00000000
cce0: 82db0780 00000000 00000000 00000000 00000000 00000000 00000000 00000000
cd00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
cd20: 00000000 00000000 00000031 00000001 00000000 00000000 01840000 00000000
cd40: 00000000 00000000 00000000 00000000 00000000 00000000 00000120 00000000
cd60: 00000000 01000000 00000000 00000000 00000000 aa1414ac bcda2b00 00000000
cd80: 00000000 00000000 00000000 b2db8ff9 dfddceb8 856b9800 000000ca 856b9800
cda0: 82f78000 00000000 844df400 00000000 dfddcddc dfddcdc0 80bd4138 80bd36a4
cdc0: 82db0780 81b68b28 856b9800 82f78000 dfddce2c dfddcde0 81370a10 80bd412c
cde0: 83fd9000 00000000 dfddce2c dfddce54 8260c494 824b32ca 8260eeb8 000000ca
ce00: 82db0780 82db0780 824b32c8 856b9800 844df400 dfddce30 83fd9000 00000000
ce20: dfddce9c dfddce30 81370eec 81370934 dfddcf44 8577e810 dfddcf1c 00000000
ce40: 81655e60 00000001 824b1f84 855548c0 00c16840 fffffff4 00000004 8577e840
ce60: 8577e800 8260c5f0 821635d8 b2db8ff9 dfddcf14 00000000 82db0780 847ec400
ce80: 0000000e 00000010 85164a00 84e62000 dfddcefc dfddcea0 815e9b14 81370d24
cea0: 82db0780 00000000 00000000 84743300 00000000 00000000 00000000 00000000
cec0: 00000000 00000000 00000000 b2db8ff9 00000000 82db0780 85164a00 84743300
cee0: 00000000 000005dc 84fae000 dfddd038 dfddcf3c dfddcf00 815edd30 815e98a0
cf00: 8553a850 dfddd038 dfddcf3c dfddcf18 814710d8 82db0780 84743300 85164a00
cf20: 00000001 856b9800 84fae000 dfddd038 dfddcf84 dfddcf40 815edec0 815edb08
cf40: 8166f2c0 00000a04 84fae000 856b9800 85164a00 84743300 815edafc b2db8ff9
cf60: 82db0780 84743300 85164a00 00000001 84743300 84570240 dfddcfa4 dfddcf88
cf80: 8166f35c 815ede54 82db0780 00000000 84fae000 00000001 dfddd08c dfddcfa8
cfa0: 80bd3ba8 8166f328 00000000 00000000 82db0780 00000000 00000000 00000000
cfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
cfe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000031 00000001
d000: 00000000 00000000 01840000 00000000 00000000 00000000 00000000 00000000
d020: 00000000 00000000 00000120 00000000 00000000 01000000 00000000 00000000
d040: 00000000 aa1414ac bcda2b00 00000000 00000000 00000000 00000000 b2db8ff9
d060: dfddd188 856b9800 000000ca 856b9800 82f78000 00000000 844df400 00000000
d080: dfddd0ac dfddd090 80bd4138 80bd36a4 82db0780 81b68b28 856b9800 82f78000
d0a0: dfddd0fc dfddd0b0 81370a10 80bd412c 83fd9000 00000000 dfddd0fc dfddd124
d0c0: 8260c494 824b32ca 8260eeb8 000000ca 82db0780 82db0780 824b32c8 856b9800
d0e0: 844df400 dfddd100 83fd9000 00000000 dfddd16c dfddd100 81370eec 81370934
d100: dfddd214 8577e810 dfddd1ec 00000000 81655e60 00000001 824b1f84 855548c0
d120: 00c16840 fffffff4 00000004 8577e840 8577e800 8260c5f0 821635d8 b2db8ff9
d140: dfddd1e4 00000000 82db0780 847ec400 0000000e 00000010 85164a00 84e62000
d160: dfddd1cc dfddd170 815e9b14 81370d24 82db0780 00000000 00000000 84743300
d180: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
d1a0: 00000000 82db0780 85164a00 84743300 00000000 000005dc 84fae000 dfddd308
d1c0: dfddd20c dfddd1d0 815edd30 815e98a0 8553a850 dfddd308 dfddd20c dfddd1e8
d1e0: 814710d8 82db0780 84743300 85164a00 00000001 856b9800 84fae000 dfddd308
d200: dfddd254 dfddd210 815edec0 815edb08 8166f2c0 00000a04 84fae000 856b9800
d220: 85164a00 84743300 815edafc b2db8ff9 82db0780 84743300 85164a00 00000001
d240: 84743300 84570240 dfddd274 dfddd258 8166f35c 815ede54 82db0780 00000000
d260: 84fae000 00000001 dfddd35c dfddd278 80bd3ba8 8166f328 00000000 00000000
d280: 82db0780 00000000 00000000 00000000 00000000 00000000 00000000 00000000
d2a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
d2c0: 00000000 00000000 00000031 00000001 00000000 00000000 01840000 00000000
d2e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000120 00000000
d300: 00000000 01000000 00000000 00000000 00000000 aa1414ac bcda2b00 00000000
d320: 00000000 00000000 00000000 b2db8ff9 dfddd458 856b9800 000000ca 856b9800
d340: 82f78000 00000000 844df400 00000000 dfddd37c dfddd360 80bd4138 80bd36a4
d360: 82db0780 81b68b28 856b9800 82f78000 dfddd3cc dfddd380 81370a10 80bd412c
d380: 83fd9000 00000000 dfddd3cc dfddd3f4 8260c494 824b32ca 8260eeb8 000000ca
d3a0: 82db0780 82db0780 824b32c8 856b9800 844df400 dfddd3d0 83fd9000 00000000
d3c0: dfddd43c dfddd3d0 81370eec 81370934 dfddd4e4 8577e810 dfddd4bc 00000000
d3e0: 81655e60 00000001 824b1f84 855548c0 00c16840 fffffff4 00000004 8577e840
d400: 8577e800 8260c5f0 821635d8 b2db8ff9 dfddd4b4 00000000 82db0780 847ec400
d420: 0000000e 00000010 85164a00 84e62000 dfddd49c dfddd440 815e9b14 81370d24
d440: 82db0780 00000000 00000000 84743300 00000000 00000000 00000000 00000000
d460: 00000000 00000000 00000000 b2db8ff9 00000000 82db0780 85164a00 84743300
d480: 00000000 000005dc 84fae000 dfddd5d8 dfddd4dc dfddd4a0 815edd30 815e98a0
d4a0: 8553a850 dfddd5d8 dfddd4dc dfddd4b8 814710d8 82db0780 84743300 85164a00
d4c0: 00000001 856b9800 84fae000 dfddd5d8 dfddd524 dfddd4e0 815edec0 815edb08
d4e0: 8166f2c0 00000a04 84fae000 856b9800 85164a00 84743300 815edafc b2db8ff9
d500: 82db0780 84743300 85164a00 00000001 84743300 84570240 dfddd544 dfddd528
d520: 8166f35c 815ede54 82db0780 00000000 84fae000 00000001 dfddd62c dfddd548
d540: 80bd3ba8 8166f328 00000000 00000000 82db0780 00000000 82c01180 00002920
d560: ffffffff 80891104 847ec4d4 00000014 dfddd5ac 00002920 804af888 80278ea8
d580: dddd5828 82c01180 00000000 00002920 8260c9bc 00002920 00000031 00000001
d5a0: 00000000 00000000 01840000 00000000 00000000 00000000 00000000 00000000
d5c0: 00000000 00000000 00000120 00000000 00000000 01000000 00000000 00000000
d5e0: 00000000 aa1414ac bcda2b00 00000000 00000000 00000000 dfddd62c b2db8ff9
d600: 8027a84c 856b9800 000000ca 856b9800 82f78000 00000000 844df400 00000000
d620: dfddd64c dfddd630 80bd4138 80bd36a4 82db0780 81b68b28 856b9800 82f78000
d640: dfddd69c dfddd650 81370a10 80bd412c 83fd9000 00000000 dfddd69c dfddd6c4
d660: 8260c494 824b32ca 8260eeb8 000000ca 82db0780 82db0780 824b32c8 856b9800
d680: 844df400 dfddd6a0 83fd9000 00000000 dfddd70c dfddd6a0 81370eec 81370934
d6a0: dfddd710 8027a844 81381380 00000000 00000000 b2db8ff9 000086dd 847ec460
d6c0: 00ddd6ec fffffff4 813db760 8134d26c 813db73c 00000000 82db0780 b2db8ff9
d6e0: dfddd70c 847ec400 00000000 82db0780 80bd3ef0 856b9800 85164a00 84e62000
d700: dfddd73c dfddd710 81381344 81370d24 00000000 000000bc dfddd73c 856b9800
d720: 82db0780 847ec400 00000009 845702a8 dfddd79c dfddd740 815e9a44 8138123c
d740: 82db0780 00000000 00000000 84743300 00000000 00000000 00000000 00000000
d760: 00000000 00000000 00000000 b2db8ff9 00000000 82db0780 85164a00 84743300
d780: 00000000 000005dc 00000000 84570240 dfddd7dc dfddd7a0 815edd30 815e98a0
d7a0: 8553a850 84570240 dfddd7dc dfddd7b8 814710d8 82db0780 84743300 85164a00
d7c0: 00000001 856b9800 00000000 84570240 dfddd824 dfddd7e0 815edec0 815edb08
d7e0: 82db0780 00000a04 00000000 856b9800 85164a00 84743300 815edafc b2db8ff9
d800: 82db0780 00000001 5b920000 85830220 84743300 845702a8 dfddd8f4 dfddd828
d820: 815e8ca4 815ede54 00000000 00000000 00000040 856b9800 85164a00 85830260
d840: 00000050 00000094 00000000 84e62000 84000000 85830250 00000a03 00000000
d860: 856b9800 85164a00 84743300 815e8404 00030000 00000000 00840000 00000000
d880: 00000000 00000000 00000000 00000000 1d810000 1d810000 00000000 00000000
d8a0: 00000000 00000000 aa1414ac 00000120 00000000 00000000 01000000 00000000
d8c0: 00000000 b2db8ff9 00000000 82db0780 85830200 85164e60 85164a00 83fd9000
d8e0: 00000002 00000000 dfddd9a4 dfddd8f8 8170fb7c 815e8988 00000000 00000002
d900: 00000000 00000000 838e8a80 b2db8ff9 816e7e2c 00000000 00000094 85830220
d920: dfddd93c dfddd930 81702640 807fbbf4 dfddd9a4 dfddd940 8134f5c0 81702628
d940: 8134f07c 816e7e2c dfddd974 838e8a80 838e8a90 82db0780 00000000 00000088
d960: 00000000 00000000 dfddd98c dfddd978 816e7e2c b2db8ff9 838e8a80 85830200
d980: dfddda24 845702b8 dfddda2c 82db0780 00000000 00000000 dfddda1c dfddd9a8
d9a0: 817035cc 8170f8cc 81c52754 dfddd9b8 dfddd9e4 dfddd9c0 817027cc 807f94a8
d9c0: 82db0780 00000000 8216c6ac 00000001 8504e800 85830200 00000000 85164a00
d9e0: 00000000 00000cc0 85830200 82db0780 dfddda1c 85830200 838e8a80 00000cc0
da00: 00000000 0000811d 00000000 8504ebb4 dfddda74 dfddda20 816ee8c8 8170301c
da20: 802f14b0 0000811d 00000000 dfddda2c dfddda2c 00000034 000000bc 00010000
da40: 85830200 00000000 00000000 b2db8ff9 dfdddac0 00000000 838e8a80 838e8a80
da60: 8504ebcc 8504e800 dfdddb04 dfddda78 816f00d8 816ee844 00000000 8504ea5c
da80: 81a04bec b2db8ff9 8027e22c 8504ea5c dddc8ac0 00000000 dfdddab4 dfdddaa8
daa0: 81849880 80278ea8 dfdddb04 00000000 8504ebb4 82604d40 8504ebb4 85830200
dac0: 858303c8 858303c8 8504e800 858303a0 00000cc0 b2db8ff9 00000000 dfdddbd4
dae0: 8504e800 00000004 838e8a80 00000000 8504e800 00000001 dfdddb14 dfdddb08
db00: 816f0a9c 816ef590 dfdddc34 dfdddb18 816dfaac 816f0a80 00000000 dfdddb5c
db20: 81710478 802dcecc dfdddbe4 85830220 00000008 00000000 0000012c 00000000
db40: 85164a00 00000001 8bc5e6c0 00000000 00000000 00000000 00000000 00000000
db60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
db80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dba0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dbc0: 00000000 00000000 00000000 00000000 00000000 838e8a80 0000000c 00000002
dbe0: 00000012 8504e800 00000001 838e8a80 00000016 00000001 00000003 dfdddbd4
dc00: dfdddbd4 b2db8ff9 dfdddc34 8504e800 85164a00 85830200 00000001 82f78000
dc20: 8bc5e6c0 dfdddd00 dfdddc54 dfdddc38 81702454 816de6e4 8bc5e6c0 8504e800
dc40: 00000000 00000cc0 dfdddcc4 dfdddc58 816f76e0 81702424 00000000 00000000
dc60: 85830200 84743300 dfdddf30 00000001 8504eb9c 85164a00 816fc31c 00000000
dc80: 0000000a 00000000 00000000 00000000 00000000 b2db8ff9 00000000 85164a00
dca0: dfdddf30 85830200 00000001 00000001 8bc5e6c0 00000000 dfdddd6c dfdddcc8
dcc0: 816ff6dc 816f74b8 dfdddd00 00000001 00000000 b2db8ff9 8504e800 82f78000
dce0: 85164a00 85830200 00000000 00000000 00000000 00000000 00000000 00000000
dd00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dd20: 85164a00 00000000 00000000 00000000 00000000 00000000 00000000 b2db8ff9
dd40: 00000000 dfdddf30 00000001 85164a00 00000000 dfddddcc dfddddcc 00008040
dd60: dfdddd8c dfdddd70 81555c18 816ff0dc 00000000 dfdddf30 84a00f00 00000000
dd80: dfddddac dfdddd90 81341798 81555be4 dfdddf30 84a00f00 00000000 00000000
dda0: dfddde1c dfddddb0 813423c8 81341760 807db754 807db574 dfddde28 dfdddf40
ddc0: 00000000 00000000 dfddde1c 00000000 00000000 00000000 00000000 00000000
dde0: 00000000 00000000 00000000 b2db8ff9 00000000 00000000 dfdddf30 84a00f00
de00: 00000000 00008040 20000280 dfddde2c dfdddf1c dfddde20 813441c0 813421a8
de20: 00000000 00000000 00000000 20000040 00000001 00000000 00000000 00000000
de40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
de60: 00000000 00000000 00000000 0000000a 00000000 00000120 00000000 00000000
de80: 01000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dee0: 00000000 00000000 00000000 b2db8ff9 804feb4c 00000000 84a00f00 20000280
df00: 00008040 80200288 82f78000 00000128 dfdddfa4 dfdddf20 813446bc 81344130
df20: 00000000 00000000 00000001 fffffff7 dfddde6c 0000001c 00000000 00000000
df40: 01000005 00000001 00000000 20000040 00000001 00000000 00000001 00000000
df60: 00000000 00000001 00008040 00000000 00000000 00000000 00000000 00000000
df80: 8020c8d0 b2db8ff9 00000000 00000000 0014c2c0 00000128 00000000 dfdddfa8
dfa0: 80200060 81344650 00000000 00000000 00000003 20000280 00008040 00000000
dfc0: 00000000 00000000 0014c2c0 00000128 7e9e032e 7e9e032f 003d0f00 76b320fc
dfe0: 76b31f08 76b31ef8 00016680 000509d0 60000010 00000003 00000000 00000000
Backtrace: 
[<816064e8>] (fib6_table_lookup) from [<81607720>] (ip6_pol_route+0x90/0x484 net/ipv6/route.c:2219)
 r10:00000080 r9:82f78000 r8:00000031 r7:dfddc1e8 r6:00000002 r5:84743300
 r4:dfddc0a8
[<81607690>] (ip6_pol_route) from [<81607b74>] (ip6_pol_route_output+0x2c/0x34 net/ipv6/route.c:2594)
 r10:dfddc228 r9:00000000 r8:81607b48 r7:00000000 r6:dfddc1e8 r5:00000084
 r4:84743300
[<81607b48>] (ip6_pol_route_output) from [<81642b70>] (pol_lookup_func include/net/ip6_fib.h:614 [inline])
[<81607b48>] (ip6_pol_route_output) from [<81642b70>] (fib6_rule_lookup+0x54/0x1e8 net/ipv6/fib6_rules.c:116)
[<81642b1c>] (fib6_rule_lookup) from [<81600234>] (ip6_route_output_flags_noref net/ipv6/route.c:2627 [inline])
[<81642b1c>] (fib6_rule_lookup) from [<81600234>] (ip6_route_output_flags+0xbc/0x1c8 net/ipv6/route.c:2639)
 r8:dfddc218 r7:00000000 r6:84743300 r5:aa1414ac r4:dfddc1e8
[<81600178>] (ip6_route_output_flags) from [<80bd3b50>] (ip6_route_output include/net/ip6_route.h:94 [inline])
[<81600178>] (ip6_route_output_flags) from [<80bd3b50>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:473 [inline])
[<81600178>] (ip6_route_output_flags) from [<80bd3b50>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<81600178>] (ip6_route_output_flags) from [<80bd3b50>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<81600178>] (ip6_route_output_flags) from [<80bd3b50>] (ipvlan_queue_xmit+0x4b8/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r9:84570240 r8:84743300 r7:00000001 r6:84fae000 r5:00000050 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddc2f0 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddc4f8 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddc4f8 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddc5c0 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddc7c8 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddc7c8 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddc890 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddca98 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddca98 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddcb60 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddcd68 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddcd68 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddce30 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddd038 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddd038 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddd100 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddd308 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddd308 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddd3d0 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (neigh_output include/net/neighbour.h:540 [inline])
[<81370d18>] (__dev_queue_xmit) from [<815e9b14>] (ip6_finish_output2+0x280/0x854 net/ipv6/ip6_output.c:135)
 r10:84e62000 r9:85164a00 r8:00000010 r7:0000000e r6:847ec400 r5:82db0780
 r4:00000000
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:dfddd5d8 r9:84fae000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:dfddd5d8 r9:84fae000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<8166f35c>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<8166f35c>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84570240 r8:84743300 r7:00000001 r6:85164a00 r5:84743300 r4:82db0780
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:593 [inline])
[<8166f31c>] (ip6_local_out) from [<80bd3ba8>] (ipvlan_queue_xmit+0x510/0x5dc drivers/net/ipvlan/ipvlan_core.c:659)
 r7:00000001 r6:84fae000 r5:00000000 r4:82db0780
[<80bd3698>] (ipvlan_queue_xmit) from [<80bd4138>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r10:00000000 r9:844df400 r8:00000000 r7:82f78000 r6:856b9800 r5:000000ca
 r4:856b9800
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (__netdev_start_xmit include/linux/netdevice.h:4889 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (netdev_start_xmit include/linux/netdevice.h:4903 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (xmit_one net/core/dev.c:3548 [inline])
[<80bd4120>] (ipvlan_start_xmit) from [<81370a10>] (dev_hard_start_xmit+0xe8/0x2ac net/core/dev.c:3564)
 r7:82f78000 r6:856b9800 r5:81b68b28 r4:82db0780
[<81370928>] (dev_hard_start_xmit) from [<81370eec>] (__dev_queue_xmit+0x1d4/0xe84 net/core/dev.c:4344)
 r10:00000000 r9:83fd9000 r8:dfddd6a0 r7:844df400 r6:856b9800 r5:824b32c8
 r4:82db0780
[<81370d18>] (__dev_queue_xmit) from [<81381344>] (dev_queue_xmit include/linux/netdevice.h:3082 [inline])
[<81370d18>] (__dev_queue_xmit) from [<81381344>] (neigh_resolve_output net/core/neighbour.c:1554 [inline])
[<81370d18>] (__dev_queue_xmit) from [<81381344>] (neigh_resolve_output+0x114/0x1b8 net/core/neighbour.c:1534)
 r10:84e62000 r9:85164a00 r8:856b9800 r7:80bd3ef0 r6:82db0780 r5:00000000
 r4:847ec400
[<81381230>] (neigh_resolve_output) from [<815e9a44>] (neigh_output include/net/neighbour.h:542 [inline])
[<81381230>] (neigh_resolve_output) from [<815e9a44>] (ip6_finish_output2+0x1b0/0x854 net/ipv6/ip6_output.c:135)
 r8:845702a8 r7:00000009 r6:847ec400 r5:82db0780 r4:856b9800
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (__ip6_finish_output net/ipv6/ip6_output.c:196 [inline])
[<815e9894>] (ip6_finish_output2) from [<815edd30>] (ip6_finish_output+0x234/0x34c net/ipv6/ip6_output.c:207)
 r10:84570240 r9:00000000 r8:000005dc r7:00000000 r6:84743300 r5:85164a00
 r4:82db0780
[<815edafc>] (ip6_finish_output) from [<815edec0>] (NF_HOOK_COND include/linux/netfilter.h:293 [inline])
[<815edafc>] (ip6_finish_output) from [<815edec0>] (ip6_output+0x78/0x1e4 net/ipv6/ip6_output.c:228)
 r10:84570240 r9:00000000 r8:856b9800 r7:00000001 r6:85164a00 r5:84743300
 r4:82db0780
[<815ede48>] (ip6_output) from [<815e8ca4>] (dst_output include/net/dst.h:458 [inline])
[<815ede48>] (ip6_output) from [<815e8ca4>] (NF_HOOK include/linux/netfilter.h:304 [inline])
[<815ede48>] (ip6_output) from [<815e8ca4>] (NF_HOOK include/linux/netfilter.h:298 [inline])
[<815ede48>] (ip6_output) from [<815e8ca4>] (ip6_xmit+0x328/0x768 net/ipv6/ip6_output.c:344)
 r9:845702a8 r8:84743300 r7:85830220 r6:5b920000 r5:00000001 r4:82db0780
[<815e897c>] (ip6_xmit) from [<8170fb7c>] (sctp_v6_xmit+0x2bc/0x348 net/sctp/ipv6.c:250)
 r10:00000000 r9:00000002 r8:83fd9000 r7:85164a00 r6:85164e60 r5:85830200
 r4:82db0780
[<8170f8c0>] (sctp_v6_xmit) from [<817035cc>] (sctp_packet_transmit+0x5bc/0xa00 net/sctp/output.c:653)
 r10:00000000 r9:00000000 r8:82db0780 r7:dfddda2c r6:845702b8 r5:dfddda24
 r4:85830200
[<81703010>] (sctp_packet_transmit) from [<816ee8c8>] (sctp_packet_singleton+0x90/0xe4 net/sctp/outqueue.c:783)
 r10:8504ebb4 r9:00000000 r8:0000811d r7:00000000 r6:00000cc0 r5:838e8a80
 r4:85830200
[<816ee838>] (sctp_packet_singleton) from [<816f00d8>] (sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline])
[<816ee838>] (sctp_packet_singleton) from [<816f00d8>] (sctp_outq_flush+0xb54/0xba4 net/sctp/outqueue.c:1212)
 r9:8504e800 r8:8504ebcc r7:838e8a80 r6:838e8a80 r5:00000000 r4:dfdddac0
[<816ef584>] (sctp_outq_flush) from [<816f0a9c>] (sctp_outq_uncork+0x28/0x2c net/sctp/outqueue.c:764)
 r10:00000001 r9:8504e800 r8:00000000 r7:838e8a80 r6:00000004 r5:8504e800
 r4:dfdddbd4
[<816f0a74>] (sctp_outq_uncork) from [<816dfaac>] (sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline])
[<816f0a74>] (sctp_outq_uncork) from [<816dfaac>] (sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline])
[<816f0a74>] (sctp_outq_uncork) from [<816dfaac>] (sctp_do_sm+0x13d4/0x1848 net/sctp/sm_sideeffect.c:1169)
[<816de6d8>] (sctp_do_sm) from [<81702454>] (sctp_primitive_ASSOCIATE+0x3c/0x44 net/sctp/primitive.c:73)
 r10:dfdddd00 r9:8bc5e6c0 r8:82f78000 r7:00000001 r6:85830200 r5:85164a00
 r4:8504e800
[<81702418>] (sctp_primitive_ASSOCIATE) from [<816f76e0>] (sctp_sendmsg_to_asoc+0x234/0x684 net/sctp/socket.c:1840)
[<816f74ac>] (sctp_sendmsg_to_asoc) from [<816ff6dc>] (sctp_sendmsg+0x60c/0x910 net/sctp/socket.c:2030)
 r10:00000000 r9:8bc5e6c0 r8:00000001 r7:00000001 r6:85830200 r5:dfdddf30
 r4:85164a00
[<816ff0d0>] (sctp_sendmsg) from [<81555c18>] (inet_sendmsg+0x40/0x4c net/ipv4/af_inet.c:840)
 r10:00008040 r9:dfddddcc r8:dfddddcc r7:00000000 r6:85164a00 r5:00000001
 r4:dfdddf30
[<81555bd8>] (inet_sendmsg) from [<81341798>] (sock_sendmsg_nosec net/socket.c:730 [inline])
[<81555bd8>] (inet_sendmsg) from [<81341798>] (__sock_sendmsg+0x44/0x78 net/socket.c:745)
 r7:00000000 r6:84a00f00 r5:dfdddf30 r4:00000000
[<81341754>] (__sock_sendmsg) from [<813423c8>] (____sys_sendmsg+0x22c/0x2a8 net/socket.c:2558)
 r7:00000000 r6:00000000 r5:84a00f00 r4:dfdddf30
[<8134219c>] (____sys_sendmsg) from [<813441c0>] (___sys_sendmsg+0x9c/0xd0 net/socket.c:2612)
 r10:dfddde2c r9:20000280 r8:00008040 r7:00000000 r6:84a00f00 r5:dfdddf30
 r4:00000000
[<81344124>] (___sys_sendmsg) from [<813446bc>] (__sys_sendmsg net/socket.c:2641 [inline])
[<81344124>] (___sys_sendmsg) from [<813446bc>] (__do_sys_sendmsg net/socket.c:2650 [inline])
[<81344124>] (___sys_sendmsg) from [<813446bc>] (sys_sendmsg+0x78/0xbc net/socket.c:2648)
 r10:00000128 r9:82f78000 r8:80200288 r7:00008040 r6:20000280 r5:84a00f00
 r4:00000000
[<81344644>] (sys_sendmsg) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdfdddfa8 to 0xdfdddff0)
dfa0:                   00000000 00000000 00000003 20000280 00008040 00000000
dfc0: 00000000 00000000 0014c2c0 00000128 7e9e032e 7e9e032f 003d0f00 76b320fc
dfe0: 76b31f08 76b31ef8 00016680 000509d0
 r7:00000128 r6:0014c2c0 r5:00000000 r4:00000000
Code: e3480216 eb084b91 eafffce9 e1a0c00d (e92dd810) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e3480216 	movt	r0, #33302	@ 0x8216
   4:	eb084b91 	bl	0x212e50
   8:	eafffce9 	b	0xfffff3b4
   c:	e1a0c00d 	mov	ip, sp
* 10:	e92dd810 	push	{r4, fp, ip, lr, pc} <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

