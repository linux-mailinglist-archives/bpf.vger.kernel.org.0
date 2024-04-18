Return-Path: <bpf+bounces-27165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D36D8AA3B0
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D99B29EBD
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8269D18133F;
	Thu, 18 Apr 2024 20:00:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6051802A1
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713470431; cv=none; b=C+b/m9lSCS9KUciXSCQdIq2Jx/2JgMZLUMW8bQ+oCXX3tKRMMYaxNF24f7TobleGVj6LPWdFiGouEjZLlK9D+/c37CgswUj3aWm/zMODlo4I3zB052SjYGra3Nak1JjIaRwfJi2g0Qv6db0hpkWzKi07lNiFt8iP0/IOFs2J6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713470431; c=relaxed/simple;
	bh=ySCKXj6c+3614/kDHxqx/25WYz77e4ES1LSGaIfup3A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rRA30XbPUL98GwF7yvvp6B9q8SIH//MegdaIwQ+9Sf2A1DQOx8f32AciaNkR2X6r/Ht5IXnysn6LFXGEsUTLN2etlTAyrc9LIqNJPgvik2LZxMQzL87Q/xZ3h/jRHvck9j4TBl1tzeaJgme6sM79ozdSvTDL3UUJhsy86Qmjg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so171474639f.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 13:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713470429; x=1714075229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvCAvI2t36jvI9ciusgvIvLSXfRKhzbxpMLYmWITJdw=;
        b=flzOdaSIhaKfw4nyqrf9QHkeAX2psM01BWPdXW2Yrg0jR9/8h0thAF09TzF6KvM1aU
         jtbIxdqNvsJZQoyxCwjatWQPIfQ6LWvKwCZ3M3weOZar0lW8SyPmMYHwIyHN27nBpt0K
         EmBc1MIXEjF6P45xYLVEO4SIrVjkaxhYKDREltJtWoBjivI/fsvKILW9Itx2lKyOXU+X
         lgjLpxQYbI/shywkD6Aq+YN9UCLNv2z92CDAhP60afg50anEqx29fDIL8LT6uab0KauU
         foqzI2a3GhQ07m/hQhQMx3l5KC+lIjA5SnsJrIkxLsJYJ8mrZJk86tYQ5/VQ7qhdNanG
         rsWg==
X-Forwarded-Encrypted: i=1; AJvYcCUSkcX1mYXB+k/Zz6esN8O4cT59mMpxBysaXIdt/qw85+5aUcMzZcWQM055HIDA5O03RclJz3dD8N0yn9lWIX7XxbtS
X-Gm-Message-State: AOJu0YxXYAjDNAhs+RBAIWcc/srlN5MP6cgS8D2oDegn6ZKrHkSX9x9x
	8R3tpScVYbxi/5oCGZkXh09EIIRLml3vxBR9Lx4qhqT6zzji3/z+FaRrtGP1N+AGjePjl7u6KkL
	Gdsdv16gUEqnhAI+dc0LCTBxmWzj6K/n5PSYD8O05N8C83UwwpsKV7EI=
X-Google-Smtp-Source: AGHT+IGk+XtOKy4Po7IaRVWu88agNqIiebP1iXGQ/Btezc2IjMMqNUq1N7cDNgJ3owAris5vDFSgf7YXJEIgD75wZvzo0+FRfgdJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164b:b0:482:e69d:b0c6 with SMTP id
 a11-20020a056638164b00b00482e69db0c6mr232411jat.6.1713470428901; Thu, 18 Apr
 2024 13:00:28 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:00:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f81750616646cb8@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __stack_map_get
From: syzbot <syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d7c52b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10869857180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1f7cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
--------------------------------------------
syz-executor224/5098 is trying to acquire lock:
ffff888021ef61d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x14b/0x4b0 kernel/bpf/queue_stack_maps.c:140

but task is already holding lock:
ffff888021ef51d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x14b/0x4b0 kernel/bpf/queue_stack_maps.c:140

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qs->lock);
  lock(&qs->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor224/5098:
 #0: ffffffff8e200c68 (pcpu_alloc_mutex){+.+.}-{3:3}, at: pcpu_alloc+0x27b/0x1670 mm/percpu.c:1769
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #2: ffff888021ef51d8 (&qs->lock){-.-.}-{2:2}, at: __stack_map_get+0x14b/0x4b0 kernel/bpf/queue_stack_maps.c:140
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 5098 Comm: syz-executor224 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __stack_map_get+0x14b/0x4b0 kernel/bpf/queue_stack_maps.c:140
 bpf_prog_7a16b54e5ee857f9+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 __stack_map_get+0x14b/0x4b0 kernel/bpf/queue_stack_maps.c:140
 bpf_prog_7a16b54e5ee857f9+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
 pcpu_alloc+0x27b/0x1670 mm/percpu.c:1769
 bpf_prog_alloc_no_stats+0x10b/0x4a0 kernel/bpf/core.c:112
 bpf_prog_alloc+0x3b/0x1b0 kernel/bpf/core.c:144
 bpf_prog_load+0x7f7/0x20f0 kernel/bpf/syscall.c:2805
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fb8f4667f69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6855faf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb8f4667f69
RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

