Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69835957F3
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiHPKUI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiHPKTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 06:19:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F4119452
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 01:00:27 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l18-20020a6bd112000000b0067cb64ad9b2so5620864iob.20
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 01:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/u2jeEEoiyJZpO0ZrnI7yKagwWTGYr7cBjjav6KTDEQ=;
        b=8QVpPBM0DMmY3Zwa8emz49lvCdo/bDQVdYPwCuflfV3Y705UgjIwuRpCROhFD/kzCJ
         Xq8sx8DEkze+FYUDymRld+UTQLLCik5qezf6asH6dRXhpdVlcPPnyNzJqlzHNDhmGikS
         YO9OsP4gx5oLEoS73WdisDGtxyiT0Mqa78xDK3Kcio/Q1QEjZckCdzm7+04SHNW4DXYf
         kyc4Oaej8K2Le/dgq2AQPKUtq93dgV95I4DKWeVa3piiVLkzC/1kbVg+UxqMR68SFNc3
         eJcWM/HMVuyFkLT+22n5S/P8gVl3OdLxiXege2rYqivCkJhMJTA1DjdOGPglWXiWJILC
         SBGA==
X-Gm-Message-State: ACgBeo3ux7OUax6IbYW9za/VhEKv3ryGEy00Dh9oOh3JWZevPGCQBCur
        KF8oQJGL1qqgmUbcjQptZ9dBAEKjqzZcYW8JP1ZPsexhmTFC
X-Google-Smtp-Source: AA6agR758k4dVTcV3GFPZiuhqFH7+ge5uru4PHLGXVTxvhhWRcfxjVGblr3p5btRyPYAJjX7pupVHyDUWWNXSwQqR1eJN/p0CFh8
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:2df:1aae:47c4 with SMTP id
 q14-20020a92ca4e000000b002df1aae47c4mr9068356ilo.57.1660636826976; Tue, 16
 Aug 2022 01:00:26 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:00:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c46ec05e6572415@google.com>
Subject: [syzbot] KASAN: use-after-free Read in sock_has_perm
From:   syzbot <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com>
To:     anton@enomsg.org, bpf@vger.kernel.org, ccross@android.com,
        eparis@parisplace.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16021dfd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2886ebe3c7b3459
dashboard link: https://syzkaller.appspot.com/bug?extid=2f2c6bea25b08dc06f86
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
Read of size 8 at addr ffff88807630e480 by task syz-executor.0/8123

CPU: 1 PID: 8123 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x467 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
 selinux_socket_setsockopt+0x3e/0x80 security/selinux/hooks.c:4913
 security_socket_setsockopt+0x50/0xb0 security/security.c:2249
 __sys_setsockopt+0x107/0x6a0 net/socket.c:2233
 __do_sys_setsockopt net/socket.c:2266 [inline]
 __se_sys_setsockopt net/socket.c:2263 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2263
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f96c7289279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96c842f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f96c739c050 RCX: 00007f96c7289279
RDX: 0000000000000007 RSI: 0000000000000103 RDI: 0000000000000004
RBP: 00007f96c72e3189 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7030593f R14: 00007f96c842f300 R15: 0000000000022000
 </TASK>

Allocated by task 8113:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:525
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __do_kmalloc mm/slab.c:3696 [inline]
 __kmalloc+0x209/0x4e0 mm/slab.c:3705
 kmalloc include/linux/slab.h:605 [inline]
 sk_prot_alloc+0x110/0x290 net/core/sock.c:1975
 sk_alloc+0x36/0x770 net/core/sock.c:2028
 nr_create+0xb2/0x5f0 net/netrom/af_netrom.c:433
 __sock_create+0x355/0x790 net/socket.c:1515
 sock_create net/socket.c:1566 [inline]
 __sys_socket_create net/socket.c:1603 [inline]
 __sys_socket_create net/socket.c:1588 [inline]
 __sys_socket+0x12f/0x240 net/socket.c:1636
 __do_sys_socket net/socket.c:1649 [inline]
 __se_sys_socket net/socket.c:1647 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 15:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x13d/0x180 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x173/0x390 mm/slab.c:3796
 sk_prot_free net/core/sock.c:2011 [inline]
 __sk_destruct+0x5e5/0x710 net/core/sock.c:2097
 sk_destruct net/core/sock.c:2112 [inline]
 __sk_free+0x1a4/0x4a0 net/core/sock.c:2123
 sk_free+0x78/0xa0 net/core/sock.c:2134
 sock_put include/net/sock.h:1927 [inline]
 nr_heartbeat_expiry+0x2de/0x460 net/netrom/nr_timer.c:148
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x679/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571

The buggy address belongs to the object at ffff88807630e000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1152 bytes inside of
 2048-byte region [ffff88807630e000, ffff88807630e800)

The buggy address belongs to the physical page:
page:ffffea0001d8c380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7630e
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00004a5648 ffffea0001e43248 ffff888011840800
raw: 0000000000000000 ffff88807630e000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x3c20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE), pid 7307, tgid 7301 (syz-executor.3), ts 520580080833, free_ts 520081225704
 prep_new_page mm/page_alloc.c:2457 [inline]
 get_page_from_freelist+0x1298/0x3b80 mm/page_alloc.c:4203
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5431
 __alloc_pages_node include/linux/gfp.h:587 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x350 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3024 [inline]
 ____cache_alloc mm/slab.c:3007 [inline]
 slab_alloc_node mm/slab.c:3227 [inline]
 kmem_cache_alloc_node_trace+0x51d/0x5b0 mm/slab.c:3611
 __do_kmalloc_node mm/slab.c:3633 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3648
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1434 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 audit_buffer_alloc kernel/audit.c:1782 [inline]
 audit_log_start.part.0+0x27f/0x740 kernel/audit.c:1900
 audit_log_start+0x5f/0x90 kernel/audit.c:1856
 integrity_audit_message+0xf6/0x470 security/integrity/integrity_audit.c:47
 integrity_audit_msg+0x3d/0x50 security/integrity/integrity_audit.c:32
 ima_collect_measurement+0x3b7/0x710 security/integrity/ima/ima_api.c:317
 process_measurement+0xd0d/0x1880 security/integrity/ima/ima_main.c:337
 ima_file_check+0xac/0x100 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3501 [inline]
 path_openat+0x1611/0x28f0 fs/namei.c:3632
 do_filp_open+0x1b6/0x400 fs/namei.c:3659
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3344 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3439
 __vunmap+0x85d/0xd30 mm/vmalloc.c:2665
 free_work+0x58/0x70 mm/vmalloc.c:97
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88807630e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807630e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807630e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807630e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807630e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
