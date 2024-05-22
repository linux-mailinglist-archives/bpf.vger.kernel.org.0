Return-Path: <bpf+bounces-30265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 675548CBC22
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8978B217E9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D2524D7;
	Wed, 22 May 2024 07:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADE3BB21
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363330; cv=none; b=VRKtF6Q/FEui5ZxQAlulf9IrabnZMddGibbdspEBs7uZ8wQsSCABRBnWDoCIJaW4w6oYhBh37VKdh+cUd4HedXnZnDDoqDs+J7YZozXSmqTIAPkhQ1cjgJxPCz3ugLMquprl4DBugXdYsuwbkzMQAe6Y9h2+Sx9Yx7PFyVQdVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363330; c=relaxed/simple;
	bh=27YeOgU9n+2JnbEP7AI0ZiCxh7SWkOh/eHC8kZMjR9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HSXwNI6eyZ1Ll+LygQKX11xfE5USWAiyH05jZQY2P7bFetzxg8U9XLYqAFeeRjEOT5/a3TLVnu+Do82XovmN5L5Qh3xBJ6smEvsP/qV/h/Ju/ZvH6NmhQgt8KTpQfkQWrfu9Qmpq0UNxgLxY3lQskUQ6mIEhIfRUf8mlFOLtdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1bbace584so1440847339f.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363328; x=1716968128;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Q5q8AaUX0JxkzzcSIhVsJoloFPyWPCpnZx3kqc1VwY=;
        b=OBWMrxSafg1S8KYYyt0slCaeYRUqfzrqauGUfs9fPu8u0NB0t5B6s+sV6q5Dlo+44V
         a/JjIfYqnLK90ZH2qLDlFh5nvU36jTahQ4Es5aiJb2O6L6YUu3XSz66rOk0uFpdMhGiV
         u77MT7mfrM4I6zXYxRxef8hZL9ywQXNWmeO7eSZfv/8dkXQGYznfb8WdFHX/67ptkIfv
         EIlPR/5/lFR49CXbecV1wdWNGQ8FEvASr5ua+H9Oghpkt6KhTYeSYCUhrIuMRnq/xImT
         rQYV8P0KiyJcxEdqmMvk2drFE/UUNsHW2RjuH7KGEP5cFMBGv5D1IyXKswyjGcqPVQQC
         YXEw==
X-Forwarded-Encrypted: i=1; AJvYcCXFLzFdkEyIHrg9vh2n5XdXJr0brUBBd7jKuduNYwVFa4zvGlCMRJOF2XC+AQliYIRvt4B9AuNxYfy4vbVO6JOT8Kfn
X-Gm-Message-State: AOJu0YwNu43YNsIIIw25uShAxlCcwX9ndagX7hxplecCoBRL17Y9K5fH
	T1PE2cAvIcoacZOzRCWmyDG8iQms18pSvmP0GVJ1RllmkBohZggBBhIeL6M5APOqv/eAyxb5CzD
	0kexNWF+NBj/nvM4JulzP3UbChE8UEtLjY3dvuN8u5E7qjVQBX7zXYHE=
X-Google-Smtp-Source: AGHT+IG7KuhTuUsbyvFuhQSFQdYuJwCXQYPxfaBD/+Rq4TQnD6DB7GkKGIDMArv3Us7rBJXZM8yh7yGDAwe/TvkdtnBm9J9Rw84g
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0b:b0:7de:d6a0:dbe1 with SMTP id
 ca18e2360f4ac-7e38b0e8c2bmr2094639f.2.1716363328313; Wed, 22 May 2024
 00:35:28 -0700 (PDT)
Date: Wed, 22 May 2024 00:35:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d6a8c061905fa5a@google.com>
Subject: [syzbot] [bpf?] possible deadlock in get_partial_node
From: syzbot <syzbot+9045c0a3d5a7f1b119f7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b377b4868ef kprobe/ftrace: fix build error due to bad fun..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1295df6c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=9045c0a3d5a7f1b119f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f4c61bc9252/disk-4b377b48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/841f1b24d3a1/vmlinux-4b377b48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/017b655dca3d/bzImage-4b377b48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9045c0a3d5a7f1b119f7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08544-g4b377b4868ef #0 Not tainted
------------------------------------------------------
syz-executor.0/10441 is trying to acquire lock:
ffff88801504e318 (&n->list_lock){-.-.}-{2:2}, at: get_partial_node+0x36/0x280 mm/slub.c:2601

but task is already holding lock:
ffff88802b82c9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
       0xffffffffa0001fe2
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
       trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0xb81/0xdc0 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
       _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
       __put_partials+0x61/0x130 mm/slub.c:2900
       put_cpu_partial+0x17c/0x250 mm/slub.c:2995
       __slab_free+0x2ea/0x3d0 mm/slub.c:4224
       qlink_free mm/kasan/quarantine.c:163 [inline]
       qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
       kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
       __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
       kasan_slab_alloc include/linux/kasan.h:201 [inline]
       slab_post_alloc_hook mm/slub.c:3871 [inline]
       slab_alloc_node mm/slub.c:3918 [inline]
       kmem_cache_alloc_node+0x194/0x390 mm/slub.c:3961
       __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
       alloc_skb include/linux/skbuff.h:1308 [inline]
       sock_wmalloc+0xab/0x120 net/core/sock.c:2643
       l2tp_ip_sendmsg+0x1b1/0x1670 net/l2tp/l2tp_ip.c:439
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x1a6/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
       ___sys_sendmsg net/socket.c:2638 [inline]
       __sys_sendmmsg+0x3b2/0x740 net/socket.c:2724
       __do_sys_sendmmsg net/socket.c:2753 [inline]
       __se_sys_sendmmsg net/socket.c:2750 [inline]
       __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&n->list_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       get_partial_node+0x36/0x280 mm/slub.c:2601
       get_partial mm/slub.c:2715 [inline]
       ___slab_alloc+0xa81/0x12e0 mm/slub.c:3572
       __slab_alloc mm/slub.c:3682 [inline]
       __slab_alloc_node mm/slub.c:3735 [inline]
       slab_alloc_node mm/slub.c:3908 [inline]
       __do_kmalloc_node mm/slub.c:4038 [inline]
       __kmalloc_node+0x2db/0x4f0 mm/slub.c:4046
       kmalloc_node include/linux/slab.h:648 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1889
       bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5196
       __sys_bpf+0x377/0x810
       __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&n->list_lock);
                               lock(&trie->lock);
  lock(&n->list_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/10441:
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88802b82c9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

stack backtrace:
CPU: 1 PID: 10441 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 get_partial_node+0x36/0x280 mm/slub.c:2601
 get_partial mm/slub.c:2715 [inline]
 ___slab_alloc+0xa81/0x12e0 mm/slub.c:3572
 __slab_alloc mm/slub.c:3682 [inline]
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 __do_kmalloc_node mm/slub.c:4038 [inline]
 __kmalloc_node+0x2db/0x4f0 mm/slub.c:4046
 kmalloc_node include/linux/slab.h:648 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
 trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x60d/0x900 kernel/bpf/syscall.c:1889
 bpf_map_do_batch+0x3e0/0x690 kernel/bpf/syscall.c:5196
 __sys_bpf+0x377/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c7b07cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c7bd5e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f9c7b1ac050 RCX: 00007f9c7b07cee9
RDX: 0000000000000038 RSI: 0000000020000240 RDI: 000000000000001a
RBP: 00007f9c7b0c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9c7b1ac050 R15: 00007fffe20416d8
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

