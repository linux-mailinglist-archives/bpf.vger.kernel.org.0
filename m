Return-Path: <bpf+bounces-26135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85789B67E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 05:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833711C20E39
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B04C63;
	Mon,  8 Apr 2024 03:43:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C61877
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547808; cv=none; b=HVuIaFhB2nTWDzNP1Cmi20vICyvbP0+E+975jsfjZCR6ssVPjRpU8quly2l4xHKN/ss12LEndAorbeyoWeCgkx4/ik0SqYmPCxP2OHGGqKYIeXe8urojtWWJkBN6hw59JCXufWTGX0Lf0XNcvY17TZ9B0mB204G2SDcKVwFjr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547808; c=relaxed/simple;
	bh=IxQPgxQQuozm5K7b4uLnW7UluWY3q4CDq7keAKK6uEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lUUAfTIs9ncuOlyRNRYszw4KP6dsBDrRtgoD2OrYbluiBQCC3TQp9uie5AXWKEcoRjCB2LzMRwZj1tSrcBDX2qDy70i13tvuHZ5X4DFNCXcAzn3+WQBI7S3tmXdbcuf7m97pEULsppKO7zjuFiyft9olW7wHX5gzqyrK3nnmD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc61b1d690so326434139f.3
        for <bpf@vger.kernel.org>; Sun, 07 Apr 2024 20:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712547805; x=1713152605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeZjjyufBBCXJMQAU+69EimZ0gey0i6TVwzsAoVWQGg=;
        b=ia4/NXilBjzEixGPxYXKDtTZtbcOK4Csozhh0jGzR4iqyxFK9epG3xyMwfO8+I73wo
         1+NvAG3VtWEZcBByZU6QYBP+QaHUmGC6p3o0UE/PvFbKtjYp9RVaGws3xNN5aO7txljE
         QcDQ35irEuH0y/h1Fi0UFjY5Bu8IdixV0yvhyacFMEwZGNgQnKhCObQ2j5QTjQMM0Gs4
         gibgIeNlKn95SZpRH/GFh0AHdcSJMDmB5zT1V62rEOrnxHZu9bR6syhJyqS3DlaiPHWR
         DfCPKFAMrItxBwgGvBuCE76goNQYfEylnkUVOq847fjmmCxflsEWvxLDmFdNikHLZ3m3
         vRTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOStf2QaliOP7CiBNjt4A1d3XuQmpxSZtAqme5KcfisezQou6NcDpnKt+fnw2sMALHZag37HZUTw1r3ZKDG2jedv4w
X-Gm-Message-State: AOJu0Yx22O0BKLXeETc/h4XaPgOO7zfYIOQMQE3gw/VpkeGWI4e4kwiC
	XXCTJx7tDnA7wmvcHBvBf/0cEibB3Tpnp3TaKiG2ytQnDJ7DE4fT7NUX/B/czGRtn76zNb853xC
	a271uyH3d41cQMby/aYsU7ipGhkxWeJd56LhT0zt3qZtVVQtbWSjAdlc=
X-Google-Smtp-Source: AGHT+IG4nQNDMHWD/MdLp06RF3H7xd52i7cSljL0k6808+tB09j17eMaQJtjMGE0osbn50LxBcAKx/RwQDpkxgy+0Xna6zQievBB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1302:b0:47c:829:32ad with SMTP id
 r2-20020a056638130200b0047c082932admr263356jad.0.1712547805638; Sun, 07 Apr
 2024 20:43:25 -0700 (PDT)
Date: Sun, 07 Apr 2024 20:43:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dbe1f06158d9b2c@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in dev_map_generic_redirect
From: syzbot <syzbot+aa38edb98c8bd20d2915@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    026e680b0a08 Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dc5d5e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10acd270ef193b93
dashboard link: https://syzkaller.appspot.com/bug?extid=aa38edb98c8bd20d2915
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-026e680b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/085338135a57/vmlinux-026e680b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b6e5889af37/zImage-026e680b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa38edb98c8bd20d2915@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000008d when read
[0000008d] *pgd=85442003, *pmd=fc491003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 13298 Comm: syz-executor.0 Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at xdp_ok_fwd_dev include/linux/filter.h:1009 [inline]
PC is at dev_map_generic_redirect+0x24/0x23c kernel/bpf/devmap.c:681
LR is at xdp_do_generic_redirect_map net/core/filter.c:4463 [inline]
LR is at xdp_do_generic_redirect+0x1d8/0x4d4 net/core/filter.c:4520
pc : [<803f2e70>]    lr : [<813e318c>]    psr: 60000013
sp : dfa41d00  ip : dfa41d58  fp : dfa41d54
r10: 0000fdef  r9 : 83641800  r8 : dfa43000
r7 : 00000001  r6 : 841bb400  r5 : 855c8a80  r4 : 824b3560
r3 : 00000000  r2 : dfa43000  r1 : 855c8a80  r0 : 841bb400
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 85104f00  DAC: 00000000
Register r0 information: slab kmalloc-cg-64 start 841bb400 pointer offset 0 size 64
Register r1 information: slab skbuff_head_cache start 855c8a80 pointer offset 0 size 192
Register r2 information: 1-page vmalloc region starting at 0xdfa43000 allocated at bpf_prog_alloc_no_stats+0x38/0x1cc kernel/bpf/core.c:103
Register r3 information: NULL pointer
Register r4 information: non-slab/vmalloc memory
Register r5 information: slab skbuff_head_cache start 855c8a80 pointer offset 0 size 192
Register r6 information: slab kmalloc-cg-64 start 841bb400 pointer offset 0 size 64
Register r7 information: non-paged memory
Register r8 information: 1-page vmalloc region starting at 0xdfa43000 allocated at bpf_prog_alloc_no_stats+0x38/0x1cc kernel/bpf/core.c:103
Register r9 information: slab task_struct start 83641800 pointer offset 0 size 3072
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdfa40000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r12 information: 2-page vmalloc region starting at 0xdfa40000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Process syz-executor.0 (pid: 13298, stack limit = 0xdfa40000)
Stack: (0xdfa41d00 to 0xdfa42000)
1d00: 804a6614 8027b0a4 855c8a80 dfa41da4 854a0102 854afef1 dfa43000 0000000e
1d20: dfa41d3c dfa41d30 824b3560 824b3560 855c8a80 84c46000 dfa41da4 0000000e
1d40: 00000024 5b930000 dfa41d9c dfa41d58 813e318c 803f2e58 dfa41d9c dfa41d68
1d60: 0000aaaa 00000000 841bb400 dfa43000 dfa41db4 dfa41e40 00000004 0000000e
1d80: dfa43000 83641800 83404800 00000000 dfa41dec dfa41da0 813ae474 813e2fc0
1da0: dfa41ef0 854a0102 854afef1 854a0102 854a0000 85060400 00000000 00020000
1dc0: 00000000 d2f4c1d4 84c46660 00000001 855e52cc 84c47660 00000ebe 855c8a80
1de0: dfa41ea4 dfa41df0 80c29b04 813ae204 00000000 00000400 00000000 00000eb0
1e00: 00000000 83641800 dfa41ea4 dfa41e18 8031cb08 00010040 00000000 83641800
1e20: 00000000 0000ef31 0000fdef 00000000 855e5000 0000fdef 00000000 00080000
1e40: 855c8a80 00000000 00000000 00000000 00000000 00000000 00000400 00000000
1e60: 00000000 d2f4c1d4 8219b2bc 84c46660 84c46000 d2f4c1d4 83641800 dfa41f08
1e80: dfa41ef0 00000000 84c46660 855e5000 20000040 81b6cbe4 dfa41ed4 dfa41ea8
1ea0: 80c2acb8 80c290c4 00000001 00000000 00000008 80c2ac58 846f6d80 0000fdef
1ec0: 83641800 dfa41f68 dfa41f64 dfa41ed8 804f7298 80c2ac64 dfa41f04 dfa41ee8
1ee0: 8020c17c 8020d138 00000000 00000000 00010000 0000fdef 20000040 00000000
1f00: 00000001 00000000 846f6d80 00000000 0000002a 00000000 00000000 00000000
1f20: 00000000 00000000 00000000 00000000 0000fdef d2f4c1d4 83641800 846f6d81
1f40: 846f6d80 0000002a 00000000 80200288 83641800 00000004 dfa41f94 dfa41f68
1f60: 804f75e0 804f7030 0000002a 00000000 80203054 d2f4c1d4 0000fdef 20000040
1f80: 000000c8 00000004 dfa41fa4 dfa41f98 804f7670 804f7574 00000000 dfa41fa8
1fa0: 80200060 804f766c 0000fdef 20000040 000000c8 20000040 0000fdef 00000000
1fc0: 0000fdef 20000040 000000c8 00000004 7ed4d32e 7ed4d32f 003d0f00 76b160fc
1fe0: 0000005c 76b15ef0 00091154 0004f04c 40000010 000000c8 00000000 00000000
Call trace: 
[<803f2e4c>] (dev_map_generic_redirect) from [<813e318c>] (xdp_do_generic_redirect_map net/core/filter.c:4463 [inline])
[<803f2e4c>] (dev_map_generic_redirect) from [<813e318c>] (xdp_do_generic_redirect+0x1d8/0x4d4 net/core/filter.c:4520)
 r10:5b930000 r9:00000024 r8:0000000e r7:dfa41da4 r6:84c46000 r5:855c8a80
 r4:824b3560
[<813e2fb4>] (xdp_do_generic_redirect) from [<813ae474>] (do_xdp_generic+0x27c/0x440 net/core/dev.c:5021)
 r10:00000000 r9:83404800 r8:83641800 r7:dfa43000 r6:0000000e r5:00000004
 r4:dfa41e40
[<813ae1f8>] (do_xdp_generic) from [<80c29b04>] (tun_get_user+0xa4c/0x13f4 drivers/net/tun.c:1924)
 r9:855c8a80 r8:00000ebe r7:84c47660 r6:855e52cc r5:00000001 r4:84c46660
[<80c290b8>] (tun_get_user) from [<80c2acb8>] (tun_chr_write_iter+0x60/0xc8 drivers/net/tun.c:2048)
 r10:81b6cbe4 r9:20000040 r8:855e5000 r7:84c46660 r6:00000000 r5:dfa41ef0
 r4:dfa41f08
[<80c2ac58>] (tun_chr_write_iter) from [<804f7298>] (call_write_iter include/linux/fs.h:2108 [inline])
[<80c2ac58>] (tun_chr_write_iter) from [<804f7298>] (new_sync_write fs/read_write.c:497 [inline])
[<80c2ac58>] (tun_chr_write_iter) from [<804f7298>] (vfs_write+0x274/0x438 fs/read_write.c:590)
 r8:dfa41f68 r7:83641800 r6:0000fdef r5:846f6d80 r4:80c2ac58
[<804f7024>] (vfs_write) from [<804f75e0>] (ksys_write+0x78/0xf8 fs/read_write.c:643)
 r10:00000004 r9:83641800 r8:80200288 r7:00000000 r6:0000002a r5:846f6d80
 r4:846f6d81
[<804f7568>] (ksys_write) from [<804f7670>] (__do_sys_write fs/read_write.c:655 [inline])
[<804f7568>] (ksys_write) from [<804f7670>] (sys_write+0x10/0x14 fs/read_write.c:652)
 r7:00000004 r6:000000c8 r5:20000040 r4:0000fdef
[<804f7660>] (sys_write) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdfa41fa8 to 0xdfa41ff0)
1fa0:                   0000fdef 20000040 000000c8 20000040 0000fdef 00000000
1fc0: 0000fdef 20000040 000000c8 00000004 7ed4d32e 7ed4d32f 003d0f00 76b160fc
1fe0: 0000005c 76b15ef0 00091154 0004f04c
Code: ee1d9f70 e1a08002 e591a054 e1a06000 (e597508c) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	ee1d9f70 	mrc	15, 0, r9, cr13, cr0, {3}
   4:	e1a08002 	mov	r8, r2
   8:	e591a054 	ldr	sl, [r1, #84]	@ 0x54
   c:	e1a06000 	mov	r6, r0
* 10:	e597508c 	ldr	r5, [r7, #140]	@ 0x8c <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

