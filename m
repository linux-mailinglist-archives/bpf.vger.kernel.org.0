Return-Path: <bpf+bounces-42423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F569A4111
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411451F22A69
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAA1EE03F;
	Fri, 18 Oct 2024 14:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E018FC79
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261479; cv=none; b=tqVXmO/f4cbCoq8DW1eXOryJp5EaF6gIY3nSKvopDmWTxSqeXb03jW7KyWSnzY7Fto7pL10m/XUZDtWeix5PIZag9gvtdCZataNrnYj7J/q5X+aNquhRO0RigKjfLIt12QPrqL8V78vgyVSNz4KgYBMEaQEVIXRfywXIhwxJp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261479; c=relaxed/simple;
	bh=0amI+pra/zfUvVwGXksXgODEtuUrveAp+y6q4EuhXsc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KaxTwjRPVwjBV9TuY/mnm7bMfKzr+er7Y8xEaIHtO8itmKrplD6P9snMdVx+jtZdqCaG2FK7yh2J14c+7RRZDwPR+YZaom5XyW3RoOzMFBSnqwM4AZs1YZjBINT+r+tO2JCWqxuj1dOajtr+J0qyJgyOG+8kVyijInR0fkZywro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b483e30bso16477235ab.3
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 07:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261476; x=1729866276;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/FklgRO5fL2x5hFvewouaMgzNXQeYe2+MrFSD9zQwo=;
        b=D9xuTcSdXEL87WsjONn7vEh1u3NBWYH4doRzp1bySWLHEVan60oOZbJIvgPJOeAlf1
         5V8HPHrYLTNkBMGG2MzsfAZKydKdLHOMxAG5MN3kmX/tvqwh/q+1/8KGqYNIgkkKZHi6
         amMynR5V7+wZaMTpPjefDhaF55vR+hkkcEIdrDcxZnXCMR1P0AP4KFrIlNc82qiObeq4
         UwuKw0DTIs0ZS9qrBvveXcw9jnjgOY+gBhphsbxYzClCZqwv680m7N1eP0CJ+P0BMGI4
         GmPYNlRBpH9CF5VkfAm1/v7V1hibpCpi3Q7kHAOXKe0+B67dThBkZUjzAULmF2p9bvDD
         Cgmg==
X-Forwarded-Encrypted: i=1; AJvYcCX/kaTuIXttRRtgAS6RxbuY5BH+MayUq7Ux9lIlIzG8UHR6xcz5Gpkz0mkIKek0rmoMjIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBST/SpAuzRMlocXBmQCVb82GA4BBKkqCX2hzZetb/hS+j3co
	qAzUnvUc/k2GDkk5lFo9rHWgmNyTTRfzOC3Zk/mX/u735dPlNYKqq/2TjagfNBNiMIbn2HXSV6V
	/m+NT079NjO/08pgmHxiiVe+oyMRc1nxqfc5b3tJ5FkvTtwGUvrpEsyA=
X-Google-Smtp-Source: AGHT+IG3xeF1ekpf38iY6japDkE5yDv7UKJYv0g8JJlIYwKJob1VofS2gVawOdOtgNkl1DXlXZKtNhpPn7wLF3jK7jsW1FqT04F/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:39f:5d96:1fde with SMTP id
 e9e14a558f8ab-3a3f4045802mr31220945ab.3.1729261476214; Fri, 18 Oct 2024
 07:24:36 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:24:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67126fa4.050a0220.10f4f4.0015.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in debug_check_no_obj_freed
From: syzbot <syzbot+b12149f7ab5a8751740f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    989a29cfed9b libbpf: Fix possible compiler warnings in has..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=116c5440580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=b12149f7ab5a8751740f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/628a969b8618/disk-989a29cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20c58ef873dc/vmlinux-989a29cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cda8b348a2ce/bzImage-989a29cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b12149f7ab5a8751740f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00176-g989a29cfed9b #0 Not tainted
------------------------------------------------------
syz.1.55/5474 is trying to acquire lock:
ffffffff9a614a58 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed lib/debugobjects.c:978 [inline]
ffffffff9a614a58 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_check_no_obj_freed+0x234/0x580 lib/debugobjects.c:1019

but task is already holding lock:
ffff88805c781a00 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
       0xffffffffa000492e
       bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
       trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0xb7e/0xdb0 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
       _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
       debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
       debug_rcu_head_unqueue kernel/rcu/rcu.h:233 [inline]
       rcu_do_batch kernel/rcu/tree.c:2559 [inline]
       rcu_core+0xa21/0x17a0 kernel/rcu/tree.c:2823
       handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
       run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
       smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&obj_hash[i].lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __debug_check_no_obj_freed lib/debugobjects.c:978 [inline]
       debug_check_no_obj_freed+0x234/0x580 lib/debugobjects.c:1019
       free_pages_prepare mm/page_alloc.c:1115 [inline]
       free_unref_page+0x41b/0xf20 mm/page_alloc.c:2638
       stack_depot_save_flags+0x6f6/0x830 lib/stackdepot.c:666
       kasan_save_stack mm/kasan/common.c:48 [inline]
       kasan_save_track+0x51/0x80 mm/kasan/common.c:68
       poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
       __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
       kasan_kmalloc include/linux/kasan.h:257 [inline]
       __do_kmalloc_node mm/slub.c:4265 [inline]
       __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4271
       kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
       alloc_slab_obj_exts mm/slub.c:1969 [inline]
       account_slab mm/slub.c:2542 [inline]
       allocate_slab+0xb6/0x2f0 mm/slub.c:2597
       new_slab mm/slub.c:2632 [inline]
       ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
       __slab_alloc+0x58/0xa0 mm/slub.c:3909
       __slab_alloc_node mm/slub.c:3962 [inline]
       slab_alloc_node mm/slub.c:4123 [inline]
       __do_kmalloc_node mm/slub.c:4264 [inline]
       __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
       kmalloc_node_noprof include/linux/slab.h:905 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       map_update_elem+0x51a/0x6f0 kernel/bpf/syscall.c:1626
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5622
       __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&obj_hash[i].lock);
                               lock(&trie->lock);
  lock(&obj_hash[i].lock);

 *** DEADLOCK ***

2 locks held by syz.1.55/5474:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88805c781a00 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xc00 kernel/bpf/lpm_trie.c:333

stack backtrace:
CPU: 1 UID: 0 PID: 5474 Comm: syz.1.55 Not tainted 6.12.0-rc1-syzkaller-00176-g989a29cfed9b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __debug_check_no_obj_freed lib/debugobjects.c:978 [inline]
 debug_check_no_obj_freed+0x234/0x580 lib/debugobjects.c:1019
 free_pages_prepare mm/page_alloc.c:1115 [inline]
 free_unref_page+0x41b/0xf20 mm/page_alloc.c:2638
 stack_depot_save_flags+0x6f6/0x830 lib/stackdepot.c:666
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4271
 kmalloc_array_node_noprof include/linux/slab.h:995 [inline]
 alloc_slab_obj_exts mm/slub.c:1969 [inline]
 account_slab mm/slub.c:2542 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2597
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4271
 kmalloc_node_noprof include/linux/slab.h:905 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
 trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 map_update_elem+0x51a/0x6f0 kernel/bpf/syscall.c:1626
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5622
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93def7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93dfe48038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f93df135f80 RCX: 00007f93def7dff9
RDX: 0000000000000020 RSI: 00000000200004c0 RDI: 0000000000000002
RBP: 00007f93deff0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f93df135f80 R15: 00007fff24bc8458
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

