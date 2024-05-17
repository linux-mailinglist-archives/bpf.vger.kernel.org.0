Return-Path: <bpf+bounces-29979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDCE8C8E80
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 01:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F5E1F22351
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0F1411F0;
	Fri, 17 May 2024 23:31:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE671DFFD
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988684; cv=none; b=deOJi62GcCqaT1KIDaDsnhsiYsR2w5bHXb9Bvmom59fZkHi7lgewFLoTb/0eKy9rS0Rw/J+mCzZB3veBBi4ZGs+P4b/+IXWHEHrIFLpMK68Xw5yjjsfCcWBomEljkNbuJECq4idYA0SJQ9seIvNjgW3yj43eOCSLIi+sSH9vhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988684; c=relaxed/simple;
	bh=Tk62uYH+Jez2jlqrkmBZWiG86NusHJOS+Lz2/95F+dE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GdEQTtjKMBQVLgqXdjLtbGY0FSMsprP/tuPgxiUsicVoQGG7+x6Mc6UquuXWF12vNQUvNanlGVkumOyRGLJx5UzgdJqF0gyk5gCQNsu8KBufitcRVM/Oqb0D3supynko91GTNmM1LdEQS2Ykb/vZFIQw+Jx5kx4WunAeJv7nANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e2230f7b56so127793639f.2
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 16:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715988682; x=1716593482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCSO2lkNuggn4gF+aNq1dyTOqh+MVBLkbyj5K1YD8XA=;
        b=EuFQ4DKl2MI7iZ4JjvCY4N+9UukEj1ydXZSqvLstpjqBBi5k51ONY5z+DxehnP+j1E
         C0wpff+tVgk3xvN+QtWLygSPLRTldIVXRmARCKZ/B5RKREuJA3Bg9SfaNOAXeX0s+N9H
         ls20hcm7qgBHDBOjhsiwWkmMCoGqrehlfbXG05YTSe9cmlTSuhlwkecVfCgJj1Ndi2tO
         bO3dkiJnkJa6fNe4LwR1QtRvYiOKJgS+KDEJsyJWjYY7aPj+N5fPJRNgFppbsV+0TtdY
         2vwprGw1kxnzYiCC+g5rmwXaf9T6AMCNJtuuGus19DcMynVmaSBsbvpf72+a+XOFIKoz
         AfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6eAQFMv0V0mkkf+81a4jSlsPtixgK1F4Rwh1Uq0PNq9pP7xQF+DR+yE5aZ3Vs+cVgsYejs/Rg0g+nedv3MAv4JRre
X-Gm-Message-State: AOJu0YxWcOvM7hSUCigQoLfpYGzVnbyHnwqXF0OI3RgBGYzsWkf42xkR
	cs7vXyn0tQwXborAZOn0R3ZHfJQ9sG0do0ebAafgmhjtKMMZsf6lgusNFPUh/a0zOk5CKSe9I1H
	k9u6nufV9b89iJARd2E8Rzd7Hvjde0PMy/LPNYqh9vbhbq50ws4YCtNE=
X-Google-Smtp-Source: AGHT+IGiKakUXRSBFC374kAZf283TAmqiMYP1nPSyBhFmmVl8CHOeh0bhzYvdv49ionEaWwTWm2NtRD5zz84qoFkC7NSuFxGPorC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891d:b0:48a:9d8f:9a1e with SMTP id
 8926c6da1cb9f-48a9d8f9d80mr497468173.5.1715988682109; Fri, 17 May 2024
 16:31:22 -0700 (PDT)
Date: Fri, 17 May 2024 16:31:22 -0700
In-Reply-To: <000000000000d4e9e20616259cfe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d605280618aebfb8@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_hash_update_common
From: syzbot <syzbot+0b95946cd0588e2ad0f5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    71ed6c266348 bpf: Fix order of args in call to bpf_map_kvc..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17554e3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd214b7accd7fc53
dashboard link: https://syzkaller.appspot.com/bug?extid=0b95946cd0588e2ad0f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1515d8b2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167b60dc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5802d805367c/disk-71ed6c26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/463c507f7ca0/vmlinux-71ed6c26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0958a8d8b793/bzImage-71ed6c26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b95946cd0588e2ad0f5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-02064-g71ed6c266348 #0 Not tainted
------------------------------------------------------
syz-executor469/5083 is trying to acquire lock:
ffff88801ba8c2b0 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88801ba8c2b0 (&psock->link_lock){+...}-{2:2}, at: sock_map_add_link net/core/sock_map.c:146 [inline]
ffff88801ba8c2b0 (&psock->link_lock){+...}-{2:2}, at: sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1041

but task is already holding lock:
ffff88801a299520 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88801a299520 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1025

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&htab->buckets[i].lock){+...}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:957
       bpf_prog_78b015942f8c5b4e+0x63/0x67
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x2bd/0x3b0 mm/slub.c:4383
       sk_psock_free_link include/linux/skmsg.h:425 [inline]
       sock_map_del_link net/core/sock_map.c:170 [inline]
       sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:192
       sock_map_update_common+0x4f0/0x5b0 net/core/sock_map.c:518
       sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:594
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5670
       __do_sys_bpf kernel/bpf/syscall.c:5789 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5787 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5787
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&psock->link_lock){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:146 [inline]
       sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1041
       sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:596
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5670
       __do_sys_bpf kernel/bpf/syscall.c:5789 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5787 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5787
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               lock(&psock->link_lock);
                               lock(&htab->buckets[i].lock);
  lock(&psock->link_lock);

 *** DEADLOCK ***

3 locks held by syz-executor469/5083:
 #0: ffff88807e797258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1595 [inline]
 #0: ffff88807e797258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:129 [inline]
 #0: ffff88807e797258 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1cc/0x910 net/core/sock_map.c:590
 #1: ffffffff8e334ea0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e334ea0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e334ea0 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:130 [inline]
 #1: ffffffff8e334ea0 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x910 net/core/sock_map.c:590
 #2: ffff88801a299520 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88801a299520 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1025

stack backtrace:
CPU: 1 PID: 5083 Comm: syz-executor469 Not tainted 6.9.0-rc7-syzkaller-02064-g71ed6c266348 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 sock_map_add_link net/core/sock_map.c:146 [inline]
 sock_hash_update_common+0x624/0xa30 net/core/sock_map.c:1041
 sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:596
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5670
 __do_sys_bpf kernel/bpf/syscall.c:5789 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5787 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5787
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f98a7323a69
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea2336c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

