Return-Path: <bpf+bounces-26221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D0D89CE32
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F62283B94
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34C1494C6;
	Mon,  8 Apr 2024 22:03:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEE148854
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613786; cv=none; b=FSEjT3CR5KwRD7S1lIF/UzMAxvkITvx1aE6n3oWC2wRF7ATq8v5YLU2CCAZnP5B48llx4EbDS5SwNlRhIAKBT405VK0WMVwEIJ2dXKi3H8Ai1G6zTxI2gJXRJthbp3Eul+wcGYsGviX5k/A81t3jEhvrDXACKQUftl73RlNtOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613786; c=relaxed/simple;
	bh=JP6s7i2VAFiUd/EYR6e9JUfTFhs5g17RVYGi9G44oxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fSQIMyaPdBkIWKVg4zUY9B01AtUka6DiVhyBvPtjgpJy2b2gzqG5ee0i9A7lu237wPAFg5T9Wm3Plji8zlvJYDmhnre3cgvKDRN+DbYtagMhjdZazJ4bgrHzbTIo+vyL7PDu+D+TGk6RV2PnLgYZghXSsxLXEzLApLaZ6/REdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso159160739f.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 15:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613784; x=1713218584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsU/sMnc5XA5zrqfRklHsN/3Qe43gMvrpG8RMn/HvFU=;
        b=glsJ0sARIVCA7Gg+oq8iOHVcOPmVaYwV5vXl85QzcOEJse5TGvhkdrzbGz338gn/jH
         pHV6z0F3MnFKxZAvqr8HQsptLTSiOcEk6FvRpvr2FYWxdkH8oRBvbV7XeUc7YigBtPnf
         +f71TgZLyJ45zUXYiTZRpiDSp92Oh4W3JVSAqFF8RKD1TbFNJpjTmRa2NgNa5Z8UEyHk
         w4RsYvYoGdfs37oKVnV4dFOBGmw6Xr68Kn109be0HoCOIxKsbuqe79sH7oOcE7uWEcVt
         7+WU3QGNWNFNL/R/8DSUlVwO621aTgwjWJnqmZkQlyW30Jt9ZgpPfPrgcU+QDKK4owu9
         W2lg==
X-Forwarded-Encrypted: i=1; AJvYcCX2T3kdksdnY+cn8eljoLn66PX0vIrsX+iKsYozpipwLa2NQESXFITuZgpTV3uJOfZ7r+xAwy+c3ZivgLz/2In4tSAY
X-Gm-Message-State: AOJu0YwC3s/2RiNqhJ5j0Q6ZkGK4YhcMb8oJGI8WhdGIa3vr0hoi+g/B
	2trJtnZkVFF8ISiKjtW16+MPhGKMZ7r7h9EmTsHXasXriaW9ygiKamBGGMFqQ+6Q8dPEdR1ljiH
	oG+csfEyO//PKP2U/KQ6rCAYD3UKV7qAhfi/MJpjCt7CMqKjtEHFpodE=
X-Google-Smtp-Source: AGHT+IEPOHz0i+nN8HqthsqApsGr1SefiMjoA0B/9H3y5BTbULzhEg6xxFL96D9wa7V1QqI3ydnVCjNIsG3KZ2gRXU83iFGadQQI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4115:b0:47e:c165:74dc with SMTP id
 ay21-20020a056638411500b0047ec16574dcmr585913jab.5.1712613783927; Mon, 08 Apr
 2024 15:03:03 -0700 (PDT)
Date: Mon, 08 Apr 2024 15:03:03 -0700
In-Reply-To: <877ch7hnxf.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a924406159cf8ee@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in dev_map_enqueue

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8787 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05236-g443574b03387-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc9000bc1f688 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888011815a00
RDX: 0000000000000000 RSI: ffff88802bed7070 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
R10: 0000000000000004 R11: ffff888011815a00 R12: ffff888022f4a000
R13: ffff88802bed7070 R14: dffffc0000000000 R15: ffff8880b943c088
FS:  00007f0b6b2916c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b6a5a80c0 CR3: 000000002dad2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
 xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
 xdp_test_run_batch net/bpf/test_run.c:337 [inline]
 bpf_test_run_xdp_live+0xf0b/0x1f10 net/bpf/test_run.c:385
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1268
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0b6a47dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b6b2910c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f0b6a5abf80 RCX: 00007f0b6a47dda9
RDX: 0000000000000050 RSI: 0000000020000240 RDI: 000000000000000a
RBP: 00007f0b6a4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0b6a5abf80 R15: 00007ffe8c70ed58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc9000bc1f688 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888011815a00
RDX: 0000000000000000 RSI: ffff88802bed7070 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
R10: 0000000000000004 R11: ffff888011815a00 R12: ffff888022f4a000
R13: ffff88802bed7070 R14: dffffc0000000000 R15: ffff8880b943c088
FS:  00007f0b6b2916c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b6a5a80c0 CR3: 000000002dad2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	53                   	push   %rbx
   7:	48 83 ec 18          	sub    $0x18,%rsp
   b:	49 89 d4             	mov    %rdx,%r12
   e:	49 89 f5             	mov    %rsi,%r13
  11:	48 89 fd             	mov    %rdi,%rbp
  14:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  1b:	fc ff df
  1e:	e8 a6 42 d8 ff       	call   0xffd842c9
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 10 8a 3b 00       	call   0x3b8a49
  39:	4c 8b 7d 00          	mov    0x0(%rbp),%r15
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c5                   	.byte 0xc5


Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac5323180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154653d3180000


