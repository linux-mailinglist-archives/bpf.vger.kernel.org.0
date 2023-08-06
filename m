Return-Path: <bpf+bounces-7102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A555771743
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CB281124
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89DDC2EB;
	Sun,  6 Aug 2023 23:23:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D18C2DE
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 23:23:53 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5D1713
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 16:23:50 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a41b765478so7222922b6e.0
        for <bpf@vger.kernel.org>; Sun, 06 Aug 2023 16:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691364230; x=1691969030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DtxWzYncT1FCh/nzYEAuayH9VVU4o8iPgfXpM5Ydtk=;
        b=E+V9CU5ukAQMQd7NYRN2UwMf8mWulQFm8AicaYYvqQOW/olIqHT3ZGrkkJWwnB2EZb
         o6VJHD183Hw6Xpm0xAE8ZoMVYMl3KzGHBZK8L8sGelULWYUWoLlTZmzeQ3W9UdMciqSy
         PEyOX2A+II+bz9tXi8aN7zWOOQb+wr5oLDTbwtVeqQ1+WEcwKZMcSbd2J6NRVJtasT6I
         GWwp75UVcDMs4zx32U9rIO/f8qxwCti5RaNEp+wMnjduSkHNaoRqW5Q3HgyG3o6S1+hg
         VmfSZ/kKpTgATouhPlJCI2/7mHKUFbpG8wSBIWN6ABnC6GrHGQ+IaKHpeEh9UNYortSh
         tKSA==
X-Gm-Message-State: AOJu0Yw/inm4bflhBJe+XBhCTRS/rjo5+fANlYRzu6bNS59BR2vycR5x
	lSvBmaeLYq6/En7wbYFH4Eonj+pjDBLRYNbR0Xw/+pPx1cOT
X-Google-Smtp-Source: AGHT+IH2eSmmRAiGzG99/dDQFxEv7B/Q/DCeCUnsJKUEVBfx9gmDMcgdrG7UV5EhPo3kBwku5aQZT4MJta3qYmbinBPJfHJIuFT2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:1318:0:b0:3a4:1484:b3db with SMTP id
 e24-20020aca1318000000b003a41484b3dbmr7627094oii.5.1691364230205; Sun, 06 Aug
 2023 16:23:50 -0700 (PDT)
Date: Sun, 06 Aug 2023 16:23:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002098bc0602496cc3@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in ieee802154_subif_start_xmit
From: syzbot <syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    25ad10658dc1 riscv, bpf: Adapt bpf trampoline to optimized..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147cbb29a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=d61b595e9205573133b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d73ccea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276aedea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d378cc13d42/disk-25ad1065.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44580fd5d1af/vmlinux-25ad1065.xz
kernel image: https://storage.googleapis.com/syzbot-assets/840587618b41/bzImage-25ad1065.xz

The issue was bisected to:

commit 8100928c881482a73ed8bd499d602bab0fe55608
Author: Yonghong Song <yonghong.song@linux.dev>
Date:   Fri Jul 28 01:12:02 2023 +0000

    bpf: Support new sign-extension mov insns

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17970c5da80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14570c5da80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10570c5da80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")

general protection fault, probably for non-canonical address 0xdffffc0000000f4f: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000007a78-0x0000000000007a7f]
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc2-syzkaller-00619-g25ad10658dc1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:strnchr+0x25/0x80 lib/string.c:403
Code: 00 00 00 00 90 f3 0f 1e fa 53 48 01 fe 48 bb 00 00 00 00 00 fc ff df 48 83 ec 18 eb 28 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <0f> b6 04 18 38 c8 7f 04 84 c0 75 25 0f b6 07 38 d0 74 15 48 83 c7
RSP: 0018:ffffc90000177848 EFLAGS: 00010046
RAX: 0000000000000f4f RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000007a7b RDI: 0000000000007a78
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000007a78
R13: ffffc900001779b0 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005611db5094b8 CR3: 0000000028ef0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_bprintf_prepare+0x127/0x1490 kernel/bpf/helpers.c:823
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0xdb/0x180 kernel/trace/bpf_trace.c:375
 bpf_prog_ebeed182d92b487f+0x38/0x3c
 bpf_dispatcher_nop_func include/linux/bpf.h:1180 [inline]
 __bpf_prog_run include/linux/filter.h:609 [inline]
 bpf_prog_run include/linux/filter.h:616 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2269 [inline]
 bpf_trace_run1+0x148/0x400 kernel/trace/bpf_trace.c:2307
 __bpf_trace_rcu_utilization+0x8e/0xc0 include/trace/events/rcu.h:27
 trace_rcu_utilization+0xcd/0x120 include/trace/events/rcu.h:27
 rcu_note_context_switch+0x6c/0x1ac0 kernel/rcu/tree_plugin.h:318
 __schedule+0x293/0x59f0 kernel/sched/core.c:6610
 schedule_idle+0x5b/0x80 kernel/sched/core.c:6814
 do_idle+0x288/0x3f0 kernel/sched/idle.c:310
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
 secondary_startup_64_no_verify+0x167/0x16b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strnchr+0x25/0x80 lib/string.c:403
Code: 00 00 00 00 90 f3 0f 1e fa 53 48 01 fe 48 bb 00 00 00 00 00 fc ff df 48 83 ec 18 eb 28 48 89 f8 48 89 f9 48 c1 e8 03 83 e1 07 <0f> b6 04 18 38 c8 7f 04 84 c0 75 25 0f b6 07 38 d0 74 15 48 83 c7
RSP: 0018:ffffc90000177848 EFLAGS: 00010046

RAX: 0000000000000f4f RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000007a7b RDI: 0000000000007a78
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000007a78
R13: ffffc900001779b0 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005611db5094b8 CR3: 0000000028ef0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64
   9:	53                   	push   %rbx
   a:	48 01 fe             	add    %rdi,%rsi
   d:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  14:	fc ff df
  17:	48 83 ec 18          	sub    $0x18,%rsp
  1b:	eb 28                	jmp    0x45
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 f9             	mov    %rdi,%rcx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e1 07             	and    $0x7,%ecx
* 2a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping instruction
  2e:	38 c8                	cmp    %cl,%al
  30:	7f 04                	jg     0x36
  32:	84 c0                	test   %al,%al
  34:	75 25                	jne    0x5b
  36:	0f b6 07             	movzbl (%rdi),%eax
  39:	38 d0                	cmp    %dl,%al
  3b:	74 15                	je     0x52
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c7                   	.byte 0xc7


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

