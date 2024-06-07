Return-Path: <bpf+bounces-31565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D007D8FF987
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F5A28254F
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 01:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62099A937;
	Fri,  7 Jun 2024 01:17:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786714C83
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723049; cv=none; b=XD31rIl9vXERkFva8vtO0RVlBOThX2v9zxn9in8w88QZpV256pI98XqfLmbvAAhfynCu3gB7E815yZ+19cFt19c9R3xaxabNnnMzm6VrifOFrvqKy6gM9Ncopf75A9iPgaT1FrYOIovfVPs/15+On5fl/oNxwWksHGJKbuda1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723049; c=relaxed/simple;
	bh=6rpa6Cw/YMoF5HS9EKidjWH6F8W6/mjgbHDSCtzFLtg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BIXcClQbaLeo7sUPjC28oBDYXPJv9qPjvNf6V0it97LZO3CnumfF0RJFTpBkRSPobgr/viq6MbVm7OdEMRYWKMFLlMHmFnzpdqWUSZXEiF0LmcdUgYmz3v7dLF2vN50XpNTmWehC719scQHYB4AvKk5ZiSjqj+qUsBSihj+Eb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-374c07c73faso10515645ab.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 18:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717723046; x=1718327846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ffFPt55Pj6UElw65/fVwckjnoiLFyZpSfjMTheLVng=;
        b=QRsEyqOuWX+iy7HW7ntWSrFM8Hfr/ZCw8fKVcYSVtq8fVpgfqoKif9bkiIdYShaY5g
         IjLWyFqXeet3MAtTdM/JeVFwgpP83HQEIoVQGW3x1umvecT6NWE2nEQidDJjj9mSMATo
         S/CSxOkK0L9hle4WhsqIXX3lGMFQB+Tx5cSfAsi+HBFY7ZGVrQFP4Q3qaW3l8JvcCOoG
         8nQNT2EWP/uP87JAWyANytElJ98Fyfzns5syWL9S342iMgL7XVWQeeCaIDSEm8WjT/Qd
         0/zCvLzlYOuEjz/1NeIqyoYNJ0A07oW+OcOvlU4iVhSf3wyjMJ1jHAu1MgesEibETtlE
         hahw==
X-Forwarded-Encrypted: i=1; AJvYcCWCYukSCjeGeVWAVZ64YNVr/OZu8nm+StuMlXszjbJuYHWKT8iXhh2u2q1AgMcwMAcnjCzNdUBeAAq4+sf8v+sJ+1xA
X-Gm-Message-State: AOJu0YwEkteTZHHAmv2TYA++rmk5vQU8LLMiFRd3AcZug0imYipd8iiX
	kKGvPpMKpKfK/ApzOP0QJYFQ9w/b0gyV+oQ4myrwG6//bQMqygYytAazUNKkTwWj/srUJPQGWfC
	AOwJ0XWPYpNvUmOlPc35s3wLG0SmX3HfJg6wl3X81ggtsSCsmcdux3Dw=
X-Google-Smtp-Source: AGHT+IFT7tyh/nmQu7DiCxZ8/rgombd/hpnI0UYfk5g6LZMmjXSgygTwAO3Ch9o9LGWvRxK1yi6nHe2QwCm1jDO1NzYwyDNsAu3a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b42:b0:374:5eee:dc2f with SMTP id
 e9e14a558f8ab-37580237d66mr620945ab.0.1717723046756; Thu, 06 Jun 2024
 18:17:26 -0700 (PDT)
Date: Thu, 06 Jun 2024 18:17:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000656bf061a429057@google.com>
Subject: [syzbot] [bpf?] possible deadlock in deactivate_slab
From: syzbot <syzbot+a4acbb99845d381e5e2f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f38fa61af7 Linux 6.10-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e9d362980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
dashboard link: https://syzkaller.appspot.com/bug?extid=a4acbb99845d381e5e2f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f38fa6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af6a0b581dee/vmlinux-c3f38fa6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47864da8bd74/bzImage-c3f38fa6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4acbb99845d381e5e2f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/23904 is trying to acquire lock:
ffff888040002018 (&n->list_lock){-.-.}-{2:2}, at: deactivate_slab+0x2b4/0x4a0 mm/slub.c:2948

but task is already holding lock:
ffff88802792d9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc7/0xdb0 kernel/bpf/lpm_trie.c:333

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       trie_delete_elem+0xb0/0x820 kernel/bpf/lpm_trie.c:462
       0xffffffffa0001fd2
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x231/0x590 kernel/trace/bpf_trace.c:2444
       trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0x28e/0xcc0 kernel/locking/qspinlock.c:557
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
       _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
       get_partial_node.part.0+0x20/0x350 mm/slub.c:2675
       get_partial_node mm/slub.c:2672 [inline]
       get_any_partial mm/slub.c:2759 [inline]
       get_partial mm/slub.c:2793 [inline]
       ___slab_alloc+0xd36/0x1870 mm/slub.c:3646
       __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
       __slab_alloc_node mm/slub.c:3809 [inline]
       slab_alloc_node mm/slub.c:3988 [inline]
       kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4007
       getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
       getname_flags include/linux/audit.h:322 [inline]
       getname+0x8f/0xe0 fs/namei.c:218
       do_sys_openat2+0x104/0x1e0 fs/open.c:1399
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&n->list_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       deactivate_slab+0x2b4/0x4a0 mm/slub.c:2948
       ___slab_alloc+0xc0b/0x1870 mm/slub.c:3591
       __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
       __slab_alloc_node mm/slub.c:3809 [inline]
       slab_alloc_node mm/slub.c:3988 [inline]
       __do_kmalloc_node mm/slub.c:4120 [inline]
       __kmalloc_node_noprof+0x36c/0x450 mm/slub.c:4128
       kmalloc_node_noprof include/linux/slab.h:681 [inline]
       bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1ef/0xdb0 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
       generic_map_update_batch+0x454/0x5f0 kernel/bpf/syscall.c:1889
       bpf_map_do_batch+0x615/0x6e0 kernel/bpf/syscall.c:5196
       __sys_bpf+0x18cb/0x5830 kernel/bpf/syscall.c:5751
       __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
       __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5792
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&n->list_lock);
                               lock(&trie->lock);
  lock(&n->list_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.1/23904:
 #0: ffffffff8dbb5160 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8dbb5160 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8dbb5160 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x24b/0x6c0 kernel/bpf/syscall.c:202
 #1: ffff88802792d9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc7/0xdb0 kernel/bpf/lpm_trie.c:333

stack backtrace:
CPU: 3 PID: 23904 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 deactivate_slab+0x2b4/0x4a0 mm/slub.c:2948
 ___slab_alloc+0xc0b/0x1870 mm/slub.c:3591
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 __kmalloc_node_noprof+0x36c/0x450 mm/slub.c:4128
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
 trie_update_elem+0x1ef/0xdb0 kernel/bpf/lpm_trie.c:342
 bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x454/0x5f0 kernel/bpf/syscall.c:1889
 bpf_map_do_batch+0x615/0x6e0 kernel/bpf/syscall.c:5196
 __sys_bpf+0x18cb/0x5830 kernel/bpf/syscall.c:5751
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5792
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf731f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f115ac EFLAGS: 00000292 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 000000000000001a RCX: 0000000020000100
RDX: 0000000000000038 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

