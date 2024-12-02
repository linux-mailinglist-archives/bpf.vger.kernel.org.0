Return-Path: <bpf+bounces-45923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94D9DFE8E
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 11:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2177163C97
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA51FCFC2;
	Mon,  2 Dec 2024 10:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E81FBEB3
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134472; cv=none; b=CLLweGC7+68Fs+2e4lTFrL9NVmjWLiFIfe7nMa20780FzmnPvL1uT+O3fgsKc711p+7AXpNFErux3JQMdlf83E2gS3ZAT4X6gK7tja4fThjO4BnhS0bqxmAW9qX65bjRXp5FRvM+em5GRFSSdsf2Zpj+K1b0uQn5CNG2EMH1Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134472; c=relaxed/simple;
	bh=tHFUdCqsMGkg322I+g4Sl3AKyQEATnxh07xEPs9CRlU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W7eCNlfxxwfSToAN923qWsvBiJ9mDqLfntCd3BK6Eh5EZmLh1rGVrMBh6cAQWPXq/6L39BlSsCs3CMmnCQRfo9pOtPDzQeuSXXewJiOkLbt/lGdA23QcZqmlp7JtBfD9r1INDOehOY4Mh3+pqdpYSJdJU4hlgKUkF4QKC096wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a77fad574cso35839165ab.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 02:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134469; x=1733739269;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p47V1VHANSclYmrUqc/dOa+k1UPLy90lRLdbDjNFoQA=;
        b=viLdvxgyndy3/1lfS2r0mE3LYH47rOCENtJU83/bgYZt7D9EjxFNd7dDJerw4ITGSA
         8CY3o3gvtECw5qbp+heLc+jeRL3AZzwlFelBnXhfLncrLaVMSeuWsQCoFHsyoLqPzWNF
         P5gF81c8568nJexWJ6vJwH87nid84Yko1VtUCONf4xN/Be5SpIxECpwIgf/uxcBo5u0J
         AV2SN++1MMr/0JH7M1JVoRWDK0gUrejyu5tj2MNluDJ40lknliRi0kJOTnvKjWtKzPfn
         CZoxkxm7sQcwV2j+XzYU56jfRniRGFBPQID45j7EIn971dxKzb/aQQb18ogeTjijvZY3
         DPlg==
X-Forwarded-Encrypted: i=1; AJvYcCVzJXd0OuB4aX0MGkH9i3rgnHP237BPBxJoELx9qOS7M2mG1ZyrUgBG6pFCHQ2maJQ9/zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUW4DxtoxDiv/2FLRxboYBmxxgKLtC4loK0+5k/JN2PKdXg3p
	uxaBNQ+MLzyvTFF3/qVz5I1pqd59PMYfQk9rRDAWruW74KqAZP9OWXEarYfK0mvwnNJCF4x7X8D
	GBuuHllUpvoaYLsoGoiePMomP/o1xvYuEZNqGTd+VwjZiJspVsYVzbHQ=
X-Google-Smtp-Source: AGHT+IHTHErrhRpgfZs8MSHh3jjs2tm56HSyOGzMC3El1nvZN9l0REftjS2coA2GIQbra6PS6+YVky2nxMgc5bew3867f389l8G0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c88:b0:3a7:7ded:5219 with SMTP id
 e9e14a558f8ab-3a7c55eb94emr227256685ab.21.1733134465858; Mon, 02 Dec 2024
 02:14:25 -0800 (PST)
Date: Mon, 02 Dec 2024 02:14:25 -0800
In-Reply-To: <67486b09.050a0220.253251.0084.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d8881.050a0220.ad585.004a.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
From: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, puranjay@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    45e04eb4d9d8 bpf: Refactor bpf_tracing_func_proto() and re..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=167e17c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=97da3d7e0112d59971de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114a7d30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1395ff78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f45e1a59de79/disk-45e04eb4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e2405d2c818/vmlinux-45e04eb4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c2415798034/bzImage-45e04eb4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-syzkaller-g45e04eb4d9d8 #0 Not tainted
-----------------------------
syz-executor227/5855 is trying to lock:
ffff8880262a8018 (&sighand->siglock){-...}-{3:3}, at: __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1379
other info that might help us debug this:
context-{5:5}
8 locks held by syz-executor227/5855:
 #0: ffff88802f97ea90 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_read include/linux/mm.h:716 [inline]
 #0: ffff88802f97ea90 (&vma->vm_lock->lock){++++}-{4:4}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6278
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: do_fault_around mm/memory.c:5279 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: do_read_fault mm/memory.c:5313 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: do_fault mm/memory.c:5456 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: do_pte_missing mm/memory.c:3979 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: handle_pte_fault+0x21c3/0x68a0 mm/memory.c:5801
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: filemap_map_pages+0x243/0x20d0 mm/filemap.c:3645
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x82/0x380 mm/pgtable-generic.c:287
 #4: ffff8880791b2df8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff8880791b2df8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x1ba/0x300 mm/pgtable-generic.c:402
 #5: ffffffff8e93c4a0 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #5: ffffffff8e93c4a0 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:941 [inline]
 #5: ffffffff8e93c4a0 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xf6/0x450 include/linux/mmzone.h:2048
 #6: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: trace_call_bpf+0xbc/0x8a0
 #7: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #7: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #7: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __lock_task_sighand+0x29/0x2d0 kernel/signal.c:1362
stack backtrace:
CPU: 0 UID: 0 PID: 5855 Comm: syz-executor227 Not tainted 6.12.0-syzkaller-g45e04eb4d9d8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1379
 lock_task_sighand include/linux/sched/signal.h:743 [inline]
 do_send_sig_info kernel/signal.c:1267 [inline]
 group_send_sig_info+0x274/0x310 kernel/signal.c:1418
 bpf_send_signal_common+0x3c4/0x630 kernel/trace/bpf_trace.c:870
 ____bpf_send_signal_thread kernel/trace/bpf_trace.c:887 [inline]
 bpf_send_signal_thread+0x1a/0x30 kernel/trace/bpf_trace.c:885
 bpf_prog_b7be628660dc1b90+0x23/0x29
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_prog_run_array include/linux/bpf.h:2177 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:146
 perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10473
 do_perf_trace_lock include/trace/events/lock.h:50 [inline]
 perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9cc/0xa30 kernel/locking/lockdep.c:5860
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:962 [inline]
 pfn_valid+0x3eb/0x450 include/linux/mmzone.h:2058
 page_table_check_set+0x22/0x540 mm/page_table_check.c:110
 __page_table_check_ptes_set+0x30f/0x410 mm/page_table_check.c:225
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 set_ptes include/linux/pgtable.h:288 [inline]
 set_pte_range+0x724/0x750 mm/memory.c:5067
 filemap_map_order0_folio mm/filemap.c:3624 [inline]
 filemap_map_pages+0x11c6/0x20d0 mm/filemap.c:3678
 do_fault_around mm/memory.c:5280 [inline]
 do_read_fault mm/memory.c:5313 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault+0x31d6/0x68a0 mm/memory.c:5801
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f2c735865f8
Code: Unable to access opcode bytes at 0x7f2c735865ce.
RSP: 002b:00007ffcc6892fb8 EFLAGS: 00010202
RAX: 00007f2c735b6ad8 RBX: 0000000000000000 RCX: 0000000000000004
RDX: 00007f2c735b7ce0 RSI: 0000000000000000 RDI: 00007f2c735b6ad8
RBP: 00007f2c735b5118 R08: 00007f2c7350e2b0 R09: 00007f2c7350e2b0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2c735b7cc8
R13: 0000000000000000 R14: 00007f2c735b7ce0 R15: 00007f2c7350e590
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

