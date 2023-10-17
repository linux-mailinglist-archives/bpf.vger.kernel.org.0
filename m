Return-Path: <bpf+bounces-12469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0FC7CCA56
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF1CB211FF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5192D7A5;
	Tue, 17 Oct 2023 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6532D78B
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:05:01 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7764CC6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:04:59 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3af5b5d7ecbso9143659b6e.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565899; x=1698170699;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBc6OrybcBoGw+HylW8Uo0tWXXs4E0MyVL0SByuv/FE=;
        b=mpyBfBYJhQUfbl3Q83OCLYuunxp9iWNCsFUFvHA1Gk1Y2Kga1JlV9X/bjwBlpdLgqt
         jYRgs1aMKjbgjTvEhrq24K5WCW7K03AwWWRK3rOWUn5jfN9SmyVajVHGeZZJdIGe2OkZ
         xGMekoWj4PDtOkVDZUv3E75Bwa+1ECkdMYx9b9RVu9Tf2Tt4mPR78tXzUwOJIB24JioR
         C/B2uaqvHQXFdIZRsW5bVK8chwUthabnh8onwHBTaby6j60pK/Q7/8Gks6VzHVRijX8K
         FabF5E91B0DyHpLFcdMUXdEAv5Ky1LEUcXJCBVYGrcNHR92JVaA57n9neF69WIRb/Xeh
         JUZA==
X-Gm-Message-State: AOJu0Ywi13O9QTlJVDEYSKfXBYq10XpxalnPGyYpYQ69Rj2ddIqu5xhi
	Qkr4S83pyqEVP3YY1kAO7RTX7a50SO8ISeLjBAINuiYw0ddXdbVoOQ==
X-Google-Smtp-Source: AGHT+IFDLXwS2Vt5zHggEQpkomEJqnHYyAN3Csq2jsoFAXyYPB2sV9AY3Aa42Q6OvUiS/pNC1LY6b3Hq2Bk0utkT1ufHiC9io0x/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3602:b0:3ae:61f:335e with SMTP id
 ct2-20020a056808360200b003ae061f335emr1021489oib.5.1697565898921; Tue, 17 Oct
 2023 11:04:58 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:04:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000635bfa0607ed5cdc@google.com>
Subject: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (6)
From: syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6465e260f487 Linux 6.6-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1376e3bc680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=de4025c006ec68ac56fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f218da680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149ff8c6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/563852357aa6/disk-6465e260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df22793fe953/vmlinux-6465e260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84c2aad43ae3/bzImage-6465e260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com

------------[ cut here ]------------
hook not found, pf 2 num 1
WARNING: CPU: 1 PID: 5062 at net/netfilter/core.c:517 __nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Modules linked in:
CPU: 1 PID: 5062 Comm: syz-executor417 Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:__nf_unregister_net_hook+0x1de/0x670 net/netfilter/core.c:517
Code: 14 02 4c 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7a 04 00 00 8b 53 1c 48 c7 c7 c0 d4 a8 8b 8b 74 24 04 e8 b2 ce dc f8 <0f> 0b e9 ec 00 00 00 e8 46 a5 16 f9 48 89 e8 48 c1 e0 04 49 8d 7c
RSP: 0018:ffffc9000355f2b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880218dde00 RCX: 0000000000000000
RDX: ffff888019aee000 RSI: ffffffff814cf016 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff92611690
R13: ffff888016fff020 R14: ffff888016fff000 R15: ffff8880218dde1c
FS:  00007f76ca1526c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76ca1e86b8 CR3: 0000000020292000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nf_unregister_net_hook+0xd5/0x110 net/netfilter/core.c:539
 __nf_tables_unregister_hook net/netfilter/nf_tables_api.c:361 [inline]
 __nf_tables_unregister_hook+0x1a0/0x220 net/netfilter/nf_tables_api.c:340
 nf_tables_unregister_hook net/netfilter/nf_tables_api.c:368 [inline]
 nf_tables_commit+0x410f/0x59f0 net/netfilter/nf_tables_api.c:9992
 nfnetlink_rcv_batch+0xf36/0x2500 net/netfilter/nfnetlink.c:569
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:639 [inline]
 nfnetlink_rcv+0x3bf/0x430 net/netfilter/nfnetlink.c:657
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2541
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2595
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f76ca192059
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f76ca152208 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f76ca21c3e8 RCX: 00007f76ca192059
RDX: 0000000000000000 RSI: 000000002000c2c0 RDI: 0000000000000004
RBP: 00007f76ca21c3e0 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000a00 R11: 0000000000000246 R12: 00007f76ca1e917c
R13: 0000000000000001 R14: 0000000000000008 R15: 0200000000000000
 </TASK>


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

