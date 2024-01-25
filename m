Return-Path: <bpf+bounces-20340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620583CA94
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8821C253A6
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E691339AF;
	Thu, 25 Jan 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CIRbStlj"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA8132C04;
	Thu, 25 Jan 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206210; cv=none; b=gZ5ZyUQ86qEaOj3blf2ce3Z3I3074NMe4qJyP8cE5vbGYd43ZfRuFmSLpLekm1ULgNrsvKfO0UpQ2Cp+QDcW4hpfqzmNr56ywktWAdQe4Hp/j06TYFPG96uaw6q07YtQG16sbZ7Asp0i54tR8MvTdHzsFjzuiJlQ89tmwRyUqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206210; c=relaxed/simple;
	bh=2qxgiU/kjGyslf6jlA4bqvkrXtYXz08QZ7CIiQ+YWyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JJDloCB3ImA23qzbTY9hgUwgXo9qht8tHn4cpHaiUNTatfjqXylY1ZADm2rBMW/q0VvOOcbK5aSu+Vz9XqdDf623d9l7mTAFzgOMyXbs0uUFmOKS6jUut5Vct+J93/6rILFKhNLPX636VoelU1d5wqGpLypjpAi2KKsAVtSAe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CIRbStlj; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5bf7be3-8c9e-4ab1-a105-0d3e1c745d51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706206205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbOkwczQdqT6rnEcotwrf5J+UUlD3rCorQj1R8O8yoo=;
	b=CIRbStljmRYl+Z78XSI08c5pG1rLiPS6edOlM5xaBCA61NeThM+3TF2EO7goCgty6ZAIPV
	GQVpdKsCBbgfczvg5n0+wzt/fvrOtSR3+h8qOdtZDldQcISqyWoP4kbj8Q5BfqO9Sj+4+X
	CSwstgm+WoqiwALXo8nAvFwlk/ItPpE=
Date: Thu, 25 Jan 2024 10:09:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_struct_ops_find_value
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
References: <00000000000040d68a060fc8db8c@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot <syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, thinker.li@gmail.com,
 yonghong.song@linux.dev
In-Reply-To: <00000000000040d68a060fc8db8c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/25/24 9:53 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d47b9f68d289 libbpf: Correct bpf_core_read.h comment wrt b..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11479fe7e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=719e6acaf392d56b
> dashboard link: https://syzkaller.appspot.com/bug?extid=88f0aafe5f950d7489d7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ea6be3e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bc199be80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1a9b4a5622fb/disk-d47b9f68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dd68baeac4fd/vmlinux-d47b9f68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/811ba9dc9ddf/bzImage-d47b9f68.xz
> 
> The issue was bisected to:
> 
> commit fcc2c1fb0651477c8ed78a3a293c175ccd70697a
> Author: Kui-Feng Lee <thinker.li@gmail.com>
> Date:   Fri Jan 19 22:49:59 2024 +0000
> 
>      bpf: pass attached BTF to the bpf_struct_ops subsystem
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106a04c3e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126a04c3e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146a04c3e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
> Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops subsystem")
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
> CPU: 0 PID: 5058 Comm: syz-executor257 Not tainted 6.7.0-syzkaller-12348-gd47b9f68d289 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> RIP: 0010:bpf_struct_ops_find_value+0x49/0x140 kernel/bpf/btf.c:8763
> Code: 7d ea dd ff 45 85 e4 0f 84 d7 00 00 00 e8 ff ee dd ff 48 8d bb 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 00 00 00 48 8b 9b 88 00 00 00 48 85 db 0f 84
> RSP: 0018:ffffc90003bb7b20 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3283
> RDX: 0000000000000011 RSI: ffffffff81aa3291 RDI: 0000000000000088
> RBP: ffffc90003bb7dd0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
> R13: 000000000000001a R14: ffffffff8ad6bca0 R15: ffffc90003bb7e04
> FS:  0000555556ed2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000160d398 CR3: 000000007809c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   bpf_struct_ops_map_alloc+0x12f/0x5d0 kernel/bpf/bpf_struct_ops.c:674

The check should be IS_ERR_"OR_NULL"(btf).  Kui-Feng, please take a look. Thanks.

>   map_create+0x548/0x1b90 kernel/bpf/syscall.c:1237
>   __sys_bpf+0xa32/0x4a00 kernel/bpf/syscall.c:5445
>   __do_sys_bpf kernel/bpf/syscall.c:5567 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5565 [inline]
>   __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5565
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f9f205ef2e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffa4ce4088 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fffa4ce4268 RCX: 00007f9f205ef2e9
> RDX: 0000000000000048 RSI: 00000000200004c0 RDI: 0000000000000000
> RBP: 00007f9f20662610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fffa4ce4258 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bpf_struct_ops_find_value+0x49/0x140 kernel/bpf/btf.c:8763
> Code: 7d ea dd ff 45 85 e4 0f 84 d7 00 00 00 e8 ff ee dd ff 48 8d bb 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 00 00 00 48 8b 9b 88 00 00 00 48 85 db 0f 84
> RSP: 0018:ffffc90003bb7b20 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3283
> RDX: 0000000000000011 RSI: ffffffff81aa3291 RDI: 0000000000000088
> RBP: ffffc90003bb7dd0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000002
> R13: 000000000000001a R14: ffffffff8ad6bca0 R15: ffffc90003bb7e04
> FS:  0000555556ed2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000160d398 CR3: 000000007809c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 4 bytes skipped:
>     0:	45 85 e4             	test   %r12d,%r12d
>     3:	0f 84 d7 00 00 00    	je     0xe0
>     9:	e8 ff ee dd ff       	call   0xffddef0d
>     e:	48 8d bb 88 00 00 00 	lea    0x88(%rbx),%rdi
>    15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    1c:	fc ff df
>    1f:	48 89 fa             	mov    %rdi,%rdx
>    22:	48 c1 ea 03          	shr    $0x3,%rdx
> * 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>    2a:	0f 85 dc 00 00 00    	jne    0x10c
>    30:	48 8b 9b 88 00 00 00 	mov    0x88(%rbx),%rbx
>    37:	48 85 db             	test   %rbx,%rbx
>    3a:	0f                   	.byte 0xf
>    3b:	84                   	.byte 0x84
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


