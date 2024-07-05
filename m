Return-Path: <bpf+bounces-33934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7B928222
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 08:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609DFB22D1C
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9F143C67;
	Fri,  5 Jul 2024 06:34:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255C12B144
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161264; cv=none; b=U29s4ngWbY8rFI1gKSlfWuJGByeYaWSKzfRUJ64HXFJ9m3Kh53GCZOA9Y4u/CYql8qfCVC5EYoMV4lZdVOR1UQMXE/F/k2wRag4CVG9+OWQH9WMBxJjxfOkEvtvMgrl0N+QfKrX1jtJ/CF7qG7VXECOVRyR0oP8iJEKMA50Z9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161264; c=relaxed/simple;
	bh=85Es58jzRms7gGzAuuYOZ6vgzuUrUwVycYLN/X+iT3o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sKIOUcVrHYYtwZmaEANstSnQ3fVKysQjZlubB74Z54VkuyCPY4n6IDEL/1P+hzB5MabCJwPowELtuGDW6mGzeLfUM9SLBZWseiUHnulFP/AAnS/UnIo/ikxpTkef15aaaTHJXnLuFUlIFJKVAcb0httqRpiOwGOdu5+Dd1fLoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f4e270277cso180997139f.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161262; x=1720766062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmwBaO/n15LUxmQZN3FFPDmzpBVBWqHutkbJ10gUEEU=;
        b=ktXgktmKH6ehd95acwckmS2sLFLh6qOEUx4N8yf3mzA6WN9ye6aDr2b53GzPBt26we
         jRNQ+0QexZDxCisqIAXK+eDzttMvVZaSqMuhcgD2ZcpMyhcASWfXDKzMR+yFO8jUwRVw
         lzzelBD5uxNeUQsZvMF+/eqBIoj/2Eq8ZaGW7DtXpqyYw/NFoIQk0IJ/4RwtHa89SGrZ
         rNMNEN5x46U2zSjPnyf3ulzxYYbf7jNvsbDIgMttL9oLf9ZmxYebqzVOXi4Q+omjK3uc
         tZuY+ir3nlNOLOrPG02vgZd2QVW8AdfxmqSEIJB5rMd6cv1aRAFIrzlULFuOIDVDvyTr
         t1cA==
X-Forwarded-Encrypted: i=1; AJvYcCXkQS768HjForlJ0kDrvUjgfwaRqtTaAwITVBpYR/a2SYUwUeeskfSRyOREAUDKsLDJkXpX7966iR4eEsTL5h69TBZ5
X-Gm-Message-State: AOJu0Yyfsli4Plo+zSZN2d1rXMXrC7q846UuG8Xk+3Td/Um1qR3bHkWJ
	s3mZ/1MQkSqR+fbbpVT1pQ1wu5hP60pUrUFQ1vonKFMxVmbDXltoWXqk0D67y9UP5oX9+xXnijn
	kfz6Fk9oSAO7olAv9njVfX7Ybsu570sWOyaNKumnULEu/xnfQ2OIH1Gw=
X-Google-Smtp-Source: AGHT+IFdRzcPV6uGugz7sSwHdnfjiuWtXM06p4xdJFyJKwULHmEagLqf+0Y5Iux5mmzLN1CcXeW9kktxQis8mZbS6ifBd7NE+3Ut
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22cb:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4bf6bd341c1mr239454173.3.1720161262181; Thu, 04 Jul 2024
 23:34:22 -0700 (PDT)
Date: Thu, 04 Jul 2024 23:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd3017061c7a405c@google.com>
Subject: [syzbot] [net?] [bpf?] general protection fault in xdp_do_generic_redirect
From: syzbot <syzbot+380f7022f450dd776e64@syzkaller.appspotmail.com>
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

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15de4eb9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=380f7022f450dd776e64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+380f7022f450dd776e64@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 8647 Comm: syz.3.1455 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:xdp_do_generic_redirect+0x7e/0x8f0 net/core/filter.c:4525
Code: 3c 01 00 74 12 48 89 df e8 9f 26 90 f8 48 b8 00 00 00 00 00 fc ff df 48 89 5c 24 48 48 8b 1b 4c 8d 73 38 4d 89 f7 49 c1 ef 03 <41> 0f b6 04 07 84 c0 0f 85 37 06 00 00 41 8b 2e 89 ee 83 e6 02 31
RSP: 0018:ffffc900094777f8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1100fd9f6c0
RDX: ffffc900042a9000 RSI: 0000000000001ab7 RDI: 0000000000001ab8
RBP: ffffc900094779b0 R08: 0000000000000005 R09: ffffffff89601c5e
R10: 0000000000000003 R11: ffff88807ecf9e00 R12: ffffc90009477b60
R13: 1ffff9200128ef1c R14: 0000000000000038 R15: 0000000000000007
FS:  00007fa9faca56c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020011000 CR3: 000000002c750000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_xdp_generic+0x884/0xb90 net/core/dev.c:5138
 tun_get_user+0x2805/0x4560 drivers/net/tun.c:1924
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa9f9f7475f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007fa9faca5010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa9fa103f60 RCX: 00007fa9f9f7475f
RDX: 000000000000fdef RSI: 0000000020001540 RDI: 00000000000000c8
RBP: 00007fa9f9fe4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fdef R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa9fa103f60 R15: 00007fff952046f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:xdp_do_generic_redirect+0x7e/0x8f0 net/core/filter.c:4525
Code: 3c 01 00 74 12 48 89 df e8 9f 26 90 f8 48 b8 00 00 00 00 00 fc ff df 48 89 5c 24 48 48 8b 1b 4c 8d 73 38 4d 89 f7 49 c1 ef 03 <41> 0f b6 04 07 84 c0 0f 85 37 06 00 00 41 8b 2e 89 ee 83 e6 02 31
RSP: 0018:ffffc900094777f8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff1100fd9f6c0
RDX: ffffc900042a9000 RSI: 0000000000001ab7 RDI: 0000000000001ab8
RBP: ffffc900094779b0 R08: 0000000000000005 R09: ffffffff89601c5e
R10: 0000000000000003 R11: ffff88807ecf9e00 R12: ffffc90009477b60
R13: 1ffff9200128ef1c R14: 0000000000000038 R15: 0000000000000007
FS:  00007fa9faca56c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020011000 CR3: 000000002c750000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 01                	cmp    $0x1,%al
   2:	00 74 12 48          	add    %dh,0x48(%rdx,%rdx,1)
   6:	89 df                	mov    %ebx,%edi
   8:	e8 9f 26 90 f8       	call   0xf89026ac
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	4c 8d 73 38          	lea    0x38(%rbx),%r14
  23:	4d 89 f7             	mov    %r14,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	41 0f b6 04 07       	movzbl (%r15,%rax,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 37 06 00 00    	jne    0x66e
  37:	41 8b 2e             	mov    (%r14),%ebp
  3a:	89 ee                	mov    %ebp,%esi
  3c:	83 e6 02             	and    $0x2,%esi
  3f:	31                   	.byte 0x31


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

