Return-Path: <bpf+bounces-28223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 558408B6736
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 03:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F87B22144
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3152107;
	Tue, 30 Apr 2024 01:13:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269B17F5
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439607; cv=none; b=MoYOI3niVU/6dBqII9Dhi9wcT/B6QHd29OvhqnMdE0yo/Dm5IePmESGFrshTSOiGUYVC3p4MCwGD7fCSlhl+NX4BwGJtMdwvzcUBTKQ2frlj1FvUam3JmEoslwnBbYFTon10WR16NTWSJAZFqQrHlqmNZcP/7GSqcuup8tw+D8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439607; c=relaxed/simple;
	bh=XQSFypaAbLEQE7raPe7sh/Srg5rAA06pObg/IzZ7EKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kJFrzfVjZE5bU9i4Tw+8/KKWSLHZ/yPETWGtnNCFb2GfwT/ocX3rB1fkM3w7Jnt8s49AjwQfrModlvNqkTbesCpGvfa0i2zvkuhaOHKy0z1KwAyBCq0nuBuykOhGMTf8H6GBI/WK8+DIYW+hwLp/FaR6yYn0npKeU21DoaYdF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b31fda393so52066135ab.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 18:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439605; x=1715044405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj8ifUoPAj0YpEtjLTKabVAuD2CaWPMIe3YhVwHK608=;
        b=KRDLo+qKdjsef4IrQ0yTtL0kJ9uaDxz2CvqmKeutW/MUZ1tHlglq0fLS2JuSxlhWma
         1ktZV7YCU5sHFQV7p2zBSdzg47a0XfNnTuJv3nfh1Q79xsg1k8LPv+7yUihSdxSspEC0
         KbNvRR9ZHP1gMOw1vMtu8RZFGKGjSz7mKXpYqCmVS95GC/GJ2Szpn9GwG/FJ/W9Znu10
         alA0I+cQ5X55k48x/g9SqBmgdA+Zg7y+4rfNweNWBf4P0Z0nuyM2OvJkA6lPrxMdIl4U
         88GSgxP2PSC5rJvi6XoW5MsU97YHtOwgWZT4g4XR3GV/De91JAHTzv48oc7Jwq7OvOZ2
         3XTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzJRVBz66cBbnm9SvNR04VqF8A4ntCBwHxxs6bVqtF5nTaqCyIxuhJel/T2bPbSVWTVx4gkMATEnmV56RVwQi+NrAh
X-Gm-Message-State: AOJu0YxDHhmpJevWDaTKuDJJdKChzCWoRBhwMfY7ndMCZ3icul+JGS8K
	3azyUiZSHTG6rC/fs6j07rI8q1MTR/qOf5Hc6y0EKikFgfoP4VWqk61eER/g6grggzMxUVo/kYw
	nKRWbSBmhRvWjPT8Lf62cTPDUdyzww7ftzZ+mfuy8wkQVa/SbpCtZdOc=
X-Google-Smtp-Source: AGHT+IE1YHyTLbrnjl9SSYY9YHdagDNl3WcuSpRG8czs8NE6RcaRc5xfQ91PzQen727kPMJAC91LiBp1TsIIQKZAq64M8vgbZFqk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:36b:f94f:3022 with SMTP id
 m7-20020a056e021c2700b0036bf94f3022mr341844ilh.5.1714439605095; Mon, 29 Apr
 2024 18:13:25 -0700 (PDT)
Date: Mon, 29 Apr 2024 18:13:25 -0700
In-Reply-To: <000000000000233ab00613f17f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a69fc506174613ad@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_map_delete_elem
From: syzbot <syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ba1cb99b559e Merge branch 'vxlan-stats'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176b097f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10795c90980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114465e8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5f29f03f4a8/disk-ba1cb99b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1a9f6891628/vmlinux-ba1cb99b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f21db47d56d/bzImage-ba1cb99b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00184-gba1cb99b559e #0 Not tainted
------------------------------------------------------
kworker/u8:6/1269 is trying to acquire lock:
ffff88807e310200 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88807e310200 (&stab->lock){+...}-{2:2}, at: __sock_map_delete net/core/sock_map.c:417 [inline]
ffff88807e310200 (&stab->lock){+...}-{2:2}, at: sock_map_delete_elem+0x175/0x250 net/core/sock_map.c:449

but task is already holding lock:
ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&psock->link_lock){+...}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:134 [inline]
       sock_map_update_common+0x31c/0x5b0 net/core/sock_map.c:503
       sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:582
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5648
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&stab->lock){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete net/core/sock_map.c:417 [inline]
       sock_map_delete_elem+0x175/0x250 net/core/sock_map.c:449
       0xffffffffa00020cb
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       __traceiter_kfree+0x2b/0x50 include/trace/events/kmem.h:94
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x2af/0x3a0 mm/slub.c:4377
       sk_psock_free_link include/linux/skmsg.h:421 [inline]
       sock_map_del_link net/core/sock_map.c:158 [inline]
       sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
       sock_map_free+0x1e7/0x3e0 net/core/sock_map.c:351
       bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&psock->link_lock);
                               lock(&stab->lock);
                               lock(&psock->link_lock);
  lock(&stab->lock);

 *** DEADLOCK ***

6 locks held by kworker/u8:6/1269:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
 #1: ffffc90005557d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90005557d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
 #2: ffff888023be2258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1673 [inline]
 #2: ffff888023be2258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_free+0x11e/0x3e0 net/core/sock_map.c:349
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: sock_map_free+0x12a/0x3e0 net/core/sock_map.c:350
 #4: ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #4: ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #4: ffff888024253290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
 #5: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #5: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #5: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #5: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 1269 Comm: kworker/u8:6 Not tainted 6.9.0-rc5-syzkaller-00184-gba1cb99b559e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound bpf_map_free_deferred
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
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:417 [inline]
 sock_map_delete_elem+0x175/0x250 net/core/sock_map.c:449
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

