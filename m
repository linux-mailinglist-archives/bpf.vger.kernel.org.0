Return-Path: <bpf+bounces-9871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8879DFE9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF91281850
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985815AFD;
	Wed, 13 Sep 2023 06:19:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430CB65B
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:19:53 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FB172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:19:52 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6bdb30c45f6so6482762a34.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585992; x=1695190792;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm6f4RGkzYtG8ypj34ipT+n6BCPW3HEasexrRCREDnM=;
        b=TElqz4qSbE0RKQthnndyqJVR6gjR4ik2RNMB8Eqnnmeny0Qr5VSPdDZ4oh+7CMkYNU
         au0y18UxRngCxDdfqjHrUrolgewcZvALucpxcT353lB9Uoy3hxFzhwWc/3Gyx4b73LaF
         OCPzQ8rMDjVnF9mcpiGuFi9O4PT5KdipJZTDXneDnD3a9GIPBk6S80VTAoodKVtrtjok
         fFDSfAe9440oU9+EgTP87q9UX4CZZR5ce5C7r1AlXzGCWJcOWE+dnTqOIKKLP0qVHZ+e
         AIRP2WZwehQf20M+wYb0zOauUz/woLrHSkGwGaQ2zPZv5GIvnXFnaOjGn53yHpt0xK7B
         THtw==
X-Gm-Message-State: AOJu0YxZJFwqeWY4kH87h3UiH/soK49Hz5tAGXazrAndNxdWl9vguRAg
	EbfWCNHPLK/gjLkkcIoxzvupPqjdClAmy1BkAt+4kv9Wmuct7Zs/jQ==
X-Google-Smtp-Source: AGHT+IHqQa6THb/fPEtlTGw/PkqP44GfmiYhQoQbeCNAKHqeyse991U74CWQV8S4K2X3x33+4ye1RQEuV9m4mdpC/6z6Ux1YIpfb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1d77:b0:6b9:97f6:655 with SMTP id
 l23-20020a0568301d7700b006b997f60655mr455389oti.2.1694585992251; Tue, 12 Sep
 2023 23:19:52 -0700 (PDT)
Date: Tue, 12 Sep 2023 23:19:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c12b30605378ce8@google.com>
Subject: [syzbot] [net?] WARNING in __ip6_append_data
From: syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=142177f4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b273cdfbc13e9a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=62cbf263225ae13ff153
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f37a0c680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10034f3fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/74df7181e630/disk-65d6e954.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8455d5988dfe/vmlinux-65d6e954.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ee7b79f0dfd/bzImage-65d6e954.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
Modules linked in:
CPU: 1 PID: 5042 Comm: syz-executor133 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__ip6_append_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
Code: db f6 ff ff e8 09 d5 97 f8 49 8d 44 24 ff 48 89 44 24 60 49 8d 6c 24 07 e9 c2 f6 ff ff 4c 8b b4 24 90 01 00 00 e8 e8 d4 97 f8 <0f> 0b 48 8b 44 24 10 45 89 f4 48 8d 98 74 02 00 00 e8 d2 d4 97 f8
RSP: 0018:ffffc90003a1f3b8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000001004 RCX: 0000000000000000
RDX: ffff88801fe70000 RSI: ffffffff88efcf18 RDI: 0000000000000006
RBP: 0000000000001000 R08: 0000000000000006 R09: 0000000000001004
R10: 0000000000001000 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000001004 R15: ffff888019f31000
FS:  0000555557280380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000072666000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6_append_data+0x1e6/0x510 net/ipv6/ip6_output.c:1895
 l2tp_ip6_sendmsg+0xdf9/0x1cc0 net/l2tp/l2tp_ip6.c:631
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:840
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 splice_to_socket+0xade/0x1010 fs/splice.c:881
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6b11150469
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd14e71a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fffd14e7378 RCX: 00007f6b11150469
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007f6b111c3610 R08: 00007fffd14e7378 R09: 00007fffd14e7378
R10: 000000010000a006 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd14e7368 R14: 0000000000000001 R15: 0000000000000001
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

