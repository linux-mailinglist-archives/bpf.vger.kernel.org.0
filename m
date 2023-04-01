Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB66D2EFB
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjDAIBr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjDAIBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 04:01:46 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F1C15F
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 01:01:42 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id r14-20020a056e02108e00b00326334613f0so5922237ilj.20
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 01:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680336101; x=1682928101;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qBOGqOaadRuFQO62liIbJjTd+xAIkWEOXhFiBNLaLo=;
        b=1Qiz0h/igCvizUYNquPX5rgNjVkj2uEDpmz0yQLQr47nWhnQsM+qng4Al9L8QYKuF9
         VAj/DF2IcF88eUJyyxy3wOCZy3EfwiMTmO3GQ+Gv9/eLvSIikOEUjxfJwiNSs65V6toG
         eTyHCqEFLUoDZ6ToSdMY+UdWMgK30tJtlV/oHJ0EfxvJGFGqHmRB1C+G+xR0j4VyXWKd
         dAu4LXeg7dU90gn4+uIR1pvrap8oh7YIlpW18eFqKRvyVbeM1dNZnBknjBzbA3EI6oET
         KjDFaU+ka2TwuJk+tIrjotYi5JI2hw3QbsFZ5oXv/R05Uk508qs4DP3mrTlARgdeoTM0
         xzHQ==
X-Gm-Message-State: AAQBX9cYDsQZ59OwYc0nRP10jFKP5k+anNzIpNwrt+rnobgJLrpSDj53
        POgOPLycwbfqjG81KRw988g1C1Y+pYR4jYFE1kNS9O2C0zWD
X-Google-Smtp-Source: AKy350YNLi9vgrH0I0tvFvZPuepoB51h1sLErch3TpXQhX4NFcRx06NYuv+GpwRWwnwa1rqOnnfsINgrhX6QXwbRkxTQQ4Y2+G0L
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:def:b0:326:2ffa:8eac with SMTP id
 m15-20020a056e020def00b003262ffa8eacmr5038588ilj.1.1680336101639; Sat, 01 Apr
 2023 01:01:41 -0700 (PDT)
Date:   Sat, 01 Apr 2023 01:01:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000710c6d05f841bcd2@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-use-after-free Read in htab_map_alloc
From:   syzbot <syzbot+0f45ed57c2c97683562e@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a6d9e3034536 Add linux-next specific files for 20230330
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1698ec59c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=0f45ed57c2c97683562e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec1f900ea929/disk-a6d9e303.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fabbf89c0d22/vmlinux-a6d9e303.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ed05d6192fa/bzImage-a6d9e303.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f45ed57c2c97683562e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
Read of size 8 at addr ffff8880384c2360 by task syz-executor.2/27781

CPU: 0 PID: 27781 Comm: syz-executor.2 Not tainted 6.3.0-rc4-next-20230330-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
 htab_map_alloc+0xf4/0x1640 kernel/bpf/hashtab.c:487
 find_and_alloc_map kernel/bpf/syscall.c:134 [inline]
 map_create+0x508/0x1920 kernel/bpf/syscall.c:1159
 __sys_bpf+0x127f/0x53d0 kernel/bpf/syscall.c:5044
 __do_sys_bpf kernel/bpf/syscall.c:5166 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5164 [inline]
 __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5164
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f62db68c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f62dc36e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f62db7abf80 RCX: 00007f62db68c0f9
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 0000000000000000
RBP: 00007f62db6e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8c3418ff R14: 00007f62dc36e300 R15: 0000000000022000
 </TASK>

Allocated by task 4640:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 ieee802_11_parse_elems_full+0x106/0x1340 net/mac80211/util.c:1609
 ieee802_11_parse_elems_crc.constprop.0+0x99/0xd0 net/mac80211/ieee80211_i.h:2311
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2318 [inline]
 ieee80211_bss_info_update+0x410/0xb50 net/mac80211/scan.c:212
 ieee80211_rx_bss_info net/mac80211/ibss.c:1120 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1609 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x18c4/0x2d50 net/mac80211/ibss.c:1638
 ieee80211_iface_process_skb net/mac80211/iface.c:1594 [inline]
 ieee80211_iface_work+0xa4d/0xd70 net/mac80211/iface.c:1648
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 insert_work+0x48/0x360 kernel/workqueue.c:1365
 __queue_work+0x5c6/0xfb0 kernel/workqueue.c:1526
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1674
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 insert_work+0x48/0x360 kernel/workqueue.c:1365
 __queue_work+0x5c6/0xfb0 kernel/workqueue.c:1526
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1674
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff8880384c2000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 864 bytes inside of
 freed 1024-byte region [ffff8880384c2000, ffff8880384c2400)

The buggy address belongs to the physical page:
page:ffffea0000e13000 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880384c1800 pfn:0x384c0
head:ffffea0000e13000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441dc0 ffffea0000e33610 ffffea0000e9d410
raw: ffff8880384c1800 000000000010000d 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5118, tgid 5118 (syz-executor.1), ts 283494273035, free_ts 0
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0xf75/0x2aa0 mm/page_alloc.c:3493
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4759
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x28e/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 bond_alloc_slave drivers/net/bonding/bond_main.c:1694 [inline]
 bond_enslave+0x4e0/0x5a00 drivers/net/bonding/bond_main.c:1931
 do_set_master+0x1c8/0x220 net/core/rtnetlink.c:2626
 do_setlink+0x89e/0x3d30 net/core/rtnetlink.c:2829
 __rtnl_newlink+0xd69/0x1840 net/core/rtnetlink.c:3626
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3673
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6388
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2572
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880384c2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880384c2280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880384c2300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880384c2380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880384c2400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
