Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847A5408D6
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiFGSDB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351432AbiFGSCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 14:02:03 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D2152B8A
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 10:44:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n12-20020a92260c000000b002d3c9fc68d6so14214658ile.19
        for <bpf@vger.kernel.org>; Tue, 07 Jun 2022 10:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n4BGUlmR4pR9XiF3XyHeZu8F5qF9HmIZfwhajJ2lW/Y=;
        b=nRvFmUrwYwKyfIMJvWtNs/Qc162zUD9GBjXn3/caobqvpUixouu57a2NbTycAtSvDT
         vIJVHaGd72U9LEl6fGu6RFYzi6sb2CXntRCgLboeicV4+cbyS0oeG/0JOV6Sb7qf4qPo
         BvB9QfbkpS1YY7sTVNkyn3V5UsEhuukqoDFPCoJ90lhV5J9hKHUo0zQgvdVrSp+73nR0
         roJbEZeuYSWCBYATm31MS8jp7enwH9CdWqq9MNC+VYB2VuNyGqTBKkD7fBtX/UChiXiy
         xZVQqkcdhzbuEGZiEwb315K5EL2pXpmXQWUyUG6pyJrcamPHl9EBWRZA39BPvqQIfVX8
         L7Lw==
X-Gm-Message-State: AOAM533dj7hMYCv8/KWtbaVrS+/+nxe9d34jxcCVopcmvcuR5PonMMpC
        Vi4YKrlZi3kKtGTGSHyUDL7V1IuYNqw4xJx4TRQBBA8F+VFP
X-Google-Smtp-Source: ABdhPJwK7agGyPU0cJZzCBiM9w+Bj0Ad574AkkUlbFR5a0VBP8sJtKar/+VtblzHI4g9hvnwjjEzlOSIqJi4kpUf4k+T4BRwFfUi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1c07:b0:331:a800:1062 with SMTP id
 ca7-20020a0566381c0700b00331a8001062mr6596705jab.4.1654623872095; Tue, 07 Jun
 2022 10:44:32 -0700 (PDT)
Date:   Tue, 07 Jun 2022 10:44:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022208805e0df247a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in inet_bind2_bucket_find
From:   syzbot <syzbot+98fd2d1422063b0f8c44@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, joannelkoong@gmail.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, kuniyu@amazon.co.jp, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
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

HEAD commit:    664a393a2663 Merge tag 'input-for-v5.19-rc0' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c9bf5bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b19cdd2d45cc221
dashboard link: https://syzkaller.appspot.com/bug?extid=98fd2d1422063b0f8c44
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154a123df00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b9d8cdf00000

The issue was bisected to:

commit d5a42de8bdbe25081f07b801d8b35f4d75a791f4
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Fri May 20 00:18:33 2022 +0000

    net: Add a second bind table hashed by port and address

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c72eedf00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c72eedf00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c72eedf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98fd2d1422063b0f8c44@syzkaller.appspotmail.com
Fixes: d5a42de8bdbe ("net: Add a second bind table hashed by port and address")

==================================================================
BUG: KASAN: use-after-free in read_pnet include/net/net_namespace.h:361 [inline]
BUG: KASAN: use-after-free in ib2_net include/net/inet_hashtables.h:116 [inline]
BUG: KASAN: use-after-free in check_bind2_bucket_match net/ipv4/inet_hashtables.c:765 [inline]
BUG: KASAN: use-after-free in inet_bind2_bucket_find+0x562/0x620 net/ipv4/inet_hashtables.c:819
Read of size 8 at addr ffff888020cbc980 by task syz-executor537/3958

CPU: 0 PID: 3958 Comm: syz-executor537 Not tainted 5.18.0-syzkaller-11080-g664a393a2663 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 read_pnet include/net/net_namespace.h:361 [inline]
 ib2_net include/net/inet_hashtables.h:116 [inline]
 check_bind2_bucket_match net/ipv4/inet_hashtables.c:765 [inline]
 inet_bind2_bucket_find+0x562/0x620 net/ipv4/inet_hashtables.c:819
 __inet_hash_connect+0xaaa/0x1450 net/ipv4/inet_hashtables.c:949
 dccp_v4_connect+0xc5c/0x16f0 net/dccp/ipv4.c:108
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x14f/0x190 net/socket.c:1979
 io_connect+0x15f/0x690 fs/io_uring.c:6724
 io_issue_sqe+0x40c6/0xa9c0 fs/io_uring.c:8351
 io_queue_sqe fs/io_uring.c:8706 [inline]
 io_req_task_submit+0xce/0x400 fs/io_uring.c:3066
 handle_tw_list fs/io_uring.c:2938 [inline]
 tctx_task_work+0x16a/0xe10 fs/io_uring.c:2967
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2372
 ptrace_report_syscall include/linux/ptrace.h:427 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:489 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0xdb/0x230 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f0041a50b99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0041a022f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000000200 RBX: 00007f0041ad8428 RCX: 00007f0041a50b99
RDX: 0000000000000000 RSI: 00000000000045f5 RDI: 0000000000000003
RBP: 00007f0041ad8420 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000009 R11: 0000000000000246 R12: 00007f0041aa6064
R13: 0000000000000003 R14: 00007f0041a02400 R15: 0000000000022000
 </TASK>

Allocated by task 3861:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 inet_bind2_bucket_create+0x37/0x360 net/ipv4/inet_hashtables.c:91
 __inet_hash_connect+0xef5/0x1450 net/ipv4/inet_hashtables.c:951
 dccp_v4_connect+0xc5c/0x16f0 net/dccp/ipv4.c:108
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x14f/0x190 net/socket.c:1979
 io_connect+0x15f/0x690 fs/io_uring.c:6724
 io_issue_sqe+0x40c6/0xa9c0 fs/io_uring.c:8351
 io_queue_sqe fs/io_uring.c:8706 [inline]
 io_submit_sqe fs/io_uring.c:8968 [inline]
 io_submit_sqes+0x16b0/0x8020 fs/io_uring.c:9079
 __do_sys_io_uring_enter+0x117f/0x2360 fs/io_uring.c:12008
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3861:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3524
 inet_bind2_bucket_destroy net/ipv4/inet_hashtables.c:137 [inline]
 inet_bind2_bucket_destroy net/ipv4/inet_hashtables.c:133 [inline]
 __inet_put_port net/ipv4/inet_hashtables.c:174 [inline]
 inet_put_port+0x4a0/0x6f0 net/ipv4/inet_hashtables.c:182
 dccp_set_state+0x1be/0x3a0 net/dccp/proto.c:103
 dccp_done+0x19/0x100 net/dccp/proto.c:138
 dccp_rcv_state_process+0xc31/0x1820 net/dccp/input.c:662
 dccp_v4_do_rcv+0xf9/0x1a0 net/dccp/ipv4.c:695
 sk_backlog_rcv include/net/sock.h:1061 [inline]
 __release_sock+0x134/0x3b0 net/core/sock.c:2849
 release_sock+0x54/0x1b0 net/core/sock.c:3404
 inet_stream_connect+0x76/0xa0 net/ipv4/af_inet.c:725
 __sys_connect_file+0x14f/0x190 net/socket.c:1979
 io_connect+0x15f/0x690 fs/io_uring.c:6724
 io_issue_sqe+0x40c6/0xa9c0 fs/io_uring.c:8351
 io_queue_sqe fs/io_uring.c:8706 [inline]
 io_submit_sqe fs/io_uring.c:8968 [inline]
 io_submit_sqes+0x16b0/0x8020 fs/io_uring.c:9079
 __do_sys_io_uring_enter+0x117f/0x2360 fs/io_uring.c:12008
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff888020cbc980
 which belongs to the cache dccp_bind2_bucket of size 56
The buggy address is located 0 bytes inside of
 56-byte region [ffff888020cbc980, ffff888020cbc9b8)

The buggy address belongs to the physical page:
page:ffffea0000832f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20cbc
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff88802393ca00
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 3856, tgid 3855 (syz-executor537), ts 156131029362, free_ts 153495137859
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x1290/0x3b70 mm/page_alloc.c:4198
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5426
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3239
 inet_bind2_bucket_create+0x37/0x360 net/ipv4/inet_hashtables.c:91
 __inet_hash_connect+0xef5/0x1450 net/ipv4/inet_hashtables.c:951
 dccp_v4_connect+0xc5c/0x16f0 net/dccp/ipv4.c:108
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x14f/0x190 net/socket.c:1979
 io_connect+0x15f/0x690 fs/io_uring.c:6724
 io_issue_sqe+0x40c6/0xa9c0 fs/io_uring.c:8351
 io_queue_sqe fs/io_uring.c:8706 [inline]
 io_submit_sqe fs/io_uring.c:8968 [inline]
 io_submit_sqes+0x16b0/0x8020 fs/io_uring.c:9079
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 kmem_cache_alloc_node+0x255/0x3f0 mm/slub.c:3264
 __alloc_skb+0x215/0x340 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1426 [inline]
 dccp_connect+0x204/0x720 net/dccp/output.c:560
 dccp_v4_connect+0x1140/0x16f0 net/dccp/ipv4.c:128
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x14f/0x190 net/socket.c:1979
 io_connect+0x15f/0x690 fs/io_uring.c:6724
 io_issue_sqe+0x40c6/0xa9c0 fs/io_uring.c:8351
 io_queue_sqe fs/io_uring.c:8706 [inline]
 io_submit_sqe fs/io_uring.c:8968 [inline]
 io_submit_sqes+0x16b0/0x8020 fs/io_uring.c:9079

Memory state around the buggy address:
 ffff888020cbc880: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
 ffff888020cbc900: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>ffff888020cbc980: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
                   ^
 ffff888020cbca00: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
 ffff888020cbca80: fa fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
