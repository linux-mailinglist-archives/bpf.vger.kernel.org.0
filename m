Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70963A553
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 10:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiK1Jpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 04:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1Jpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 04:45:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575A19034
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 01:45:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id w9-20020a056e021c8900b0030247910269so8271485ill.4
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 01:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym/OUSXcSo5j7eGB/rVFvkIyqO8xk7T9lTybvL0yzJY=;
        b=i18kdx3gUY+MR2lZXZncGusnqGRXoY7t8DaV0mw9INTp9DWwHFTfR8lqqyUsf1OZHT
         0+zUGyGVwnLuCSNcWbEf/fnbdf+PfLgyuYK7y3AK/nZ+L2rSitQ52WYLfyAmVFkblBYr
         ZgtnUn9GFeHxULy7rr8Dv38APnWXFOtKfiUzTcaKN9zhpi8T/x3w/t2WZTxG8X+pFXqn
         CKoJD/tcXcm/NsAazqW8HT4ypkAr4/g8ruxD7kS99jqvqnNYzBAxPwnpgOXjRuSPpO30
         C8G5bgWTzHo5YEDRRVw7MfRCjZeafsdZ6ZicC+U5sBfQPaslxMHIzBZ5+aoULJMK5uHF
         a7og==
X-Gm-Message-State: ANoB5pkyaqmpfLOsmVO6ugYPM7xZZQDUKqbYeKBss45NK1ZjvfJcFcr2
        kpVTBe2dgyAvat2qXxFOS8nAXRTPLK5FxMKHvttGu7KQkQ4v
X-Google-Smtp-Source: AA0mqf7g+BbAKhTFYouvOLM5l0TGyBqGOq2srTjREwc7lZRt0sFsgBV64ia/9Ymk1H03h2PGF4V/1juC3r29hVx5JcfiqfSWsIn0
MIME-Version: 1.0
X-Received: by 2002:a92:de48:0:b0:302:feee:c5c1 with SMTP id
 e8-20020a92de48000000b00302feeec5c1mr5622946ilr.257.1669628738943; Mon, 28
 Nov 2022 01:45:38 -0800 (PST)
Date:   Mon, 28 Nov 2022 01:45:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e444a205ee84bb27@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ip6_fragment (2)
From:   syzbot <syzbot+8c0ac31aa9681abb9e2d@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11625bb5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=436ee340148d5197
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0ac31aa9681abb9e2d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/74c2f7e0e278/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e596ae25a228/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35c136c2ae23/bzImage-4312098b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c0ac31aa9681abb9e2d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ip6_dst_idev include/net/ip6_fib.h:245 [inline]
BUG: KASAN: use-after-free in ip6_fragment+0x2724/0x2770 net/ipv6/ip6_output.c:951
Read of size 8 at addr ffff88801d403e80 by task syz-executor.3/7618

CPU: 1 PID: 7618 Comm: syz-executor.3 Not tainted 6.1.0-rc6-syzkaller-00012-g4312098baf37 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 ip6_dst_idev include/net/ip6_fib.h:245 [inline]
 ip6_fragment+0x2724/0x2770 net/ipv6/ip6_output.c:951
 __ip6_finish_output net/ipv6/ip6_output.c:193 [inline]
 ip6_finish_output+0x9a3/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:445 [inline]
 ip6_local_out+0xb3/0x1a0 net/ipv6/output_core.c:161
 ip6_send_skb+0xbb/0x340 net/ipv6/ip6_output.c:1966
 udp_v6_send_skb+0x82a/0x18a0 net/ipv6/udp.c:1286
 udp_v6_push_pending_frames+0x140/0x200 net/ipv6/udp.c:1313
 udpv6_sendmsg+0x18da/0x2c80 net/ipv6/udp.c:1606
 inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:665
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 sock_write_iter+0x295/0x3d0 net/socket.c:1108
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9ed/0xdd0 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fde3588c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde365b6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fde359ac050 RCX: 00007fde3588c0d9
RDX: 000000000000ffdc RSI: 00000000200000c0 RDI: 000000000000000a
RBP: 00007fde358e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fde35acfb1f R14: 00007fde365b6300 R15: 0000000000022000
 </TASK>

Allocated by task 7618:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x82/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x2b4/0x3d0 mm/slub.c:3422
 dst_alloc+0x14a/0x1f0 net/core/dst.c:92
 ip6_dst_alloc+0x32/0xa0 net/ipv6/route.c:344
 ip6_rt_pcpu_alloc net/ipv6/route.c:1369 [inline]
 rt6_make_pcpu_route net/ipv6/route.c:1417 [inline]
 ip6_pol_route+0x901/0x1190 net/ipv6/route.c:2254
 pol_lookup_func include/net/ip6_fib.h:582 [inline]
 fib6_rule_lookup+0x52e/0x6f0 net/ipv6/fib6_rules.c:121
 ip6_route_output_flags_noref+0x2e6/0x380 net/ipv6/route.c:2625
 ip6_route_output_flags+0x76/0x320 net/ipv6/route.c:2638
 ip6_route_output include/net/ip6_route.h:98 [inline]
 ip6_dst_lookup_tail+0x5ab/0x1620 net/ipv6/ip6_output.c:1092
 ip6_dst_lookup_flow+0x90/0x1d0 net/ipv6/ip6_output.c:1222
 ip6_sk_dst_lookup_flow+0x553/0x980 net/ipv6/ip6_output.c:1260
 udpv6_sendmsg+0x151d/0x2c80 net/ipv6/udp.c:1554
 inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:665
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 __sys_sendto+0x23a/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7599:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0xee/0x5c0 mm/slub.c:3683
 dst_destroy+0x2ea/0x400 net/core/dst.c:127
 rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2510
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x9d/0x820 kernel/rcu/tree.c:2798
 dst_release net/core/dst.c:177 [inline]
 dst_release+0x7d/0xe0 net/core/dst.c:167
 refdst_drop include/net/dst.h:256 [inline]
 skb_dst_drop include/net/dst.h:268 [inline]
 skb_release_head_state+0x250/0x2a0 net/core/skbuff.c:838
 skb_release_all net/core/skbuff.c:852 [inline]
 __kfree_skb net/core/skbuff.c:868 [inline]
 kfree_skb_reason+0x151/0x4b0 net/core/skbuff.c:891
 kfree_skb_list_reason+0x4b/0x70 net/core/skbuff.c:901
 kfree_skb_list include/linux/skbuff.h:1227 [inline]
 ip6_fragment+0x2026/0x2770 net/ipv6/ip6_output.c:949
 __ip6_finish_output net/ipv6/ip6_output.c:193 [inline]
 ip6_finish_output+0x9a3/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:445 [inline]
 ip6_local_out+0xb3/0x1a0 net/ipv6/output_core.c:161
 ip6_send_skb+0xbb/0x340 net/ipv6/ip6_output.c:1966
 udp_v6_send_skb+0x82a/0x18a0 net/ipv6/udp.c:1286
 udp_v6_push_pending_frames+0x140/0x200 net/ipv6/udp.c:1313
 udpv6_sendmsg+0x18da/0x2c80 net/ipv6/udp.c:1606
 inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:665
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 sock_write_iter+0x295/0x3d0 net/socket.c:1108
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9ed/0xdd0 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x9d/0x820 kernel/rcu/tree.c:2798
 dst_release net/core/dst.c:177 [inline]
 dst_release+0x7d/0xe0 net/core/dst.c:167
 refdst_drop include/net/dst.h:256 [inline]
 skb_dst_drop include/net/dst.h:268 [inline]
 __dev_queue_xmit+0x1b9d/0x3ba0 net/core/dev.c:4211
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 neigh_resolve_output net/core/neighbour.c:1552 [inline]
 neigh_resolve_output+0x51b/0x840 net/core/neighbour.c:1532
 neigh_output include/net/neighbour.h:546 [inline]
 ip6_finish_output2+0x56c/0x1530 net/ipv6/ip6_output.c:134
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x694/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:445 [inline]
 NF_HOOK include/linux/netfilter.h:302 [inline]
 NF_HOOK include/linux/netfilter.h:296 [inline]
 mld_sendpack+0xa09/0xe70 net/ipv6/mcast.c:1820
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x720/0xdc0 net/ipv6/mcast.c:2653
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88801d403dc0
 which belongs to the cache ip6_dst_cache of size 240
The buggy address is located 192 bytes inside of
 240-byte region [ffff88801d403dc0, ffff88801d403eb0)

The buggy address belongs to the physical page:
page:ffffea00007500c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d403
memcg:ffff888022f49c81
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001ef6580 dead000000000002 ffff88814addf640
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888022f49c81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 3719, tgid 3719 (kworker/0:6), ts 136223432244, free_ts 136222971441
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4288
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5555
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x31a/0x3d0 mm/slub.c:3422
 dst_alloc+0x14a/0x1f0 net/core/dst.c:92
 ip6_dst_alloc+0x32/0xa0 net/ipv6/route.c:344
 icmp6_dst_alloc+0x71/0x680 net/ipv6/route.c:3261
 mld_sendpack+0x5de/0xe70 net/ipv6/mcast.c:1809
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x720/0xdc0 net/ipv6/mcast.c:2653
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x4d0 mm/page_alloc.c:3483
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2586
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x184/0x210 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 kmem_cache_alloc_node+0x304/0x410 mm/slub.c:3443
 __alloc_skb+0x214/0x300 net/core/skbuff.c:497
 alloc_skb include/linux/skbuff.h:1267 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1191 [inline]
 netlink_sendmsg+0x9a6/0xe10 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 __sys_sendto+0x23a/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801d403d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88801d403e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801d403e80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88801d403f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801d403f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
