Return-Path: <bpf+bounces-66415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A30BB34909
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEE5188778E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1913019D4;
	Mon, 25 Aug 2025 17:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE81D6187
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143574; cv=none; b=aEZfI0vHsDcFjbmhKuV9meWKSTW54D+OJjRNQrMrn4vDDNWndTjycDRhuvyX3lTlfh0/DRnZc48OgzI7OJorYxOz4uVzeNthmAXvwVw1d+9HyDnFNDy0u1ZovnCN+wQbSRTrlCZZLKADNWo5jBCHoC3qnOBB7t76vEgyxL/gx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143574; c=relaxed/simple;
	bh=bMgUecEUwmuQ5iHcGsGcqiKcMRsbdbPMZOdOnzKFEHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AzAeyUDo21Qww6DslV3K0Ewdj/6lQElxW9JR8PHV1s0qPuNThaDuMl7tOE6RGCc/ENA00h8bmhYmbI/zvQj5k10e875oAukdAFwVGkAtkP0I7CGn96QhxYBkFbui9levRerwF2+XJknPXTG8UlQZRdFS0TJdkNkB9lCHvWuEYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e6754b0ec1so133556955ab.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 10:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143571; x=1756748371;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoKRMllrU2xAaVReY0OXakrcbaoMzAgMTduUHxr6ves=;
        b=Ooqj+tzeG3XiTG6tyBXR+i4lp6Ta45ProfNcH6FCobGGmqy2Qmc5WE9KAoJvV3BMUB
         3hyNkdLdSNXzVxV8qAuurH71VMci2yB1H6KCNBgE01xtNSNMNpg9GXinzHfjhPGYT7Pe
         TjeGYlMX30kqzvCNMMAOJKqE1bt/eTjGGuEQ2c2tgOhNJuXLIP6KpQL6ZykpxM/Y59oO
         8164XIKOPC9E5YjUaTFnd3FqRN4Lh4GCvyNtIrmAxoM5tQVcu3nFJ0FRc7Apxmo0+pXl
         0tYoab3pz4ELIVILOefNM14ZfENHgDLFXMl2TvtBEHO9y8MoWgFnIr0MtSYyyHpPkRLY
         kV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhRHUhlJX97hX7+qEJelqXMKSoKDwWhMwIDNyqyQkJ13GKl9Y65JDpXoOrhSSkp8aU/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmO2rfpvOWch4SEPiTsyW5wf6dy+jjxNK8lGYroRjjKQF1BCxl
	ntF89QjBjXwwqgAIRDvTsx761VxLGYUL4mXwxNX8udViFY1SJ8IFHVAcVYupDwa6YxmnBMvQBTK
	JX2WVlhNdB0lg8oj3Zt9a2R3h0WpkXuXbtmOJ7XT64eXLZj6nnaBBH5Q+05s=
X-Google-Smtp-Source: AGHT+IHmCiGOEVGHGc2l2cwdhQN21F/LwlGC4TSPDlo5vcFOx/rJOlQ1oJynS4KKwWCv9rXb3U/EpMATPGjfOJ8DGFHnGHOO+gNt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:3e6:7df0:ec19 with SMTP id
 e9e14a558f8ab-3e9201f40afmr27100605ab.8.1756143571501; Mon, 25 Aug 2025
 10:39:31 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
From: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd9de524183a xsk: Fix immature cq descriptor production
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=102da862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a3389c1558f/disk-dd9de524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c97133192a27/vmlinux-dd9de524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ae5a1a88637/bzImage-dd9de524.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz-execprog/5866 is trying to acquire lock:
ffffc900048c10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423

but task is already holding lock:
ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rb->spinlock);
  lock(&rb->spinlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-execprog/5866:
 #0: ffff88807e021588 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0x19f/0x3d0 mm/mmap_lock.c:147
 #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: ___pte_offset_map+0x29/0x250 mm/pgtable-generic.c:286
 #2: ffff8880787b60d8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff8880787b60d8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x13e/0x210 mm/pgtable-generic.c:401
 #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2256 [inline]
 #3: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2298
 #4: ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
 #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #5: ffffffff8e139ea0 (rcu_read_lock){....}-{1:3}, at: trace_call_bpf+0xb7/0x850 kernel/trace/bpf_trace.c:-1

stack backtrace:
CPU: 1 UID: 0 PID: 5866 Comm: syz-execprog Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
 ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
 bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:466
 bpf_prog_df2ea1bb7efca089+0x36/0x54
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_prog_run_array include/linux/bpf.h:2292 [inline]
 trace_call_bpf+0x326/0x850 kernel/trace/bpf_trace.c:146
 perf_trace_run_bpf_submit+0x78/0x170 kernel/events/core.c:10911
 do_perf_trace_contention_end include/trace/events/lock.h:122 [inline]
 perf_trace_contention_end+0x253/0x2f0 include/trace/events/lock.h:122
 __do_trace_contention_end include/trace/events/lock.h:122 [inline]
 trace_contention_end+0x111/0x140 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x9f9/0xb60 kernel/locking/qspinlock.c:374
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:557 [inline]
 queued_spin_lock_slowpath+0x43/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x21f/0x290 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xb3/0xf0 kernel/locking/spinlock.c:162
 __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
 ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:474 [inline]
 bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:466
 bpf_prog_6979e45824a16319+0x36/0x66
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
 __bpf_trace_tlb_flush+0xf5/0x150 include/trace/events/tlb.h:38
 __traceiter_tlb_flush+0x76/0xd0 include/trace/events/tlb.h:38
 __do_trace_tlb_flush include/trace/events/tlb.h:38 [inline]
 trace_tlb_flush+0x115/0x140 include/trace/events/tlb.h:38
 native_flush_tlb_multi+0x78/0x140 arch/x86/mm/tlb.c:-1
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x6b1/0x12d0 arch/x86/mm/tlb.c:1451
 flush_tlb_page arch/x86/include/asm/tlbflush.h:324 [inline]
 ptep_clear_flush+0x120/0x170 mm/pgtable-generic.c:101
 wp_page_copy mm/memory.c:3618 [inline]
 do_wp_page+0x1bc2/0x5800 mm/memory.c:4013
 handle_pte_fault mm/memory.c:6068 [inline]
 __handle_mm_fault+0x1033/0x5440 mm/memory.c:6195
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x410964
Code: b9 01 00 00 00 90 e8 3b 36 06 00 84 00 48 8d 50 10 83 3d be 5f d9 02 00 74 10 e8 87 d9 06 00 49 89 13 48 8b 48 10 49 89 4b 08 <48> 89 50 10 48 89 c1 48 8b 54 24 20 48 8b 1a 66 89 59 18 83 3d 92
RSP: 002b:000000c0000e7608 EFLAGS: 00010246
RAX: 000000c0080e0000 RBX: 0000000000000070 RCX: 0000000007b2a8a0
RDX: 000000c0080e0010 RSI: 000000000b1130e1 RDI: 0000000009e14d67
RBP: 000000c0000e7638 R08: 00007f16e8ad96e0 R09: 7fffffffffffffff
R10: 0000000000000001 R11: 00007f16e8a2e000 R12: 000000c0080e0000
R13: 0000000000000049 R14: 000000c0026156c0 R15: 000000c0080c1c20
 </TASK>


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

