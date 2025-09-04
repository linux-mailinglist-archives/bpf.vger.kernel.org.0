Return-Path: <bpf+bounces-67432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226BB43ACA
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 13:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A34167B80
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1062FE584;
	Thu,  4 Sep 2025 11:54:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED72FE059
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986845; cv=none; b=C6z8wPBeL/NfdbguqZGyehnGGszDIk2EZ+CwAikxfkoz1v3kzMgAWZmRxH13HhXSp3L+ltqTP5NuUbA/emjlXmERiD6wdShaWa6yc1MCN81oIHtddEsuxf8kw9YZsSSJsl8aF3otsSqgbcoVzmfUtW9K7H2GDPftMjqB6ll4Ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986845; c=relaxed/simple;
	bh=KQ6gP5NpHsCK1Cj/tVYfp41SGmc/i9E5aCZ+sZGm9mc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eDYUAz72QHoKP4iW9jDEe9rA6b4AjMOiPnPdvAX5rnKnlIcN9jeP+0VSp5bt5lmcPWzl+VMBFbQMi7tYibtorQZODBgIeT0AjmOgX6bav0PzXG9cBrgc4vxhUb46JdgjaJtKfanaBr5oebJ+vBs+6G9j5JMQq2FszQg5dJaf/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f34562d167so11359665ab.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756986842; x=1757591642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BDHW0BO0OxvJaoZ1/aTkWN+6Wj76ZtsXduBRytK0lI=;
        b=xFteVxE4OnWtld3idhFYNz5tSR/fcyuRqSSyd+ZNA6p0PxzpusxqSvnmSKkg+JGzkj
         2V2hWxHWcYrD+TpkUYHDcsGUxDl2nMgn0TAn6Xyn/g2piBXpakC1+k/xwp+vFIAQ/9ph
         bImasIA/5z9nRABsfBg0MxNoVzTeS0FUTtxZZi0qZKGttw2Fe0OdgID18PFLljAGbOg+
         lTjQLpzhKd324RHRiw5mvBrsbVSeF7bQrYBngZB6+JvEhQnVGEMDvhlHotK3+wRo2QmE
         NB8JuZxjMQVIW7krwaOtUb4g16YsWtLQpRoaZcdOPgdUoRb1nmEIhkRy2pKziga/xmRc
         EDmQ==
X-Gm-Message-State: AOJu0YzXx9eVo4mpUaLRdDscD8GGo+4TdznLOoAf3TbpsFCu4SrSHTMa
	hhA7zFbHqcAwXOy3bFa8ElrrQIMObNJMq5Awo6vZV0CKjkP6ul+FJ50Lo+7t78ISsFt6J63Ajfy
	ab9E9LR24Bcatbe8B+XmqXxCZaupj03LARkvgIsEgqcz5HNOC23coq44sOiQ=
X-Google-Smtp-Source: AGHT+IEFUdhUst7jL/OZbzZo9qTs+C43cn4Kb1Z9/4CWu6RRxRpnyTuvauipgtcW3ErPjkv3VZupaL3PnU6gNXT9ZuVYxVt5nHw4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3e5:5bc0:21d5 with SMTP id
 e9e14a558f8ab-3f4019f5eacmr276183625ab.21.1756986842623; Thu, 04 Sep 2025
 04:54:02 -0700 (PDT)
Date: Thu, 04 Sep 2025 04:54:02 -0700
In-Reply-To: <20250904101703.3633-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b97dda.050a0220.192772.0005.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Write in __bpf_get_stackid

==================================================================
BUG: KASAN: slab-out-of-bounds in __bpf_get_stackid+0x677/0xcf0 kernel/bpf/stackmap.c:287
Write of size 8 at addr ffff88807a2d9258 by task syz.1.290/7428

CPU: 1 UID: 0 PID: 7428 Comm: syz.1.290 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __bpf_get_stackid+0x677/0xcf0 kernel/bpf/stackmap.c:287
 ____bpf_get_stackid_raw_tp kernel/trace/bpf_trace.c:1810 [inline]
 bpf_get_stackid_raw_tp+0x196/0x210 kernel/trace/bpf_trace.c:1799
 bpf_prog_b724608cae728045+0x27/0x2f
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
 __traceiter_kfree+0x2e/0x50 include/trace/events/kmem.h:94
 __do_trace_kfree include/trace/events/kmem.h:94 [inline]
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x3a0/0x440 mm/slub.c:4866
 slab_free_after_rcu_debug+0x60/0x2a0 mm/slub.c:4717
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
RIP: 0010:rcu_is_watching+0x3a/0xb0 kernel/rcu/tree.c:751
Code: e8 eb f2 d2 09 89 c3 83 f8 08 73 65 49 bf 00 00 00 00 00 fc ff df 4c 8d 34 dd 10 ed bd 8d 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 <74> 08 4c 89 f7 e8 dc b8 7c 00 48 c7 c3 98 6f a1 92 49 03 1e 48 89
RSP: 0018:ffffc9000b4d7ad8 EFLAGS: 00000246
RAX: 1ffffffff1b7bda3 RBX: 0000000000000001 RCX: 0f1baf102ea8c100
RDX: 0000000000000000 RSI: ffffffff8be33260 RDI: ffffffff8be33220
RBP: ffffffff81b2dcc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc9000b4d7c40 R11: fffff5200169af8b R12: 0000000000000002
R13: ffffffff8e139ea0 R14: ffffffff8dbded18 R15: dffffc0000000000
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x5f/0x360 kernel/locking/lockdep.c:5831
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 futex_hash+0x5d/0x2d0 kernel/futex/core.c:308
 class_hb_constructor kernel/futex/futex.h:240 [inline]
 futex_wake+0x161/0x560 kernel/futex/waitwake.c:172
 do_futex+0x395/0x420 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f132bf8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f132cd870e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f132c1b5fa8 RCX: 00007f132bf8ebe9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f132c1b5fac
RBP: 00007f132c1b5fa0 R08: 7fffffffffffffff R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f132c1b6038 R14: 00007ffd03290180 R15: 00007ffd03290268
 </TASK>

Allocated by task 7428:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_node_noprof+0x276/0x4e0 mm/slub.c:4371
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 __bpf_map_area_alloc kernel/bpf/syscall.c:393 [inline]
 bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:406
 prealloc_elems_and_freelist+0x86/0x1d0 kernel/bpf/stackmap.c:73
 stack_map_alloc+0x33f/0x4c0 kernel/bpf/stackmap.c:136
 map_create+0xaa3/0x14d0 kernel/bpf/syscall.c:1480
 __sys_bpf+0x60f/0x870 kernel/bpf/syscall.c:6011
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807a2d9000
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 24 bytes to the right of
 allocated 576-byte region [ffff88807a2d9000, ffff88807a2d9240)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a2d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888054d19001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a44b280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 ffff888054d19001
head: 00fff00000000040 ffff88801a44b280 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 ffff888054d19001
head: 00fff00000000003 ffffea0001e8b601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5237, tgid 5237 (udevd), ts 36597748986, free_ts 36397116210
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 alloc_pipe_info+0x1fd/0x4d0 fs/pipe.c:815
 get_pipe_inode fs/pipe.c:894 [inline]
 create_pipe_files+0x8a/0x7e0 fs/pipe.c:926
 __do_pipe_flags+0x46/0x1f0 fs/pipe.c:988
 do_pipe2+0x9c/0x170 fs/pipe.c:1036
 __do_sys_pipe2 fs/pipe.c:1054 [inline]
 __se_sys_pipe2 fs/pipe.c:1052 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1052
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5244 tgid 5244 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2753 [inline]
 __put_partials+0x156/0x1a0 mm/slub.c:3218
 put_cpu_partial+0x17c/0x250 mm/slub.c:3293
 __slab_free+0x2d5/0x3c0 mm/slub.c:4550
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 do_readlinkat+0xbc/0x500 fs/stat.c:575
 __do_sys_readlink fs/stat.c:613 [inline]
 __se_sys_readlink fs/stat.c:610 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:610
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a2d9100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807a2d9180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807a2d9200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                    ^
 ffff88807a2d9280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a2d9300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	e8 eb f2 d2 09       	call   0x9d2f2f0
   5:	89 c3                	mov    %eax,%ebx
   7:	83 f8 08             	cmp    $0x8,%eax
   a:	73 65                	jae    0x71
   c:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  13:	fc ff df
  16:	4c 8d 34 dd 10 ed bd 	lea    -0x724212f0(,%rbx,8),%r14
  1d:	8d
  1e:	4c 89 f0             	mov    %r14,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
* 2a:	74 08                	je     0x34 <-- trapping instruction
  2c:	4c 89 f7             	mov    %r14,%rdi
  2f:	e8 dc b8 7c 00       	call   0x7cb910
  34:	48 c7 c3 98 6f a1 92 	mov    $0xffffffff92a16f98,%rbx
  3b:	49 03 1e             	add    (%r14),%rbx
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


Tested on:

commit:         71ca59e2 Merge branch 'fix-bpf_strnstr-len-error'
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=143c1162580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=807fffde4ddbe9ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158e0134580000


