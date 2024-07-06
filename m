Return-Path: <bpf+bounces-33982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F392907A
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 05:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA61B22620
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 03:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521710A1A;
	Sat,  6 Jul 2024 03:39:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324617E9
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720237163; cv=none; b=V0b5TFYdgoo1TJhHNgp5Z+C4u8FA818uIN84fN9ck3mNJI9aVDNpFwQ/dgs5WGNfP147vBjZS3GK6DwkpeeQscuLzPeqflu/1A7vkSC/qOEK7WTWQfy8yBDfaOxxA6bohFytziMXgHntv04TtJvztmq9JteZtxNE5BrCi/5CIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720237163; c=relaxed/simple;
	bh=9HoLEGbmceEGBTjOQEjiwLflbPeqmy8PvF3X1MamxdM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gQoetxPyUBh+L3QL/zPy8Ar4yzdAE11edYqrG+JoDhxufM8qcrdh1WotzHct0TYx9zY5ULjD1Z5vkd1EKxrqiOwQenxMr3faikop4ApkQ9UhR8cxFOQSJ3BiHDq8Zzad9hfGw8T/jiaXcBMe9eVsZIJzETOgWV1mpFURWCBH8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61da2de1eso268310839f.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 20:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720237161; x=1720841961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9vbFEPaCtzXExclJU34Uc1ms4DD1o5TgMN10/y/2oA=;
        b=szmcu5IhsNnOOKG8+72xmzQIZoLVQ9Ijhd+3h20aEv363OzWx9XgJwqtmOuOQwbzzD
         ZA8vRvpj59tz0cVjX8WRPhuhvbkUvlIgexMnq2qqlGjnApXSxd/oRCxURyhHPTd4J1/t
         K0D9QwbV5cbTx3xsxkzWoRDQw78uTkJizGR7H1iDBzq3BWqWbi97b2FXXuJiVZuh8QYc
         GOL+UvPYcjw4gfnGnAUTqYRq+TyVLRxbaG32LcOewFkaepqvM3zutWBzhACGyDzGl4Rm
         uZdd1DWYL+13rv/M2HlE/cUM6lCZ+nJDsJQtpHmEhu7kKPQBfoVm8RZ/R8Sj4RY3ebAU
         VEiA==
X-Forwarded-Encrypted: i=1; AJvYcCUhdd4KFas4zj9uhAGRlW1B3SBs9EeSCzol117mFcukUe0v48rkcV1zTrAfGmIIDbtZPBeoVJIO2uLQEOHDrLeirCPM
X-Gm-Message-State: AOJu0YyFET2cIEXx0fNYhk3Pte4JnpZjGPSyAC4ngxqFRA7iK0Nklphn
	8F3/ssY9NfsEH66J1PGKXqM6xEqTAL+tbAYLfU3Ls8v5JSdyFSlO17b4KLyzX/7cAZjUoWEUJeh
	CGHbuz9AdM+SRJkIoSyuwIfq9ORG8abWzUBEaWkdMCY2NKz/3mdP8qUc=
X-Google-Smtp-Source: AGHT+IHSc110c0J9eVD7CGgwtr2W6owe93kYrvJ+SA8Ln/gay+v2r6gxePWxpc9otu8cNOHrhCPNkPM3y6gkNDkiHSp5SaybU3YQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d48d:0:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-3839bc3885amr1686475ab.5.1720237160655; Fri, 05 Jul 2024
 20:39:20 -0700 (PDT)
Date: Fri, 05 Jul 2024 20:39:20 -0700
In-Reply-To: <0000000000008f77c2061c357383@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e40c9b061c8bec7b@google.com>
Subject: Re: [syzbot] [bpf?] [net?] stack segment fault in bpf_xdp_redirect
From: syzbot <syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ee3e81980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=5ae46b237278e2369cac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a6e781980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165e6db9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5100 Comm: syz-executor326 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4561 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4559
Code: 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 b5 18 90 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc900033bf6f8 EFLAGS: 00010202
RAX: 1ffff11004549e40 RBX: 0000000000000000 RCX: ffff888022a4da00
RDX: 0000000000000000 RSI: 0000000002000000 RDI: ffffc900033bf900
RBP: 0000000000000007 R08: ffffffff895fff80 R09: 1ffff110172a8938
R10: dffffc0000000000 R11: ffffed10172a8939 R12: 0000000000000038
R13: dffffc0000000000 R14: 1ffff92000677f21 R15: 0000000002000000
FS:  000055557e4d4380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 000000007abc8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_56e821181540367a+0x1d/0x1f
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x679/0x14c0 net/core/dev.c:4962
 netif_receive_generic_xdp net/core/dev.c:5075 [inline]
 do_xdp_generic+0x673/0xb90 net/core/dev.c:5134
 tun_get_user+0x2805/0x4560 drivers/net/tun.c:1924
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f806d71bfd0
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d d1 e0 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007fff9b41b6b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff9b41b750 RCX: 00007f806d71bfd0
RDX: 000000000000fdef RSI: 0000000020000100 RDI: 00000000000000c8
RBP: 00007fff9b41b700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4561 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4559
Code: 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 b5 18 90 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc900033bf6f8 EFLAGS: 00010202
RAX: 1ffff11004549e40 RBX: 0000000000000000 RCX: ffff888022a4da00
RDX: 0000000000000000 RSI: 0000000002000000 RDI: ffffc900033bf900
RBP: 0000000000000007 R08: ffffffff895fff80 R09: 1ffff110172a8938
R10: dffffc0000000000 R11: ffffed10172a8939 R12: 0000000000000038
R13: dffffc0000000000 R14: 1ffff92000677f21 R15: 0000000002000000
FS:  000055557e4d4380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 000000007abc8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 c3 00 18 00 00    	add    $0x1800,%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 b5 18 90 f8       	call   0xf89018d1
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	4c 8d 63 38          	lea    0x38(%rbx),%r12
  23:	4c 89 e5             	mov    %r12,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 0f b6 44 2d 00    	movzbl 0x0(%rbp,%r13,1),%eax <-- trapping instruction
  30:	84 c0                	test   %al,%al
  32:	0f 85 d0 00 00 00    	jne    0x108
  38:	45 8b 34 24          	mov    (%r12),%r14d
  3c:	44 89 f6             	mov    %r14d,%esi
  3f:	83                   	.byte 0x83


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

