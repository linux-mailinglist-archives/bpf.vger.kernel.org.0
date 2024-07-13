Return-Path: <bpf+bounces-34733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224593065F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7532A1C212CD
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359B13C90C;
	Sat, 13 Jul 2024 16:24:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29932139D1E
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720887866; cv=none; b=DWs4k7tVVoaNmyV31H5gV7UAkXAvI7AImxtfb9dP8F3vOiMpohnXZu2oMXkFRvVeVgz7TJ6S7XphzM2b6bKHzOQAdRhGiOKyOHoSNruiqngmSTf4U39cRk7iwYZOXBDTseFyquWoCCMa3vp1HG7WFeimejH0rc6/76J7SoG9/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720887866; c=relaxed/simple;
	bh=xpb5I2zJPE5D0bPloO26bg1gbNNMxjtkM+WgGTFmj3o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FkXmd8yfGak9E8bvu7Lsij3w1GonS2ra8Jq+4mmZC1Q2E690gEvljkTtxbv39UJjNK+jThgUKq0IpA/CII4hxhYMC7Btt7ZU9JFGkAJ41FPvzBYU5ii2XFpo69AhcxZ8o7eUyC0jz3qbVk+mDAIc5zmddXC4g/wn7kL5QDEy71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso322842139f.2
        for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 09:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720887863; x=1721492663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E296RzClnDhpDUcuegleyH62gwNo5mzWmNwTtDEFd4g=;
        b=N4lsm6o/3q7qnJMuoacQ7N1mZkWdBiHW5QRaFOkh7QYcX0va6zVJxLvkq6xdKzAZXh
         HR+3asgr6KcS2+mWznqWizpt7xoQ836wP0YuxLOFQoDUhmbNQsPJzUsv5wCKOqltOY1b
         91UR09abUvflD3SudEzCS/UKUYIvSYZrN9qxkpWA6e/jfaHaohMrCbpa/eFI1aNd3LN9
         2z5jCBnS2ygsRo/iKr1/xP2piSEONuOSdF9xKHRA4lcd9714JxM1sBpBLxPLD7GPrQHi
         xFTmChMC+6H1uIN6Mjg7bQa7Vm0kBNxFm7ft5lNYNRGsqqURf3t1SGHXjtj/hMt/gvRx
         YVXg==
X-Forwarded-Encrypted: i=1; AJvYcCX123E9TX+mtN9C3Lt68CK5qAjoOnmuoU3qNFT6kkWbEUHBR2XcPrAvlF3AcbfTQvHi0TlNNq0TFRLQ8umNiY+gR+JZ
X-Gm-Message-State: AOJu0YzMgUVrMIFn6/pnkqTxAbAsm1JcQhb3ZbqRENCEfbo0+KzsnaCb
	Pcl7Zqu2ATUV01tgq6v/aXltPXL96rb+Qbkl1BedEItOxmXxtXcHex+1VJFM0f1DOwFbvJa5Z9Z
	x7CB9JCnlHJPTPwJJkLHjmzPGs/m1ZTQ0WyWwjZYtYX4sinRvA5RCsFs=
X-Google-Smtp-Source: AGHT+IEsnS9zUo0dPuae33bLd+vzGrV52ncVkwDwwbg3xoBy5DjDE3By6X9h+aogNRQiy9djP5qIZ0M3aTVocfPwrYfDiBMm8w3E
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:710a:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4c0b29ba495mr1263022173.2.1720887863213; Sat, 13 Jul 2024
 09:24:23 -0700 (PDT)
Date: Sat, 13 Jul 2024 09:24:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c90eee061d236d37@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (3)
From: syzbot <syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8b9b59e27aa8 i40e: fix: remove needless retries of NVM upd..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135ee4f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=ad9ec60c8eaf69e6f99c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171399dd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e4054e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/535b0bcd3e1f/disk-8b9b59e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/127f5ddff150/vmlinux-8b9b59e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3ac9910529c/bzImage-8b9b59e2.xz

The issue was bisected to:

commit 1f1e864b65554e33fe74e3377e58b12f4302f2eb
Author: Yonghong Song <yonghong.song@linux.dev>
Date:   Fri Jul 28 01:12:07 2023 +0000

    bpf: Handle sign-extenstin ctx member accesses

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121c054e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111c054e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=161c054e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
Fixes: 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses")

BUG: unable to handle page fault for address: 000000002aebd040
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 80000000226b6067 P4D 80000000226b6067 PUD 226b7067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5096 Comm: syz-executor365 Not tainted 6.10.0-rc7-syzkaller-00133-g8b9b59e27aa8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_prog_82ec301e76077160+0x5c/0xa0
Code: 0a b8 02 00 00 00 41 5d 5b c9 c3 48 89 df 48 8b b7 d8 00 00 00 48 63 f6 48 8b 57 50 48 89 f0 48 83 c0 08 48 39 c2 77 02 eb dc <48> 0f b7 5e 00 4c 0f bf eb 48 81 fb 0f ff 07 00 74 00 48 c1 e3 20
RSP: 0018:ffffc900031f7980 EFLAGS: 00010292
RAX: 000000002aebd048 RBX: 0000000000000000 RCX: ffff888076a99e00
RDX: ffff88802aebd050 RSI: 000000002aebd040 RDI: ffff8880226b4b40
RBP: ffffc900031f7990 R08: ffffffff8183cf51 R09: 1ffffffff1f5b295
R10: dffffc0000000000 R11: ffffffffa0001f9c R12: ffffffff8998404e
R13: dffffc0000000000 R14: ffffc90000ace030 R15: ffffc90000ace020
FS:  0000555562a39380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002aebd040 CR3: 0000000021bc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x409/0x910 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1072
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4292
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5706
 __do_sys_bpf kernel/bpf/syscall.c:5795 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5793 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5793
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd7dc9bbb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1893ff98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd7dc9bbb9
RDX: 000000000000004c RSI: 0000000020000240 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 000000002aebd040
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_prog_82ec301e76077160+0x5c/0xa0
Code: 0a b8 02 00 00 00 41 5d 5b c9 c3 48 89 df 48 8b b7 d8 00 00 00 48 63 f6 48 8b 57 50 48 89 f0 48 83 c0 08 48 39 c2 77 02 eb dc <48> 0f b7 5e 00 4c 0f bf eb 48 81 fb 0f ff 07 00 74 00 48 c1 e3 20
RSP: 0018:ffffc900031f7980 EFLAGS: 00010292
RAX: 000000002aebd048 RBX: 0000000000000000 RCX: ffff888076a99e00
RDX: ffff88802aebd050 RSI: 000000002aebd040 RDI: ffff8880226b4b40
RBP: ffffc900031f7990 R08: ffffffff8183cf51 R09: 1ffffffff1f5b295
R10: dffffc0000000000 R11: ffffffffa0001f9c R12: ffffffff8998404e
R13: dffffc0000000000 R14: ffffc90000ace030 R15: ffffc90000ace020
FS:  0000555562a39380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002aebd040 CR3: 0000000021bc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0a b8 02 00 00 00    	or     0x2(%rax),%bh
   6:	41 5d                	pop    %r13
   8:	5b                   	pop    %rbx
   9:	c9                   	leave
   a:	c3                   	ret
   b:	48 89 df             	mov    %rbx,%rdi
   e:	48 8b b7 d8 00 00 00 	mov    0xd8(%rdi),%rsi
  15:	48 63 f6             	movslq %esi,%rsi
  18:	48 8b 57 50          	mov    0x50(%rdi),%rdx
  1c:	48 89 f0             	mov    %rsi,%rax
  1f:	48 83 c0 08          	add    $0x8,%rax
  23:	48 39 c2             	cmp    %rax,%rdx
  26:	77 02                	ja     0x2a
  28:	eb dc                	jmp    0x6
* 2a:	48 0f b7 5e 00       	movzwq 0x0(%rsi),%rbx <-- trapping instruction
  2f:	4c 0f bf eb          	movswq %bx,%r13
  33:	48 81 fb 0f ff 07 00 	cmp    $0x7ff0f,%rbx
  3a:	74 00                	je     0x3c
  3c:	48 c1 e3 20          	shl    $0x20,%rbx


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

