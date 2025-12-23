Return-Path: <bpf+bounces-77364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E8CD97D2
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B0D4301D31A
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63558261B80;
	Tue, 23 Dec 2025 13:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA9258EDE
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497824; cv=none; b=tQBINnj8hgLJRe/lVYJmChnzpmlG9pEjEzGro/31S7mJLmm1e8U3OBQDGb7ZG+s0cJcP6/HkpYhQogv4qAJGYbcYiI8JRDXzRMlqK3I9VWpNraIxBUeLWNizdBxvkdrWSVd/3QHfQk+g4Bwv50+oNOmZVRkdRMqrqeIJn3rnmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497824; c=relaxed/simple;
	bh=brD7nQeBZFLgLdWCr1Vl+PYm0aQ7zt3SSVm/zosRp08=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NMCj8G8HtMBpwMD1NOQMma2YE8Ls2T0fuMOg8CbQUXUv6JnCzg2aOLHI+r3wT5pxRPjv0LOrK/8CsoQFsw/h9FXoJHamAL3+O00MLpO5rGBkrdSz7c83SfTM4vhSf+ZLQVJCD95ncQYUbLv6d63x0bi+sN6eWpU+4LAxoFgIkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3f509212de4so3638840fac.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 05:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497821; x=1767102621;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZIm9n8fzi2IxahtXr6omz5E7yUUvjoLnnt+JYxZeBw=;
        b=Ag2uOLWU/2wNQbLNXDrbRB5Pcq7S1iRkR69GVrJCzysKtdzRoRPIciK1yyja68Kk4J
         EE6mtMngStmTItMPhoTYy5ufXuw2Y1oMSPs343RUFVBmrex+tqjUSKcjV8MfEbCVF4D7
         /oA54aN69G0Q+zBm80r8KpAxcWdP3tL2TRQ7VuMbsTj+6T9agTGmPKQRO/WgXR3atfT3
         9iEPPpkG2afKK5ivmEMaxMhQ1nOcjY1qYS9541Ow6lkscD8bkSLDFlkxQGaKR2EdoPIQ
         hJPfxC67U6j8gbiuTMgKoENwnKKGQOiSYYWVsmYwNkJN72IrrIGTq/u5al/ZVlSe2QDn
         4RwA==
X-Forwarded-Encrypted: i=1; AJvYcCVIgBRYKAin4vZIY68zmKVy2Ss7oKy2cdZ0myDp4l6RgQeHQyeSQfQkqXn4Gsd8P0FQAI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5I2F7sknHLDDISe+ORnwmUXB4BukDvB2sbD81qGZW6nDEi9Vy
	LAjbYnGYLl640muzXU2qKxl1kVdiCTRaSsiXBTvJBcbXWnuSjP1WXyta0QCWNjOgl/FAJIvy8eW
	4MkncoqmtNJyB9GYqDP5ByopayyDPUsq23IcCtici6b1ayHLlLKmRw9OROos=
X-Google-Smtp-Source: AGHT+IHTUcbm9P2l7i9tw3AJfgORiEwdRfJUxB8WYYaL8sMkK71G8YhySth8ymI7K+FUJvireB4PyKb3UAcTw03wR3I+oiDhTfB/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:222a:b0:659:9a49:8e65 with SMTP id
 006d021491bc7-65d0eace109mr6025685eaf.53.1766497821366; Tue, 23 Dec 2025
 05:50:21 -0800 (PST)
Date: Tue, 23 Dec 2025 05:50:21 -0800
In-Reply-To: <20251223091120.2413435-1-tangyazhou@zju.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694a9e1d.050a0220.19928e.0028.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Add value tracking for BPF_DIV
From: syzbot ci <syzbot+ciad93e439a86bd2a7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, 
	song@kernel.org, tangyazhou518@outlook.com, tangyazhou@zju.edu.cn, 
	yonghong.song@linux.dev, ziye@zju.edu.cn
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] bpf: Add value tracking for BPF_DIV
https://lore.kernel.org/all/20251223091120.2413435-1-tangyazhou@zju.edu.cn
* [PATCH bpf-next v2 1/2] bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
* [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for BPF_DIV analysis

and found the following issue:
WARNING in reg_bounds_sanity_check

Full report is available here:
https://ci.syzbot.org/series/9bfb8ed3-0d6e-4ae4-93a1-e5d466326f9e

***

WARNING in reg_bounds_sanity_check

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      ec439c38013550420aecc15988ae6acb670838c1
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/67e90945-0cc5-47d7-a492-406b63cd4281/config
C repro:   https://ci.syzbot.org/findings/5808370d-6cee-4ff9-9a6f-ba4007533b78/c_repro
syz repro: https://ci.syzbot.org/findings/5808370d-6cee-4ff9-9a6f-ba4007533b78/syz_repro

------------[ cut here ]------------
verifier bug: REG INVARIANTS VIOLATION (alu): range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x1, 0x0)
WARNING: kernel/bpf/verifier.c:2748 at reg_bounds_sanity_check+0x201/0xc30 kernel/bpf/verifier.c:2742, CPU#0: syz.0.17/5999
Modules linked in:
CPU: 0 UID: 0 PID: 5999 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:reg_bounds_sanity_check+0x3e6/0xc30 kernel/bpf/verifier.c:2742
Code: 98 00 00 00 4c 8b 8c 24 88 00 00 00 41 ff 34 24 41 57 55 41 55 ff b4 24 f0 00 00 00 ff b4 24 a8 00 00 00 ff b4 24 c0 00 00 00 <67> 48 0f b9 3a 48 83 c4 38 49 bf 00 00 00 00 00 fc ff df 48 8b 84
RSP: 0018:ffffc90004277098 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff11022c96804 RCX: 0000000000000001
RDX: ffffffff8b71cd00 RSI: ffffffff8b71bae0 RDI: ffffffff8f861280
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000000c R11: 0000000000000000 R12: ffff8881164b4020
R13: 0000000000000001 R14: 1ffff11022c96803 R15: 0000000000000001
FS:  000055555eb0e500(0000) GS:ffff88818e835000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad443e7dac CR3: 00000001bc680000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 check_alu_op kernel/bpf/verifier.c:16205 [inline]
 do_check_insn kernel/bpf/verifier.c:20533 [inline]
 do_check+0xa72c/0xeba0 kernel/bpf/verifier.c:20802
 do_check_common+0x19cc/0x25b0 kernel/bpf/verifier.c:24080
 do_check_main kernel/bpf/verifier.c:24163 [inline]
 bpf_check+0x5e7a/0x1c300 kernel/bpf/verifier.c:25470
 bpf_prog_load+0x13ba/0x1a10 kernel/bpf/syscall.c:3088
 __sys_bpf+0x5c3/0x8a0 kernel/bpf/syscall.c:6207
 __do_sys_bpf kernel/bpf/syscall.c:6320 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6318 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6318
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad4418f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe64db1fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fad443e5fa0 RCX: 00007fad4418f7c9
RDX: 0000000000000094 RSI: 0000200000000340 RDI: 0000000000000005
RBP: 00007fad441f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fad443e5fa0 R14: 00007fad443e5fa0 R15: 0000000000000003
 </TASK>
----------------
Code disassembly (best guess):
   0:	98                   	cwtl
   1:	00 00                	add    %al,(%rax)
   3:	00 4c 8b 8c          	add    %cl,-0x74(%rbx,%rcx,4)
   7:	24 88                	and    $0x88,%al
   9:	00 00                	add    %al,(%rax)
   b:	00 41 ff             	add    %al,-0x1(%rcx)
   e:	34 24                	xor    $0x24,%al
  10:	41 57                	push   %r15
  12:	55                   	push   %rbp
  13:	41 55                	push   %r13
  15:	ff b4 24 f0 00 00 00 	push   0xf0(%rsp)
  1c:	ff b4 24 a8 00 00 00 	push   0xa8(%rsp)
  23:	ff b4 24 c0 00 00 00 	push   0xc0(%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 38          	add    $0x38,%rsp
  33:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  3a:	fc ff df
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	84                   	.byte 0x84


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

