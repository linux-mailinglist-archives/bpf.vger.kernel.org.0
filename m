Return-Path: <bpf+bounces-35055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC09374C7
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2456B219B1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680669D31;
	Fri, 19 Jul 2024 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad9k81Qu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5F40862;
	Fri, 19 Jul 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376686; cv=none; b=RZdg9rOfP1KZ1F/+Nvp4HG6+LMm7GH+O53zEEGNzx2ySQf8azy40zJQm7HY9+VYfjCNg7kOcoB8FCiPoZrQmQJXp0HR36Nxp9nAzvz2mMauf1L2itcaJFB7yNUALhZpwMOkpjGsHnktmELFsxirGiuhPoSgfLPIxYxUspTF3A84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376686; c=relaxed/simple;
	bh=W0TBcbt0kxdAcdDSv/013U8B31U4ZsrmKh7hvyyOjn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c5XPg/I098RSeLMA/Q9ZivRF03gIHDOMd/MpUIrBQ6hXjCoIzaE6UkCQ7UVaC4gFTMYtfaZXnwlvku2MpPXWlYKgBGrSsQIBlH0Xcj7Nk1afHd+PwBHhjvWkCAV5SiwkFGWZpsgfRHlD5mUusU+o5hCnuSoI91snF453A/FFuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad9k81Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB95C32782;
	Fri, 19 Jul 2024 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376685;
	bh=W0TBcbt0kxdAcdDSv/013U8B31U4ZsrmKh7hvyyOjn4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ad9k81QuKT3QA9fZMjMHAKxEjnGvEVrT53AuhJOkh0LyZ/0mqf4wQQCLxqAdJEvyK
	 kgGzXmn9zoJq21YGxjBzo9Go+XWzITHf/xGLFHNj7HIJGwEOrtI55Tdklzusmof7c1
	 TgDWmqoZC0jWUeq6vJxETcWXXpf84z+A2ibGWGVBXRW2fBOAPadkPx4JjVLyv7NiHk
	 4Iiq/ldqaNdRPPAvNUxYC+uN3P/QZAEzSSA+ZlwpBQNlKgn8yF0b9E/LIfP4LdhhLB
	 pT4P1ZiJPhiL34lD4I5ohAnBLbMiQ1fqhcOlItCR/YNg9d3+j+bD+Dt1cwEVqWWM+1
	 yjziOXIWRCxbA==
Message-ID: <89a21fa6-df1b-4eb3-b564-2376aededc75@kernel.org>
Date: Fri, 19 Jul 2024 10:11:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 bq_xmit_all
To: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <000000000000943e1c061d92bdd6@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/07/2024 07.12, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    73399b58e5e5 Add linux-next specific files for 20240718
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f2195980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=54e443ddc2b981c8
> dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602cf31980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fde5e980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fbab059c854f/disk-73399b58.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/874a209f4c3f/vmlinux-73399b58.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f34e5c7be278/bzImage-73399b58.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in ./kernel/bpf/devmap.c:385:28
> index 16 is out of range for type 'struct xdp_frame *[16]'
> CPU: 1 UID: 0 PID: 5101 Comm: syz-executor232 Not tainted 6.10.0-next-20240718-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   ubsan_epilogue lib/ubsan.c:231 [inline]
>   __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
>   bq_xmit_all+0x157/0x11d0 kernel/bpf/devmap.c:385
>   __dev_flush+0x81/0x160 kernel/bpf/devmap.c:425
>   xdp_do_check_flushed+0x129/0x240 net/core/filter.c:4300

When xdp_do_check_flushed() calls __dev_flush(), this indicate that some 
driver didn't call xdp_do_flush() after NAPI finished.

What NIC device driver is this tested on?

--Jesper

>   __napi_poll+0xe4/0x490 net/core/dev.c:6774
>   napi_poll net/core/dev.c:6840 [inline]
>   net_rx_action+0x89b/0x1240 net/core/dev.c:6962
>   handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>   __do_softirq kernel/softirq.c:588 [inline]
>   invoke_softirq kernel/softirq.c:428 [inline]
>   __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>   common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
> Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ce cf 5c f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 69 c4 f5 65 8b 05 04 5f 65 74 85 c0 74 43 48 c7 04 24 0e 36
> RSP: 0018:ffffc9000369fb60 EFLAGS: 00000206
> RAX: 3e45100d05912800 RBX: 1ffff920006d3f70 RCX: ffffffff817023ea
> RDX: dffffc0000000000 RSI: ffffffff8bcad5c0 RDI: 0000000000000001
> RBP: ffffc9000369fbf0 R08: ffffffff9300f817 R09: 1ffffffff2601f02
> R10: dffffc0000000000 R11: fffffbfff2601f03 R12: dffffc0000000000
> R13: 1ffff920006d3f6c R14: ffffc9000369fb80 R15: 0000000000000246
>   spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>   do_notify_parent_cldstop+0x9ab/0xb50 kernel/signal.c:2216
>   ptrace_stop+0x465/0x940 kernel/signal.c:2319
>   ptrace_do_notify kernel/signal.c:2393 [inline]
>   ptrace_notify+0x255/0x380 kernel/signal.c:2405
>   ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>   ptrace_report_syscall_entry include/linux/ptrace.h:452 [inline]
>   syscall_trace_enter+0x5d/0x150 kernel/entry/common.c:45
>   syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
>   syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
>   do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f708ebe0e20
> Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d 81 e2 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffd97b2a878 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000015 RCX: 00007f708ebe0e20
> RDX: ffffffffffffffb8 RSI: 0000000020000240 RDI: 0000000000000014
> RBP: 0000000000000000 R08: 00007ffd97b2a9a8 R09: 00007ffd97b2a9a8
> R10: 00007ffd97b2a9a8 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffd97b2a8b0 R15: 00007ffd97b2a8a0
>   </TASK>
> ---[ end trace ]---
> ----------------
> Code disassembly (best guess):
>     0:	9c                   	pushf
>     1:	8f 44 24 20          	pop    0x20(%rsp)
>     5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
>     a:	74 08                	je     0x14
>     c:	4c 89 f7             	mov    %r14,%rdi
>     f:	e8 ce cf 5c f6       	call   0xf65ccfe2
>    14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
>    19:	75 52                	jne    0x6d
>    1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
>    22:	74 01                	je     0x25
>    24:	fb                   	sti
>    25:	bf 01 00 00 00       	mov    $0x1,%edi
> * 2a:	e8 c3 69 c4 f5       	call   0xf5c469f2 <-- trapping instruction
>    2f:	65 8b 05 04 5f 65 74 	mov    %gs:0x74655f04(%rip),%eax        # 0x74655f3a
>    36:	85 c0                	test   %eax,%eax
>    38:	74 43                	je     0x7d
>    3a:	48                   	rex.W
>    3b:	c7                   	.byte 0xc7
>    3c:	04 24                	add    $0x24,%al
>    3e:	0e                   	(bad)
>    3f:	36                   	ss
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
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

