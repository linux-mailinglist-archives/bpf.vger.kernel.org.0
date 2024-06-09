Return-Path: <bpf+bounces-31680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD579015F9
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 13:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260251C20992
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF1A3B182;
	Sun,  9 Jun 2024 11:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02F3611B
	for <bpf@vger.kernel.org>; Sun,  9 Jun 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932868; cv=none; b=kXOnRl9QHeyR32cJBL0JyROaQ7WjhOJn8zCrX3cAGu6+dqsNHyZP9DgNFTxHBTSxfYDWmFy0Ksf+c1BaaPg5TWOzKm0N3burdWj0Ve86RAKXUzXI88bIoFvEtVS7NgjHz01n30v+Pws5TN+xDZEyXointGNUo7yF9Ty3CLmsZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932868; c=relaxed/simple;
	bh=Y1+ti1mbb9MNw7nNtpV56B0Q6eW+P17Im7g7i/SEQzs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UB8YxAXPNXAtnricvSCeF3THF19LGzFy52q799faT9zp8GRAHfCJGBmdAdabGVZ2VDczA+iHaku9g47foBOfCOrVaq7Ap1KjRhfEC0qA7gOQqnArZEzwsOYjl6TFsw8F2YII7114syPzxO4IWrviwDftHMpaivMXv/EI6o8g5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37593c84fedso14488405ab.3
        for <bpf@vger.kernel.org>; Sun, 09 Jun 2024 04:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717932866; x=1718537666;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZV4E2L8maI6s7zq2yrwNQ7hph7xAqxH7JzWM8hda4Q=;
        b=MQvlqI+bUo55+Kcjmqf72FF0/BQO7XEBmTVmozgUdo2AAspW0z/q2rywZ7MLxVX7uV
         X8M4zmH9UuC3RJqWFqRitz8Pygw4v2CYdEIDMLVis6gLSn4W+DcrxsLpAz3YinFabnV/
         GlVm+ZvNl/MQc2eA3JHHUYTTToF3pZrOwgn/EkArsfOda6sKtO/QV8TxUpCIG8CV0gY4
         pXKDqp3jJ4wi7V7Ir2466bjCuPQBDRj98SMGLa0LTjh81dsPNpqfp0KeNG2Ky7i+AbRl
         HjEMejUCvrseJU1dKfLt+B1SFCZg7bXlayPVptH9WSvbQ5Gz9DbllXVCkf3UmPXLGpmj
         Ysbg==
X-Forwarded-Encrypted: i=1; AJvYcCXMRDIJSBbmRAMe+RX21EuG0BdYfmDbOgGASb6iQHpp7RzXoeLg4VvfycIh1nbwijjO8JDDZ/21y5ZVJe1ql0RuQl5f
X-Gm-Message-State: AOJu0Yxn9jfY2EQq7rNReqfWS6axrsC8pBdoTTH04ysN0peR89nEI2NY
	X6cZZndW5yaQOPIkmsx1OI0rOjWklek6yz6dg1XOSg2Dotp7jOdR31Dk7fDswuNCVlLWCoKlICB
	y5tOLPJCctJDnNT40DQXidzX2FoohN32BL7HpcOjKZWyTI7LPzpJFevs=
X-Google-Smtp-Source: AGHT+IGbhhOsz75IpMUaqd4IQp6/f84Ci5jbYbl1vq4N3CB8GmF1Ph8Ht43avaioasT7zxVpLi/qG21XDDP+AWCbfVPf8+NAGXY8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:374:a840:e5be with SMTP id
 e9e14a558f8ab-375802379b1mr3680665ab.0.1717932865811; Sun, 09 Jun 2024
 04:34:25 -0700 (PDT)
Date: Sun, 09 Jun 2024 04:34:25 -0700
In-Reply-To: <00000000000099cf25061964d113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000371fcb061a736a5b@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
From: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c44711b78608 liquidio: Adjust a NULL pointer handling path..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1175e6f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172b3126980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17caa30a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47ff53e982e7/disk-c44711b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b10dcb52f35/vmlinux-c44711b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4a6bf6f87c5/bzImage-c44711b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5098 Comm: syz-executor784 Not tainted 6.10.0-rc2-syzkaller-00228-gc44711b78608 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 46 9c d7 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 a0 5e 3d 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc9000343f678 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807eb31e00
RDX: 0000000000000000 RSI: ffff88802224a070 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff89625806 R09: ffffffff896257c3
R10: 0000000000000004 R11: ffff88807eb31e00 R12: ffff8880151d8000
R13: ffff88802224a070 R14: dffffc0000000000 R15: 0000000000000000
FS:  00005555867d5380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc79c59303 CR3: 0000000022bc8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
 xdp_do_redirect_frame+0x2a6/0x660 net/core/filter.c:4451
 xdp_test_run_batch net/bpf/test_run.c:336 [inline]
 bpf_test_run_xdp_live+0xe60/0x1e60 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x80e/0x11b0 net/bpf/test_run.c:1281
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4292
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5706
 __do_sys_bpf kernel/bpf/syscall.c:5795 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5793 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5793
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc79c5b239
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5780f908 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdc79c5b239
RDX: 0000000000000050 RSI: 0000000020000240 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 46 9c d7 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 a0 5e 3d 00 4c 8b 7d 00 48 83 c5
RSP: 0018:ffffc9000343f678 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807eb31e00
RDX: 0000000000000000 RSI: ffff88802224a070 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff89625806 R09: ffffffff896257c3
R10: 0000000000000004 R11: ffff88807eb31e00 R12: ffff8880151d8000
R13: ffff88802224a070 R14: dffffc0000000000 R15: 0000000000000000
FS:  00005555867d5380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc79c59303 CR3: 0000000022bc8000 CR4: 00000000003506f0
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
  1e:	e8 46 9c d7 ff       	call   0xffd79c69
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 a0 5e 3d 00       	call   0x3d5ed9
  39:	4c 8b 7d 00          	mov    0x0(%rbp),%r15
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	c5                   	.byte 0xc5


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

