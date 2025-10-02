Return-Path: <bpf+bounces-70182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80796BB2A53
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB2D19C0390
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BC27A913;
	Thu,  2 Oct 2025 06:48:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83F1A76BC
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387725; cv=none; b=mhfBVtXPU47Wc6tOzMPHrFClpoY6xL5TZLuF5P7/wf7K4hnRSyhbvYNsDOS8bVUF8hucJRCySfkWxE8sbK18SdoytnQGvycu6EQAYT8+nlJ4Sy6rb1Qc5xk8wzEfKO1pQaZMfrFVvjlAPoYlgZzVsxu//6mV/AHeBeuVM8+Q7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387725; c=relaxed/simple;
	bh=J/lBfDjzp7sK7BVAC3wbubf3b359BTCiuUSAx+HlcM4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OSOlIfvSe/DPBfL6wug86nTWC6WRtrVLF/MsG9wmzJ2WjXb0nD/wZAbyT/AnymkHmdxx0PqZ54mYDeHf/2/B1FXoCYCKq4L9t+AQ6tGFcSkVXo4nTHuEE6e3UlABaigyuEpI9tcUX+xWgTwHdH6oTqRbOHvskYk8SKz20gUofoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-91fbba9a0f7so85934239f.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 23:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759387722; x=1759992522;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsAoquJXWOrxnpoHBB3ShRijd8y7bShVqqcx6EXKYgI=;
        b=qvkieJRx3SjfZM1LNq2k82HpwBeuAaenmgdrbUwpPEvruusHoRfCGRwCmhRShK7hH5
         Mr3U/UWQ3aS65A3rLtUFYp/o46f9jGuAZgfSV1MlBBLYZsyAgX46LLo5oMHGRpbxtjTy
         RjD9dSOVE/+o7YRrv/P5aqpwHAeSdbb6l1u2Pq7qz7f1nIh7sr/Yc+7EkDGy1O2A1WcC
         3Y2Vngo1bxVx+8QbsHHCye82tLOMg137omoodNllp7nANkkXMyQHiI5hUMY//lOEBCTQ
         sKY11mg+Luyq2gHyvjetDq2TeaU0yEbrbx0QM6XEggZVFd4SLlpLsIYiWRZaWJ2idbb7
         GzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8rA+14lTgotAgCcmgmvoojwJ1cpqOJg/GmC7ppnvFn+/Ew6VTfPriFBXUvp6I34z3g8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw51Ne7yoWG5Mak2h+EAfytelIocvh/8QVbSa3gLkTDWBBjNNE
	67TvjCtNA/X1GtP2gWWJWVHJZoDGZkVgUI1FbBdwnb3O9elITF/g+NeKwqS+ODpEWZqgRMKQ7DF
	3Fu4tkCkSjy9zKzT8ipL8TCLVCv8d0zcFvtXqnVJ7UXi0vqb6Cx/NXZ3GsjU=
X-Google-Smtp-Source: AGHT+IHX7zWS0uHMOZd6D0aYAIknzssSiYxJeHMPY5sJ1Fbb0HuMlZ7kVdegDwo4DzQyE1saGpRAerpMNvKBpRAL6XbK1BY9ccPr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c7:b0:927:17a1:e865 with SMTP id
 ca18e2360f4ac-937a87fa564mr833230339f.6.1759387722405; Wed, 01 Oct 2025
 23:48:42 -0700 (PDT)
Date: Wed, 01 Oct 2025 23:48:42 -0700
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de204a.050a0220.1696c6.002d.GAE@google.com>
Subject: [syzbot ci] Re: Support non-linear skbs for BPF_PROG_TEST_RUN
From: syzbot ci <syzbot+ci5eb67f3916ab3265@syzkaller.appspotmail.com>
To: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@linux.dev, paul.chaignon@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v4] Support non-linear skbs for BPF_PROG_TEST_RUN
https://lore.kernel.org/all/cover.1759341538.git.paul.chaignon@gmail.com
* [PATCH bpf-next v4 1/5] bpf: Refactor cleanup of bpf_prog_test_run_skb
* [PATCH bpf-next v4 2/5] bpf: Reorder bpf_prog_test_run_skb initialization
* [PATCH bpf-next v4 3/5] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
* [PATCH bpf-next v4 4/5] selftests/bpf: Support non-linear flag in test loader
* [PATCH bpf-next v4 5/5] selftests/bpf: Test direct packet access on non-linear skbs

and found the following issue:
KASAN: invalid-free in bpf_prog_test_run_skb

Full report is available here:
https://ci.syzbot.org/series/356d4048-147c-4079-ae1f-94b437c8f9ef

***

KASAN: invalid-free in bpf_prog_test_run_skb

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4ef77dd584cfd915526328f516fec59e3a54d66e
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/e93ac4a0-f0c0-48d2-b7f6-3c9dfeba06d8/config
C repro:   https://ci.syzbot.org/findings/d21cac8a-ab8d-4fbe-972c-dd47b243d83e/c_repro
syz repro: https://ci.syzbot.org/findings/d21cac8a-ab8d-4fbe-972c-dd47b243d83e/syz_repro

==================================================================
BUG: KASAN: double-free in bpf_prog_test_run_skb+0x568/0x1bd0 net/bpf/test_run.c:1198
Free of addr ffff88810f002c00 by task syz.0.17/5995

CPU: 1 UID: 0 PID: 5995 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
 kasan_slab_pre_free include/linux/kasan.h:198 [inline]
 slab_free_hook mm/slub.c:2367 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x13f/0x440 mm/slub.c:4894
 bpf_prog_test_run_skb+0x568/0x1bd0 net/bpf/test_run.c:1198
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4673
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba7578ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3f323258 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fba759d5fa0 RCX: 00007fba7578ec29
RDX: 0000000000000050 RSI: 0000200000002300 RDI: 000000000000000a
RBP: 00007fba75811e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fba759d5fa0 R14: 00007fba759d5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 5995:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_krealloc+0xe7/0x140 mm/kasan/common.c:475
 kasan_krealloc include/linux/kasan.h:280 [inline]
 __do_krealloc mm/slub.c:4953 [inline]
 krealloc_noprof+0x1b8/0x340 mm/slub.c:5010
 __slab_build_skb net/core/skbuff.c:400 [inline]
 slab_build_skb+0x8b/0x3e0 net/core/skbuff.c:420
 bpf_prog_test_run_skb+0x41b/0x1bd0 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4673
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5995:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x18e/0x440 mm/slub.c:4894
 skb_release_data+0x62d/0x7c0 net/core/skbuff.c:1086
 skb_release_all net/core/skbuff.c:1151 [inline]
 __kfree_skb net/core/skbuff.c:1165 [inline]
 sk_skb_reason_drop+0x127/0x170 net/core/skbuff.c:1203
 vti_tunnel_xmit+0xf5a/0x18b0 net/ipv4/ip_vti.c:-1
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x2d7/0x830 net/core/dev.c:3855
 __dev_queue_xmit+0x1b8d/0x3b50 net/core/dev.c:4725
 dev_queue_xmit include/linux/netdevice.h:3361 [inline]
 __bpf_tx_skb+0x18e/0x260 net/core/filter.c:2153
 ____bpf_clone_redirect net/core/filter.c:2478 [inline]
 bpf_clone_redirect+0x272/0x3d0 net/core/filter.c:2448
 bpf_prog_69c2527fbc57d46b+0x5f/0x68
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 bpf_test_run+0x318/0x7b0 net/bpf/test_run.c:434
 bpf_prog_test_run_skb+0xd42/0x1bd0 net/bpf/test_run.c:1153
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4673
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810f002c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 512-byte region [ffff88810f002c00, ffff88810f002e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10f000
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88801a441c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88801a441c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 057ff00000000002 ffffea00043c0001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5965, tgid 5965 (udevd), ts 56045734118, free_ts 55352678471
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x397/0xca0 fs/kernfs/file.c:623
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5594 tgid 5594 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x156/0x1a0 mm/slub.c:3223
 put_cpu_partial+0x17c/0x250 mm/slub.c:3298
 __slab_free+0x2d5/0x3c0 mm/slub.c:4565
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4292
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 netlink_sendmsg+0x5c6/0xb30 net/netlink/af_netlink.c:1871
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88810f002b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810f002b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88810f002c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88810f002c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810f002d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

