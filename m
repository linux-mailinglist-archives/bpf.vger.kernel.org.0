Return-Path: <bpf+bounces-22234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4148599D0
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 23:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08877B20E93
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95A745E9;
	Sun, 18 Feb 2024 22:22:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E273165
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294940; cv=none; b=DNexVB6DklaqZHsOIQ71v6luozjGZDRovD7QTFG89ReDP4dpZ1VFwDbirj2T8vUVLYaypzgWDsB/zFttfakjFuME1D57tNAv1tZZaf77UZpEC7+gZW1jEaO7srraInvY7wXu3qu+K8B/DrUDofbmUOz5L0UVBWuLpVB4vaE8wzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294940; c=relaxed/simple;
	bh=hKCkF2Nc02tElu4OZDLKcK7Rpu1cpp/hq4ESd91kik8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pYSe4gkU5wm9k91A9IY6k6sHT8Bcbs/DM3brDu18JoxoS9XALFigpLQS14Pr9iZFx5FSn0+v/T8NHhDgQXjh/KyKvjghsBUQ/NpphsQm1NZidj/0AkQjkE8gJ1IHkmEBLFZ14cA7gWsssGtEKt8fTIh6cFPBNN2+fFqHckBAzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3653311926bso513645ab.0
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 14:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708294937; x=1708899737;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZYk1LMO5y6n5tGB1SFVJxfsyQYKQ7bfwvDflpKRAPI=;
        b=iICYWHS9e+GG1LvE2WGye0uUvtwCCvLRcnBwF4M8GELmg4lLkPgvpERc3UztXeTuvF
         8hbVytZRp9C+8pB/Dgh7gtpq/4KLkfV+PmhB5xugqj8CiSkbwln0/H51BJvIhrEt4nsh
         kLyO6sItLIVV6sab2pfl3BNtCbFr2naxMkaP0QWLh94qFP7opQ/DDh0LD7keo5PAqUtT
         HzIUNSH0rxi6Egs0oRQAThoWaYr20yMsBQCCIqujZtGjwQuM1b+/vOzYhoTLt+iFIzO4
         MTl2e8DFRGg8kwIs0lpRmah+7hbBfg2x1XGTn+BZ6gwNehbJ4ZwXsroWN887Icgje+gW
         d/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXujEihxIf3FmnuOU/FBff3XdGiTQLj8zY38jd16BgbYK5YC7D3gzykXC8e9TYfNc2pP1Aj1GVsM6PPJj+GgV2Bpv2T
X-Gm-Message-State: AOJu0YwJqIfekS/P8LrEzPxb8Q/way2t45A5Bex9mth9u0RyIQRiMrqQ
	Ax5JTntgbnL8JPuWbtP5N5oCzP9h7fQVVCjcXPZeFJylb6+ylESJRYAcWQ6hG+gsHM0+gWf/+pu
	t9tKkRDjmGXZ+Kin5U5Q3819DRB/qbtzFphcygEcfxrLyY7Zdz1j5djM=
X-Google-Smtp-Source: AGHT+IGJnExPV9Xp6gCG90zK3qSJ71JHKUOQY4H1LWGqTi9yZIMSzgcyvwkAvmwc6Dcuj0xwYH9KNyd3az04FZ7sgm6V8a5CwTTn
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:365:3086:74f7 with SMTP id
 i11-20020a056e0212cb00b00365308674f7mr89848ilm.4.1708294937599; Sun, 18 Feb
 2024 14:22:17 -0800 (PST)
Date: Sun, 18 Feb 2024 14:22:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed666a0611af6818@google.com>
Subject: [syzbot] [net?] [bpf?] BUG: unable to handle kernel NULL pointer
 dereference in dev_map_hash_update_elem
From: syzbot <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e90b5c295ec Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1460a080180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8ee3942159acc92
dashboard link: https://syzkaller.appspot.com/bug?extid=8cd36f6b65f3cafd400a
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-7e90b5c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79d91883bc70/vmlinux-7e90b5c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0dcf5ad6b94a/zImage-7e90b5c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000014 when read
[00000014] *pgd=85006003, *pmd=fe2d5003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 7433 Comm: syz-executor.1 Not tainted 6.8.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __dev_map_hash_lookup_elem kernel/bpf/devmap.c:269 [inline]
PC is at __dev_map_hash_update_elem kernel/bpf/devmap.c:972 [inline]
PC is at dev_map_hash_update_elem+0x90/0x210 kernel/bpf/devmap.c:1010
LR is at get_lock_parent_ip include/linux/ftrace.h:977 [inline]
LR is at preempt_latency_start kernel/sched/core.c:5843 [inline]
LR is at preempt_count_add+0x12c/0x150 kernel/sched/core.c:5868
pc : [<803e5ed8>]    lr : [<8027b2b4>]    psr: 60000093
sp : dfaf1da8  ip : dfaf1d68  fp : dfaf1de4
r10: 00000001  r9 : 84658000  r8 : 84e58110
r7 : 00000001  r6 : a0000013  r5 : 84e58000  r4 : ffffffff
r3 : 00000001  r2 : 00000010  r1 : 00000000  r0 : a0000013
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 83e1be00  DAC: 00000000
Register r0 information: non-slab/vmalloc memory
Register r1 information: NULL pointer
Register r2 information: zero-size pointer
Register r3 information: non-paged memory
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-cg-512 start 84e58000 pointer offset 0 size 512
Register r6 information: non-slab/vmalloc memory
Register r7 information: non-paged memory
Register r8 information: slab kmalloc-cg-512 start 84e58000 pointer offset 272 size 512
Register r9 information: slab net_namespace start 84658000 pointer offset 0 size 3264
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdfaf0000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Register r12 information: 2-page vmalloc region starting at 0xdfaf0000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Process syz-executor.1 (pid: 7433, stack limit = 0xdfaf0000)
Stack: (0xdfaf1da8 to 0xdfaf2000)
1da0:                   dfaf1dc4 ffffffff 00000000 caa92d0f dfaf1de4 84e58000
1dc0: 824aeaf0 86a45440 86a45c80 84f14000 00000004 84e58000 dfaf1e14 dfaf1de8
1de0: 8038c070 803e5e54 00000001 00000000 80883e10 84e580b8 84f14001 84f14000
1e00: dfaf1ec8 86a45440 dfaf1e6c dfaf1e18 8038cff8 8038be80 00000001 00000000
1e20: 00000000 00000004 20000280 00000004 00000000 86a45c80 200002c0 00000000
1e40: dfaf1e6c 00000000 00000020 dfaf1ea0 00000002 200002c0 00000020 00000000
1e60: dfaf1f8c dfaf1e70 80392a58 8038cdb0 00000000 00000000 20000013 83f0d400
1e80: dfaf1ee0 dfaf1fb0 dfaf1ea4 dfaf1e98 80883e10 dfaf1ee0 dfaf1fb0 80200288
1ea0: 200002c0 00000000 00000008 00000000 00000008 8041ad38 00000000 00000000
1ec0: 00000000 00000000 00000003 00000000 20000240 00000000 20000280 00000000
1ee0: 00000001 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1f40: 00000000 00000000 00000000 00000000 00000000 00000000 80203134 caa92d0f
1f60: 8261c978 00000000 00000000 0014c2c8 00000182 80200288 83f0d400 00000182
1f80: dfaf1fa4 dfaf1f90 80394e5c 803927e8 200002c0 00000000 00000000 dfaf1fa8
1fa0: 80200060 80394e3c 00000000 00000000 00000002 200002c0 00000020 00000000
1fc0: 00000000 00000000 0014c2c8 00000182 7ec5132e 7ec5132f 003d0f00 76b440fc
1fe0: 76b43f08 76b43ef8 000167e8 00050bb0 60000010 00000002 00000000 00000000
Backtrace: 
[<803e5e48>] (dev_map_hash_update_elem) from [<8038c070>] (bpf_map_update_value+0x1fc/0x2d4 kernel/bpf/syscall.c:202)
 r10:84e58000 r9:00000004 r8:84f14000 r7:86a45c80 r6:86a45440 r5:824aeaf0
 r4:84e58000
[<8038be74>] (bpf_map_update_value) from [<8038cff8>] (map_update_elem+0x254/0x460 kernel/bpf/syscall.c:1553)
 r8:86a45440 r7:dfaf1ec8 r6:84f14000 r5:84f14001 r4:84e580b8
[<8038cda4>] (map_update_elem) from [<80392a58>] (__sys_bpf+0x27c/0x2104 kernel/bpf/syscall.c:5445)
 r10:00000000 r9:00000020 r8:200002c0 r7:00000002 r6:dfaf1ea0 r5:00000020
 r4:00000000
[<803927dc>] (__sys_bpf) from [<80394e5c>] (__do_sys_bpf kernel/bpf/syscall.c:5561 [inline])
[<803927dc>] (__sys_bpf) from [<80394e5c>] (sys_bpf+0x2c/0x48 kernel/bpf/syscall.c:5559)
 r10:00000182 r9:83f0d400 r8:80200288 r7:00000182 r6:0014c2c8 r5:00000000
 r4:00000000
[<80394e30>] (sys_bpf) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdfaf1fa8 to 0xdfaf1ff0)
1fa0:                   00000000 00000000 00000002 200002c0 00000020 00000000
1fc0: 00000000 00000000 0014c2c8 00000182 7ec5132e 7ec5132f 003d0f00 76b440fc
1fe0: 76b43f08 76b43ef8 000167e8 00050bb0
Code: e595210c e1a06000 e2433001 e003300a (e7924103) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e595210c 	ldr	r2, [r5, #268]	@ 0x10c
   4:	e1a06000 	mov	r6, r0
   8:	e2433001 	sub	r3, r3, #1
   c:	e003300a 	and	r3, r3, sl
* 10:	e7924103 	ldr	r4, [r2, r3, lsl #2] <-- trapping instruction


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

