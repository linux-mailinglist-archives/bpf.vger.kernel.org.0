Return-Path: <bpf+bounces-8890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63378C021
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BBF280FCE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA114AAB;
	Tue, 29 Aug 2023 08:21:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCE63BE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:21:02 +0000 (UTC)
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13DE9
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:21:00 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-56c2d67da6aso2667474a12.2
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297260; x=1693902060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh/pEQLMKgKobYvE5PMRD39Z7EHs1MTaXWjLouRz2yc=;
        b=LIZRYPYSRmjg69YJeNyqKToqpel1Sg9I7JCp5wo49vavpU2G0DT+NgUliir0fw+52p
         b+dROLPIOvLsEEMO3Dc1WCjA7WLz3qLTdDuzRSLYjWUlBH79UhxQXhSUJ540xET99KDj
         C9RhuQZixzVqD6eCIT+FI+/1o53/xrHq1cSp8q6TCBdjH8e4d4YjtkBkGoStBPZvEkSl
         AyKd3ElJTcPJXc07OKArursKhzXuT7vNbJsAzXup4Z/5K6z3iTzdlmZUY4dJsci08/vL
         V8bOmPOuEagANeXQQqgMRTymy5sibGn/okc/EbCBnx0xpCbhr0b1j7thIu7N7wEv8jSn
         RuIA==
X-Gm-Message-State: AOJu0YzPI0/UF7bHRDFTUbG/7g33ewO942YtRKkofXp4MXHtWsty5aMA
	vJjlPmvOJ2JTS95x+cgCpp190j6zUPATUAG9lGQ6f8o8tNQj
X-Google-Smtp-Source: AGHT+IED70DLyywoz/DasvF/rG73oZGQsC6t1BTPxNqoJ5LszXXhwpc4Q4xsrgOo8gmrxjoGdmVniOQA3qKuzMw9+GeBHXUpBsW3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:3546:0:b0:55a:b9bb:7ca with SMTP id
 c67-20020a633546000000b0055ab9bb07camr3919796pga.10.1693297260049; Tue, 29
 Aug 2023 01:21:00 -0700 (PDT)
Date: Tue, 29 Aug 2023 01:20:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af3ba506040b7d0c@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in xsk_diag_dump
From: syzbot <syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jonathan.lemon@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    5c905279a1b7 Merge branch 'pds_core-error-handling-fixes'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16080070680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
dashboard link: https://syzkaller.appspot.com/bug?extid=822d1359297e2694f873
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec63a7a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109926eba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98add120b6e5/disk-5c905279.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9e9009eadbd/vmlinux-5c905279.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b840142cc0c1/bzImage-5c905279.xz

The issue was bisected to:

commit 18b1ab7aa76bde181bdb1ab19a87fa9523c32f21
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Mon Feb 28 09:45:52 2022 +0000

    xsk: Fix race at socket teardown

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c6229fa80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c6229fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6229fa80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")

==================================================================
BUG: KASAN: slab-use-after-free in xsk_diag_put_info net/xdp/xsk_diag.c:21 [inline]
BUG: KASAN: slab-use-after-free in xsk_diag_fill net/xdp/xsk_diag.c:114 [inline]
BUG: KASAN: slab-use-after-free in xsk_diag_dump+0x1573/0x15c0 net/xdp/xsk_diag.c:163
Read of size 4 at addr ffff8880789da0e0 by task syz-executor370/5025

CPU: 1 PID: 5025 Comm: syz-executor370 Not tainted 6.5.0-rc7-syzkaller-00108-g5c905279a1b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 xsk_diag_put_info net/xdp/xsk_diag.c:21 [inline]
 xsk_diag_fill net/xdp/xsk_diag.c:114 [inline]
 xsk_diag_dump+0x1573/0x15c0 net/xdp/xsk_diag.c:163
 netlink_dump+0x588/0xca0 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x6d0/0x9c0 net/netlink/af_netlink.c:2376
 netlink_dump_start include/linux/netlink.h:330 [inline]
 xsk_diag_handler_dump+0x1a6/0x240 net/xdp/xsk_diag.c:190
 __sock_diag_cmd net/core/sock_diag.c:238 [inline]
 sock_diag_rcv_msg+0x316/0x440 net/core/sock_diag.c:269
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 sock_write_iter+0x29b/0x3d0 net/socket.c:1129
 call_write_iter include/linux/fs.h:1877 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_writev+0x221/0x700 fs/read_write.c:933
 do_writev+0x285/0x370 fs/read_write.c:976
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd9ce8b9df9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3b052168 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd9ce8b9df9
RDX: 0000000000000001 RSI: 00000000200003c0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5025:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node+0x60/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:720 [inline]
 kvzalloc include/linux/slab.h:728 [inline]
 alloc_netdev_mqs+0x9b/0x1240 net/core/dev.c:10594
 rtnl_create_link+0xc9c/0xfd0 net/core/rtnetlink.c:3350
 rtnl_newlink_create net/core/rtnetlink.c:3476 [inline]
 __rtnl_newlink+0x108e/0x1940 net/core/rtnetlink.c:3706
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3719
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6445
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5025:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook+0x10b/0x1e0 mm/slub.c:1818
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3814
 kvfree+0x47/0x50 mm/util.c:650
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:713 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:730
 netdev_run_todo+0x7dd/0x11d0 net/core/dev.c:10366
 rtnl_unlock net/core/rtnetlink.c:151 [inline]
 rtnetlink_rcv_msg+0x446/0xd30 net/core/rtnetlink.c:6446
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880789da000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 224 bytes inside of
 freed 4096-byte region [ffff8880789da000, ffff8880789db000)

The buggy address belongs to the physical page:
page:ffffea0001e27600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x789d8
head:ffffea0001e27600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801284f500 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4479, tgid 4479 (udevd), ts 29735533397, free_ts 28964079298
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node+0x4f/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:720 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x80b/0x1280 fs/seq_file.c:210
 kernfs_fop_read_iter+0x4c8/0x680 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:1871 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4e0/0x930 fs/read_write.c:470
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1401
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1433
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880789d9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880789da000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880789da080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880789da100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880789da180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

