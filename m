Return-Path: <bpf+bounces-30626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5648CF70E
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E1C1C20D5A
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB923D7;
	Mon, 27 May 2024 00:44:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84B64D
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770666; cv=none; b=TpAlKXTdPuCN1qVh4V4G4B0m4d+BhUyI5sX5UBp3Es7Fc3P3NLcNiEEwociStWj5YMQp4SOOw4DWd6LV5yV1d0IGnoRkO5/N3MiQ54fJPIXCDK798LblVFsnHD3mKjvU6qtnDDR6kGmdfKBunaRY1uz1vXeJeYV6iU8FtK+w6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770666; c=relaxed/simple;
	bh=YLLNooDN0/HSLN7Bhkuq2J+Ulv9x3CHF8Y6DFTcgCJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vz45F+RrMqRWcps0yUDBL+gDLvzOEuT20EeOhWI++Mws/uQpo5cUgFu7jWpDOag+nRQ1ldU7IT1AJVhrkDPEi8Bz8pE/vD45Vf7xoQvzYjb2NXU3a/7rwtzJJ+RbO1YUN+NTrKboBOIczDJrSAMYNPQujiBgTNIgz7puriX+Qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e20341b122so500306639f.1
        for <bpf@vger.kernel.org>; Sun, 26 May 2024 17:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716770664; x=1717375464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZ9DVVzJCjcM9K5tX8UBkpT2XOidm8OOyTP+Gai07qA=;
        b=C1vu8hWETBYc1cQnYvqBU0PdI9tXzQu0q2pPi6rfm7QrMJ2VTGBsr859xVKZpbUJMR
         xCrhJxn4NyrIIYr7wPZ8l/YfI25hAoR8/NxAN2WKJcul/UCD1KJqKh+Fj22D7GlqKRI1
         LG4Yu2TEm++h4Ikosw7pYYDHZXvwfpREoVmkFKHDmRkxFc2MloQvVqfZSImF9vO/kcoD
         fhufEnqPPwjj+SbA7tQdqQBHE5SdDxlb8YdyrdcPx4MamrJDJm0zTeowV+3krBZ9kdYT
         DjYgWLHs1GvIEzSwDMRf+Sa8MdAMjTnX2+UI24oDOM4068wyzixGMtgPTvR0dmYtO9SU
         dePg==
X-Forwarded-Encrypted: i=1; AJvYcCUWTPDsYL/3P2Yr5gDnrsl4CzKCj881yMdt2xIJeSP996jAP8bmv/nDzF/rwB5JTSVztU6sTVccOBb5Mx49SfkjHuR6
X-Gm-Message-State: AOJu0Yy5RdPbBgRcO7asNAAywxwxKYMS52FkNOzBJwFV7F64KlXUYk45
	m+D/Z6RbuMQVJQHv8FhSbqmTmijN3qQtkQrdUdrydpJCax5uwcShc/uvqQEvbRYjYtqPkTsNd4Y
	n132aqA9aaDeAlWu0KGMFAYmZYW/KuAuq1woCi5F19/VYuUwy7fVcJmw=
X-Google-Smtp-Source: AGHT+IHMlVRdAWGtoNpjOKcE4YDn0zSO/EMtUtMcJLJnv+K2DPvBDguh57Z07+BRVKH7F0Mwgv4E/eDPvo6mchXNV683oFBTta6F
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2c83:b0:488:d489:3963 with SMTP id
 8926c6da1cb9f-4b03f6329b1mr173553173.1.1716770664201; Sun, 26 May 2024
 17:44:24 -0700 (PDT)
Date: Sun, 26 May 2024 17:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099cf25061964d113@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue (2)
From: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136bd8fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02867060d65d/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bb75fbf6fb1/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd38cadddf33/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000003b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001d8-0x00000000000001df]
CPU: 0 PID: 12830 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__xdp_enqueue kernel/bpf/devmap.c:484 [inline]
RIP: 0010:dev_map_enqueue+0x70/0x3e0 kernel/bpf/devmap.c:541
Code: c5 18 48 89 e8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 ef e8 b2 10 3a 00 48 8b 5d 00 49 8d af d8 01 00 00 48 89 e8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 3a 02 00 00 8b 6d 00 89 ee 83 e6 04 31
RSP: 0018:ffffc900031ff678 EFLAGS: 00010202
RAX: 000000000000003b RBX: ffff888023efa078 RCX: 0000000000040000
RDX: ffffc90015e01000 RSI: 0000000000000ba1 RDI: 0000000000000ba2
RBP: 00000000000001d9 R08: ffffffff895b0946 R09: ffffffff895b0903
R10: 0000000000000004 R11: ffff888020d73c00 R12: ffff888058f06000
R13: ffff888021fff070 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f9f791576c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30823000 CR3: 000000002e298000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
 xdp_do_redirect_frame+0x2a6/0x660 net/core/filter.c:4451
 xdp_test_run_batch net/bpf/test_run.c:336 [inline]
 bpf_test_run_xdp_live+0xe60/0x1e60 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x80e/0x11b0 net/bpf/test_run.c:1275
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4291
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9f7847cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f791570c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f9f785ac050 RCX: 00007f9f7847cee9
RDX: 0000000000000048 RSI: 00000000200000c0 RDI: 000000000000000a
RBP: 00007f9f784c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9f785ac050 R15: 00007ffc7dc03298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__xdp_enqueue kernel/bpf/devmap.c:484 [inline]
RIP: 0010:dev_map_enqueue+0x70/0x3e0 kernel/bpf/devmap.c:541
Code: c5 18 48 89 e8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 ef e8 b2 10 3a 00 48 8b 5d 00 49 8d af d8 01 00 00 48 89 e8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 3a 02 00 00 8b 6d 00 89 ee 83 e6 04 31
RSP: 0018:ffffc900031ff678 EFLAGS: 00010202
RAX: 000000000000003b RBX: ffff888023efa078 RCX: 0000000000040000
RDX: ffffc90015e01000 RSI: 0000000000000ba1 RDI: 0000000000000ba2
RBP: 00000000000001d9 R08: ffffffff895b0946 R09: ffffffff895b0903
R10: 0000000000000004 R11: ffff888020d73c00 R12: ffff888058f06000
R13: ffff888021fff070 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f9f791576c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30823000 CR3: 000000002e298000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	18 48 89             	sbb    %cl,-0x77(%rax)
   3:	e8 48 c1 e8 03       	call   0x3e8c150
   8:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   d:	74 08                	je     0x17
   f:	48 89 ef             	mov    %rbp,%rdi
  12:	e8 b2 10 3a 00       	call   0x3a10c9
  17:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  1b:	49 8d af d8 01 00 00 	lea    0x1d8(%r15),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 3a 02 00 00    	jne    0x270
  36:	8b 6d 00             	mov    0x0(%rbp),%ebp
  39:	89 ee                	mov    %ebp,%esi
  3b:	83 e6 04             	and    $0x4,%esi
  3e:	31                   	.byte 0x31


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

