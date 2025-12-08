Return-Path: <bpf+bounces-76272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CFCAC940
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 09:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0069D3046EC9
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864742EC094;
	Mon,  8 Dec 2025 08:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB32DC76F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184308; cv=none; b=lb1a2F0JPB0QnpOtM4O1KHKP9nl716SVCGxGF2VAeuHtVt2QrmFTh0B02G91ujNlXxTw0A+sM43Z/dkXLsP9w87ghy5cAbP4YCX9q5nFtxscWkBxDeyGuv2WptiL66kq40aKrBhH1eKmjbp5ng7S2mZiI81gQkuJVbQzG26PD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184308; c=relaxed/simple;
	bh=ZS71SkdDyRKSWwtwVL9j8zb1nfO+MqbEZ7A91WWyfNU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QVh00oFsg4orfQI96BloKpVpUDwLApifGXtsG4e1Zr+Q98ZNOfINnNhoxrh3eUsXeFZ9Bsvrplb740XLCO2MYwBNVN0csabTd/Gg0m6S9kMdAS1XnizyrjFCbGxeV4H417jS97eEPVlFGhX3jwAxheotei3tLKCPhid1gGhIKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4530ea23ce6so6694357b6e.1
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184305; x=1765789105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FQasKD4bqoPxS9gKhFI9S0GuhkqNXd0OMNuacVPrKw=;
        b=cYdukwwNCZopHZMpLWf6bW8/d4EXr1261D+GiCaaezwN7U5ouZAVjMz7aKU+bhr/l1
         Xhqs9IpGt/Aq4VHCYMfQNT5SMm4HTCg+jRiY8HVtrLfSPjHtJYYXAZ5s5kKESRZ11LiQ
         PKgUOqy/q/Sw9LO6Jgn6+drr0bM7XRGJdPBY5+ASrtf+clzUzN0UmHctQIIPb900qnzh
         XlXEQSJ01+gDhDsXOW4UUQJZDe2FuKfzNg5sfXWylcEwJUk1on5Mj7esDh6K4Q0/K9/8
         f7BAg1QH9CJgWy2Wl9exe/ILnOkXe2yuuQDFt2Vg7cctk8Bzx0mVOY2BkxlBSKXIzshR
         dZfg==
X-Forwarded-Encrypted: i=1; AJvYcCWiuY/qVOeChzYCRsvxnbhCvr0Tp333L/79ZWMgbCAIZUr5bLaf1DB7ME5/hvhZ/yWJX6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3bDsvblK++XjdQvp1PC7N91X4un9v0P8vjiZ2BtOMJFBVNbk
	j8U/rL6DweCIm0yGoKyVPPck1lBrLAZrI5zaMxlGI7JIjNCZYb2vnAcLI2FZVSc+Ma048P/wXBW
	JAUd5tIlkTnZR165Mr3d4ojFvRCpg6zmHd/OZn9xXE7GVeg5JH+tlFVBcEPQ=
X-Google-Smtp-Source: AGHT+IFZbjrqQF5gjS1Cv/xFxoq1Zp2A6lPpXNZ8sqN7jFPoGRpQglq9N/QrYtkv4alX3tXkL1Y9cbWV+nA2jo/oB4X4qT5ZeoO+
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1621:b0:659:9a49:9045 with SMTP id
 006d021491bc7-6599a8b6ef8mr3257881eaf.16.1765184305736; Mon, 08 Dec 2025
 00:58:25 -0800 (PST)
Date: Mon, 08 Dec 2025 00:58:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69369331.a70a0220.38f243.009d.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] general protection fault in bq_flush_to_queue (2)
From: syzbot <syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com>
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

HEAD commit:    aa833fc394ba drm/xe: Fix duplicated put due to merge resol..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f27cc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb66b4eefaf3f448
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3391f44313b3983e91
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d701a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166e7192580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/262740328d6d/disk-aa833fc3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf629be0ab14/vmlinux-aa833fc3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b71e61abc00a/bzImage-aa833fc3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6085 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__list_del include/linux/list.h:204 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:217 [inline]
RIP: 0010:bq_flush_to_queue+0x46f/0x580 kernel/bpf/cpumap.c:740
Code: 35 00 4d 8b 26 4d 8d 74 24 08 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 0b f2 35 00 49 89 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f2 f1 35 00 4c 89 23 48 8b 04 24
RSP: 0018:ffffc90004207650 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffff888030b0c400 R08: ffff888024b2802b R09: 1ffff11004965005
R10: dffffc0000000000 R11: ffffed1004965006 R12: ffffc90003ad79e0
R13: 0000000000000008 R14: ffffc90003ad79e8 R15: dffffc0000000000
FS:  00007f6b36bed6c0(0000) GS:ffff888126d5e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b36becf98 CR3: 000000003f6c6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __cpu_map_flush+0x5d/0xd0 kernel/bpf/cpumap.c:808
 xdp_do_flush+0x13c/0x1d0 net/core/filter.c:4348
 xdp_test_run_batch net/bpf/test_run.c:348 [inline]
 bpf_test_run_xdp_live+0x154f/0x1b20 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0x7c0/0x10e0 net/bpf/test_run.c:1388
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4703
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b3759f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6b36bed038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f6b377f6090 RCX: 00007f6b3759f749
RDX: 0000000000000050 RSI: 0000200000000000 RDI: 000000000000000a
RBP: 00007f6b37623f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6b377f6128 R14: 00007f6b377f6090 R15: 00007ffda92d99b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del include/linux/list.h:204 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:217 [inline]
RIP: 0010:bq_flush_to_queue+0x46f/0x580 kernel/bpf/cpumap.c:740
Code: 35 00 4d 8b 26 4d 8d 74 24 08 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 0b f2 35 00 49 89 1e 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f2 f1 35 00 4c 89 23 48 8b 04 24
RSP: 0018:ffffc90004207650 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffff888030b0c400 R08: ffff888024b2802b R09: 1ffff11004965005
R10: dffffc0000000000 R11: ffffed1004965006 R12: ffffc90003ad79e0
R13: 0000000000000008 R14: ffffc90003ad79e8 R15: dffffc0000000000
FS:  00007f6b36bed6c0(0000) GS:ffff888126d5e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b36becf98 CR3: 000000003f6c6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	35 00 4d 8b 26       	xor    $0x268b4d00,%eax
   5:	4d 8d 74 24 08       	lea    0x8(%r12),%r14
   a:	4c 89 f0             	mov    %r14,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  16:	74 08                	je     0x20
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 0b f2 35 00       	call   0x35f22b
  20:	49 89 1e             	mov    %rbx,(%r14)
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 f2 f1 35 00       	call   0x35f22b
  39:	4c 89 23             	mov    %r12,(%rbx)
  3c:	48 8b 04 24          	mov    (%rsp),%rax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

