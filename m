Return-Path: <bpf+bounces-26727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE13F8A46F3
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 04:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E32B22D37
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71352168C7;
	Mon, 15 Apr 2024 02:28:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788F1C02
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148099; cv=none; b=S7OlzpMk+pa34+k7W3HF68ss0WDpkaU0HUVqwLwgw6XikAk3C3IaqaRSMxvOpF2tGq8fMOqLIza82sGLeUTgD78reo54/vDNihDYlbxT8ZYnQPpyfotir/4HnfN2sP5hE3U3nLrRf0q9pScvR46tq58Bjis1y6z+rh93WErfE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148099; c=relaxed/simple;
	bh=Cio18tSKuF/8euwAPGekhlyQd88E7BpLqga+zxfPc48=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VtkPA4hp9MuZRRQWpeSWDwhNDP/xLTmpoi21vYE4cGIgw0xGYIBJnHnmpUCEMm0fP+go3B12eVUrZLEtO5qhyTI6eO6wsX+SGEW+1F6tBJzgWXK8q0vXkznL8s5vWWBj1/M2gP/hjwFrYIdrRYs9NY1lNTIFIIWmrbYH/nSgY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so324653839f.0
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 19:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713148097; x=1713752897;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waGhkYO2YB//zJMzb8XaEyUj7MB1CN5OmHFF1KBcXK8=;
        b=t3+X/HFV4DFAIkyIl8to+LjoZF88jOZ1Sxt//ZBo3F7G9Wu4YjxBEu50tPmibmGd+o
         Uac4so2BR9Fbymn8d8HeGhQ5+TpHM71McFGVw/N5VPDwo9w79G6+VZ6Hcc8Cl2NoBeJW
         U0NvWcFOLo9RMGyNrUgvbKGrdOdm8qU+X8NA9hl0uCj/RzeTAB6cUtcJeSNW+FQOsOe1
         pycG1X97MIgffEZ9LWzkw0K3UyMaNuwQR8wQQB2eK5PZHMn37+YaObR0UBEOfXxXMoVY
         9OJatDJRnBSL/Ol5jvBsRnTrOt9mBM+TMj5CgGkrOw6nGDpAisvOW9nHz0QmKHriD7c8
         sKEg==
X-Forwarded-Encrypted: i=1; AJvYcCWoNle57C3YXQ2nFVRDWFtS+lD25bKWgFP6vqETWvF/DhwgqQWil5MXGSEwpfWr4S+bUEWaN1EWzPHNgmM5+VjTasZT
X-Gm-Message-State: AOJu0YzYxMgcAbQBQcjKOV1LVZdvgT3RivejAD6X5gjcH4oEezRO7Bi6
	nuNKW5Kia6fDnFMptmpo8pSVgoVb/vPnVIMHS7nJGGmvbjjhmvQIp4xMk3ru5YoltIc+rHuxTnq
	0FSk6wCycwaUafK994hGQVckACwHGlIoAmQpuI/tShTFzZC2UzRcs9k0=
X-Google-Smtp-Source: AGHT+IFxXw2ygp9bjH5rqRCSkOklQS/GaMClPTsB1b+4o+YTRt+xrIGsH7pG3sQQsd1ogrehTiXwpExceTePCkKLHh3kh6SATozg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2111:b0:482:e924:beca with SMTP id
 n17-20020a056638211100b00482e924becamr420554jaj.5.1713148096691; Sun, 14 Apr
 2024 19:28:16 -0700 (PDT)
Date: Sun, 14 Apr 2024 19:28:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c051d80616195f15@google.com>
Subject: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
From: syzbot <syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1358aeed180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D285be8dd6baeb43=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7f061d2d16154538=
c58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc=
7510fe41f/non_bootable_disk-7efd0a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39eb4e17e7f0/vmlinux-=
7efd0a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9a08c36e0ca/bzI=
mage-7efd0a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0 Not tainted
------------------------------------------------------
syz-executor.2/7645 is trying to acquire lock:
ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue_buddy mm/page_alloc=
.c:2730 [inline]
ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue mm/page_alloc.c:291=
1 [inline]
ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: get_page_from_freelist+0x4b=
9/0x3780 mm/page_alloc.c:3314

but task is already holding lock:
ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xdd0=
 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       trie_delete_elem+0xb0/0x7e0 kernel/bpf/lpm_trie.c:451
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
       __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:12=
2
       trace_contention_end.constprop.0+0xea/0x170 include/trace/events/loc=
k.h:122
       __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinlock.=
c:560
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [in=
line]
       queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inlin=
e]
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline=
]
       _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
       rmqueue_bulk mm/page_alloc.c:2131 [inline]
       __rmqueue_pcplist+0x5a8/0x1b00 mm/page_alloc.c:2826
       rmqueue_pcplist mm/page_alloc.c:2868 [inline]
       rmqueue mm/page_alloc.c:2905 [inline]
       get_page_from_freelist+0xbaa/0x3780 mm/page_alloc.c:3314
       __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
       __alloc_pages_node include/linux/gfp.h:238 [inline]
       alloc_pages_node include/linux/gfp.h:261 [inline]
       alloc_slab_page mm/slub.c:2175 [inline]
       allocate_slab mm/slub.c:2338 [inline]
       new_slab+0xcc/0x3a0 mm/slub.c:2391
       ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
       __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
       __slab_alloc_node mm/slub.c:3663 [inline]
       slab_alloc_node mm/slub.c:3835 [inline]
       __do_kmalloc_node mm/slub.c:3965 [inline]
       __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
       kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
       __alloc_skb+0x164/0x380 net/core/skbuff.c:668
       alloc_skb include/linux/skbuff.h:1313 [inline]
       nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
       nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
       nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:85=
0
       process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&zone->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       rmqueue_buddy mm/page_alloc.c:2730 [inline]
       rmqueue mm/page_alloc.c:2911 [inline]
       get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
       __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
       __alloc_pages_node include/linux/gfp.h:238 [inline]
       alloc_pages_node include/linux/gfp.h:261 [inline]
       __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
       __do_kmalloc_node mm/slub.c:3954 [inline]
       __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
       kmalloc_node include/linux/slab.h:648 [inline]
       bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
       trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
       bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
       map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
       __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&zone->lock);
                               lock(&trie->lock);
  lock(&zone->lock);

 *** DEADLOCK ***

2 locks held by syz-executor.2/7645:
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:329 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:781 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value=
+0x24b/0x6c0 kernel/bpf/syscall.c:202
 #1: ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/=
0xdd0 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 7645 Comm: syz-executor.2 Not tainted 6.9.0-rc3-syzkaller-00355=
-g7efd0a74039f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16=
.2-1 04/01/2014
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
 rmqueue_buddy mm/page_alloc.c:2730 [inline]
 rmqueue mm/page_alloc.c:2911 [inline]
 get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
 trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
 bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
 map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
 __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb1c27de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb1d0210c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fdb1c3abf80 RCX: 00007fdb1c27de69
RDX: 0000000000000020 RSI: 0000000020001400 RDI: 0000000000000002
RBP: 00007fdb1c2ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdb1c3abf80 R15: 00007ffe7cd30f08
 </TASK>
loop2: detected capacity change from 0 to 512
ext4: Unknown parameter '=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD3;=EF=BF=BD{\C	_r=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BDgD=19Z*=
=EF=BF=BD=EF=BF=BD=D7=92=EF=BF=BDMd=EF=BF=BD;=EF=BF=BDs=EF=BF=BD8)V=1B=EF=
=BF=BDZ=EF=BF=BD-#=EF=BF=BD=EF=BF=BDS%=19=EF=BF=BDSY=EF=BF=BDE`1t=10AS=EF=
=BF=BD>=EF=BF=BD>=EF=BF=BD=EF=BF=BD=EF=BF=BD=0Ed]=EF=BF=BDx=EF=BF=BD=EF=BF=
=BDh'


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

