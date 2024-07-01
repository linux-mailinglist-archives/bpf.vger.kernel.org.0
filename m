Return-Path: <bpf+bounces-33535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52C91E973
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84688283D70
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75D17164A;
	Mon,  1 Jul 2024 20:19:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BE16F903
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865158; cv=none; b=pklsHTi7fLfMS/G/k7rBq7P+X1PE2q4qxROMTmTzlbJ5u0AGArMjx4jVmSvvNIMjqAqjSqg0ocIpi5qVCK4g2ST0L1UbWMX8k7PWzi5N9pSj6eqV7iz8jhlhX2QkEfph34lFh466oE4wV3BJIWFniAJHu94CcV9WxNVecZgiHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865158; c=relaxed/simple;
	bh=GuGFgUB0wRmpGpvqpqeC4Kel6vtxlu81KkcAp82U6GU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qRJmL9sxj2cJi+Y46pn61NAwKYXOh7qHBlRt0Ykgl5wfC3WqWul+ysGhuxBRmV2tVnRiED8YOwGuHNFLh0QSuxGOowg7+uddV34wFGFr9Uwbt28A9Z/WK78rKPw1kKP4AeivfhKzKKlLLWU/5HWjHqib6F16s+5dDa12nHryKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e20341b122so347693439f.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 13:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865156; x=1720469956;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1UVddZMPvm16kcS2U3h8+V4FuFZxzP61cHTkwZr3EI=;
        b=oDL9jdcCxWSltcyhNwZ3wel8WEAeMwnfQa05p8uRtA1tMLk1wUH6xN4xdDl4Zs7q7F
         Rj7alAjuCCD7HokkVv+m/7nLTRjOCV+zBWAelbILZJ+XMx4WrNCctpEk2+zwumBfynme
         9MiHqvLgkVTDetB7pAsGlFeXjtj+9lpBhY1SBoGGch7XfrqDDKTrx06ZJA57xdZ/XJ4O
         UP6hwTlDATCqnkMWBVkZXhT9RP0V0qqm8HGbQYJ/+SF1uKqsHiqAFZjIRfV90fzf1m0Q
         ShFRD04BM3phXVwyfcm+0io1bCscwV1venupzkAAeJ1Y5rgxp2/IdNfkctUanmbCxV4v
         tkdw==
X-Forwarded-Encrypted: i=1; AJvYcCXEvmp6wD5m2NiLn9ybEaH85z6FsaRPgq328lUNpz0AUbyRtVS3mM2+FJPY7xsaFHsKX7oPgHmrv9qQQ9HoVMHbahTB
X-Gm-Message-State: AOJu0Yzc+EoygC2xmf4u6D7nVnwPOmbeM113DOB3++Pyw+99kDz2Zdrq
	47ilcrQpOvpdN3mWcDwQJhe84SD/GdqN4V2iG8Ppyk4fVyGplCGBKdzPmzam/z6jsTRbpQDKATY
	WVDEGS/4X71uCk6nto0yjcEKQAyj0MmhoMAnS8Vt1GJlov5KIRp5y3/s=
X-Google-Smtp-Source: AGHT+IGsKtqOiSfcC1y9RFrvxEtRYtJ6V84chtBEALgdKHTqgzpas2X36mzFaT7Fzgn7Qvj280JJXW10jNr9lsYr6B/62GtYFyKW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4bbb6e8ec35mr490530173.1.1719865155890; Mon, 01 Jul 2024
 13:19:15 -0700 (PDT)
Date: Mon, 01 Jul 2024 13:19:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adb970061c354f06@google.com>
Subject: [syzbot] [net?] [bpf?] general protection fault in dev_map_redirect
From: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12e5b0e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=111e4e0e6fbde8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04b8d7db78fb/disk-74564adf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d996f4370003/vmlinux-74564adf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e7e630054e7/bzImage-74564adf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 13476 Comm: syz.2.2696 Not tainted 6.10.0-rc6-next-20240701-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1672 [inline]
RIP: 0010:dev_map_redirect+0x65/0x6a0 kernel/bpf/devmap.c:1020
Code: 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 f3 b2 3d 00 4c 8b 2b 4d 8d 7d 38 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 03 84 c0 0f 85 6e 04 00 00 41 8b 2f 89 ee 83 e6 02 31 ff
RSP: 0018:ffffc9000483f088 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: 0000000000040000
RDX: ffffc90009a9a000 RSI: 00000000000004bc RDI: 00000000000004bd
RBP: dffffc0000000000 R08: 0000000000000007 R09: ffffffff81b5e80f
R10: 0000000000000004 R11: ffff888022d49e00 R12: 000000000483f0d8
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000038
FS:  00007f91a35f06c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2a246b CR3: 0000000023d08000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_ec9efaa32d58ce69+0x56/0x5a
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x679/0x14c0 net/core/dev.c:4963
 netif_receive_generic_xdp net/core/dev.c:5076 [inline]
 do_xdp_generic+0x673/0xb90 net/core/dev.c:5135
 __netif_receive_skb_core+0x1be6/0x4570 net/core/dev.c:5476
 __netif_receive_skb_one_core net/core/dev.c:5654 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5770
 netif_receive_skb_internal net/core/dev.c:5856 [inline]
 netif_receive_skb+0x1e8/0x890 net/core/dev.c:5916
 tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
 tun_get_user+0x2f3b/0x4560 drivers/net/tun.c:2002
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f91a277471f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007f91a35f0010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f91a2903fa0 RCX: 00007f91a277471f
RDX: 000000000000002a RSI: 0000000020000300 RDI: 00000000000000c8
RBP: 00007f91a27f677e R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000002a R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007f91a2903fa0 R15: 00007ffef99a1428
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1672 [inline]
RIP: 0010:dev_map_redirect+0x65/0x6a0 kernel/bpf/devmap.c:1020
Code: 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 f3 b2 3d 00 4c 8b 2b 4d 8d 7d 38 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 03 84 c0 0f 85 6e 04 00 00 41 8b 2f 89 ee 83 e6 02 31 ff
RSP: 0018:ffffc9000483f088 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: 0000000000040000
RDX: ffffc90009a9a000 RSI: 00000000000004bc RDI: 00000000000004bd
RBP: dffffc0000000000 R08: 0000000000000007 R09: ffffffff81b5e80f
R10: 0000000000000004 R11: ffff888022d49e00 R12: 000000000483f0d8
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000038
FS:  00007f91a35f06c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2a246b CR3: 0000000023d08000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   8:	74 08                	je     0x12
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 f3 b2 3d 00       	call   0x3db305
  12:	4c 8b 2b             	mov    (%rbx),%r13
  15:	4d 8d 7d 38          	lea    0x38(%r13),%r15
  19:	4c 89 fb             	mov    %r15,%rbx
  1c:	48 c1 eb 03          	shr    $0x3,%rbx
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 03          	movzbl (%rbx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 6e 04 00 00    	jne    0x4a4
  36:	41 8b 2f             	mov    (%r15),%ebp
  39:	89 ee                	mov    %ebp,%esi
  3b:	83 e6 02             	and    $0x2,%esi
  3e:	31 ff                	xor    %edi,%edi


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

