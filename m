Return-Path: <bpf+bounces-39629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E4975752
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42125286A98
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28621AB6C4;
	Wed, 11 Sep 2024 15:38:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F541A3AB8
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069108; cv=none; b=GeBH6L5pNvMSArZpEwrb57EvwldjFqePQn58RCK8N+5aVJ1Qv1tFgb7BXyZ0C+sY2kDaeI5i85Er0KvsAfRjKIwrdZOPgKJNwF0y7OvBm7ppnCman4xmVPZyCYrmtkPCXKRpfEbCEvEQOecpEmRviy3zRgqTumAm0a/26y/ukJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069108; c=relaxed/simple;
	bh=vf4YJfMQhvB2k4jeP+7ZET85oaca2FO35oaOeHIQw/g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fKh+iYcdHr1zXngmT6+zuzP/ek7JYyuH/U1rcyfQ/j36I2a43sZc+gwoGCgAzru4fvh+ZnLUpZRPFl6mohhZ9gCe0MwOpaozCwSeL4obcNEZ9GJ+Zb/5CyTOvTm9ywI54+dHRKxjMRvygYM8Xy2Rzd5irXwWQZLelcKu8xk9uJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a043f8e2abso36595045ab.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 08:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069106; x=1726673906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgblRGyb3jy/wNNwrBc0K4CXPl0ML7ihIOLfDamaJdA=;
        b=oLaN4H8E3zjbKXwjjLbyYcV7pAgFVVCGV5q3MSGdw6b6UMxbRQZBKI+JUAg05ML6zt
         /NrTjZAK5IO9F8hUVWLAhjXsk5EmILTUMoJQ9S517x4AYpbPgjLGMPUjVHlV8Fj0B1Yw
         BrZovUuiI/kReCVCOcWQdmd5Mc1Lcl3VVdXplivZYTQh9C0XZFAnbRWP69fcygSqWaCH
         SUXl8cntaXXR0HbkF3SqBjAQTqANTdRgf/4h0TzKIt/1HbYhZAFxIT84ME8HhCScVsxa
         Hq+1Dr53Tow/CzT301IFg/WSi6sNaslZnmXIS/A4GihW8S1aoYuCLn0Sp1dWRZLq+Vo5
         is3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFXEAqoXhVHlu2rSfc8mtSyiEHuQ+HyVIC/2Wb4EW/bkjBOPLNqCHigVU/2wo9ti+nj78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cQMske7mvh4VV3F2wo94g6PIzmL5Op7beB2YHcaFFTQ5gJVH
	mNGDflWnLDN9c58Qoan5DbqsZ4wRi6Nj4kazfq+0H4cQGaJ3QBOnf3Bt3dTeah2lVPcCnBnl4vi
	R9JgNhaCRlSpb7yFQQx15LPktskJEYy8pGvI8x8a544mGM4s/QV2d1Fk=
X-Google-Smtp-Source: AGHT+IE7z8blM6voJmDWRd38Y1GnOzFLBqSmyni9oUlhVRTV9mlYugPW3JdVW++DjJle/Wqbk4NQZ8A78q6As8VNMHYcMX8je359
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1647:b0:3a0:4382:233b with SMTP id
 e9e14a558f8ab-3a0742af9e7mr39969885ab.23.1726069105734; Wed, 11 Sep 2024
 08:38:25 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7ca170621d9c775@google.com>
Subject: [syzbot] [bpf?] possible deadlock in htab_map_delete_elem
From: syzbot <syzbot+26bfd0c1cea0b221a4bf@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121a189f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=26bfd0c1cea0b221a4bf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c2bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5ba00580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b31c4492.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f518d8293660/vmlinux-b31c4492.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d06107105268/bzImage-b31c4492.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26bfd0c1cea0b221a4bf@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00308-gb31c44928842 #0 Not tainted
------------------------------------------------------
syz-executor169/5356 is trying to acquire lock:
ffff888035409940 (&htab->lockdep_key#4){-.-.}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
ffff888035409940 (&htab->lockdep_key#4){-.-.}-{2:2}, at: htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426

but task is already holding lock:
ffff888035408820 (&htab->lockdep_key#2){-.-.}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
ffff888035408820 (&htab->lockdep_key#2){-.-.}-{2:2}, at: htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->lockdep_key#2){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
       bpf_prog_1a158c95e143a564+0x45/0x4e
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
       __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
       __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
       trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0x27e/0xc90 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
       bpf_prog_1a158c95e143a564+0x45/0x4e
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
       __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
       __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
       trace_contention_end+0xce/0x140 include/trace/events/lock.h:122
       __mutex_lock_common kernel/locking/mutex.c:617 [inline]
       __mutex_lock+0x19c/0x9c0 kernel/locking/mutex.c:752
       put_rng+0x1a/0xe0 drivers/char/hw_random/core.c:141
       rng_dev_read+0x22d/0x720 drivers/char/hw_random/core.c:248
       do_loop_readv_writev fs/read_write.c:761 [inline]
       do_loop_readv_writev fs/read_write.c:749 [inline]
       vfs_readv+0x6cb/0x8a0 fs/read_write.c:934
       do_preadv fs/read_write.c:1049 [inline]
       __do_sys_preadv fs/read_write.c:1099 [inline]
       __se_sys_preadv fs/read_write.c:1094 [inline]
       __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1094
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&htab->lockdep_key#4){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
       bpf_prog_1a158c95e143a564+0x45/0x4e
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
       __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
       __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
       trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0x27e/0xc90 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
       htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
       bpf_prog_1a158c95e143a564+0x45/0x4e
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
       __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
       __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
       trace_contention_end+0xce/0x140 include/trace/events/lock.h:122
       __mutex_lock_common kernel/locking/mutex.c:727 [inline]
       __mutex_lock+0x281/0x9c0 kernel/locking/mutex.c:752
       rng_dev_read+0x128/0x720 drivers/char/hw_random/core.c:218
       do_loop_readv_writev fs/read_write.c:761 [inline]
       do_loop_readv_writev fs/read_write.c:749 [inline]
       vfs_readv+0x6cb/0x8a0 fs/read_write.c:934
       do_preadv fs/read_write.c:1049 [inline]
       __do_sys_preadv fs/read_write.c:1099 [inline]
       __se_sys_preadv fs/read_write.c:1094 [inline]
       __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1094
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->lockdep_key#2);
                               lock(&htab->lockdep_key#4);
                               lock(&htab->lockdep_key#2);
  lock(&htab->lockdep_key#4);

 *** DEADLOCK ***

5 locks held by syz-executor169/5356:
 #0: ffffffff8e9fb728 (reading_mutex){+.+.}-{3:3}, at: rng_dev_read+0x128/0x720 drivers/char/hw_random/core.c:218
 #1: ffffffff8e9fb6e0 (reading_mutex.wait_lock){+.+.}-{2:2}, at: __mutex_lock_common kernel/locking/mutex.c:706 [inline]
 #1: ffffffff8e9fb6e0 (reading_mutex.wait_lock){+.+.}-{2:2}, at: __mutex_lock+0x6ac/0x9c0 kernel/locking/mutex.c:752
 #2: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
 #2: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2447
 #3: ffff888035408820 (&htab->lockdep_key#2){-.-.}-{2:2}, at: htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 #3: ffff888035408820 (&htab->lockdep_key#2){-.-.}-{2:2}, at: htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2405 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1c2/0x590 kernel/trace/bpf_trace.c:2447

stack backtrace:
CPU: 0 UID: 0 PID: 5356 Comm: syz-executor169 Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
 bpf_prog_1a158c95e143a564+0x45/0x4e
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
 __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
 __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
 trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x27e/0xc90 kernel/locking/qspinlock.c:557
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
 htab_lock_bucket kernel/bpf/hashtab.c:167 [inline]
 htab_map_delete_elem+0x1c8/0x730 kernel/bpf/hashtab.c:1426
 bpf_prog_1a158c95e143a564+0x45/0x4e
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2447
 __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
 __traceiter_contention_end+0x5a/0xa0 include/trace/events/lock.h:122
 trace_contention_end+0xce/0x140 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:727 [inline]
 __mutex_lock+0x281/0x9c0 kernel/locking/mutex.c:752
 rng_dev_read+0x128/0x720 drivers/char/hw_random/core.c:218
 do_loop_readv_writev fs/read_write.c:761 [inline]
 do_loop_readv_writev fs/read_write.c:749 [inline]
 vfs_readv+0x6cb/0x8a0 fs/read_write.c:934
 do_preadv fs/read_write.c:1049 [inline]
 __do_sys_preadv fs/read_write.c:1099 [inline]
 __se_sys_preadv fs/read_write.c:1094 [inline]
 __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1094
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa70184cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa701805218 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007fa7018dc1a8 RCX: 00007fa70184cea9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007fa7018dc1a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa7018a325c
R13: 7277682f7665642f R14: 00646e655f6e6f69 R15: 69746e65746e6f63
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

