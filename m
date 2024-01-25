Return-Path: <bpf+bounces-20336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955283CA54
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9601F22964
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A377133434;
	Thu, 25 Jan 2024 17:53:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AE130E4C
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205208; cv=none; b=B2Cd5x4s5gQt/9QP0msIT7Hv5sTyUB8PPy1KwzRtaqMnnscZ5aiEddYEgZ9GUI/dCqqL63iy0GyCGoFJ9vwkQ73pSmMtfm4duLobf5I2WnEuCg5TERY94KJLUaI6JqLVxVIvwFk+cZAd+DnK9mLNdqkCx4N6OYYu8VvwitBgM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205208; c=relaxed/simple;
	bh=9NXpVVXWncb/IUWv9CvZzmHyl6/N0VnRCmv41L6VDX4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mQ2v4IU0IICnUsnvSdHZawxurKWVSNqtz4BcBacEWYn88Arcb9h8axdSP/FXV/+Kz/A8vf6DzNQVjcEwNbITqM+WoleJseqm7mX+3QaCc3/YDcRP+lTcTKtiw8KOlqHVfAmtgubIDgWjr8f1LSnF0u1MvvOIPTHzT5t+/Ey7KXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so690752039f.2
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 09:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205206; x=1706810006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GIo5UEfmmEJrGtw4TbN8J6mKXeZ+fxztdMS3KxE1Jo=;
        b=wXqC0qlrJPN/h9vZBREMJusCJYuHlyXGfXULcospPYvEjhvH9l5hCSQk1ojNf3loSG
         ivgmHlmVx+vy2f6UiO5IwgN96E5mWg71StWefFBcP93xPkTbPw3j8z9pP1I6KETJbsAv
         /vhHqL3PoK2TMySFhWK8mZM8eNxpqDgbpGMSKhN4ePtHw9XqMRyWDGtNKkTe1HxO2mWf
         KJUtdRgNdiHG2B5mtd1B7Kk1/9eTqcf+uY1Kg8Sak5q4YqK7QD2PdWpQilDuBrigirHi
         YAGH1C+QhVMvU7yBUgflEXv4Hl2qETYxHITLearW0QaRIVMupDWpKiOSNmqQX91LuokK
         Thmg==
X-Gm-Message-State: AOJu0YypPMvY5nSSRWTSc1KxpsHhtlScrxw3tAFd6PEUvMDfE5p02wsb
	8g3yVqyktbc6xb9h/h4c7cKceap2iRvu2uVtqlR+ocaKHoBj2A+4MpbVJN03Pdk1MKZwKpdXDjj
	WMBjsaf1ixsSAEx4XU6SUzGvMUdNxIE/i8MKJcPx/AOKNaY4+Ll7HwAw=
X-Google-Smtp-Source: AGHT+IHPr1gnQYMVgd3XU9mcspBuYbfX2pkIsEBdOgnyKMH9eiOQl0et+oLtEMipLiPun8lunlLDZOT2MtrMNngYVW7e4gCG96QK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6282:b0:46e:dbd6:691b with SMTP id
 fh2-20020a056638628200b0046edbd6691bmr92115jab.1.1706205206596; Thu, 25 Jan
 2024 09:53:26 -0800 (PST)
Date: Thu, 25 Jan 2024 09:53:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040d68a060fc8db8c@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_struct_ops_find_value
From: syzbot <syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	thinker.li@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d47b9f68d289 libbpf: Correct bpf_core_read.h comment wrt b..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11479fe7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=719e6acaf392d56b
dashboard link: https://syzkaller.appspot.com/bug?extid=88f0aafe5f950d7489d7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ea6be3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bc199be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a9b4a5622fb/disk-d47b9f68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd68baeac4fd/vmlinux-d47b9f68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/811ba9dc9ddf/bzImage-d47b9f68.xz

The issue was bisected to:

commit fcc2c1fb0651477c8ed78a3a293c175ccd70697a
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Fri Jan 19 22:49:59 2024 +0000

    bpf: pass attached BTF to the bpf_struct_ops subsystem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106a04c3e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126a04c3e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=146a04c3e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops subsystem")

general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 PID: 5058 Comm: syz-executor257 Not tainted 6.7.0-syzkaller-12348-gd47b9f68d289 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:bpf_struct_ops_find_value+0x49/0x140 kernel/bpf/btf.c:8763
Code: 7d ea dd ff 45 85 e4 0f 84 d7 00 00 00 e8 ff ee dd ff 48 8d bb 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 00 00 00 48 8b 9b 88 00 00 00 48 85 db 0f 84
RSP: 0018:ffffc90003bb7b20 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3283
RDX: 0000000000000011 RSI: ffffffff81aa3291 RDI: 0000000000000088
RBP: ffffc90003bb7dd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
R13: 000000000000001a R14: ffffffff8ad6bca0 R15: ffffc90003bb7e04
FS:  0000555556ed2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000160d398 CR3: 000000007809c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_struct_ops_map_alloc+0x12f/0x5d0 kernel/bpf/bpf_struct_ops.c:674
 map_create+0x548/0x1b90 kernel/bpf/syscall.c:1237
 __sys_bpf+0xa32/0x4a00 kernel/bpf/syscall.c:5445
 __do_sys_bpf kernel/bpf/syscall.c:5567 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5565 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5565
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9f205ef2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa4ce4088 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fffa4ce4268 RCX: 00007f9f205ef2e9
RDX: 0000000000000048 RSI: 00000000200004c0 RDI: 0000000000000000
RBP: 00007f9f20662610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffa4ce4258 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_struct_ops_find_value+0x49/0x140 kernel/bpf/btf.c:8763
Code: 7d ea dd ff 45 85 e4 0f 84 d7 00 00 00 e8 ff ee dd ff 48 8d bb 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 00 00 00 48 8b 9b 88 00 00 00 48 85 db 0f 84
RSP: 0018:ffffc90003bb7b20 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3283
RDX: 0000000000000011 RSI: ffffffff81aa3291 RDI: 0000000000000088
RBP: ffffc90003bb7dd0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
R13: 000000000000001a R14: ffffffff8ad6bca0 R15: ffffc90003bb7e04
FS:  0000555556ed2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000160d398 CR3: 000000007809c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	45 85 e4             	test   %r12d,%r12d
   3:	0f 84 d7 00 00 00    	je     0xe0
   9:	e8 ff ee dd ff       	call   0xffddef0d
   e:	48 8d bb 88 00 00 00 	lea    0x88(%rbx),%rdi
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 89 fa             	mov    %rdi,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	0f 85 dc 00 00 00    	jne    0x10c
  30:	48 8b 9b 88 00 00 00 	mov    0x88(%rbx),%rbx
  37:	48 85 db             	test   %rbx,%rbx
  3a:	0f                   	.byte 0xf
  3b:	84                   	.byte 0x84


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

