Return-Path: <bpf+bounces-67446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDAB43F0D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20E7A01B0A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6919322A11;
	Thu,  4 Sep 2025 14:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F18322A03
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996326; cv=none; b=Fh4AirJ5SVkdjfV8RtbtQCIfm+qeFOJhnYBaL94YjmywtQckIEkMkQY6GnLSeIhtY9icPO9cnJwkzSbdhjFTelLHx8zuW7EO4H4ip3jWtBPXeHaQUtXoaSBtGnfmV6rVT3FEhCRZrgV7+flFZkRtHgCg3jHhJBnLjOCQtJpL9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996326; c=relaxed/simple;
	bh=In+H4ULXihMXAIl7N/U1hBBkdqNZJtAnxtMM9lC4w8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oCSxLwlyWR14g/R5saniP1uCGd+jCLQOFIz6KeBwFxZIdu8+1008dq0H/J8w/Q0/wC7xb6w6nuFvE6A+Ec6uOWaCSIStOP9MWWyvni70sw2jjXluX5l5jbe2kzAZy7YexzWVOTJWsKZMChKvOD2pHbnY+ancDzAhspCBpM6CQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88731310ba4so216145739f.3
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 07:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996324; x=1757601124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jKoZmmsCs2Z38AV9tRaNbzzgASYhc49jaUgSQP5Jus=;
        b=EVu+K3SoSud+J4SSus6UK22jGh5ytZMQzTra+0auONBtngiCFkSZquyrOOQqv7+Jdf
         QgwjgafMzEriOeujKumShkMEtG+VtRR8+NitEQQxLyMl8OGt/ZR3RiwJBPRgKROjeVz4
         eqQlIBbcRmhtUTWgweGXPCoAX9mM527sT5H0Lwa8xpe1GW0oCEoCj0Z6PyH+/LTFPep4
         F0Btyep3DO5TU6imOhxX//6/cdqBtuQHF6w5cipC3NmQhNkrJYVs7+vM0e3Ep06eMyC9
         5G+b9/aWuVFd9zVSdcG3iOxAiApHU/pQePIeBdmm3LTmWrfN7spXPVbQBakIdZL+jH0U
         bo8g==
X-Gm-Message-State: AOJu0YzqkQevfUc3sj0mVMrbelAhVvuorDWq0nm6I1IBIFAfhL7Y0FGb
	26PPm+cQm+LksLYwu0iVge/IBXmJ58+CDebFIs0uyOgrwhbuZD8yJsznL8RFf8/c6U/6dzEZnWC
	f1xenexje34HBdqTPPSeQwbs542101CdEjUdta00zFhVYACXiqpF7RqED804=
X-Google-Smtp-Source: AGHT+IG+CDBhcnwNucXmuckDivC00si4Bw4cKf0JEqotnlEpRNXnyi2jjSUYivSmLiQZew+TladJqNgnpI1ut3o4lg2l5Z3SsWNI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:104c:b0:3f6:6068:8382 with SMTP id
 e9e14a558f8ab-3f6606885d5mr66676875ab.31.1756996323655; Thu, 04 Sep 2025
 07:32:03 -0700 (PDT)
Date: Thu, 04 Sep 2025 07:32:03 -0700
In-Reply-To: <20250904141113.40660-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9a2e3.a00a0220.eb3d.0005.GAE@google.com>
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
Write of size 8 at addr ffff88802fd43258 by task syz.3.65/6980

CPU: 1 UID: 0 PID: 6980 Comm: syz.3.65 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 4b 87 4b f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 93 2e 14 f6 65 8b 05 6c 71 24 07 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc90003f6fc60 EFLAGS: 00000206
RAX: 237d7f7a06c71d00 RBX: 0000000000000a06 RCX: 237d7f7a06c71d00
RDX: 0000000000000006 RSI: ffffffff8d9b68b0 RDI: 0000000000000001
RBP: ffffc90003f6fcf0 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: dffffc0000000000
R13: ffff8880641d6a40 R14: ffff888057cc1000 R15: 1ffff920007edf8c
 __do_sys_perf_event_open kernel/events/core.c:13712 [inline]
 __se_sys_perf_event_open+0x1942/0x1d70 kernel/events/core.c:13353
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9da58ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd9db415038 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fd9da7b5fa0 RCX: 00007fd9da58ebe9
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 00002000000003c0
RBP: 00007fd9da611e19 R08: 0000000000000003 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd9da7b6038 R14: 00007fd9da7b5fa0 R15: 00007ffee6a22f78
 </TASK>

Allocated by task 6980:
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

The buggy address belongs to the object at ffff88802fd43000
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 24 bytes to the right of
 allocated 576-byte region [ffff88802fd43000, ffff88802fd43240)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2fd40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88806f32bf01
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a44b280 ffffea0001e83e00 dead000000000003
raw: 0000000000000000 0000000080100010 00000000f5000000 ffff88806f32bf01
head: 00fff00000000040 ffff88801a44b280 ffffea0001e83e00 dead000000000003
head: 0000000000000000 0000000080100010 00000000f5000000 ffff88806f32bf01
head: 00fff00000000003 ffffea0000bf5001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5882, tgid 5882 (syz-executor), ts 81348212299, free_ts 80466086651
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
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __register_sysctl_table+0x72/0x1340 fs/proc/proc_sysctl.c:1379
 neigh_sysctl_register+0x9a2/0xa80 net/core/neighbour.c:3887
 devinet_sysctl_register+0xad/0x200 net/ipv4/devinet.c:2715
 inetdev_init+0x2b4/0x500 net/ipv4/devinet.c:291
 inetdev_event+0x301/0x15b0 net/ipv4/devinet.c:1591
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11227
 __ip_tunnel_create+0x3e7/0x560 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2ba/0x800 net/ipv4/ip_tunnel.c:1161
page last free pid 5526 tgid 5526 stack trace:
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
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4281
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6665
 sock_alloc_send_pskb+0x857/0x990 net/core/sock.c:2980
 unix_dgram_sendmsg+0x461/0x1850 net/unix/af_unix.c:2153
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 sock_write_iter+0x258/0x330 net/socket.c:1179
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c6/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738

Memory state around the buggy address:
 ffff88802fd43100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802fd43180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802fd43200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                    ^
 ffff88802fd43280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802fd43300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	74 05                	je     0x7
   2:	e8 4b 87 4b f6       	call   0xf64b8752
   7:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   e:	00 00
  10:	9c                   	pushf
  11:	8f 44 24 20          	pop    0x20(%rsp)
  15:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  1a:	75 4f                	jne    0x6b
  1c:	f7 c3 00 02 00 00    	test   $0x200,%ebx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 93 2e 14 f6       	call   0xf6142ec2 <-- trapping instruction
  2f:	65 8b 05 6c 71 24 07 	mov    %gs:0x724716c(%rip),%eax        # 0x72471a2
  36:	85 c0                	test   %eax,%eax
  38:	74 40                	je     0x7a
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


Tested on:

commit:         71ca59e2 Merge branch 'fix-bpf_strnstr-len-error'
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=127c3e62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=807fffde4ddbe9ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1381fe62580000


