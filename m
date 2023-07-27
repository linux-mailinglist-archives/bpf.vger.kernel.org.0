Return-Path: <bpf+bounces-6065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C36765197
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E898D282283
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A981549E;
	Thu, 27 Jul 2023 10:46:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490410794
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 10:46:51 +0000 (UTC)
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5111FDD
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 03:46:47 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a1e6022b60so1834041b6e.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 03:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690454807; x=1691059607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvI6vtfQJFf8LXXcJyjBDqhJYmrLxLa/d2Tx/45QJ/4=;
        b=JToKQ8ec2m9NzqfhCwjoA1owPo7x8POn92YFHZykqI3O1Hufq5WVJMCwqzNpT1VLOl
         8GDJM9VjnA1qA6a/7ylbgGQJHSrh96aCqs/i1UnEgoZs16H13cbLVqqGBO+q+tFWBJBF
         qVumeNa+JFj6CVM4jCpcUQn4PLB+9tPmf4pBNiHg0GLh/JcY117fzHMI82uSOiUKJdJg
         SvJ6vQuPk+epCbKy3Mrb0ThdfUU/7+/ZT5Eoz4mX5TEgC9GmRPOQMB3MH4MvuMHTCeCw
         CP7uFrxPRgTRQIjc2/HvSmicEBxlWHE8BPCqQPnoNJagS0SckaM9DBhaE/euvXYA2GWa
         mtEw==
X-Gm-Message-State: ABy/qLaQyCV2mjH4uyXU6gFVQ6AUCJlbnu9Nxuk7Y9SNfX0mQm7J8ddn
	QjkG8KNngsmfpc8DMo1Hkoe7T8CmdTWgILglh5h9NhtfnSi1Ez76DQ==
X-Google-Smtp-Source: APBJJlEjHNOn01A7PhQWqnlltz8q9HyG34aGQpyMcKlcIfoPZdDs6G+HJfbX5y+E5uQqAt5wnkcTQrVHYprRdQVKORLxIcQez/7u
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2092:b0:3a4:2943:8f7 with SMTP id
 s18-20020a056808209200b003a4294308f7mr5363691oiw.5.1690454807115; Thu, 27 Jul
 2023 03:46:47 -0700 (PDT)
Date: Thu, 27 Jul 2023 03:46:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000497c3c060175aed9@google.com>
Subject: [syzbot] [netfilter?] WARNING in __nf_conntrack_confirm
From: syzbot <syzbot+ff6e85a2812073da0a36@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    15cec633fc7b net: fec: tx processing does not call XDP API..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17fbd745a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=ff6e85a2812073da0a36
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cfb97ef3ebf9/disk-15cec633.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e8df2be69d2/vmlinux-15cec633.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bdf17720191/bzImage-15cec633.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff6e85a2812073da0a36@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 12 at net/netfilter/nf_conntrack_core.c:1198 __nf_conntrack_confirm+0x867/0x12c0 net/netfilter/nf_conntrack_core.c:1198
Modules linked in:
CPU: 1 PID: 12 Comm: kworker/u4:1 Not tainted 6.5.0-rc2-syzkaller-00231-g15cec633fc7b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: events_unbound macvlan_process_broadcast
RIP: 0010:__nf_conntrack_confirm+0x867/0x12c0 net/netfilter/nf_conntrack_core.c:1198
Code: df e8 5d 64 ff ff 31 ff 41 89 c4 89 c6 e8 91 b5 1c f9 45 84 e4 0f 84 7a ff ff ff 44 8b 7c 24 18 e9 3b fe ff ff e8 49 ba 1c f9 <0f> 0b 48 8b 7c 24 20 e8 bd f6 cb 01 44 8b 74 24 44 8b 5c 24 38 44
RSP: 0018:ffffc900001e08b0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888077a75bc0 RCX: 0000000000000100
RDX: ffff888015265940 RSI: ffffffff8869b667 RDI: 0000000000000001
RBP: 000000000001e698 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000004f10 R12: ffff888077a75b00
R13: 0000000000000001 R14: 000000000001e698 R15: 00000000000038d1
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea3059d988 CR3: 000000004f78b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 nf_conntrack_confirm include/net/netfilter/nf_conntrack_core.h:62 [inline]
 nf_confirm+0xfae/0x1200 net/netfilter/nf_conntrack_proto.c:155
 nf_hook_entry_hookfn include/linux/netfilter.h:143 [inline]
 nf_hook_slow+0xbf/0x1e0 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:258 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_local_deliver+0x2f1/0x540 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:468 [inline]
 ip_rcv_finish+0x1c4/0x2e0 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:303 [inline]
 NF_HOOK include/linux/netfilter.h:297 [inline]
 ip_rcv+0xc8/0x410 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5452
 __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5566
 process_backlog+0x101/0x6c0 net/core/dev.c:5894
 __napi_poll.constprop.0+0xb4/0x530 net/core/dev.c:6460
 napi_poll net/core/dev.c:6527 [inline]
 net_rx_action+0x956/0xe90 net/core/dev.c:6660
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 do_softirq kernel/softirq.c:454 [inline]
 do_softirq+0xaa/0xe0 kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:381
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx net/core/dev.c:4972 [inline]
 netif_rx+0x332/0x420 net/core/dev.c:4961
 macvlan_broadcast+0x37d/0x680 drivers/net/macvlan.c:290
 macvlan_multicast_rx drivers/net/macvlan.c:302 [inline]
 macvlan_multicast_rx+0xd6/0x100 drivers/net/macvlan.c:296
 macvlan_process_broadcast+0x225/0x690 drivers/net/macvlan.c:338
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

