Return-Path: <bpf+bounces-35206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAD938798
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0365281532
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A0156CF;
	Mon, 22 Jul 2024 02:59:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25572FC0B
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617168; cv=none; b=jsaf/nYteTcI0LjEROBSFSr6e85gmy/faIJz84QTcQAHOlQit2m7zhmtFHm+qV5qdy8NSQKnSWgEVnnTfkkrrt1xgB0xiW1IwCmGtGgyniZPV4lxTPk7LcCDSMJbOtLxW5p+q2YMP9e70i8CFBAAj3ivymX15TKsSBBzT8E3QQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617168; c=relaxed/simple;
	bh=fnNvtVYu9841oAbcEi/wwNmNti+GwXT0AiQPzlkRTYs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WWSpHyx6EsHo5FAf+WWPhTwI9npnDEXcqHORU7XrYzVCMYwx1WAPUGsBiPrvgKb5ccVYsie6YWOD2scgNUmKuoJQWDsmeBjeXndY+4ru29TMoDn4MAE83+BjboYPX4/08aeHPubwYR+NzfJjlspNvZkA5QjpNiQNeOKtrYI/KfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397052a7bcbso54883915ab.2
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 19:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721617165; x=1722221965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueGLKV6NVXnEKdgpkNR/ZMhR7GBDaHk0gOzZZ/egVIE=;
        b=C5vJ5a44B91xpSyKE3Fq2dBP4n4Iie3eooR1tWMD/SV1eyfcSGNVh1EoeUoD8R1LeM
         PWAoktjv++t7KcYD135sP2e4lGssdB6YiMX0myDMfNEwoaObuiAoO8vOpbVD95EZoQKL
         Gz2HYEVkAf/DKX0FoRbXFbbNyGjCyA1zceizZcQ+nRj504rZHp7dMw14H6P0WsFkfoAG
         EEn3lbLZ5qkFz5CI3GJyaEZSbWhMKSzaeHvx+QbUvKLPyMvih9wGBQRcNzanXLc8SQIG
         cwW4npzbHZA9UmTJKGPcj8oSA2vcFwhA4fuTURKkiA+quFZTtJvc4YaOXisz6TPv42uR
         L5HA==
X-Forwarded-Encrypted: i=1; AJvYcCU/v0Zkim18rIIsPIxAeTP684ocpDB0rJgXSFnp9MEyM4n04MyUaDVUDy0vRmpFvkxahsvynRA94ikC0hNwtPpHa30j
X-Gm-Message-State: AOJu0YxdF4LAMLgYxIJfYgdVR8jXLvOwzjkOfQrlVeHMKvqxJrt9VwBP
	dRKpHJ0LPh9PzCfHEHeAhQ7nqFd10BzZf+1QKbhcJn9KesRgu4dBxtgLq0SRc0vqnBtNgSRfhd8
	OrshtBvCRMxxI2qMgEdTrWSNS0LftYyGdTGF4RNRgDUvWZ6cUzAJANQQ=
X-Google-Smtp-Source: AGHT+IHeFkYVH1icTw/weReGKosNPDp83s0pfcZnWgjIjnJ2FUyfH9iLDVqbjYO62KllVjvyBPNROSRqnhxQ3UlNtz45YuOnA16M
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:397:3e38:eb30 with SMTP id
 e9e14a558f8ab-398e6d8925dmr4712165ab.3.1721617165354; Sun, 21 Jul 2024
 19:59:25 -0700 (PDT)
Date: Sun, 21 Jul 2024 19:59:25 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000949a14061dcd3b05@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7846b618e0a4 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142d3eb5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154c40b1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f3e11d980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7846b618.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a2831ffe61c/vmlinux-7846b618.xz
kernel image: https://storage.googleapis.com/syzbot-assets/575e23a7c452/bzImage-7846b618.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5389 Comm: syz-executor357 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_flush+0x49/0x1e0 kernel/bpf/devmap.c:424
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 98 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 2f 48 8d 5d 80 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 69 01 00 00 48 8b 45 00 49 39 ef 4c 8d 60 80 0f
RSP: 0018:ffffc900008b0c90 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffffffff80 RCX: ffffffff88d6a5bb
RDX: 0000000000000000 RSI: ffffffff81af9c56 RDI: ffffc9000345fa68
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000345fa58
R13: ffff888022ec0fb0 R14: ffffc9000345fa68 R15: ffffc9000345fa68
FS:  0000555568ea6380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4743880f0 CR3: 0000000023168000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x40a/0x4e0 net/core/filter.c:4300
 __napi_poll.constprop.0+0xd1/0x550 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6962
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 tun_get_user+0x1d9b/0x3c30 drivers/net/tun.c:1936
 tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff47430af50
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 e1 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffde0326728 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffde03267c0 RCX: 00007ff47430af50
RDX: 0000000000000e80 RSI: 0000000020000100 RDI: 00000000000000c8
RBP: 00007ffde0326770 R08: 00007ffde0326750 R09: 00007ffde0326750
R10: 00007ffde0326750 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__dev_flush+0x49/0x1e0 kernel/bpf/devmap.c:424
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 98 01 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 2f 48 8d 5d 80 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 69 01 00 00 48 8b 45 00 49 39 ef 4c 8d 60 80 0f
RSP: 0018:ffffc900008b0c90 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffffffff80 RCX: ffffffff88d6a5bb
RDX: 0000000000000000 RSI: ffffffff81af9c56 RDI: ffffc9000345fa68
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000345fa58
R13: ffff888022ec0fb0 R14: ffffc9000345fa68 R15: ffffc9000345fa68
FS:  0000555568ea6380(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4743880f0 CR3: 0000000023168000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 98 01 00 00    	jne    0x1a6
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	49 8b 2f             	mov    (%r15),%rbp
  1b:	48 8d 5d 80          	lea    -0x80(%rbp),%rbx
  1f:	48 89 ea             	mov    %rbp,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	0f 85 69 01 00 00    	jne    0x199
  30:	48 8b 45 00          	mov    0x0(%rbp),%rax
  34:	49 39 ef             	cmp    %rbp,%r15
  37:	4c 8d 60 80          	lea    -0x80(%rax),%r12
  3b:	0f                   	.byte 0xf


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

