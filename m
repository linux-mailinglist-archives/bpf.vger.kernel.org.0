Return-Path: <bpf+bounces-35052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FA49372E4
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 05:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22139B2156C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4136286A8;
	Fri, 19 Jul 2024 03:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46929CEC
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721361567; cv=none; b=pviuD2OxtlNEeIVR1v2PqtN8sG866ppfrNyTGd9cwOtG1FPws6eSktBSMPk/5IhfJluVkL/WUN5rJUx6Cc8u1ROuq8FBdbArBP9Ax7kBo45Y/usJJu8plMQHAgMiCPcxK8E8bhvCF5wHQ1sjFWnhaqQiXV8j/J54ICX3CZ0SqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721361567; c=relaxed/simple;
	bh=BYtjMnrg77lwtp/tNpjJPFhBlO3WMLQtQ7fv2/nGYgU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CG3n36fW1UFYycScQ0s2w98bR0osS+LGt3CtJ3gPi94BI3/RqKxLwRC9WDv7W2adhzPXN6Ve7w3gHg2k0dMvaC35GKBl1u4SOt/FF6ZAug5Dw/q8Mf8b9dQRYERrPn8nNgrmLFEjF50vpTZ6M1T1MGQEcxYOhB2ZAfXq3tzsCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-396a820a8a3so19516715ab.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721361565; x=1721966365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrK4WYf/uKs8zDYDpmiI5632yMosk+h9POQVGPzsB5s=;
        b=HpDTSvg/w1E8bSh3B9XG3jNH9pug8+iYsacMAgk4hvediyaF5FhbCqUDx2q4Xoly7H
         yTcGEYHJp/AoKL2geJ13NSZn1DmsNfTh0nn3sXJ8bX53v/5o5QmV7Gds1Cl90LOawgP2
         MkdvB1jp5VaADWZynCypgv5bft3rumuvVDTGAsAx7qWDyahebfiAuippQo2/SjsAyMtn
         u+RuXjttQcH6pHPYHL9P16jKdPESkvI2ZbS/iyGM6JRENsMLHhAG0SoQh77PZ+oj6q8T
         nNoYZbxWEZ08CXnA9e5CNTWDWBUh6ZZSWPcithNWs2w2MZ8NN3YCvFUdKJLu9tNluv87
         sYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXOrsHrRpCUb3yY03m7PGu+4FGHomZSIPtiCsf80Sqgo/6vMn0E9IjtgkUcxQSF0Mt5qRb+ulUzee0uwFNhHP2t47hZ
X-Gm-Message-State: AOJu0YwyJdDJJ+dA5YuZT711LE0WiXafKwVdNRusV4znngbbqeHknzai
	DxaRO53ZFek0ShUn01XKBm2jn2D+u2PSxwoznV2GvUpI09uNpHk59/WINlglIYPgPL11t+Iv3Ai
	HySyue3z57IJ7yjPPHgK9eNxf9sYf0Faty7w0NMmXquzHSwwB3cBdqcc=
X-Google-Smtp-Source: AGHT+IERhI+Qf5xCGkt6hoxXKWechrHPgrkAWOL7Nr8CIRUnJqmAwc7hDK1I+Vy/hcXMvtrm4Oo6xEiqY6BhTqziDlvkYPJnHKUw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d8c2:0:b0:380:e1e4:4ba3 with SMTP id
 e9e14a558f8ab-3964de98c1dmr791605ab.2.1721361565025; Thu, 18 Jul 2024
 20:59:25 -0700 (PDT)
Date: Thu, 18 Jul 2024 20:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d1d0a061d91b803@google.com>
Subject: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68b59730459e Merge tag 'perf-tools-for-v6.11-2024-07-16' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cb0ab5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6230d83d52af231
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8229997a3dbb/disk-68b59730.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd51823e0836/vmlinux-68b59730.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01811b27f987/bzImage-68b59730.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead4ead00000008-0xdead4ead0000000f]
CPU: 1 PID: 8860 Comm: syz.0.1070 Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:209 [inline]
RIP: 0010:__dev_flush+0xe4/0x160 kernel/bpf/devmap.c:428
Code: b8 00 00 00 00 00 fc ff df 41 80 7c 05 00 00 49 89 c5 74 08 48 89 df e8 6a c3 3d 00 48 8b 2b 48 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 3d c4 3d 00 4c 89 23 4c 89 e0 48
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010212
RAX: 1bd5a9d5a0000001 RBX: dead4ead00000008 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffff8880b943e868
RBP: dead4ead00000000 R08: ffff8880b943e867 R09: ffff8880b943e858
R10: dffffc0000000000 R11: ffffed1017287d0d R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffff8880b943e848 R15: 1ffff11017287d09
FS:  00007f33633c96c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffec0000 CR3: 0000000054f40000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x129/0x240 net/core/filter.c:4300
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5062
Code: c9 50 e8 19 b6 0b 00 48 83 c4 08 4c 89 f7 e8 7d 38 00 00 e9 de 04 00 00 4c 89 f7 e8 d0 d9 32 0a e8 4b e8 36 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003a377a8 EFLAGS: 00000286
RAX: 94ed15acce52c200 RBX: ffff88807e01da00 RCX: ffffffff947db703
RDX: dffffc0000000000 RSI: ffffffff8bcac9a0 RDI: ffffffff8c205b20
RBP: ffffc90003a377f0 R08: ffffffff8faec7af R09: 1ffffffff1f5d8f5
R10: dffffc0000000000 R11: fffffbfff1f5d8f6 R12: 1ffff110172a7ebb
R13: dffffc0000000000 R14: ffff8880b943e840 R15: ffff8880b953f5d8
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x1808/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 futex_wait_queue+0x14e/0x1d0 kernel/futex/waitwake.c:370
 __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
 futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
 do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3362575b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f33633c90f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f3362705f68 RCX: 00007f3362575b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f3362705f68
RBP: 00007f3362705f60 R08: 00007f33633c96c0 R09: 00007f33633c96c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3362705f6c
R13: 000000000000000b R14: 00007ffec9a21080 R15: 00007ffec9a21168
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:209 [inline]
RIP: 0010:__dev_flush+0xe4/0x160 kernel/bpf/devmap.c:428
Code: b8 00 00 00 00 00 fc ff df 41 80 7c 05 00 00 49 89 c5 74 08 48 89 df e8 6a c3 3d 00 48 8b 2b 48 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 3d c4 3d 00 4c 89 23 4c 89 e0 48
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010212
RAX: 1bd5a9d5a0000001 RBX: dead4ead00000008 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffff8880b943e868
RBP: dead4ead00000000 R08: ffff8880b943e867 R09: ffff8880b943e858
R10: dffffc0000000000 R11: ffffed1017287d0d R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffff8880b943e848 R15: 1ffff11017287d09
FS:  00007f33633c96c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffec0000 CR3: 0000000054f40000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	(bad)
   8:	df 41 80             	filds  -0x80(%rcx)
   b:	7c 05                	jl     0x12
   d:	00 00                	add    %al,(%rax)
   f:	49 89 c5             	mov    %rax,%r13
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 6a c3 3d 00       	call   0x3dc386
  1c:	48 8b 2b             	mov    (%rbx),%rbp
  1f:	48 8d 5d 08          	lea    0x8(%rbp),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 3d c4 3d 00       	call   0x3dc476
  39:	4c 89 23             	mov    %r12,(%rbx)
  3c:	4c 89 e0             	mov    %r12,%rax
  3f:	48                   	rex.W


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

