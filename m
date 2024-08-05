Return-Path: <bpf+bounces-36370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0C94790D
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1811C20BE5
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E281547DB;
	Mon,  5 Aug 2024 10:05:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401714F9D4
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852323; cv=none; b=k+Fm3g6Cd8GeoTGVV+WYSpPN3UBM8BGskCduc4ZU5fwUQ9F7WRbaZkqlcyQC18Fa0PstSPNQgo27b5dvz7fni8bxGSqPPYv/szYs8UwNQO2XggFO8I6zA+4aHAhLzovbJaSbO7VxDYIfdGRwpJJMxKs4ZMV9JWGrVdUX7A6LlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852323; c=relaxed/simple;
	bh=/h5oeIlQcFSn0/XuPr8gitbBNNHWqeYuri2lo6u9g1s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gjE8mja0jlaaU+VnhP//o9R1myNxnsUgX+rYlzMyObBYNFn3X7B9o1YOlhD+Mw77DwWWQ/zwwB23g/o3a6a9k3bfWAPZhQe1g8Ex6Gw4SAl+qiHi22bfqJQknrzS97TyPd05SW3RuLPvGPQPypXlQrU3O0dXHB+NV0jKD4eCyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8edd7370so1506827839f.1
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852320; x=1723457120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDZy3P0o1+HtnAWWTRk6Epce0wSWs9IuG0kry7BEyeg=;
        b=XJM8Fjexi8q2MyxG96OWiK0Y07nvC1WoTkiUN8BLJ0VZwpsgINxogQ7C2Qn1tgj5Ox
         3IScAG4jx4ZUSl0NOVwe2nqVpyBUjJlp+VczUyjoD3DOZRcSSQeoSJRtomrB6AjEWGde
         XPRJyMPyvOg6VQ4KDOZH6ELzSwE77kZtH93/gw+dvlE08aoDkWG7URuF8Rk8it+TMkzh
         UCtcF52dX8kd30DJyjy7xH3dp8XYC0VLaF1BnmH9rkPGpVT5qGpWIKv6BpM4QuNkDFgR
         xjfaAZfeYWcCN03BHbjhFpBOA2brXStAuDXIgkSuyFk0FixjGj9T7Jtyn+w9hrQogSqh
         Zh2A==
X-Forwarded-Encrypted: i=1; AJvYcCWaRIZjyotO3CefV3EzVQafysKFh5TjhQepZEGH0Kg+l84DX+cd5JfmY5yg6XOp3ZpfEpJZnymL8LszkMuemURRpB83
X-Gm-Message-State: AOJu0Yyk46sFMvh7hR4Tpuk9qY1dwaZJAVOy2AxxLtW5GZuHB6zVkm3s
	iuznIG1Zn6aOFXkjLkILEMJRbN2bt/rH+1joANvczaE+UAro4d80qkEhKOaAK1vSCq7Y/0pVwlF
	JH7bO21Jumk9aUf3vUJlyF8G2cmfMHV4d14/P+p/Xwag++qfSBZtULig=
X-Google-Smtp-Source: AGHT+IG04J0lj9ssNagQfGF2Q5+s+NkiqerV+4ZugZs2xk44U2bbJwEuPTALitfPhMfKWo1GGyrxH89WbjjM1CQ2khw7zgY1uJxb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a1:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4c8d560a200mr712218173.2.1722852320610; Mon, 05 Aug 2024
 03:05:20 -0700 (PDT)
Date: Mon, 05 Aug 2024 03:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000921c0b061eecd080@google.com>
Subject: [syzbot] [bpf?] possible deadlock in htab_lock_bucket (2)
From: syzbot <syzbot+ee7551b0640c5471e610@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d650ab5e7d9 selftests/bpf: Fix a btf_dump selftest failure
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1628e483980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ee7551b0640c5471e610
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117de4e5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142e86bd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/630e210de8d9/disk-3d650ab5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3576ca35748a/vmlinux-3d650ab5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b33f099abfa/bzImage-3d650ab5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee7551b0640c5471e610@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-12666-g3d650ab5e7d9 #0 Not tainted
------------------------------------------------------
strace-static-x/5224 is trying to acquire lock:
ffff888024c4e218 (&htab->lockdep_key){....}-{2:2}, at: htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167

but task is already holding lock:
ffff888023c33188 (&htab->lockdep_key#3){....}-{2:2}, at: htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->lockdep_key#3){....}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
       htab_lru_map_delete_elem+0x1f1/0x700 kernel/bpf/hashtab.c:1462
       bpf_prog_6f5f05285f674219+0x43/0x4c
       bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
       __traceiter_contention_begin+0x7b/0xb0 include/trace/events/lock.h:95
       trace_contention_begin+0x117/0x140 include/trace/events/lock.h:95
       __pv_queued_spin_lock_slowpath+0x114/0xdc0 kernel/locking/qspinlock.c:402
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
       htab_lru_map_delete_elem+0x1f1/0x700 kernel/bpf/hashtab.c:1462
       0xffffffffa000204b
       bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
       __traceiter_contention_begin+0x7b/0xb0 include/trace/events/lock.h:95
       trace_contention_begin+0xf5/0x120 include/trace/events/lock.h:95
       __mutex_lock_common kernel/locking/mutex.c:610 [inline]
       __mutex_lock+0x147/0xd70 kernel/locking/mutex.c:752
       pipe_read+0x12a/0x13e0 fs/pipe.c:264
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x9bd/0xbc0 fs/read_write.c:476
       ksys_read+0x1a0/0x2c0 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&htab->lockdep_key){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
       htab_lru_map_delete_elem+0x1f1/0x700 kernel/bpf/hashtab.c:1462
       0xffffffffa000204b
       bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
       __traceiter_contention_begin+0x7b/0xb0 include/trace/events/lock.h:95
       trace_contention_begin+0x117/0x140 include/trace/events/lock.h:95
       __pv_queued_spin_lock_slowpath+0x114/0xdc0 kernel/locking/qspinlock.c:402
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
       htab_lru_map_delete_elem+0x1f1/0x700 kernel/bpf/hashtab.c:1462
       bpf_prog_6f5f05285f674219+0x43/0x4c
       bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2447
       __traceiter_contention_begin+0x7b/0xb0 include/trace/events/lock.h:95
       trace_contention_begin+0xf5/0x120 include/trace/events/lock.h:95
       __mutex_lock_common kernel/locking/mutex.c:610 [inline]
       __mutex_lock+0x147/0xd70 kernel/locking/mutex.c:752
       pipe_write+0x1c9/0x1a40 fs/pipe.c:455
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->lockdep_key#3);
                               lock(&htab->lockdep_key);
                               lock(&htab->lockdep_key#3);
  lock(&htab->lockdep_key);

 *** DEADLOCK ***

4 locks held by strace-static-x/5224:
 #0: ffff88802c11bc68 (&pipe->mutex){+.+.}-{3:3}, at: pipe_write+0x1c9/0x1a40 fs/pipe.c:455
 #1: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #1: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #1: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
 #1: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2447
 #2: ffff888023c33188 (&htab->lockdep_key#3){....}-{2:2}, at: htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
 #3: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #3: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #3: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
 #3: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2447

stack backtrace:
CPU: 0 UID: 0 PID: 5224 Comm: strace-static-x Not tainted 6.10.0-syzkaller-12666-g3d650ab5e7d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
 htab_lru_map_delete_elem+0x1f1/0x700 kernel/bpf/hashtab.c:1462
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

