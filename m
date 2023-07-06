Return-Path: <bpf+bounces-4255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2599749F14
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082361C20DB9
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416719474;
	Thu,  6 Jul 2023 14:33:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B37946D
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 14:33:58 +0000 (UTC)
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F311732
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:33:55 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-55b9ed8275aso905914a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 07:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654035; x=1691246035;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdY5YVqvkkEWyCyiuVGh8eA0O+Xyor0zejGoIjJswSc=;
        b=Ix+Q1gPR+V2dK1gRUPeM0MKyS5vJgC+7By3hAzgs+RWHYv9a82E+DhjF4B08D3TAzR
         5j/mNS8zhXujZJKLm0uG9KEq4lis6rk0dyjI31UMgeCQDsupxwsXE8PValnHyhQSHrQU
         5K1XUj9JcoJ+hXGXW3cTD3qoo34DekEU1S6WVHNs4KJOFLJWE4GHiFWLUl2azT8eUTeY
         5m3GWjILO+qT0+HF8qsGa/vtqMIj1OtPRkYIUyEGX2I7RdCAxPwv1teCv1rXmZTQ0LOL
         8g2JiUu0kHbwx2jLa5B21lU0MWLFHmBAA6kO2V1EQ23uDPflD/Bg3mRCrfVbUuDlsYPu
         hk8Q==
X-Gm-Message-State: ABy/qLYiZ3O+4Cn8t5+nGY/qL8PjjdOWGNg8hAS1gd5YkF3GBwxAo+Fe
	NrT7n/su7uZXQPZ/ni1krD41PKLr5gy7rGeDCC16pEOGOaw48qTnYg==
X-Google-Smtp-Source: APBJJlGGsF5Se9Kz/yr4SUYlfYoKIDs4xwaPq7jIbYLi81Rcib1PCDq4kZkYJKeLEk0EtcWZBfFiV8/bjW6MSJ+YlJersi0epj9K
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:230c:b0:682:616a:f907 with SMTP id
 h12-20020a056a00230c00b00682616af907mr2664139pfh.4.1688654035172; Thu, 06 Jul
 2023 07:33:55 -0700 (PDT)
Date: Thu, 06 Jul 2023 07:33:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea44c905ffd26705@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in rtnl_newlink (3)
From: syzbot <syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124db278a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=afb3084a933aa2bdacc6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15849d08a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13184990a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5e1d8e2898a/disk-d5280145.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9c6252b0cf2/vmlinux-d5280145.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecdc540999f3/bzImage-d5280145.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D } 2671 jiffies s: 1489 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5040 Comm: syz-executor363 Not tainted 6.4.0-syzkaller-11478-gd528014517f2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__lock_acquire+0x46/0x5e20 kernel/locking/lockdep.c:5000
Code: 89 f5 53 48 81 ec 20 01 00 00 48 8b 84 24 58 01 00 00 48 c7 84 24 a0 00 00 00 b3 8a b5 41 48 c7 84 24 a8 00 00 00 18 0e 14 8c <48> c7 84 24 b0 00 00 00 70 d6 65 81 44 89 44 24 08 48 89 44 24 20
RSP: 0018:ffffc900001e0aa8 EFLAGS: 00000082
RAX: 0000000000000000 RBX: 1ffff9200003c187 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff8d356d20
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8ea9e517 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff8d356d20 R14: 0000000000000001 R15: 0000000000000000
FS:  0000555555e03300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 00000000289bd000 CR4: 0000000000350ee0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 debug_objects_fill_pool lib/debugobjects.c:614 [inline]
 debug_object_activate+0x128/0x4f0 lib/debugobjects.c:713
 debug_hrtimer_activate kernel/time/hrtimer.c:422 [inline]
 debug_activate kernel/time/hrtimer.c:477 [inline]
 enqueue_hrtimer+0x27/0x320 kernel/time/hrtimer.c:1087
 __run_hrtimer kernel/time/hrtimer.c:1705 [inline]
 __hrtimer_run_queues+0xa65/0xc00 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1098 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 06 ac 43 f7 48 89 ef e8 de 1b 44 f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 1f d7 35 f7 65 8b 05 50 25 e1 75 85 c0 74 0a 5b 5d c3 e8 ac ef
RSP: 0018:ffffc90003bbecb0 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff23120ac
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000001
RBP: ffffffff8cadc9c0 R08: 0000000000000001 R09: fffffbfff230b1e0
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: 00000000000744f0 R15: 00000000000744f0
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 pcpu_alloc+0x882/0x1430 mm/percpu.c:1843
 fib6_nh_init+0x524/0x1bd0 net/ipv6/route.c:3613
 ip6_route_info_create+0x10f3/0x1980 net/ipv6/route.c:3796
 ip6_route_add+0x28/0x150 net/ipv6/route.c:3840
 addrconf_prefix_route+0x309/0x520 net/ipv6/addrconf.c:2425
 fixup_permanent_addr net/ipv6/addrconf.c:3500 [inline]
 addrconf_permanent_addr net/ipv6/addrconf.c:3524 [inline]
 addrconf_notify+0x114f/0x19b0 net/ipv6/addrconf.c:3596
 notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 __dev_notify_flags+0x120/0x2d0 net/core/dev.c:8569
 dev_change_flags+0x11b/0x170 net/core/dev.c:8607
 do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
 __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:748
 __sys_sendto+0x254/0x350 net/socket.c:2134
 __do_sys_sendto net/socket.c:2146 [inline]
 __se_sys_sendto net/socket.c:2142 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2142
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa216946bd6
Code: 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
RSP: 002b:00007ffd1c703708 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fa216a004e0 RCX: 00007fa216946bd6
RDX: 000000000000002c RSI: 00007fa216a00530 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffd1c703724 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa216a00530 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.077 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

