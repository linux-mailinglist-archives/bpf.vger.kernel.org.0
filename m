Return-Path: <bpf+bounces-33536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721EF91E994
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D35282347
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738D171643;
	Mon,  1 Jul 2024 20:29:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B016F265
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865760; cv=none; b=kMAake5vA4TD4n/HOA+2l12Wr7kf0j4A6iBLejywf/f0+mB2LrCVgvXA4BKaxzGBBwyAyG9cZm46byAJi5Q8ZBOYRQUeB8H3aa50ml4mN8eYMNvg+SqVgNTaMW7CMRYg0/oCHzi87+lD9IVfUWykOVfjAx7AVwZz3R9/NJnEN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865760; c=relaxed/simple;
	bh=oQITdv6k40q5TSoehNoxrygADAbUkGKXr5RS1yF57+Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uLYaMyvjRRcPIOIoOm4ID+wb6QWHbiBxRv1gAVOuuymesTY8qxb98dEotdHYkNjkw0xsEuSNYD46WuWDUMHGmEkoPCINGBSZkCeZGH/E5hFnL1/Z5jUyeoTFsYh6SgagLvPeZOAB93sFSghDO5KxHF1KcGV3GgVH/iq9T5pxMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c9b72aebso366647439f.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 13:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865758; x=1720470558;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45VUjgKyDJbHN9NQFzOoMfLnofpNwCXcTZgDZaJxLls=;
        b=osqocTtQ7cMcwZJ5DyliDcn23kOItwZpBVzzF0WpwF3eGnkd+YHBQcypzzk/5khxYe
         Eouprxn+SboPzI62HmSiSUUX15IQ2VTgEVmTdKUl9UjlnWENeLuZf8674mh9UPr60z/k
         jYgMbO6wtd/f3Rwh8CERrm7qKtGJUjeYZaJpMKIn0t6dsCcH5YqngCSea1jQiKfdbysE
         H0zb7AQexODQTjrAUzuL1sm62QNx8qL+ItWrNaysloWX/Xn+eDZ1gZRe73d9c2W43nTP
         SnNTIl3Bo8eV9ec4UghryxPUshZ7hS5MbJQj0qtuyrVElYRRPRsBrnMoz/4iWsfaO6AI
         9Jow==
X-Forwarded-Encrypted: i=1; AJvYcCWWuLuSxNUJ4Rd2sKA2B3l2ZT/FA27tXQaueO8nGin/SHBBsTI5Z7dSJWAOV5ca9nnar8rjiA+yKAIlXljjD5ezukuU
X-Gm-Message-State: AOJu0YxwhnuyejoE2h8xSz3Pb7MvjHof6CUh+qI078WVewzZ8yzjtvqB
	Vrku5MRmqDywuju3xb4OC3/kydt8HDn7DtnlE3WYFR2V7msoJzuy9BuYNxyjXFKQ3/dwDSsBNaI
	Ybk5kWEhsj3rNGjAxmdI/cpjgUf+5BpWV/By+DBL4xX1+zwADFCrTKSM=
X-Google-Smtp-Source: AGHT+IEVwvPqAO53RkQyrGV7S43o0Ayz+T2x8h0oOso1Pw1DV3p6wT7yDYTKBgkzGYkTxpWKLJW0/Xh3SDCbB4xF/KLPiBHqQTBQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:7f3:d460:610f with SMTP id
 ca18e2360f4ac-7f62eeae7d7mr60589339f.4.1719865757885; Mon, 01 Jul 2024
 13:29:17 -0700 (PDT)
Date: Mon, 01 Jul 2024 13:29:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f77c2061c357383@google.com>
Subject: [syzbot] [bpf?] [net?] stack segment fault in bpf_xdp_redirect
From: syzbot <syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa6fa6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=5ae46b237278e2369cac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9672225af907/disk-1c5fc27b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f14d163a914/vmlinux-1c5fc27b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec6c331e6a6e/bzImage-1c5fc27b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 10179 Comm: syz.0.1527 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4544 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4542
Code: 81 c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 55 1a 99 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc9000d537970 EFLAGS: 00010202
RAX: 1ffff1100c81ca81 RBX: 0000000000000000 RCX: ffff8880640e3c00
RDX: 0000000000000000 RSI: 000000000000a020 RDI: ffffc9000d537af0
RBP: 0000000000000007 R08: ffffffff8665e84f R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: 0000000000000038
R13: dffffc0000000000 R14: ffffc90012a31048 R15: 000000000000a020
FS:  00007f04c1ac26c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04c1aa1d58 CR3: 000000002ccf6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_bc55b47b7a2429cd+0x1d/0x1f
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
RIP: 0033:0x7f04c0d7471f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007f04c1ac2010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f04c0f04150 RCX: 00007f04c0d7471f
RDX: 0000000000000032 RSI: 0000000020001500 RDI: 00000000000000c8
RBP: 00007f04c0df677e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000032 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007f04c0f04150 R15: 00007ffffb5272c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4544 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4542
Code: 81 c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 55 1a 99 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc9000d537970 EFLAGS: 00010202
RAX: 1ffff1100c81ca81 RBX: 0000000000000000 RCX: ffff8880640e3c00
RDX: 0000000000000000 RSI: 000000000000a020 RDI: ffffc9000d537af0
RBP: 0000000000000007 R08: ffffffff8665e84f R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: 0000000000000038
R13: dffffc0000000000 R14: ffffc90012a31048 R15: 000000000000a020
FS:  00007f04c1ac26c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04c1aa1d58 CR3: 000000002ccf6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 c3 08 18 00 00    	add    $0x1808,%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 55 1a 99 f8       	call   0xf8991a71
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

