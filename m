Return-Path: <bpf+bounces-33538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8B91EAB3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97DC1F22564
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B716F0E8;
	Mon,  1 Jul 2024 22:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CF18EAF
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871580; cv=none; b=r1hqXA7xlv5Rlx8xMfsb2tyqVYJWs5C4ZFlJesEPXV0K1iAhzkKTKJaOToL9wqvXDnsj3/KuycK8kMJNLsUisDD31T2Wk4sjGz6+0tuc6dabm5ZW2siKIV/GpdnSlMXtNPwnb5qDs0emqKRJ72B7GQaAPWdcohbGfl2xtYsUc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871580; c=relaxed/simple;
	bh=/amQ3zaG0Voaax8MZ6Awgi9QGC3fLvJuYy3bJyQOMh8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gnV7NM4G/hRkuYKhQCu7aLYYE+yui2XvqQ6O6eDFKIElXYH61MP1nmmJYHSqJ6K32UmcEq268n+A7D4eXwyT+39FTU/d4nj0CICBItAdoWUL9JobGldRC96B1qH5HlipcQ6qpqQbXup55TiXqjdnY4AWLUCKIZurNT6i6L82LPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f63eb9f141so107672539f.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 15:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719871578; x=1720476378;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pK4372I5RZBtND3R4f8EVsxKlmv2omYFokbpeIbDVLc=;
        b=QTuR8tdPG+aRIdxT2lSpdH5qSr1e4lHOiBtlOkUqmPTENEBHuo6W0XNhp446kser7q
         DQuVDgnZl/R/N6rDb+aKNhe7MGCo9X3DmKP43K7D9BcuWdR1SeKGru7ZNwbbb3qb2nKR
         O59oEPZjR1260FRZG/wMEC/5NQM97ST2RI919OrU6MI4FbCvL8rt+SctSrOe8OP9P1dp
         BzzoJiG5BVDbPaOJu3eVnblRBznjS7sNuwY5GsVq/ENoM3mIrzJcm5YF9+42AK9lu92Q
         RerE/QEkBTdBGIv0x6YyrsIjEG0QLDv8yC8J+SWitF6zC/Pm3+re6u1FwAJcTx2m78+E
         vvsA==
X-Forwarded-Encrypted: i=1; AJvYcCUF8gtibXC+ZM4M1Rul0WD6jy9jWaU8XUPr8SkNgB0dNWJMWhNY+VVGIl1PAQrICshC8OwpO4XeaLjQt//drR6bKJeA
X-Gm-Message-State: AOJu0YwuO7GAeyTwUhJershB6PyYRA4LBac7xpXW9uZDuF8gz6VW8z0g
	djkt1rXMaTnWUIrG7IygbA6lzWSFBkys3vLyiWn2AJFu04cHOtdjMK9CZ1hHb3Wahcbbngarj88
	oj1Vk1HcVeyZskIOIPdJVNp6rS30koEmdiBfVv2dOLtxs56XeDiPnHKg=
X-Google-Smtp-Source: AGHT+IEy2Ao1feR4CNno+aEAC9qWbhnOOwQH9ujAypDFvcvVEvsLzIWNCRRoSsbwGY42/nss4LyApOIjk0Rh5aOEu+SumhtIwFvW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b710:0:b0:376:2246:3b4b with SMTP id
 e9e14a558f8ab-37cbadfbd49mr2906965ab.1.1719871578161; Mon, 01 Jul 2024
 15:06:18 -0700 (PDT)
Date: Mon, 01 Jul 2024 15:06:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079d168061c36ce83@google.com>
Subject: [syzbot] [bpf?] [net?] stack segment fault in dev_hash_map_redirect
From: syzbot <syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    74564adfd352 Add linux-next specific files for 20240701
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163a0f1e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=111e4e0e6fbde8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=c1e04a422bbc0f0f2921
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04b8d7db78fb/disk-74564adf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d996f4370003/vmlinux-74564adf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e7e630054e7/bzImage-74564adf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 12368 Comm: syz.0.2084 Not tainted 6.10.0-rc6-next-20240701-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1672 [inline]
RIP: 0010:dev_hash_map_redirect+0x64/0x620 kernel/bpf/devmap.c:1027
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 0f 9c 3d 00 48 8b 03 48 89 44 24 08 48 8d 58 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 3d 00 84 c0 0f 85 f5 03 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc900108f7958 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000040000
RDX: ffffc90009834000 RSI: 00000000000001b9 RDI: 00000000000001ba
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5e80f
R10: 0000000000000004 R11: ffff888068e5da00 R12: 0000000000000008
R13: 00000000108f79b0 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fb7f29dc6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000078d4a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_ec9efaa32d58ce69+0x56/0x5a
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 tun_build_skb drivers/net/tun.c:1711 [inline]
 tun_get_user+0x3321/0x4560 drivers/net/tun.c:1819
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb7f1b7471f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007fb7f29dc010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb7f1d03fa0 RCX: 00007fb7f1b7471f
RDX: 000000000000003a RSI: 0000000020000000 RDI: 00000000000000c8
RBP: 00007fb7f1bf677e R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003a R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb7f1d03fa0 R15: 00007ffc3bd4c628
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1672 [inline]
RIP: 0010:dev_hash_map_redirect+0x64/0x620 kernel/bpf/devmap.c:1027
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 0f 9c 3d 00 48 8b 03 48 89 44 24 08 48 8d 58 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 3d 00 84 c0 0f 85 f5 03 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc900108f7958 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000040000
RDX: ffffc90009834000 RSI: 00000000000001b9 RDI: 00000000000001ba
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5e80f
R10: 0000000000000004 R11: ffff888068e5da00 R12: 0000000000000008
R13: 00000000108f79b0 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fb7f29dc6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000078d4a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	d8 48 c1             	fmuls  -0x3f(%rax)
   6:	e8 03 42 80 3c       	call   0x3c80420e
   b:	38 00                	cmp    %al,(%rax)
   d:	74 08                	je     0x17
   f:	48 89 df             	mov    %rbx,%rdi
  12:	e8 0f 9c 3d 00       	call   0x3d9c26
  17:	48 8b 03             	mov    (%rbx),%rax
  1a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  1f:	48 8d 58 38          	lea    0x38(%rax),%rbx
  23:	48 89 dd             	mov    %rbx,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 0f b6 44 3d 00    	movzbl 0x0(%rbp,%r15,1),%eax <-- trapping instruction
  30:	84 c0                	test   %al,%al
  32:	0f 85 f5 03 00 00    	jne    0x42d
  38:	44 8b 33             	mov    (%rbx),%r14d
  3b:	44 89 f6             	mov    %r14d,%esi
  3e:	83                   	.byte 0x83
  3f:	e6                   	.byte 0xe6


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

