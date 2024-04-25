Return-Path: <bpf+bounces-27799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072F8B1D65
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103C61F250E6
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68D84E0B;
	Thu, 25 Apr 2024 09:05:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46884D29
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035934; cv=none; b=o+3lr4UPrJFhXdIhJAbX9PngToy1f9fOwMuCZ32vMk0wTEfiqECiJ5y8sJIe3YWEifILvho5c4W4z2Whfa5Yst7yIZGS8uPzJ2MMZ/P2YbjfviqEOtYHG/Dn3ysNsw6xGhyeMofrmF+NWhMJlQcpuIxNBrGT9XK8RP4VX/VP4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035934; c=relaxed/simple;
	bh=RX+zX8jrmvHf1Z01Ezc1syopSi7zYBJfP5RwzdIbFK8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IY/D0aEghxbMod966cLmhtOlQv+ItYr8aHFNpd2+yQFbgdsf9hzmpH8a4u5t/j+ntLMPzBzFmCKB3u7sb1jcWaV3R7qbOxZCvtcS+ZDOHvitf5LtQxGlIeGEV8LUyqywV1KJcXck/LIKniI3dL6uFTopSk+ir85rfBAkH/iNJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c1c062c1bso7287215ab.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 02:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035931; x=1714640731;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TzcA1tOQMPKCuQfewMj/n825aXvUOXGh9ktRQv3gKc=;
        b=XXM8/5G6b/8IVtMq23bE12+i6OBQ98P9CnYh4xPhyYPSY7UYaqAoVXXnPoo5vZkwzE
         VWCxrtiO45/Tn1747WyxtS1ujw9zO92njjLuA82nJ51xgA5ISOyWv10rc3h76gpAOgRf
         3ZpiwytrtKAk47cpa7IRRk/skyRTWBgCW3SIAPtDOFxajWfaa594xo2+xA9VDivTIY1v
         SgQMGuY382aXRmrx46cjGjfcLPTm7nILBbnL8oXif//w5kSFz+8Nu7bY7SqVbxpGMbyl
         LrbfCExMa/PkIKNb/cEth2e+ucJXRFn5sPYRA3hqOPF2/f0eeFI6qr+lSQXcd0b2VCmm
         3Jgg==
X-Forwarded-Encrypted: i=1; AJvYcCWoxVtsQ1GC2j7obxzLZfY87Q6omnXjRqljsXhz5fWz9bVCjEAdv/rKXjj90PMwV4+gbvzeySh/UGAj7cN55bCX+fRL
X-Gm-Message-State: AOJu0Yw9OkylGcgtlKYvvaOSENlg6pYmXt5WreCW2cwzgYFxgyHv8rNC
	IDBKbNPGU3OJjWt0VCd2dq2vZw7DW0CaOtlNvrTprIGonvK6MpOTgyaD9Z5h8/cGzVamKnia4UY
	/m92Uqek/VupPxVEhts0Zzxhhb6XKMwTBZvAZaCFxW2KG7ImnUIagb+s=
X-Google-Smtp-Source: AGHT+IGtkcV54puVSjIVr9KOB9ef1QeMLhXajVtd1EHCpWIz0na0JZwOP86pPfjf9mnzBXPs9RrBDkGchgAvmrKx10dzQz+j8LWL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:36b:f94f:3022 with SMTP id
 dt11-20020a056e021feb00b0036bf94f3022mr355787ilb.5.1714035931604; Thu, 25 Apr
 2024 02:05:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 02:05:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5f4fc0616e816d4@google.com>
Subject: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
From: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17080d20980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=83e7f982ca045ab4405c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/549d1add1da9/disk-977b1ef5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e8e501c8aa2/vmlinux-977b1ef5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d02f7cb905b8/bzImage-977b1ef5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0 Not tainted
------------------------------------------------------
syz-executor.0/11241 is trying to acquire lock:
ffff888020a2c0d8 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334

but task is already holding lock:
ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
       _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1404 [inline]
       rq_lock_irqsave kernel/sched/sched.h:1683 [inline]
       class_rq_lock_irqsave_constructor kernel/sched/sched.h:1737 [inline]
       sched_mm_cid_exit_signals+0x17b/0x4b0 kernel/sched/core.c:12005
       exit_signals+0x2a1/0x5c0 kernel/signal.c:3016
       do_exit+0x6a8/0x27e0 kernel/exit.c:837
       __do_sys_exit kernel/exit.c:994 [inline]
       __se_sys_exit kernel/exit.c:992 [inline]
       __pfx___ia32_sys_exit+0x0/0x10 kernel/exit.c:992
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sighand->siglock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
       force_sig_fault_to_task kernel/signal.c:1733 [inline]
       force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
       __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       strncpy_from_user+0x2c6/0x2f0 lib/strncpy_from_user.c:138
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
       ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
       bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
       bpf_prog_e42f6260c1b72fb3+0x3d/0x3f
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
       __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2535/0x4a00 kernel/sched/core.c:6743
       preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7068
       irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       force_sig_fault+0x0/0x1d0
       __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_handle_exception+0x0/0x10
       __do_sys_gettimeofday kernel/time/time.c:147 [inline]
       __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140
       emulate_vsyscall+0xe23/0x1290 arch/x86/entry/vsyscall/vsyscall_64.c:247
       do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x160/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       _end+0x6a9da000/0x0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&sighand->siglock);
                               lock(&rq->__lock);
  lock(&sighand->siglock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/11241:
 #0: ffff8880b943e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 11241 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
 force_sig_fault_to_task kernel/signal.c:1733 [inline]
 force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
 __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:do_strncpy_from_user lib/strncpy_from_user.c:72 [inline]
RIP: 0010:strncpy_from_user+0x2c6/0x2f0 lib/strncpy_from_user.c:139
Code: cc cc cc cc e8 ab 95 b6 fc 45 31 ed eb e0 e8 a1 95 b6 fc 49 c7 c5 f2 ff ff ff eb d2 e8 93 95 b6 fc 49 c7 c5 f2 ff ff ff eb c4 <f3> 0f 1e fa e8 81 95 b6 fc eb a1 f3 0f 1e fa e8 76 95 b6 fc 4d 29
RSP: 0018:ffffc90009f9f5e0 EFLAGS: 00050046
RAX: 0000000000000002 RBX: ffff8880795c3584 RCX: ffff8880795c1e00
RDX: ffffc90004bf1000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff84df6a34 R09: ffffffff82056cb7
R10: 0000000000000003 R11: ffff8880795c1e00 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90009f9f6a8 R15: 0000000000000000
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
 bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
 bpf_prog_e42f6260c1b72fb3+0x3d/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
 __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2535/0x4a00 kernel/sched/core.c:6743
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7068
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:force_sig_fault+0x0/0x1d0 kernel/signal.c:1737
Code: 9a 00 e9 31 ff ff ff e8 1e 7e 1a 0a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48
RSP: 0018:ffffc90009f9fb78 EFLAGS: 00000286
RAX: ffffffff8141f9d7 RBX: 0000000000000000 RCX: 0000000000040000
RDX: 0000000000000019 RSI: 0000000000000001 RDI: 000000000000000b
RBP: ffffc90009f9fc78 R08: ffffffff8141f976 R09: ffffffff81423712
R10: 0000000000000014 R11: ffff8880795c1e00 R12: dffffc0000000000
R13: ffffc90009f9fd70 R14: 1ffff920013f3fae R15: 0000000000000002
 __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_handle_exception+0x0/0x10 arch/x86/lib/putuser.S:125
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 01 cb 48 89 01 31 c9 0f 01 ca c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 <0f> 01 ca b9 f2 ff ff ff c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90
RSP: 0018:ffffc90009f9fd98 EFLAGS: 00050202
RAX: 000000006624d6a7 RBX: 0000000000000000 RCX: 0000000000000019
RDX: 0000000000000000 RSI: ffffffff8bcaca20 RDI: ffffffff8c1eb160
RBP: ffffc90009f9fe50 R08: ffffffff8fa7b6af R09: 1ffffffff1f4f6d5
R10: dffffc0000000000 R11: fffffbfff1f4f6d6 R12: ffffc90009f9fde0
R13: dffffc0000000000 R14: 1ffff920013f3fb8 R15: 0000000000000019
 __do_sys_gettimeofday kernel/time/time.c:147 [inline]
 __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140
 emulate_vsyscall+0xe23/0x1290 arch/x86/entry/vsyscall/vsyscall_64.c:247
 do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x160/0x8e0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:_end+0x6a9da000/0x0
Code: Unable to access opcode bytes at 0xffffffffff5fffd6.
RSP: 002b:00007f9364a35b38 EFLAGS: 00010246
RAX: ffffffffffffffda RBX: 00007f9363dabf80 RCX: 00007f9363c7dea9
RDX: 00007f9364a35b40 RSI: 00007f9364a35c70 RDI: 0000000000000019
RBP: 00007f9363cca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9363dabf80 R15: 00007ffc4b734e88
 </TASK>
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	e8 ab 95 b6 fc       	call   0xfcb695b4
   9:	45 31 ed             	xor    %r13d,%r13d
   c:	eb e0                	jmp    0xffffffee
   e:	e8 a1 95 b6 fc       	call   0xfcb695b4
  13:	49 c7 c5 f2 ff ff ff 	mov    $0xfffffffffffffff2,%r13
  1a:	eb d2                	jmp    0xffffffee
  1c:	e8 93 95 b6 fc       	call   0xfcb695b4
  21:	49 c7 c5 f2 ff ff ff 	mov    $0xfffffffffffffff2,%r13
  28:	eb c4                	jmp    0xffffffee
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	e8 81 95 b6 fc       	call   0xfcb695b4
  33:	eb a1                	jmp    0xffffffd6
  35:	f3 0f 1e fa          	endbr64
  39:	e8 76 95 b6 fc       	call   0xfcb695b4
  3e:	4d                   	rex.WRB
  3f:	29                   	.byte 0x29


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

