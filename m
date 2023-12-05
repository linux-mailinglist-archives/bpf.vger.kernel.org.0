Return-Path: <bpf+bounces-16754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7002805C9F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D09B1F2163D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3806A33F;
	Tue,  5 Dec 2023 17:53:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753F129
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 09:53:26 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d87607d2c2so5971355a34.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 09:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798806; x=1702403606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmF1E4cgql5JMVIjcXLrnsYwldekR7/sa+hhIzCwXi0=;
        b=CzEEjqJgEBsCuGTFsKzhIyEQabnE0r/3wlKlehnxNdIJOt29E0OXHDGu3VBzVBMGZ+
         N+xlVp5QvdUKxMt0iRrujhdfqtNsTwwqPl+7DmkWvDvOVaIFf9GqJgAV7UPH1lpV9JxJ
         m+R9e9bGOqmnQaVbWtNHxQuoGO5iLn5KoL7FkLNW3dkrOsB7ZmSPxifdrpyyKYC0B34A
         VyXUq/8sKfbaYKUj6dSp/Wu2+Z76CHX94TLtxZeINAGt6jnvDq7DOpTmJ/8UmTtEtvMJ
         NAfM0E9ZSbrzg/KovF9nSkZ/UK4cdWdH2D8dxGCCPrVB1KNH9wcEflPISiDU2LgOSg+7
         /guA==
X-Gm-Message-State: AOJu0YwihUKHis3lxWNtDT+uarZD2lemFEwHRpQXWpo/w8tGk6g1k6rY
	W9iX6xN26W4NqAH8WWV+6Dav4nb4fpAnNgkHwX261uLgM/W4
X-Google-Smtp-Source: AGHT+IH/l4O9QOjC5H0eyORFG6DTQAO/7Nwr/Ft8BfBYchS8c0cPKHLrsH+MlzGJV9cmRIVOUbZZxQBNymoyDWNOKyWVP9RUfuNU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aca:1909:0:b0:3b8:752e:ca8b with SMTP id
 l9-20020aca1909000000b003b8752eca8bmr3730765oii.11.1701798805977; Tue, 05 Dec
 2023 09:53:25 -0800 (PST)
Date: Tue, 05 Dec 2023 09:53:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f438d060bc6e988@google.com>
Subject: [syzbot] [net?] WARNING in tcp_recvmsg_locked (2)
From: syzbot <syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cong.wang@bytedance.com, daniel@iogearbox.net, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, john.fastabend@gmail.com, 
	kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: ***

Hello,

syzbot found the following issue on:

HEAD commit:    8470e4368b0f Merge branch 'net-cacheline-optimizations'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12094286e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247bee2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1285243ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90007d08e178/disk-8470e436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b55270de1cdc/vmlinux-8470e436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2237d34b6fec/bzImage-8470e436.xz

The issue was bisected to:

commit 965b57b469a589d64d81b1688b38dcb537011bb0
Author: Cong Wang <cong.wang@bytedance.com>
Date:   Wed Jun 15 16:20:12 2022 +0000

    net: Introduce a new proto_ops ->read_skb()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1087c0d4e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1287c0d4e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1487c0d4e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com
Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")

WARNING: CPU: 1 PID: 5130 at net/ipv4/tcp.c:2396 tcp_recvmsg_locked+0xa54/0x2490 net/ipv4/tcp.c:2396
Modules linked in:
CPU: 1 PID: 5130 Comm: syz-executor313 Not tainted 6.7.0-rc3-syzkaller-00690-g8470e4368b0f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:tcp_recvmsg_locked+0xa54/0x2490 net/ipv4/tcp.c:2396
Code: 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 70 18 00 00 48 8b 04 24 89 da 48 c7 c7 a0 b0 f4 8b 44 8b 44 24 30 8b 30 e8 ad 69 57 f8 90 <0f> 0b 90 90 e9 62 fa ff ff e8 7e 4b 91 f8 49 8d 5f 60 be 08 00 00
RSP: 0018:ffffc90003acf290 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 000000000618aefc RCX: ffffffff814db209
RDX: ffff8880259e9dc0 RSI: ffffffff814db216 RDI: 0000000000000001
RBP: ffff8880250b7024 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000004 R12: dffffc0000000000
R13: ffff8880250b6ff0 R14: 0000000000000001 R15: ffff8880250b7018
FS:  0000555556ebf380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff3dd9f6f8 CR3: 000000002534d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 receive_fallback_to_copy+0x1d5/0x7a0 net/ipv4/tcp.c:1866
 tcp_zerocopy_receive+0x110b/0x2110 net/ipv4/tcp.c:2099
 do_tcp_getsockopt+0x1ae0/0x27b0 net/ipv4/tcp.c:4257
 tcp_getsockopt net/ipv4/tcp.c:4342 [inline]
 tcp_getsockopt+0xd1/0xf0 net/ipv4/tcp.c:4333
 do_sock_getsockopt+0x2e1/0x6c0 net/socket.c:2373
 __sys_getsockopt+0x1a3/0x270 net/socket.c:2402
 __do_sys_getsockopt net/socket.c:2412 [inline]
 __se_sys_getsockopt net/socket.c:2409 [inline]
 __x64_sys_getsockopt+0xbd/0x150 net/socket.c:2409
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fcd44438c59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3dd9f7f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcd44438c59
RDX: 0000000000000023 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000200004c0 R09: 0000000100000000
R10: 0000000020000380 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

