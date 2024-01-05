Return-Path: <bpf+bounces-19135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65D825914
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88553281CA6
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582F328C9;
	Fri,  5 Jan 2024 17:32:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253C321A9
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7fdde8b2dso162267839f.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 09:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475952; x=1705080752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EATfGG2+PisH1hXGp7ObnfeaaEJzw+IxUMnODwpyuTI=;
        b=p6DhNEYQpoKsPZrHwOwxqkcJ3wIqvPUR3rsaY/+tXl+/ULyzlmFp6mBL7isWwfx2J2
         99JRSSkuHxq54uxxbdY0ShqGADwiGro917idyguGXLN6geD6G5BTiFBqNqxum/H9vM6N
         wQ2NZ/dynnV9kluMW0KWhxTj3oVml8h/cLTHX8IZfEMOfxu48KOjiCx36hOg6EW9vxZN
         P3PJG7Dbo1+5vtivU9/E9F1HJFvzrIhpXmI1+7tM+O3aG8aIBbtbwvAXxxeEWihO99IQ
         KpLFo6+6/ISqTkSszaImw7cFx7nOdVzS5P1jtA+v4pyCUZiO6N4v3uN8ErsjLr9yjBhp
         wddg==
X-Gm-Message-State: AOJu0Yy9pJJmVzD2JrkbC1X8B71JF1N1BsTWjYuaMRvHVeDW2R58v7uW
	mkzgBwSDSxexUoCxt/4zM2Osd9MHTVj1FaS1ximaEXDuUBZk
X-Google-Smtp-Source: AGHT+IGns/PkbiGRGP7Vrp27ykA2swovFnQd3eZqd+GMeyO2j30wA8Reufk2C1Dh9RvlYcH7DumWZuUwtHI9eFjsKinFcZAEqauN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:48cf:b0:46e:820:2920 with SMTP id
 cu15-20020a05663848cf00b0046e08202920mr25494jab.3.1704475952293; Fri, 05 Jan
 2024 09:32:32 -0800 (PST)
Date: Fri, 05 Jan 2024 09:32:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa2f41060e363b2b@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in __sk_msg_free
From: syzbot <syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, borisp@nvidia.com, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dhowells@redhat.com, 
	edumazet@google.com, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ab1efad60ad net/sched: cls_api: complement tcf_tfilter_du..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162a3829e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=f2977222e0e95cec15c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153f4f29e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14acd65ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc9bebeba249/disk-2ab1efad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b355f4afef6/vmlinux-2ab1efad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c561e15b929/bzImage-2ab1efad.xz

The issue was bisected to:

commit fe1e81d4f73b6cbaed4fcc476960d26770642842
Author: David Howells <dhowells@redhat.com>
Date:   Wed Jun 7 18:19:17 2023 +0000

    tls/sw: Support MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e87d81e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10187d81e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e87d81e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Fixes: fe1e81d4f73b ("tls/sw: Support MSG_SPLICE_PAGES")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5059 at include/linux/skmsg.h:137 sk_msg_check_to_free include/linux/skmsg.h:137 [inline]
WARNING: CPU: 0 PID: 5059 at include/linux/skmsg.h:137 sk_msg_check_to_free include/linux/skmsg.h:135 [inline]
WARNING: CPU: 0 PID: 5059 at include/linux/skmsg.h:137 __sk_msg_free+0x29f/0x390 net/core/skmsg.c:203
Modules linked in:
CPU: 0 PID: 5059 Comm: syz-executor395 Not tainted 6.7.0-rc6-syzkaller-01873-g2ab1efad60ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:sk_msg_check_to_free include/linux/skmsg.h:137 [inline]
RIP: 0010:sk_msg_check_to_free include/linux/skmsg.h:135 [inline]
RIP: 0010:__sk_msg_free+0x29f/0x390 net/core/skmsg.c:203
Code: 00 00 48 83 e0 fe 48 83 c8 02 49 89 85 40 02 00 00 8b 44 24 0c 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 62 98 00 f9 90 <0f> 0b 90 e8 59 98 00 f9 48 63 5c 24 08 48 83 fb 13 0f 87 9d 00 00
RSP: 0018:ffffc90003bff8e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000000e RCX: ffffffff8886e85f
RDX: ffff888022e88000 RSI: ffffffff8886e90e RDI: 0000000000000005
RBP: 000000000000000e R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000036 R11: 0000000000000002 R12: 0000000000000036
R13: ffff8880177f2018 R14: 0000000000000007 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c1dd31a18 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tls_free_rec net/tls/tls_sw.c:359 [inline]
 tls_free_open_rec net/tls/tls_sw.c:370 [inline]
 tls_sw_release_resources_tx+0x4e8/0x6f0 net/tls/tls_sw.c:2467
 tls_sk_proto_cleanup net/tls/tls_main.c:352 [inline]
 tls_sk_proto_close+0x678/0xac0 net/tls/tls_main.c:382
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xb70 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:869
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
 get_signal+0x23b5/0x2790 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0c1dcdae39
Code: Unable to access opcode bytes at 0x7f0c1dcdae0f.
RSP: 002b:00007f0c1dc9d218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000010000 RBX: 00007f0c1dd64328 RCX: 00007f0c1dcdae39
RDX: 00000000fffffecc RSI: 0000000020000100 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0c1dd64320
R13: 0000000000000000 R14: 00007f0c1dd32004 R15: 34ea337571a66fd8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

