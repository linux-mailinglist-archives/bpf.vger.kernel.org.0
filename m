Return-Path: <bpf+bounces-77298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4FCD6E95
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D106D300119F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDFD327204;
	Mon, 22 Dec 2025 19:02:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8517B418
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430146; cv=none; b=l+EuBidYPYVj0PVJmhUNyLcB7SdjDJzeST5BON6hecuC1rrXLtG4uh9hC1we8kp0qYdexrjg9h3dumQ8nLUlSdew3eZns/ZHaT+BIAhxrKgXCw7o99nY8HxRZBFk3Dp8DRPVBbdAZrlZBTIQJ/QJE1bnUPpXTAVRi2R+S1bKiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430146; c=relaxed/simple;
	bh=lvG7/KC5SdV3rZD1gR4ypoAC7Du/+a94VdGRIiKI2Iw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ML3cx+vm2xt9MeC9c2xhlrOfVZSodahx/dI5ORvGS82gH+V6vn1Hn2m86d+LPsAnivI6Qqch+wFZE66eDryzDDQ6Y70cI/z7c9ChNKH6HYcvr0/PpVlpjFmtBmuJC3uEddY5jrXykQym80xN6MhmPxWY9y+i1fQT8xMli+lD4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c673f5f4b6so10539065a34.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 11:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766430144; x=1767034944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cMOxTqUUgv+8e1Z9FqvuS1Js6UAgEL5Z9Ux+JNrZ+k=;
        b=OVQE0dtQEJEhdxqoImskXs/30u01dCBWFVGwe7lwkQsvndftKDlHDk+SG/Baozx16+
         iVnMozyeIfUxFHuqMgcx+wwTFpD+aTfwLLoO04USyxEeuUKxEMZpn+5yxNDVAl90FbDQ
         EDdeGHJA6V66qDOgBbgA9V+xYhQLLVqGKtth1zuo4+34G20KXhR5O6mvxGNObvk6vrxR
         dlkGqOqlYSJCy0UjY5UaXrqdvt9C3kNHY9P2pKipPqwWXP/K0kb7ZDhicAmXlSKotuqR
         bTW2X+AOWRCb/h6KGvA+VesPXV+UTo4ojzWQLtc4knD9AIKwei5P49DTvRQkYfIX/IEo
         AGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHHQNby9b8fC8+WcZysOCmgxmkb30b4ZRsl1sLbV0VoVHMTtW/aRXxhPcF3Wv4WbwHQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4l36PK2a0s6yrpr5EVakNFxjIImVv/HxMZjM97uB24IjyjyV5
	s9wZV03AXLDMsalMv/zpgkwJyGG2maXRm53Xsx+aeSNbx7NitSogcnfJcJpRZdCi7t7uhoWVErv
	CLiD28oWmII7NXAlTzgTJMk9wTkKvU011cO0wZAzlitg7994ISqcG1d1JSvQ=
X-Google-Smtp-Source: AGHT+IG8xsBpwxKwnuEzoTqUck+mAcaQLOvcJWRggN9Vr/d4tU//JYtoopA2qNRb6K5HMb5FG28mRzDwALIfonSK+6At43SyGXUd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:827:b0:65b:32b4:83e7 with SMTP id
 006d021491bc7-65d0ea341dcmr5150529eaf.19.1766430143807; Mon, 22 Dec 2025
 11:02:23 -0800 (PST)
Date: Mon, 22 Dec 2025 11:02:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694995bf.050a0220.2fb209.01a1.GAE@google.com>
Subject: [syzbot] [bpf?] inconsistent lock state in bpf_lru_push_free
From: syzbot <syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f785a31395d9 bpf: arm64: Fix sparse warnings
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1122d392580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4aa52bacc0658d1
dashboard link: https://syzkaller.appspot.com/bug?extid=c69a0a2c816716f1e0d5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1780f584580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e044cc52f4d/disk-f785a313.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5af05af9fe6f/vmlinux-f785a313.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e8bd1bb41f24/bzImage-f785a313.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
syz.0.17/5989 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffffe8ffffc2f8d8 (&l->lock#2){....}-{2:2}, at: bpf_lru_push_free+0x13e/0x520 kernel/bpf/bpf_lru_list.c:-1
{INITIAL USE} state was registered at:
  lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
  bpf_percpu_lru_pop_free kernel/bpf/bpf_lru_list.c:407 [inline]
  bpf_lru_pop_free+0xcb/0x19b0 kernel/bpf/bpf_lru_list.c:494
  prealloc_lru_pop kernel/bpf/hashtab.c:299 [inline]
  htab_lru_map_update_elem+0x168/0x8a0 kernel/bpf/hashtab.c:1215
  bpf_map_update_value+0x751/0x920 kernel/bpf/syscall.c:294
  generic_map_update_batch+0x5a9/0x810 kernel/bpf/syscall.c:2038
  bpf_map_do_batch+0x39b/0x630 kernel/bpf/syscall.c:5647
  __sys_bpf+0x750/0x8a0 kernel/bpf/syscall.c:-1
  __do_sys_bpf kernel/bpf/syscall.c:6320 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:6318 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6318
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 19654
hardirqs last  enabled at (19653): [<ffffffff8b5b413e>] syscall_enter_from_user_mode include/linux/entry-common.h:108 [inline]
hardirqs last  enabled at (19653): [<ffffffff8b5b413e>] do_syscall_64+0xbe/0xf80 arch/x86/entry/syscall_64.c:90
hardirqs last disabled at (19654): [<ffffffff8b5b8058>] exc_debug_kernel+0x68/0x150 arch/x86/kernel/traps.c:1233
softirqs last  enabled at (19590): [<ffffffff81d3246b>] bpf_prog_load+0x14fb/0x1a10 kernel/bpf/syscall.c:3118
softirqs last disabled at (19588): [<ffffffff81d0e0bd>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (19588): [<ffffffff81d0e0bd>] bpf_ksym_add+0x2d/0x340 kernel/bpf/core.c:640

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&l->lock#2);
  <Interrupt>
    lock(&l->lock#2);

 *** DEADLOCK ***

no locks held by syz.0.17/5989.

stack backtrace:
CPU: 0 UID: 0 PID: 5989 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <#DB>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_usage_bug+0x28b/0x2e0 kernel/locking/lockdep.c:4042
 lock_acquire+0x1f8/0x340 kernel/locking/lockdep.c:5859
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 bpf_lru_push_free+0x13e/0x520 kernel/bpf/bpf_lru_list.c:-1
 htab_lru_push_free kernel/bpf/hashtab.c:1183 [inline]
 htab_lru_map_delete_elem+0x3a3/0x410 kernel/bpf/hashtab.c:1464
 bpf_prog_464bc2be3fc7c272+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_overflow_handler kernel/events/core.c:10303 [inline]
 __perf_event_overflow+0x39c/0xe70 kernel/events/core.c:10402
 perf_swevent_overflow kernel/events/core.c:10536 [inline]
 perf_swevent_event+0x4f8/0x5e0 kernel/events/core.c:10574
 perf_bp_event+0x251/0x300 kernel/events/core.c:11395
 hw_breakpoint_handler arch/x86/kernel/hw_breakpoint.c:556 [inline]
 hw_breakpoint_exceptions_notify+0x244/0x680 arch/x86/kernel/hw_breakpoint.c:587
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 notify_die+0x130/0x180 kernel/notifier.c:588
 notify_debug+0x2e/0x50 arch/x86/kernel/traps.c:1208
 exc_debug_kernel+0xbe/0x150 arch/x86/kernel/traps.c:1270
 asm_exc_debug+0x1e/0x40 arch/x86/include/asm/idtentry.h:654
RIP: 0010:rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:74
Code: 48 04 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 <f3> a4 e9 8f 48 04 00 48 8b 06 48 89 07 48 8d 47 08 48 83 e0 f8 48
RSP: 0018:ffffc90003697cf8 EFLAGS: 00050202
RAX: 00007ffffffff001 RBX: 0000000000000050 RCX: 000000000000000f
RDX: 0000000000000001 RSI: 0000200000000301 RDI: ffffc90003697da1
RBP: ffffc90003697ea8 R08: ffffc90003697daf R09: 1ffff920006d2fb5
R10: dffffc0000000000 R11: fffff520006d2fb6 R12: ffffc90003697d60
R13: 0000000000000050 R14: ffffc90003697d60 R15: 00002000000002c0
 </#DB>
 <TASK>
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:185 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:223 [inline]
 copy_from_bpfptr_offset include/linux/bpfptr.h:53 [inline]
 copy_from_bpfptr include/linux/bpfptr.h:59 [inline]
 __sys_bpf+0x1f2/0x8a0 kernel/bpf/syscall.c:6180
 __do_sys_bpf kernel/bpf/syscall.c:6320 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6318 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6318
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efcc198f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efcc2754038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007efcc1be5fa0 RCX: 00007efcc198f749
RDX: 0000000000000050 RSI: 00002000000002c0 RDI: 000000000000000a
RBP: 00007efcc1a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efcc1be6038 R14: 00007efcc1be5fa0 R15: 00007ffd9db831a8
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 04 00             	rex.W add $0x0,%al
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00
   d:	0f 1f 00             	nopl   (%rax)
  10:	48 8b 06             	mov    (%rsi),%rax
  13:	48 89 07             	mov    %rax,(%rdi)
  16:	48 83 c6 08          	add    $0x8,%rsi
  1a:	48 83 c7 08          	add    $0x8,%rdi
  1e:	83 e9 08             	sub    $0x8,%ecx
  21:	74 db                	je     0xfffffffe
  23:	83 f9 08             	cmp    $0x8,%ecx
  26:	73 e8                	jae    0x10
  28:	eb c5                	jmp    0xffffffef
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	e9 8f 48 04 00       	jmp    0x448c0
  31:	48 8b 06             	mov    (%rsi),%rax
  34:	48 89 07             	mov    %rax,(%rdi)
  37:	48 8d 47 08          	lea    0x8(%rdi),%rax
  3b:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

