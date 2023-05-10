Return-Path: <bpf+bounces-284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0FC6FDDD0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8141C20D45
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51412B85;
	Wed, 10 May 2023 12:29:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA762105
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 12:29:03 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41DD44B0
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 05:29:01 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331663d8509so106444335ab.0
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 05:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683721741; x=1686313741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtyEHgMICM4fpwcH4FzG9uK+8/49FVxPeU/+8ghuGA8=;
        b=FSEWjpuIGb7d6yLE6aJyftdDoR5npHOTqOJ8LkC6bFFyDbtN1oCjUJuqGair/OJYUR
         dqUiLQbHGh27F1nPvfHXFbOi31/IP2vDtUOTe6bOp4SiOsOu9MNPLoQR0ysPLUsylVMr
         hd8uoQbZM1GIHvYoqtX+ELTUrA7abKleGZidI2a4LSU/qgxdaadJO55mQrE/hebhM4+n
         bPNoLuv8vwuEOiOd7Sbc0mBFnonEdzDjHB9UlSw4TNkS3o4rfkfMw/OGDnPXabHUE5MP
         alcthJIZhd/892Nwz9N06tdxevGFqVNEqYXYQSI12HolvGpDLQwbc7QuVhmKaIfLug+e
         +5oA==
X-Gm-Message-State: AC+VfDxrN6PjYqZiBe4yvCkP5AS7ZwGkmU193Oq3w5zKpXrfnWBxZLr/
	Stq5eZKOlWwtnu/yrEjEhZDRy4Nv07xOvsaO80Ni9AESojbi
X-Google-Smtp-Source: ACHHUZ715Id6Yl8UOuYVL97pihs/7YYSStE2/G6P8oZi1RSPuLJ7j79XDEYBl9L3nBtumnGYxsXF0ZFRz/09fg7Yq/3l4GP4gCe3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:860e:0:b0:40f:7382:e4aa with SMTP id
 e14-20020a02860e000000b0040f7382e4aamr3101580jai.2.1683721741181; Wed, 10 May
 2023 05:29:01 -0700 (PDT)
Date: Wed, 10 May 2023 05:29:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048abb105fb5604c1@google.com>
Subject: [syzbot] [bpf?] [net?] kernel BUG in pskb_expand_head (2)
From: syzbot <syzbot+78bac731178aabdb6307@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    ed23734c23d2 Merge tag 'net-6.4-rc1' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10ecc3b0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87f9126139666d37
dashboard link: https://syzkaller.appspot.com/bug?extid=78bac731178aabdb6307
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d103acfdbd1d/disk-ed23734c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4448a632b1df/vmlinux-ed23734c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/758a66ebff4f/bzImage-ed23734c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78bac731178aabdb6307@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:2047!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 16973 Comm: syz-executor.5 Not tainted 6.3.0-syzkaller-13379-ged23734c23d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:pskb_expand_head+0xc4a/0x1170 net/core/skbuff.c:2047
Code: 8d 75 ff e9 0f fe ff ff e8 b3 20 7c f9 48 c7 c6 40 cb 5d 8b 4c 89 f7 e8 14 a4 b7 f9 0f 0b e8 9d 20 7c f9 0f 0b e8 96 20 7c f9 <0f> 0b e8 8f 20 7c f9 48 89 df e8 87 50 ff ff e9 75 f5 ff ff e8 7d
RSP: 0018:ffffc90003797818 EFLAGS: 00010216
RAX: 0000000000001b49 RBX: ffff888015b06870 RCX: ffffc900056ba000
RDX: 0000000000040000 RSI: ffffffff8808244a RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000002 R11: 1ffff110040ad08a R12: 0000000000000820
R13: dffffc0000000000 R14: ffff888015b06940 R15: 0000000000000000
FS:  00007f4a686bb700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e124000 CR3: 000000007314b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_ensure_writable net/core/skbuff.c:6001 [inline]
 skb_ensure_writable+0x2cb/0x450 net/core/skbuff.c:5993
 __bpf_try_make_writable net/core/filter.c:1658 [inline]
 sk_skb_try_make_writable net/core/filter.c:1881 [inline]
 ____sk_skb_pull_data net/core/filter.c:1895 [inline]
 sk_skb_pull_data+0x8b/0xa0 net/core/filter.c:1884
 bpf_prog_53daab6e9cefb4fc+0x1a/0x1c
 bpf_dispatcher_nop_func include/linux/bpf.h:1168 [inline]
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run include/linux/filter.h:607 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:624 [inline]
 sk_psock_verdict_recv+0x36d/0x7a0 net/core/skmsg.c:1201
 tcp_read_skb+0x177/0x670 net/ipv4/tcp.c:1773
 sk_psock_verdict_data_ready+0xad/0xd0 net/core/skmsg.c:1220
 tcp_data_ready+0x10a/0x520 net/ipv4/tcp_input.c:5006
 tcp_rcv_established+0x194f/0x1f90 net/ipv4/tcp_input.c:5986
 tcp_v4_do_rcv+0x65a/0x9c0 net/ipv4/tcp_ipv4.c:1721
 sk_backlog_rcv include/net/sock.h:1113 [inline]
 __release_sock+0x133/0x3b0 net/core/sock.c:2917
 release_sock+0x58/0x1b0 net/core/sock.c:3484
 tcp_sendmsg+0x3a/0x50 net/ipv4/tcp.c:1486
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:825
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2152
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4a6788c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a686bb168 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4a679abf80 RCX: 00007f4a6788c169
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f4a678e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff06f0778f R14: 00007f4a686bb300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pskb_expand_head+0xc4a/0x1170 net/core/skbuff.c:2047
Code: 8d 75 ff e9 0f fe ff ff e8 b3 20 7c f9 48 c7 c6 40 cb 5d 8b 4c 89 f7 e8 14 a4 b7 f9 0f 0b e8 9d 20 7c f9 0f 0b e8 96 20 7c f9 <0f> 0b e8 8f 20 7c f9 48 89 df e8 87 50 ff ff e9 75 f5 ff ff e8 7d
RSP: 0018:ffffc90003797818 EFLAGS: 00010216
RAX: 0000000000001b49 RBX: ffff888015b06870 RCX: ffffc900056ba000
RDX: 0000000000040000 RSI: ffffffff8808244a RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000002 R11: 1ffff110040ad08a R12: 0000000000000820
R13: dffffc0000000000 R14: ffff888015b06940 R15: 0000000000000000
FS:  00007f4a686bb700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feddbf47100 CR3: 000000007314b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

