Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6631DC6F
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhBQPhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 10:37:36 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40888 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbhBQPhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 10:37:02 -0500
Received: by mail-il1-f197.google.com with SMTP id j7so10667888ilu.7
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 07:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=V4Slvj7ntItWb8LzbQuB3PGx+xGHcyKbdozov7Qt7lI=;
        b=MF1+Eo9xbxuhOHFI+uQesr0Dyfc4nipcvbBSDiDXDcAvYzC6ipC0ABS3Ze+X1Yndeg
         uMObCR1DxiKnlbk3+WC5kIQ0e/KWyKHziFqPhwA4Uqaiav+vPMfiAVUuy1m4d/VQzLin
         qO+UBTY5JD30tyLWcKHkxh3E+ycrB7EJcqGG6BWtTjAx0Kq7q/ANl8Q0RZWmXKaxIi98
         h8LI1trlVfxuGYPV653Tmu4Uaq6YRtaIDuz34QtDSQjfTlIaX8Ej1YVQHREX0k6FtPbY
         0txwf8Bss4RLfg7XNF+k4HWnoGGjS+MS5RyhRfLXMgeUdoznePh2+eseftwDg7y4dyrg
         GAsw==
X-Gm-Message-State: AOAM531app/KKJYiW3hskIgHYGYN5F6ltfASXrKhDjqGbeHnv+rpxig9
        A0NvYP4Ec/aFlRmL6gk4SP7KgswPMd/lf2jFECRs64cnsUZK
X-Google-Smtp-Source: ABdhPJwgAEC7qF6eNYsfvsTmw4p7UvOxm9s2KQY08Zb+4hyEMst1uTKC/KKT6eRjBQ69wihPAg1MZbbH8J1+s6n6maFipQ/EyQbK
MIME-Version: 1.0
X-Received: by 2002:a92:8711:: with SMTP id m17mr20639780ild.48.1613576181017;
 Wed, 17 Feb 2021 07:36:21 -0800 (PST)
Date:   Wed, 17 Feb 2021 07:36:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016715505bb89fb93@google.com>
Subject: KASAN: use-after-free Read in tcp_current_mss
From:   syzbot <syzbot+ea948c9d0dedf6ff57b1@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    773dc50d Merge branch 'Xilinx-axienet-updates'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13460822d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc1ca9e55dc1f9f
dashboard link: https://syzkaller.appspot.com/bug?extid=ea948c9d0dedf6ff57b1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea948c9d0dedf6ff57b1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dst_mtu include/net/dst.h:201 [inline]
BUG: KASAN: use-after-free in tcp_current_mss+0x358/0x360 net/ipv4/tcp_output.c:1835
Read of size 8 at addr ffff88802943db08 by task syz-executor.2/11568

CPU: 0 PID: 11568 Comm: syz-executor.2 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 dst_mtu include/net/dst.h:201 [inline]
 tcp_current_mss+0x358/0x360 net/ipv4/tcp_output.c:1835
 tcp_send_mss+0x28/0x2b0 net/ipv4/tcp.c:943
 mptcp_sendmsg_frag+0x13b/0x1220 net/mptcp/protocol.c:1266
 mptcp_push_pending+0x2cc/0x650 net/mptcp/protocol.c:1477
 mptcp_sendmsg+0x1ffb/0x2830 net/mptcp/protocol.c:1692
 inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:638
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 sock_write_iter+0x289/0x3c0 net/socket.c:999
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465d99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc692d89188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056c0b0 RCX: 0000000000465d99
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000004bcf27 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c0b0
R13: 00007ffc258487df R14: 00007fc692d89300 R15: 0000000000022000

Allocated by task 11558:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
 kasan_slab_alloc include/linux/kasan.h:209 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2892 [inline]
 slab_alloc mm/slub.c:2900 [inline]
 kmem_cache_alloc+0x1c6/0x440 mm/slub.c:2905
 dst_alloc+0x9e/0x650 net/core/dst.c:93
 rt_dst_alloc+0x73/0x430 net/ipv4/route.c:1642
 __mkroute_output net/ipv4/route.c:2457 [inline]
 ip_route_output_key_hash_rcu+0x955/0x2ce0 net/ipv4/route.c:2684
 ip_route_output_key_hash+0x1a4/0x2f0 net/ipv4/route.c:2512
 __ip_route_output_key include/net/route.h:126 [inline]
 ip_route_output_flow+0x23/0x150 net/ipv4/route.c:2773
 ip_route_newports include/net/route.h:342 [inline]
 tcp_v4_connect+0x12d7/0x1c40 net/ipv4/tcp_ipv4.c:281
 tcp_v6_connect+0x733/0x1df0 net/ipv6/tcp_ipv6.c:248
 __inet_stream_connect+0x8c5/0xee0 net/ipv4/af_inet.c:661
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:725
 mptcp_stream_connect+0x156/0x800 net/mptcp/protocol.c:3200
 __sys_connect_file+0x155/0x1a0 net/socket.c:1835
 __sys_connect+0x161/0x190 net/socket.c:1852
 __do_sys_connect net/socket.c:1862 [inline]
 __se_sys_connect net/socket.c:1859 [inline]
 __x64_sys_connect+0x6f/0xb0 net/socket.c:1859
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 11559:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
 ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kmem_cache_free+0x82/0x350 mm/slub.c:3159
 dst_destroy+0x2bc/0x3c0 net/core/dst.c:129
 rcu_do_batch kernel/rcu/tree.c:2489 [inline]
 rcu_core+0x5eb/0xf00 kernel/rcu/tree.c:2723
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xc5/0xf0 mm/kasan/generic.c:344
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3038
 dst_release net/core/dst.c:179 [inline]
 dst_release+0x79/0xe0 net/core/dst.c:169
 tcp_disconnect+0xc26/0x1ec0 net/ipv4/tcp.c:3003
 __tcp_close+0x486/0x1170 net/ipv4/tcp.c:2745
 tcp_close+0x29/0xc0 net/ipv4/tcp.c:2867
 inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
 inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:475
 __sock_release net/socket.c:597 [inline]
 sock_release+0x87/0x1b0 net/socket.c:625
 rds_tcp_accept_one+0x5fc/0xc10 net/rds/tcp_listen.c:220
 rds_tcp_accept_worker+0x50/0x80 net/rds/tcp.c:515
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xc5/0xf0 mm/kasan/generic.c:344
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3038
 dst_release net/core/dst.c:179 [inline]
 dst_release+0x79/0xe0 net/core/dst.c:169
 inet_sock_destruct+0x600/0x830 net/ipv4/af_inet.c:160
 __sk_destruct+0x4b/0x900 net/core/sock.c:1795
 rcu_do_batch kernel/rcu/tree.c:2489 [inline]
 rcu_core+0x5eb/0xf00 kernel/rcu/tree.c:2723
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343

The buggy address belongs to the object at ffff88802943db00
 which belongs to the cache ip_dst_cache of size 176
The buggy address is located 8 bytes inside of
 176-byte region [ffff88802943db00, ffff88802943dbb0)
The buggy address belongs to the page:
page:0000000019369b4d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2943d
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888141745a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802943da00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802943da80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff88802943db00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802943db80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff88802943dc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
