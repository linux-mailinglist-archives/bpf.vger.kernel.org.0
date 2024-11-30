Return-Path: <bpf+bounces-45907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBC9DF272
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 19:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A5162EF8
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E561A9B38;
	Sat, 30 Nov 2024 18:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5619EEA1
	for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989930; cv=none; b=ZIFSYpryfHGU6ONMDvzfifp2nOcRn16hRHExWVlq4hfa4MptBix2dsA5NLuvPV5KluCm9DxXw5F7eT0o4uoASjgLmHEFJ9JJtqu8jkZb5rVqOWAIQQGXfc+u8iOromuQGU7sfrr785eQtjKgtcBos+mnTUS7kwpGSHqEYcc5XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989930; c=relaxed/simple;
	bh=2C4d7UEKbKI1mAkzDFtYC51rOUqkJDdUDhD2OKE+FbY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h+LLAle2iR1j8CFKrfIulNKvLJkL5QpquH0NyvIIAO6IsZfUzM5S3mOkNTpjmj9VvT2CW3W6h5vVKE9t3SJoKtJ9RI73sIEnSRSaGFb9yyz6oboIrPedvfqGt5AfQ0Yo99OrayqMu/CHhFuM7i7nZgfJ7q9rSza1VBm9FaPZq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso34691275ab.3
        for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 10:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989928; x=1733594728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRHMMbOM9jVJYYNqroswi5u/gwQteibRbzcIjAytvhM=;
        b=pPxIyvJUjJ7q7c3ZSD4Wq2kthgsSqhbxyLygjHALe68mS1PCt0Px/+pxM3AwFBQhjm
         55p9ejt3gRbRec/N/eCx8VjIbs6w/eUQpYre+hHCviSR+FT3Cx8Is/FXZxVBKhpOieYQ
         mvaUiiQTyw67JzsUwxpsySgx1NrHj1WdTYUS3HLF8BWLOfkflSZnibZDu2AK5rnIQ5JJ
         +TJC9VkZIDE/UgWmslISA7hoc96SzOmUwYU9lzcvPFNgsUHe5arTobF20ENMhRJFOMuv
         6zWnACEkRBQFLsX9xAIBjAQ/lYdjgPedKIedxYChsRZ2sKxLLislDl7yU7yn+9lGHBWU
         PQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCU80ld43WWXO2CpEqJrwPg4rZClKwLi8MOWMa5N8XwPqEP5aqgzH/+EZ5+gYNfiZgMUVj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqDcIBjP5vVkA4JxaZT1V9T0K3T3PNt+vn6ruJaBSR+lb/igg
	iSW9ZzhcVen0WDvC4oOc4cXg8HY3T2osGAqjW3yCfrf2AII/kqsOErGd6v4ynb77qTZNLS+m5Av
	0nE6CtwvDkjfjSdsO0Sk+QnEBpn4Dt8g449mE77s1noJVp6SazToKxTk=
X-Google-Smtp-Source: AGHT+IEv6YmrCOe0vSZf00GEMUS/16hEGNr7prLtk9Itu6MSY1XWR6kc8bNn8216SRdyU83X52rWfu30sjWxoil4Suf9kjb036JK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7c5524090mr206778105ab.3.1732989928071; Sat, 30 Nov 2024
 10:05:28 -0800 (PST)
Date: Sat, 30 Nov 2024 10:05:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b53e8.050a0220.253251.00e0.GAE@google.com>
Subject: [syzbot] [bpf?] [netfilter?] INFO: rcu detected stall in sys_sendmmsg (7)
From: syzbot <syzbot+53e660acb94e444b9d63@syzkaller.appspotmail.com>
To: andrii@kernel.org, anna-maria@linutronix.de, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, frederic@kernel.org, 
	kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd4f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e5d0648de624aa
dashboard link: https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7afd648f7c25/disk-b86545e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/40e3ee6c8cc8/vmlinux-b86545e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53bc5977cfb0/bzImage-b86545e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53e660acb94e444b9d63@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...0: (6 ticks this GP) idle=545c/1/0x4000000000000000 softirq=161841/161847 fqs=2100
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:        0          0            0   ==> 52500(ms)
rcu: 	(detected by 0, t=10505 jiffies, g=202837, q=172 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1553 Comm: syz.8.7708 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:advance_sched+0x36/0xca0 net/sched/sch_taprio.c:916
Code: 54 53 48 81 ec 98 00 00 00 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 79 e7 c8 f7 49 8d 5e 88 48 89 d8 48 c1 e8 03 80 3c 28 00 <74> 08 48 89 df e8 50 a3 30 f8 48 8b 03 48 89 84 24 88 00 00 00 48
RSP: 0018:ffffc90000a18c70 EFLAGS: 00000046
RAX: 1ffff1100c0f9259 RBX: ffff8880607c92c8 RCX: ffff88802d349e00
RDX: 0000000000010000 RSI: 0000000000000000 RDI: ffff8880607c9340
RBP: dffffc0000000000 R08: ffffffff8183463f R09: 1ffffffff203a606
R10: dffffc0000000000 R11: ffffffff89ccfc90 R12: dffffc0000000000
R13: ffffffff89ccfc90 R14: ffff8880607c9340 R15: ffff88802d34a8c8
FS:  00007f7bb35f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c32f64a CR3: 0000000070470000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5243
Code: c9 50 e8 79 07 0c 00 48 83 c4 08 4c 89 f7 e8 9d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 70 2f 6f 0a e8 2b 9a 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900033771a8 EFLAGS: 00000286
RAX: a5530211a14c0a00 RBX: ffff88802d349e00 RCX: ffffffff9a3f7903
RDX: dffffc0000000000 RSI: ffffffff8c0ad980 RDI: ffffffff8c6083a0
RBP: ffffc900033771f0 R08: ffffffff901d3037 R09: 1ffffffff203a606
R10: dffffc0000000000 R11: fffffbfff203a607 R12: 1ffff110170e7eac
R13: dffffc0000000000 R14: ffff8880b863e740 R15: ffff8880b873f560
 context_switch kernel/sched/core.c:5372 [inline]
 __schedule+0x1803/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0xb0/0x290 kernel/time/sleep_timeout.c:75
 unix_wait_for_peer+0x250/0x340 net/unix/af_unix.c:1529
 unix_dgram_sendmsg+0x127f/0x1f80 net/unix/af_unix.c:2131
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmmsg+0x36a/0x720 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bb5780809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bb35f6058 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f7bb5945fa0 RCX: 00007f7bb5780809
RDX: 0000000000000651 RSI: 0000000020000000 RDI: 0000000000000007
RBP: 00007f7bb57f393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7bb5945fa0 R15: 00007ffe8b8d0818
 </TASK>


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

