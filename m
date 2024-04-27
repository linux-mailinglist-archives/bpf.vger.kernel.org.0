Return-Path: <bpf+bounces-28012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC98B4479
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796FC1C215AB
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1E4086A;
	Sat, 27 Apr 2024 06:08:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1331405FC
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714198102; cv=none; b=AYuqnpz9FvIuwANYJKNyO9cGhG3Orn6DzQMYjBwBQGgzog2lw0r4LUOdhBkT4WPpOqUCMBkbjowjyUbZ4/W7jns83QZsw+ldX6FCR+GhWOnx3ASoSO7RtHC0KculpUm1EqNa7XjIwZHFi1v3ifXJBfOPbpLIEmBmU570GTkCwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714198102; c=relaxed/simple;
	bh=nyA9/XTxlQcPGTjwj3kf3iu51eo7cB/3xVNnvNV4vlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kc2XdS8l7wrHmsyedqjkdWVyji5y/Zu/fM9EBsMowhBrciO0y4lOHkiCNh76WOP2f+rFx8ZcZg5WB3R8D3uGLtddY/xbdmccmG0sUjzWilF6+RG3m+3pwW265MUxtqjSFm8geMK05fnsar/JhvK9b0ypaqPkHlpGbReuQ4mtUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so287562639f.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714198100; x=1714802900;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc/bj6Pb6mpN/D5wfm6HuVO2UjtEKfcC01ViGnC//f0=;
        b=aC1iIoJJa/5hA/9zzXzxo0/UJL2QwulUd6dWsafEYnU3JZCBMDz3TsUGk+y1xDLRX3
         WZTK5FpJXXZOfUA3CTcD6kETCXvv7bVcuRsPLD9egsUcU3wPr6VnyK3np84XKxSHwR/p
         hk/8YGRzTJQAB3m8fvs4Nl03aBVvemywTy9Y4rRqkztv4Ucd1Wny71kzyqI/vwvTbXTK
         l7OHlK9c8rWKPqUYWer8tF18HtekgmzADelRA2twVWrXUXekhkQ3TM+m4tYnJjqH5jRI
         xARsFG5fNzkiG5kcqMUh+PfRRuSSIwEYMyK92r6cgm47DArgimEQLuSXJgsuiYzWAF42
         n7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbqpiK4/L5OMhcLDii7seYaDd9cT8XrXyKWZqC5zfngodUG6y3QV7BPdYXg79zfUtFEQSVQ+ukVxx/nLmh6Kk4Gm52
X-Gm-Message-State: AOJu0Yyka2lAhiN66itVpJAY+qgEbv0o8JX0sMAZvxSj3Ch2dxwrpBPA
	vhIocSlLpnnrocIEKXJRpesGYECrAYxuxN0T6VhKq+J5s8/Xh3emJH7qxlvSJI8X6DHogzFKU+b
	6p7mpLVmP9AygrhIPM3Taf/jp6SqLfELKqVbLhHB93ViN+BF5mI5Ahfs=
X-Google-Smtp-Source: AGHT+IEG3OJfnn94SCS/RcYeqisQrf5NF/CAzxQJMxz6hbX6LQoNMkCMdFxHSsDP0GYHQZc7PjY+fGcomjaerii7y/SzHPuUDlU6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6f0b:b0:487:80f7:c4ee with SMTP id
 hp11-20020a0566386f0b00b0048780f7c4eemr5675jab.0.1714198099830; Fri, 26 Apr
 2024 23:08:19 -0700 (PDT)
Date: Fri, 26 Apr 2024 23:08:19 -0700
In-Reply-To: <0000000000000d7c8f0614076733@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0b87206170dd88f@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b2ff42c6d3ab Merge tag 'for-netdev' of https://git.kernel...
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157ea5e8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145682f8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c06aa0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bbdf1d091619/disk-b2ff42c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bf7c5b24257/vmlinux-b2ff42c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41fcb792fc43/bzImage-b2ff42c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.9.0-rc5-syzkaller-00171-gb2ff42c6d3ab #0 Not tainted
--------------------------------------------
syz-executor361/5090 is trying to acquire lock:
ffff888022c83260 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888022c83260 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945

but task is already holding lock:
ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&htab->buckets[i].lock);
  lock(&htab->buckets[i].lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor361/5090:
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: map_delete_elem+0x388/0x5e0 kernel/bpf/syscall.c:1695
 #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88807b2af8f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #2: ffff88801c2a4290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xcc/0x5e0 net/core/sock_map.c:180
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 5090 Comm: syz-executor361 Not tainted 6.9.0-rc5-syzkaller-00171-gb2ff42c6d3ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0x17c/0x400 net/core/sock_map.c:945
 bpf_prog_174bfe9d52de9121+0x4f/0x53
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x2af/0x3a0 mm/slub.c:4377
 sk_psock_free_link include/linux/skmsg.h:421 [inline]
 sock_map_del_link net/core/sock_map.c:158 [inline]
 sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:180
 sock_hash_delete_elem+0x392/0x400 net/core/sock_map.c:949
 map_delete_elem+0x464/0x5e0 kernel/bpf/syscall.c:1696
 __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5651
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1dbe94ce29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff608ae88 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1dbe94ce29
RDX: 0000000000000020 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

