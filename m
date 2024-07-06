Return-Path: <bpf+bounces-33985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC1C929111
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 07:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467B9281AD8
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 05:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B522EF4;
	Sat,  6 Jul 2024 05:08:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDF208BC
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720242504; cv=none; b=lxkDle7I8Fny09gBMANwtohriwd2XcDzx+/ripuOZ3PZLIna0oQGpFo8bKjCi8zabeQ24LeWRx9iv6W4EEGSQEx8KO3zmsNz17diZ9tbkYKiw/uEPXMxOYLZDUMB2nQ7aZq8wPqvAnCMfo3KJUPqhQRMOtJc26RTEQu0/j5haqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720242504; c=relaxed/simple;
	bh=zNgwfH6InNsnWWKPwSRPQOgaum/vvGCcbSzXoI9VjYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmEkp3YPRjx3nLM0Q+5Hu83Ppp+z4qRhaJ/RT1Wz+fXf891wR3BEq9j+HMyKCQqCDHcVfl6G9dJ/pBJrR5fQG7qfMxOh4cgOtldbpYSSQFzlZEa+CXatIw553cU3pgWCCBGAUWJMwKvR98qnQloQ5443azqNhSQHnb9Cwb4WyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f639551768so287750239f.3
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 22:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720242502; x=1720847302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMnth4lpZqa54DWQFc+Nscp7G5diBYCWrU+izZnqnwE=;
        b=BAti9giS7XK22SvAeex9IfdhgkwpUBVp4yx2PLHKMhWPup/etb/CLr4ocmt4irCRfa
         /BlFr4//phPbivsm3YYmyBx7aCIzIvqsG9J1DU5DZw3YR66H5xFB2vPKCOXjiDkMs5K1
         CiqqWhUnhC4SfCWhK0rwQyyuX6yhF4ciTtbtkYX+Gf8WA8J6RnnuIEk3OjwOXdyebswh
         yg0lPJ+nfqDSx66/w0R+Euz/mLwFCOi4V8G/6TDoPMAzw4TzwEtF5jK13qzhKmjHz22K
         VmSNDBf7mqxxIjMvJykxdw7vEEVwaWPoyUw0f48dKVeEIgc8WE6AmZezOX4OizitmFfU
         5RXg==
X-Forwarded-Encrypted: i=1; AJvYcCXibyz5it0QXz1vR5vWw0NcGbBNR7L5WkN6Mz0Q9u5Tzbx/Vqqt5Sc2gj5NUeTDdkFTOEH8wiIGNGj2EyDKViN/1Sh1
X-Gm-Message-State: AOJu0YwfK75XT/E9D5v4VpkvnIT+MA93xL6v5T6sbUeA2ytzPn4N1B2G
	anTtzdlw8iPxCbx1OrSeWy86Bvnm1iZ5IlL6fd2/MP0tBlqK2aczkbuU0TvtO2h5UYQ03aHiWQe
	ASqigmRst2uuQWSJtK3cj6sfY2LNA2R3FSkXpzBPpdrTRB4KMnJWJ3g4=
X-Google-Smtp-Source: AGHT+IFr4AsctvjiD5hASZ8o+wMepJiBeGtuBChIyn9BbPMd4UnjcMUWz+fifv4uC5+sdUUtcxKT9HnpOHj9ChVOOZf4dAxjVZ9C
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc4:b0:7f6:5c77:ce16 with SMTP id
 ca18e2360f4ac-7f66df29b61mr44280539f.3.1720242502048; Fri, 05 Jul 2024
 22:08:22 -0700 (PDT)
Date: Fri, 05 Jul 2024 22:08:22 -0700
In-Reply-To: <00000000000079d168061c36ce83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000432cc7061c8d2b68@google.com>
Subject: Re: [syzbot] [bpf?] [net?] stack segment fault in dev_hash_map_redirect
From: syzbot <syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165ce371980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=c1e04a422bbc0f0f2921
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14987969980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11955485980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5094 Comm: syz-executor316 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:dev_hash_map_redirect+0x64/0x620 kernel/bpf/devmap.c:1022
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 9f 9c 3d 00 48 8b 03 48 89 44 24 08 48 8d 58 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 3d 00 84 c0 0f 85 f5 03 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc9000356f958 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000038 RCX: ffff8880276e9e00
RDX: 0000000000000000 RSI: 000000000356f9b0 RDI: ffff88802f22f000
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff8880276e9e00 R12: 0000000000000008
R13: 000000000356f9b0 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557ccb9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021d5ab98 CR3: 0000000022250000 CR4: 00000000003506f0
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
RIP: 0033:0x7fbd788a7f10
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d b1 e1 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffde33a9838 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbd788a7f10
RDX: 000000000000004e RSI: 0000000020000540 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffde33a9968 R09: 00007ffde33a9968
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:dev_hash_map_redirect+0x64/0x620 kernel/bpf/devmap.c:1022
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 9f 9c 3d 00 48 8b 03 48 89 44 24 08 48 8d 58 38 48 89 dd 48 c1 ed 03 <42> 0f b6 44 3d 00 84 c0 0f 85 f5 03 00 00 44 8b 33 44 89 f6 83 e6
RSP: 0018:ffffc9000356f958 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000038 RCX: ffff8880276e9e00
RDX: 0000000000000000 RSI: 000000000356f9b0 RDI: ffff88802f22f000
RBP: 0000000000000007 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff8880276e9e00 R12: 0000000000000008
R13: 000000000356f9b0 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557ccb9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021d5ab98 CR3: 0000000022250000 CR4: 00000000003506f0
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
  12:	e8 9f 9c 3d 00       	call   0x3d9cb6
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
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

