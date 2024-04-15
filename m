Return-Path: <bpf+bounces-26846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099368A58B0
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F51C224C1
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AB84A3E;
	Mon, 15 Apr 2024 17:04:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E483CCD
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200663; cv=none; b=b/HQvsX2Hi7N25ETi45rBNuxFXdAiP6X1udM1IjtnzszepkqYMKbOH/6ii8PN1N62J6TfwwlQvlEXWSS9RUP+s7CnN/sJ34vcaDQiw3clvokdk2ePLQwQb5ZX49aZvxceUR6d2JaDEobvqyhQzrTQBw4uA19aOOE/XNWyVqSRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200663; c=relaxed/simple;
	bh=izvWnAzCy7V62DtygwtacnZI4620p1lqZoR3woSeWYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jnOTN6uGoAJnqAYzd/vGtdUyOOqMMDh0YldyjKpBmCS725FmcbnEKHFZv0147pYXlppVkcohkOyHWkXI0ztqbWA91Xnvh87vRI2qw2oXUSRrkv/UEo0MxJ3SCQ4Y+JsbwZS3+ymfrmLPt0i4DXrVlqqoWAvYu4YrCSaQzeJJX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5db4ed86bso439469339f.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 10:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200661; x=1713805461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40v/AsyGrLM0aSSUAr+y6YU80S4A1ysDKe4O4B0Pxg0=;
        b=bNlStJnFhtEkMeiHY4J+yrY7yUVveLibsPdW/wWoSGqlD+iC8WnpmBSNdZWLiWX50l
         vqmyhrVuX64+2KOJ3beHkMllmgrCXQL35lmJBnnQPItrV5y7NGH5XxLQJFJqOfDQin2Q
         O7Sj1RG5+piKAvFN8qdZbrzgzgjGj/TQM0GkYXK0HLQrgPIkcGlmdBFUm+gcP5ttIeNj
         dGIcpzPyTneQCF2Ff9cEx2SVeZPYTq6BCxDhFiyevznijhfEDHQPhaKLfWHhZNBRGmNP
         6vt674e192L27SBpy/LnMPIbzTkZl0Ha1rtQfwMBVr8XHYLkWkVoY5hzwN/9rFc9Vwo0
         KhuA==
X-Forwarded-Encrypted: i=1; AJvYcCVPWSjItNt264BPl3KsVAZXE+Tu4A+m5zOQH67rzycwboe0//wK+0Y5pH43NMulQMiUdtX0V9Y24ysuSwrieo30RY6q
X-Gm-Message-State: AOJu0YwXt/upNWc3PQoNYK9+iWX4/PTB1NB/Akw6mrnSrlHjV3G4h1Mn
	DPNHdF0frX5QMwIn3kcLHkFTT7E3fPsJ2WJ/yjUGw0hTT6OmaW4Q8XmjMceh6bxMmZWp3n+5rNr
	EuJ7+X556Oppe7hDG7qijegF87ht58b73p+UTgJKKV6CVO8mj+TwK7Pk=
X-Google-Smtp-Source: AGHT+IFhasR2e7dknyyxcAevF1xE+GyFaiRATi1XcCeItgbBVla1e5ifYUmIpcMylQI/P5EdXM57axmNEwI4MOvRJxWtem7dtVII
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260a:b0:482:eac1:fece with SMTP id
 m10-20020a056638260a00b00482eac1fecemr566366jat.4.1713200661058; Mon, 15 Apr
 2024 10:04:21 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:04:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e9e20616259cfe@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sock_hash_update_common
From: syzbot <syzbot+0b95946cd0588e2ad0f5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=131e1a57180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=0b95946cd0588e2ad0f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b95946cd0588e2ad0f5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
------------------------------------------------------
syz-executor.0/6160 is trying to acquire lock:
ffff88801f90d290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88801f90d290 (&psock->link_lock){+...}-{2:2}, at: sock_map_add_link net/core/sock_map.c:134 [inline]
ffff88801f90d290 (&psock->link_lock){+...}-{2:2}, at: sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1023

but task is already holding lock:
ffff88802b942868 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802b942868 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->buckets[i].lock){+.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
       0xffffffffa0001da2
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x291/0x380 mm/slub.c:4396
       sk_psock_free_link include/linux/skmsg.h:421 [inline]
       sock_map_del_link net/core/sock_map.c:158 [inline]
       sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
       __sock_map_delete net/core/sock_map.c:420 [inline]
       sock_map_delete_elem+0xc0/0x140 net/core/sock_map.c:446
       0xffffffffa0001e0a
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_fdb_delete include/trace/events/bridge.h:69 [inline]
       fdb_delete+0x117e/0x11f0 net/bridge/br_fdb.c:321
       br_fdb_changeaddr+0x218/0x420 net/bridge/br_fdb.c:476
       br_device_event+0x529/0x970 net/bridge/br.c:79
       notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       dev_set_mac_address+0x3d9/0x510 net/core/dev.c:8949
       dev_set_mac_address_user+0x31/0x50 net/core/dev.c:8963
       dev_ifsioc+0xbd9/0xe70 net/core/dev_ioctl.c:542
       dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:787
       sock_do_ioctl+0x240/0x460 net/socket.c:1236
       sock_ioctl+0x629/0x8e0 net/socket.c:1341
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&psock->link_lock){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:134 [inline]
       sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1023
       sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               lock(&psock->link_lock);
                               lock(&htab->buckets[i].lock);
  lock(&psock->link_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/6160:
 #0: ffff88807c9f5a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #0: ffff88807c9f5a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:117 [inline]
 #0: ffff88807c9f5a58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1cc/0x910 net/core/sock_map.c:575
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:118 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x910 net/core/sock_map.c:575
 #2: ffff88802b942868 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88802b942868 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007

stack backtrace:
CPU: 1 PID: 6160 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_map_add_link net/core/sock_map.c:134 [inline]
 sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1023
 sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f87b227de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f87b304a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f87b23abf80 RCX: 00007f87b227de69
RDX: 0000000000000020 RSI: 00000000200005c0 RDI: 0000000000000002
RBP: 00007f87b22ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f87b23abf80 R15: 00007ffd6d15d8b8
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

