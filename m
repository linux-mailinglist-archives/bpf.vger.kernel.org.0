Return-Path: <bpf+bounces-68472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6CB58F4C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE51189F7D0
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3512E5B04;
	Tue, 16 Sep 2025 07:36:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829E72622
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008185; cv=none; b=ELA/A2uwpxWWONg7arVDoH9G1pGdohhFQdR2o3BzpPjhDzbsVE9mmGb2ZazWXvM25dGOokj5CfHbnsgAUtUdyvkhZWUipRhbR02fq+ipbm6KI9WGIYOAiGMLG38FCCHMFlaViAvQWEO5mAITFU1MdS2v0qYH0wS2wVdZBdHp9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008185; c=relaxed/simple;
	bh=OZCFx3BcRYhdvVmEa58ELvb5Cv276j5W6aVgx7YoZbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PKrwjwJ1UwSlaw18KmauP6DzzbVzE9VDf2AbWkoR9PgyDA0MHGMiL5VjN+3RXklfP3MYw49MFiVVlSNuv3xUWRCzljyM9lKUB4Y3dNlaUmZ/qewwWwkvhWeQMrmGwbJdFZXhPaWLTB6o9MZJ2QB/8NPX2Ms5EdKGrtyq7ReugsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-424019a3dfaso20174325ab.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 00:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008183; x=1758612983;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kG/wpCMoPSpliPZLV7sSFCxt7a5+qRf8Tr8/Vy2E0+8=;
        b=ClSwj6vFoy23mNyTgDa7aZwS0JJ4xpJqIWO19YLqQZ4xU0itIy0XWfvSPQEBGNHd71
         qr9cXGNPlOHPd/3DOIQQAlii+/q6K2XZ/XCcHzW46JXB9ISn78HRjqYApVLkN02pQLnf
         308lvm/U34CbReWrwV6hZxZlu2mYJLvgxm++DITi7fHCp1oDMbP3tQWQ5OrdYTIt5eF1
         A9weitSdMFSWEcHfYt1j5lmR37q/WWNfug5KNIHPK9mcOU7MednbkRQ8nM3+eOWi96kv
         W/hFjXWHcb0/FdKQF88M6Y6BEf1pst0TYT2QbldnLyipIhSwfsBCbSiaUMZikqe4TQUV
         qBOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPYZPPL375hmrLtg1rEgKUMebcZvis2qgQkPK3AHWSqVaSE3zXfwW6BD9G+wzKdDjRQJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+LzntBtwSQNcl2R2DuXj/vKcT3SI8qmeSmGB2u5gYt+FbFip
	kgNVzwhKRLaTMfwq006uD+/J4Tf1mCkld+XjCtGMCcdeY8njcBJAatxtCKBRW1kGTsK9+WXznjP
	3dTu06wEboW0SrJxpy/KpLa+37EcHU6SKXs8LsZX6m71mg6Yg44KkrQtsaGk=
X-Google-Smtp-Source: AGHT+IH4Bs+ZtsLTX+kC8ZuzvXU3zCESpr9ECGm1Cu7cKkBEEu0LDMqvnvSLqGXvbYdYurfhzBDdbSq+P3MTe+sB/PlyX+JAjAW2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:441a:10b0:423:84d0:7f7e with SMTP id
 e9e14a558f8ab-42384d08142mr99670435ab.6.1758008183103; Tue, 16 Sep 2025
 00:36:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 00:36:23 -0700
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c91377.050a0220.3c6139.0e56.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Introduce deferred task context execution
From: syzbot ci <syzbot+ci32b4e1af61a315c2@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, mykyta.yatsenko5@gmail.com, yatsenko@meta.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v4] bpf: Introduce deferred task context execution
https://lore.kernel.org/all/20250915201820.248977-1-mykyta.yatsenko5@gmail.com
* [PATCH bpf-next v4 1/8] bpf: refactor special field-type detection
* [PATCH bpf-next v4 2/8] bpf: extract generic helper from process_timer_func()
* [PATCH bpf-next v4 3/8] bpf: htab: extract helper for freeing special structs
* [PATCH bpf-next v4 4/8] bpf: verifier: permit non-zero returns from async callbacks
* [PATCH bpf-next v4 5/8] bpf: bpf task work plumbing
* [PATCH bpf-next v4 6/8] bpf: extract map key pointer calculation
* [PATCH bpf-next v4 7/8] bpf: task work scheduling kfuncs
* [PATCH bpf-next v4 8/8] selftests/bpf: BPF task work scheduling tests

and found the following issue:
general protection fault in process_timer_func

Full report is available here:
https://ci.syzbot.org/series/e70d729f-f3e4-4237-b9e5-1ca20a4669da

***

general protection fault in process_timer_func

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      df0cb5cb50bd54d3cd4d0d83417ceec6a66404aa
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/43db8049-6e85-46cb-a784-af031a39375f/config
C repro:   https://ci.syzbot.org/findings/f6e0987d-2e21-4806-85fb-a885db967391/c_repro
syz repro: https://ci.syzbot.org/findings/f6e0987d-2e21-4806-85fb-a885db967391/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 5988 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:process_timer_func+0xe5/0x290 kernel/bpf/verifier.c:8558
Code: 1f 4c 8d 63 38 4c 89 e0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 e7 e8 8a 38 46 00 4d 8b 24 24 49 83 c4 10 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 47 01 00 00 41 8b 0c 24 4c 89 f7 89 ee
RSP: 0018:ffffc90003b66f80 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff88802701d400 RCX: 0000000000000078
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: ffff888106b53980 R09: 000000000000000e
R10: 0000000000000017 R11: 0000000000000000 R12: 0000000000000010
R13: dffffc0000000000 R14: ffff8880247e0000 R15: ffff888027b90080
FS:  0000555581212500(0000) GS:ffff8880b861c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30e63fff CR3: 000000010664a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 check_func_arg kernel/bpf/verifier.c:9885 [inline]
 check_helper_call+0x20de/0x6a90 kernel/bpf/verifier.c:11526
 do_check_insn kernel/bpf/verifier.c:20042 [inline]
 do_check+0x8b35/0xe520 kernel/bpf/verifier.c:20211
 do_check_common+0x1949/0x24f0 kernel/bpf/verifier.c:23378
 do_check_main kernel/bpf/verifier.c:23461 [inline]
 bpf_check+0x1746a/0x1d2d0 kernel/bpf/verifier.c:24821
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2993
 __sys_bpf+0x528/0x870 kernel/bpf/syscall.c:6043
 __do_sys_bpf kernel/bpf/syscall.c:6153 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6151 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00c358eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb3c1bfd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f00c37d5fa0 RCX: 00007f00c358eba9
RDX: 0000000000000094 RSI: 0000200000000400 RDI: 0000000000000005
RBP: 00007f00c3611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f00c37d5fa0 R14: 00007f00c37d5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:process_timer_func+0xe5/0x290 kernel/bpf/verifier.c:8558
Code: 1f 4c 8d 63 38 4c 89 e0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 e7 e8 8a 38 46 00 4d 8b 24 24 49 83 c4 10 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 47 01 00 00 41 8b 0c 24 4c 89 f7 89 ee
RSP: 0018:ffffc90003b66f80 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff88802701d400 RCX: 0000000000000078
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: ffff888106b53980 R09: 000000000000000e
R10: 0000000000000017 R11: 0000000000000000 R12: 0000000000000010
R13: dffffc0000000000 R14: ffff8880247e0000 R15: ffff888027b90080
FS:  0000555581212500(0000) GS:ffff8880b861c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30e63fff CR3: 000000010664a000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	4c 8d 63 38          	lea    0x38(%rbx),%r12
   4:	4c 89 e0             	mov    %r12,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  10:	74 08                	je     0x1a
  12:	4c 89 e7             	mov    %r12,%rdi
  15:	e8 8a 38 46 00       	call   0x4638a4
  1a:	4d 8b 24 24          	mov    (%r12),%r12
  1e:	49 83 c4 10          	add    $0x10,%r12
  22:	4c 89 e0             	mov    %r12,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 47 01 00 00    	jne    0x17d
  36:	41 8b 0c 24          	mov    (%r12),%ecx
  3a:	4c 89 f7             	mov    %r14,%rdi
  3d:	89 ee                	mov    %ebp,%esi


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

