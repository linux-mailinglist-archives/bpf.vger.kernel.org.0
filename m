Return-Path: <bpf+bounces-34872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750A931E76
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09EE282282
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D68EAD8;
	Tue, 16 Jul 2024 01:23:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E14C98
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093003; cv=none; b=Yq71P6DrmA3JV65Vm2d3ln3WvbCHXeB9cbSDNqxBhjgZvf948KOi+6XxSjkihsbqoGW21Q4kM4KUJ5SGhoHU4CCRZGiHY6MaKxdLLU8YRFTzIkax/lCMmSqKMUhwCcFK8OddLMrp4d9i8TMpHvxmzeNWPoZoK/SZFX+1WXtbBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093003; c=relaxed/simple;
	bh=ZZMrXW//datlgTk9/AxilYaBdsktv+cJT4ZHKJ7/2fo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oXprXKSqLXeg3U1gXgWyo41sxDUzz1+8RunUjd4r16E+USCIAqKMGASzxN3SxRQKy+0fEakNhWqnjk4LHVwVBz5eUHaYfZjhAfL0TAoAQ3F8p/FvBLgIAuL4niFQ4SDhW2GmC6nMVb5NfAI4jJa4KTYuwma9ZQiu7+XxPy4yPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f682b4694aso547224839f.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 18:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093000; x=1721697800;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrTY4E9dwMaOsFfSFijC10L9Vx6+2nYaCItEw+V4XCE=;
        b=wJpOhPBJwSyvf7W/imuINgogKhepCFrj2juXq5PMGpsDiNAMjkO/gKIW6HcWZ5ukDx
         ncdUDJzq8VsqZOGmAT1TQ7QnJSWmY1RIlxgsYuiUVof4Vdtl7yT9XwWDjiDhMN7yuzu8
         fYIJHVNZb7sWnvlwUTbXjQWJ62mmrztQdzloz4Rj/6hTXmAHLp23T4Esghlfz9J3nbik
         ds6YkQXB73e9cxTubuY5yPD9giPjE1ae1ke5ZaWC6ZQmpLN7SiBvNirFzeFaAj41vdJ7
         dZIRlYG3XfiwpfDuvqKlJ3s0vNhJz/yIk2V4C81z7v5lRPI6mY2NOu7CQVjhLyiA2mJe
         FCyA==
X-Forwarded-Encrypted: i=1; AJvYcCVj2MaWNTgozwcOvomVlt4bJCM9MmqNBttMA/aTTifd59Hi4CNNg1UraQmOvuY1gYbKU1YlfTxa8xgA6NC8qYBwc+rC
X-Gm-Message-State: AOJu0YzsKBNwyIiikYk0arUr8n/CMBIMlTSnmrbKy5GEOhSBHaqZOS34
	eJUqOI0j+AOFgCr5qDNW6I4KR2FWZnY9Br1aStquJpkPkQREJzbKynI8jaA0EXUE3UXO7IKIiBo
	zoznFv/SzS5rZTfFcnQjKGuQB0g/Cdlnl8an1uAP3sshmjuPpNItoKY4=
X-Google-Smtp-Source: AGHT+IFGxH153aE/8usxwyP9BT7oG/12wXoV7aedxCjgHSoq3sBUSvjz1NXDAaGaDQwujP8sBwSS+p/J8bLtx4T0vN+LyxUj1tGU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2721:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4c2048d9527mr43214173.6.1721093000326; Mon, 15 Jul 2024
 18:23:20 -0700 (PDT)
Date: Mon, 15 Jul 2024 18:23:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8fcab061d53308f@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, bjorn@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	jasowang@redhat.com, jiri@resnulli.us, john.fastabend@gmail.com, 
	jolsa@kernel.org, jonathan.lemon@gmail.com, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16085221980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=61a1cfc2b6632363d319
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2a5e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dd6479980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz

The issue was bisected to:

commit fecef4cd42c689a200bdd39e6fffa71475904bc1
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jul 4 14:48:15 2024 +0000

    tun: Assign missing bpf_net_context.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119d4b6e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139d4b6e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=159d4b6e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")

Oops: general protection fault, probably for non-canonical address 0xe000140493916901: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x0000c0249c8b4808-0x0000c0249c8b480f]
CPU: 1 UID: 0 PID: 5098 Comm: syz-executor400 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:xskq_prod_submit net/xdp/xsk_queue.h:436 [inline]
RIP: 0010:xsk_flush net/xdp/xsk.c:331 [inline]
RIP: 0010:__xsk_map_flush+0x95/0x2b0 net/xdp/xsk.c:393
Code: 24 10 49 8d 5f e8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 d9 ea 81 f6 48 8b 1b 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 72 01 00 00 8b 6b 08 48 83 c3 10 48 89
RSP: 0018:ffffc90000a18ae8 EFLAGS: 00010202
RAX: 0000180493916901 RBX: 0000c0249c8b4800 RCX: ffff888029608000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: 0000c0249c8b4808
RBP: dffffc0000000000 R08: ffffffff896d0c9a R09: 1ffffffff1f5ffad
R10: dffffc0000000000 R11: fffffbfff1f5ffae R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000010 R15: ffffffff8173aee3
FS:  000055557b0fb380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b0fbca8 CR3: 000000007eb32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x18e/0x240 net/core/filter.c:4308
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x9f7/0xf50 kernel/printk/printk.c:3103
Code: 20 00 90 0f 0b 90 e9 f3 f9 ff ff e8 c3 1b 20 00 e8 7e 56 20 0a 4d 85 f6 74 c0 e8 b4 1b 20 00 fb 49 bd 00 00 00 00 00 fc ff df <43> 80 3c 2f 00 48 8b 5c 24 30 74 08 48 89 df e8 d5 a1 87 00 4c 8b
RSP: 0018:ffffc90003527880 EFLAGS: 00000293
RAX: ffffffff8173af3c RBX: 0000000000000000 RCX: ffff888029608000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003527a10 R08: ffffffff8173aee3 R09: 1ffffffff1f5ffad
R10: dffffc0000000000 R11: fffffbfff1f5ffae R12: ffffffff8eb30c00
R13: dffffc0000000000 R14: 0000000000000200 R15: 1ffffffff1d6618b
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3173
 vprintk_emit+0x7a1/0x900 kernel/printk/printk.c:2423
 _printk+0xd5/0x120 kernel/printk/printk.c:2450
 show_opcodes+0x148/0x170 arch/x86/kernel/dumpstack.c:123
 show_signal_msg arch/x86/mm/fault.c:775 [inline]
 __bad_area_nosemaphore+0x5f2/0x770 arch/x86/mm/fault.c:818
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x61d/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f9fe69c315e
Code: fd d7 c9 0f bc d1 c5 fe 7f 27 c5 fe 7f 6f 20 c5 fe 7f 77 40 c5 fe 7f 7f 60 49 83 c0 1f 49 29 d0 48 8d 7c 17 61 e9 d2 04 00 00 <c5> fe 6f 1e c5 fe 6f 56 20 c5 fd 74 cb c5 fd d7 d1 49 83 f8 21 0f
RSP: 002b:00007ffce01d48e8 EFLAGS: 00010287
RAX: 00007ffce01d4900 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000003ff RSI: 0000000000000000 RDI: 00007ffce01d4900
RBP: 00007ffce01d4900 R08: 00000000000003ff R09: 00007ffce01d4e48
R10: 00007ffce01d4e48 R11: 0000000000000246 R12: 6666666666666667
R13: 0000000000000000 R14: 00007ffce01d4d50 R15: 00007ffce01d4d40
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xskq_prod_submit net/xdp/xsk_queue.h:436 [inline]
RIP: 0010:xsk_flush net/xdp/xsk.c:331 [inline]
RIP: 0010:__xsk_map_flush+0x95/0x2b0 net/xdp/xsk.c:393
Code: 24 10 49 8d 5f e8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 d9 ea 81 f6 48 8b 1b 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 72 01 00 00 8b 6b 08 48 83 c3 10 48 89
RSP: 0018:ffffc90000a18ae8 EFLAGS: 00010202
RAX: 0000180493916901 RBX: 0000c0249c8b4800 RCX: ffff888029608000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: 0000c0249c8b4808
RBP: dffffc0000000000 R08: ffffffff896d0c9a R09: 1ffffffff1f5ffad
R10: dffffc0000000000 R11: fffffbfff1f5ffae R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000010 R15: ffffffff8173aee3
FS:  000055557b0fb380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b0fbca8 CR3: 000000007eb32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 10                	and    $0x10,%al
   2:	49 8d 5f e8          	lea    -0x18(%r15),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 d9 ea 81 f6       	call   0xf681eaf5
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 72 01 00 00    	jne    0x1a9
  37:	8b 6b 08             	mov    0x8(%rbx),%ebp
  3a:	48 83 c3 10          	add    $0x10,%rbx
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

