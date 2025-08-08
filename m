Return-Path: <bpf+bounces-65257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A925B1E366
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 09:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A287B1AD7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52824338F;
	Fri,  8 Aug 2025 07:30:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1222A4EB
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638217; cv=none; b=rBctf4aI+/pGUR9wA7dqjPGUnKBKmRIFHa/xC3X8GL/0i7gQ/JgJYWPCvqRjnqVU0fBAsf4ED3R4Gywyq63+mwwUO5K3ha1o5yrxitm7pUD3XyL/BsQ6EXA2yvFKAcsZ+hTDNEpQJ7L391lxFPIFbMBY5sfQhS16nb9CN/vlVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638217; c=relaxed/simple;
	bh=keg61B/+p9gqufvR1XQ9nMk8GgnCssYJR3R4TSC6mtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=TzzlD7HkC4jwzImq1DjtHEs0x4k8L2lyJdnuvcp18GHQMB1/CqaWb4+4MrCq+BhrVYazVfyQ7X0X+mPmsCNUqncQa7rV0x1uDLPg+j+FanaER0q9wCrDX1t3Iqt8/+SBeInkpQwqzyQCJ7m83KYFXMe7QuukVfDxIrygMxCBhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-881a05b0846so171356939f.1
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 00:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638214; x=1755243014;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CDXWPKDbSaaWMQnPXOZ1ZyCr/i3dxjvf7dpcEW3T/g=;
        b=leEmrkQycyUVGvhHJJcDa3EOMGO5FCLMGcBsgopoLMFN5CN2PGrIrOmwW2JVkOElr+
         oSJud5H9eZijwc+vyiGSch3w5C2j0Lwa4Fty1Sn4katve78hFg35WhtCDTH1GIIrnfTS
         yHH6Tt8uPrBL8qKb+MujcSn3jPTUPsaIUTrz22b0gL4FrbV6818bTPuhF5xuDDIttI7t
         rT/DqyDouhmbNLenbexHfUV5mQoqU5VmixeUCjRNMX0mWdT9Wu4WRwHLZXZvseRmGH+b
         Le+Jmt9WCCbhQNFH90j1NEeLkRsS3IVXMsiT6VoYuNjVQ0hW38Y51C0JtQjxCQ/8Bhqh
         fVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhhNbE0EAcjQvi2YMEZZHZf9QBtdGrBRs+MhQYZT8KBQt2E9g1Y2fVGor/DSPDFhc4sWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhzvTCUNg7dSQoquKPNvutqAJrNfNf/+NG30duh2qHHYpTR/n
	93gK/IfmHSw4RFAANfyGOuy4BhjF3Q4Wwqw8vFUJnFH4IH5zV5EdXeX3v2BelboFyHQN1MhaIFS
	scS8Rh2P/4i6WN4GeOXO6aPtvWFlcXcx1UgYCOrh4Ca24o337Husuh6FfBhw=
X-Google-Smtp-Source: AGHT+IG1vKLXhxfVsTKCbsHjpwNzYcuITkrI472OzzS/qNWdw3Km4FDuLtfxYLpAdcwY9YkMud0p0U5Y6AQ4T6KIbSgUkU0r3tXw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1648:b0:87c:a4e:fc7d with SMTP id
 ca18e2360f4ac-883f1279a2amr449278939f.14.1754638214551; Fri, 08 Aug 2025
 00:30:14 -0700 (PDT)
Date: Fri, 08 Aug 2025 00:30:14 -0700
In-Reply-To: <20250807175032.7381-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895a786.050a0220.7f033.0057.GAE@google.com>
Subject: [syzbot ci] Re: bpf: refactor max_depth computation in bpf_get_stack()
From: syzbot ci <syzbot+ci465abfb91e7946e5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] bpf: refactor max_depth computation in bpf_get_stack()
https://lore.kernel.org/all/20250807175032.7381-1-contact@arnaud-lcm.com
* [PATCH 1/2] bpf: refactor max_depth computation in bpf_get_stack()
* [PATCH 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()

and found the following issues:
* KASAN: stack-out-of-bounds Write in __bpf_get_stack
* PANIC: double fault in its_return_thunk

Full report is available here:
https://ci.syzbot.org/series/2af1b227-99e3-4e64-ac23-827848a4b8a5

***

KASAN: stack-out-of-bounds Write in __bpf_get_stack

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      f3af62b6cee8af9f07012051874af2d2a451f0e5
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/5e5c6698-7b84-4bf2-a1ee-1b6223c8d4c3/config
C repro:   https://ci.syzbot.org/findings/1355d710-d133-43fd-9061-18b2de6844a4/c_repro
syz repro: https://ci.syzbot.org/findings/1355d710-d133-43fd-9061-18b2de6844a4/syz_repro

netdevsim netdevsim1 netdevsim0: renamed from eth0
netdevsim netdevsim1 netdevsim1: renamed from eth1
==================================================================
BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x54a/0xa70 kernel/bpf/stackmap.c:501
Write of size 208 at addr ffffc90003655ee8 by task syz-executor/5952

CPU: 1 UID: 0 PID: 5952 Comm: syz-executor Not tainted 6.16.0-syzkaller-11113-gf3af62b6cee8-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 __bpf_get_stack+0x54a/0xa70 kernel/bpf/stackmap.c:501
 ____bpf_get_stack kernel/bpf/stackmap.c:525 [inline]
 bpf_get_stack+0x33/0x50 kernel/bpf/stackmap.c:522
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1835 [inline]
 bpf_get_stack_raw_tp+0x1a9/0x220 kernel/trace/bpf_trace.c:1825
 bpf_prog_4e330ebee64cb698+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run10+0x2e4/0x500 kernel/trace/bpf_trace.c:2306
 __bpf_trace_percpu_alloc_percpu+0x364/0x400 include/trace/events/percpu.h:11
 __do_trace_percpu_alloc_percpu include/trace/events/percpu.h:11 [inline]
 trace_percpu_alloc_percpu include/trace/events/percpu.h:11 [inline]
 pcpu_alloc_noprof+0x1534/0x16b0 mm/percpu.c:1892
 fib_nh_common_init+0x9c/0x3b0 net/ipv4/fib_semantics.c:620
 fib6_nh_init+0x1608/0x1ff0 net/ipv6/route.c:3671
 ip6_route_info_create_nh+0x16a/0xab0 net/ipv6/route.c:3892
 ip6_route_add+0x6e/0x1b0 net/ipv6/route.c:3944
 addrconf_add_mroute net/ipv6/addrconf.c:2552 [inline]
 addrconf_add_dev+0x24f/0x340 net/ipv6/addrconf.c:2570
 addrconf_dev_config net/ipv6/addrconf.c:3479 [inline]
 addrconf_init_auto_addrs+0x57c/0xa30 net/ipv6/addrconf.c:3567
 addrconf_notify+0xacc/0x1010 net/ipv6/addrconf.c:3740
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9608
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec5c790a7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007fff7b55f7b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fec5d4e35c0 RCX: 00007fec5c790a7c
RDX: 0000000000000030 RSI: 00007fec5d4e3610 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007fff7b55f804 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000006
R13: 0000000000000000 R14: 00007fec5d4e3610 R15: 0000000000000000
 </TASK>

The buggy address belongs to stack of task syz-executor/5952
 and is located at offset 296 in frame:
 __bpf_get_stack+0x0/0xa70 include/linux/mmap_lock.h:-1

This frame has 1 object:
 [32, 36) 'rctx.i'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc90003650000 allocated at copy_process+0x54b/0x3c00 kernel/fork.c:2002
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888024c63200 pfn:0x24c62
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888024c63200 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 5845, tgid 5845 (syz-executor), ts 59049058263, free_ts 59031992240
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
 vm_area_alloc_pages mm/vmalloc.c:3642 [inline]
 __vmalloc_area_node mm/vmalloc.c:3720 [inline]
 __vmalloc_node_range_noprof+0x97d/0x12f0 mm/vmalloc.c:3893
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3956
 alloc_thread_stack_node kernel/fork.c:318 [inline]
 dup_task_struct+0x3e7/0x860 kernel/fork.c:879
 copy_process+0x54b/0x3c00 kernel/fork.c:2002
 kernel_clone+0x21e/0x840 kernel/fork.c:2603
 __do_sys_clone3 kernel/fork.c:2907 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2886
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5907 tgid 5907 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90003655e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003655e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003655f00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f2 f2
                                           ^
 ffffc90003655f80: 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3
 ffffc90003656000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


***

PANIC: double fault in its_return_thunk

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      f3af62b6cee8af9f07012051874af2d2a451f0e5
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/5e5c6698-7b84-4bf2-a1ee-1b6223c8d4c3/config
C repro:   https://ci.syzbot.org/findings/1bf5dce6-467f-4bcd-9357-2726101d2ad1/c_repro
syz repro: https://ci.syzbot.org/findings/1bf5dce6-467f-4bcd-9357-2726101d2ad1/syz_repro

traps: PANIC: double fault, error_code: 0x0
Oops: double fault: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5789 Comm: syz-executor930 Not tainted 6.16.0-syzkaller-11113-gf3af62b6cee8-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:its_return_thunk+0x0/0x10 arch/x86/lib/retpoline.S:412
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <c3> cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e9 6b 2b b9 f5 cc
RSP: 0018:ffffffffa0000877 EFLAGS: 00010246
RAX: 2161df6de464b300 RBX: 4800be48c0315641 RCX: 2161df6de464b300
RDX: 0000000000000000 RSI: ffffffff8dba01ee RDI: ffff888105cc9cc0
RBP: eb7a3aa9e9c95e41 R08: ffffffff81000130 R09: ffffffff81000130
R10: ffffffff81d017ac R11: ffffffff8b7707da R12: 3145ffff888028c3
R13: ee8948f875894cf6 R14: 000002baf8c68348 R15: e1cb3861e8c93100
FS:  0000555557cbc380(0000) GS:ffff8880b862a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa0000868 CR3: 0000000028468000 CR4: 00000000000006f0
Call Trace:
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:its_return_thunk+0x0/0x10 arch/x86/lib/retpoline.S:412
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <c3> cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e9 6b 2b b9 f5 cc
RSP: 0018:ffffffffa0000877 EFLAGS: 00010246
RAX: 2161df6de464b300 RBX: 4800be48c0315641 RCX: 2161df6de464b300
RDX: 0000000000000000 RSI: ffffffff8dba01ee RDI: ffff888105cc9cc0
RBP: eb7a3aa9e9c95e41 R08: ffffffff81000130 R09: ffffffff81000130
R10: ffffffff81d017ac R11: ffffffff8b7707da R12: 3145ffff888028c3
R13: ee8948f875894cf6 R14: 000002baf8c68348 R15: e1cb3861e8c93100
FS:  0000555557cbc380(0000) GS:ffff8880b862a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa0000868 CR3: 0000000028468000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
  16:	cc                   	int3
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	cc                   	int3
  22:	cc                   	int3
  23:	cc                   	int3
  24:	cc                   	int3
  25:	cc                   	int3
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	e9 6b 2b b9 f5       	jmp    0xf5b92baa
  3f:	cc                   	int3


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

