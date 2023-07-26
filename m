Return-Path: <bpf+bounces-5902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4467628E4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 04:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10A428171A
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFD1878;
	Wed, 26 Jul 2023 02:51:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10215CB
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 02:51:04 +0000 (UTC)
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D3193
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:51:02 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a5aa4a8fd6so7054469b6e.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339862; x=1690944662;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBVL2KaY/jGaDbxPBhPklgUjk/YxnvyLpjs8hxXCAVE=;
        b=f/lB9v+XYrWgjYIopvK3mi9QLKv/Ni7G0RrdwEhojeYvQjyNLMgxVh2FZ/vcqkqXI4
         ohDJJYxVw0osKp6Knlz4HyUMrMwyRjgbR0hOJZyCnkEGHY/cx33Mj570Ms5vM7pwwB73
         UuS7+683pCm0TvNGNa6x0NE3oSpnqm/gmaQyRCdRMYXiyPBx7c9+mr9HWrMPu+so+JmG
         q1gkLKh15najgDjb5c2Ux+/W0tjPMn3NG76+x4ABYpP++IuVdJTEkZOrLhrgVwwCoDUn
         0fpRGGoP5zsvZir8UrkaKM4n3kjJg0eOoquS8O6hJAmF/2F+W6bBNtdlnZdqdSKxSqYW
         jnSw==
X-Gm-Message-State: ABy/qLbNg5UM6T4616BeM6H7ZXCsD+/imkk4Kzj5I/+1IBnH/Wp2WiGS
	e/cWEi6DSIwnjHprgkuye9ixsHcUPR+q5RIqf4M3tR5tII0N
X-Google-Smtp-Source: APBJJlEUE43iMMxxWkzJQPDbwwb56PSaCJIN6LWjC7k2OWHLEVQY30kNf/rR0AU+TJxXZR9oc2poiy+7lRbjal+FWXp5UN0Dwlar
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2109:b0:3a3:edca:2950 with SMTP id
 r9-20020a056808210900b003a3edca2950mr1832483oiw.5.1690339862078; Tue, 25 Jul
 2023 19:51:02 -0700 (PDT)
Date: Tue, 25 Jul 2023 19:51:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000076a0a06015aeb85@google.com>
Subject: [syzbot] [bpf?] WARNING in tcx_uninstall
From: syzbot <syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6bfef2ec0172 Merge branch 'net-page_pool-remove-page_pool_..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131ca4e6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=376a289e86a0fd02b9ba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aabbaaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c5cbaaa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a9243441696/disk-6bfef2ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aae660d02e45/vmlinux-6bfef2ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8aaadbed7a6a/bzImage-6bfef2ec.xz

The issue was bisected to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11496cbea80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13496cbea80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15496cbea80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5181 at kernel/bpf/tcx.c:114 tcx_uninstall+0x542/0x630 kernel/bpf/tcx.c:114
Modules linked in:
CPU: 1 PID: 5181 Comm: syz-executor399 Not tainted 6.5.0-rc2-syzkaller-00549-g6bfef2ec0172 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:tcx_uninstall+0x542/0x630 kernel/bpf/tcx.c:114
Code: 4c 00 00 00 48 c7 c6 a0 0f 76 8a 48 c7 c7 e0 0f 76 8a c6 05 b7 f2 ec 0c 01 e8 ba 6b a4 ff 0f 0b e9 fc fa ff ff e8 fe a1 dd ff <0f> 0b e9 92 fd ff ff e8 f2 a1 dd ff 44 0f b6 25 93 f2 ec 0c 31 ff
RSP: 0018:ffffc9000409f108 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801f663b80 RSI: ffffffff81a8dc32 RDI: 0000000000000001
RBP: ffff888023e16008 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888023e16008 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f50a1a326c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42a5984018 CR3: 000000002d318000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_tcx_uninstall include/net/tcx.h:174 [inline]
 unregister_netdevice_many_notify+0x5e7/0x1a20 net/core/dev.c:10899
 rtnl_delete_link net/core/rtnetlink.c:3213 [inline]
 rtnl_dellink+0x3c1/0xae0 net/core/rtnetlink.c:3265
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6423
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2546
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1911
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f50a1a96349
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50a1a32218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f50a1b1f438 RCX: 00007f50a1a96349
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007f50a1b1f430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f50a1b1f43c
R13: 00007f50a1aec4f4 R14: 0031313230386c6e R15: 746361736c630001
 </TASK>


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

