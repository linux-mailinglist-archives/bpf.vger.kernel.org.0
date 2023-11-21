Return-Path: <bpf+bounces-15603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9507F7F3966
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE2E282848
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EF5645D;
	Tue, 21 Nov 2023 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5C1A3
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:43:20 -0800 (PST)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso7306057b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 14:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606600; x=1701211400;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivbz5bpE+W+Oj9SpHnmJixA7SEzdHmNbg1vNF2tT5Tg=;
        b=kXqPXyuCmrKI8wbYTGz62yodIdAdSFMqvOeU9K45LOWryVW8wUF0VKNI9Ycq6xQzDg
         saX3zTtF6VYVRd0vBsudhF4eqbjZp31+P93gbe7mMF/lkssgzolA8Ql5O3HkA6nUUoY0
         rBxMARLqw/nbKSdFLuYf2OXfjAF5YzEhLWxapUV9c4WC88xfhzr6mJS2diFW2cCk9r3o
         Crx2KtAIuWSPP7MVRznfwQ8dWc7uGuUF+ccWYVQG3m2Tb5O52w/8HgoWGNq7fcjWOV9Z
         0fSn/v+64ttxs3cWS9v3q8c6r8FWsuQEdo8FydpJcutfwpXZRQS3Yj1hhJPQP4cXwCh9
         guOw==
X-Gm-Message-State: AOJu0YyW15OqP/CbE7kEXcZBpn/fmG/1RdYlt4jwAdSj/e9fvrJAXnEh
	KEY7PHCXjZRerSE3sDF5yf3LHY9M3YrYinEkQyqQfWiDSe/M
X-Google-Smtp-Source: AGHT+IExPtY3zCeKZZGHiMjJ+inznyEtr4G9raGYEtOGjRDcr2B/bafIj7qKUBJbMBlx7hCThkCreDweHnb5Kp0bujc6MUXvWdpw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aa7:8211:0:b0:6c6:bfb:900 with SMTP id k17-20020aa78211000000b006c60bfb0900mr124673pfi.2.1700606599979;
 Tue, 21 Nov 2023 14:43:19 -0800 (PST)
Date: Tue, 21 Nov 2023 14:43:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b6de5060ab1545b@google.com>
Subject: [syzbot] [bpf?] [trace?] WARNING in format_decode (3)
From: syzbot <syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@kernel.org, martin.lau@linux.dev, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    76df934c6d5f MAINTAINERS: Add netdev subsystem profile link
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D10c2b667680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84217b7fc4acdc5=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3De2c932aec5c8a6e1d=
31c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12b2f668e8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D171ea200e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e271179068c6/disk-=
76df934c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9523b3749bb/vmlinux-=
76df934c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c1a888bade0/bzI=
mage-76df934c.xz

The issue was bisected to:

commit 114039b342014680911c35bd6b72624180fd669a
Author: Stanislav Fomichev <sdf@google.com>
Date:   Mon Nov 21 18:03:39 2022 +0000

    bpf: Move skb->len =3D=3D 0 checks into __bpf_redirect

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13d237b76800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D103237b76800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17d237b7680000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Fixes: 114039b34201 ("bpf: Move skb->len =3D=3D 0 checks into __bpf_redirec=
t")

------------[ cut here ]------------
Please remove unsupported %=00 in format string
WARNING: CPU: 0 PID: 5068 at lib/vsprintf.c:2675 format_decode+0xa03/0xba0 =
lib/vsprintf.c:2675
Modules linked in:
CPU: 0 PID: 5068 Comm: syz-executor288 Not tainted 6.7.0-rc1-syzkaller-0013=
4-g76df934c6d5f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 11/10/2023
RIP: 0010:format_decode+0xa03/0xba0 lib/vsprintf.c:2675
Code: f7 41 c6 44 24 05 08 e9 c4 fa ff ff e8 c6 f7 15 f7 c6 05 0b bd 91 04 =
01 90 48 c7 c7 60 5f 19 8c 40 0f b6 f5 e8 2e 17 dc f6 90 <0f> 0b 90 90 e9 1=
7 fc ff ff 48 8b 3c 24 e8 4b 87 6c f7 e9 13 f7 ff
RSP: 0018:ffffc90003b6f798 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffc90003b6fa0c RCX: ffffffff814db209
RDX: ffff8880214b9dc0 RSI: ffffffff814db216 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003b6f898
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000ffffffd0
FS:  000055555567c380(0000) GS:ffff8880b9800000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000f6f398 CR3: 00000000251e7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bstr_printf+0x13b/0x1050 lib/vsprintf.c:3248
 ____bpf_trace_printk kernel/trace/bpf_trace.c:386 [inline]
 bpf_trace_printk+0x10b/0x180 kernel/trace/bpf_trace.c:371
 bpf_prog_12183cdb1cd51dab+0x36/0x3a
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x3e1/0x9e0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0xb75/0x1dd0 net/bpf/test_run.c:1045
 bpf_prog_test_run kernel/bpf/syscall.c:4040 [inline]
 __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fefcec014e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca6179888 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffca6179a58 RCX: 00007fefcec014e9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007fefcec74610 R08: 0000000000000000 R09: 00007ffca6179a58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffca6179a48 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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

