Return-Path: <bpf+bounces-34831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A09318B3
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789C71F22296
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915B1CD3C;
	Mon, 15 Jul 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jKbQrQBg"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C091C6A7
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061948; cv=none; b=f/o83KOm5IWXJEKgW2hGviae9xKcwKhL5ioDMQQS37wyu6DL3UbtNDYjDfi5reYOr1HzYO61yAzSqcunKzYFK0OFHYpQ7dPl1zDZ/LB3jgJFtBolYsIQQa43ijapA9D+Raj7D9B+EWrsO2EqeVNw9urpTk7yLCUv9RMcEv01Zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061948; c=relaxed/simple;
	bh=g3TsDC1Dt+QibKjC/aru0pCKi2GGtH+rQmoK53Q/fjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nwmd56Le1p2Sm+XrGltFE2r2hnFO/q6gWZI2glmCj9TBlezohbXytXGFRudRhjZLhDXff30Op01hnO6ncXTomcwzKUIgNiVKe0tRyKibgUdW2EE+yk41aKYdhsOsW8XJiNCuA4g5saGiK5r3mGRzMEyegTF+kKMrlLNey0pUbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jKbQrQBg; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721061943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrkrYYeAqHTSclk91Vns/UxONgZciPm/zZb1C5sKiKE=;
	b=jKbQrQBgKzYJvLtKgZy5prSOEuKJ5/CV1DuHj3K5rLj767vP/bV1jvM7ayqQ51Gfii3W72
	SgI/SXffLADbbfUQ3rKz+kyCUN5SzD2rm9MCCDPQN54mWVx6Aa/PuES2JwasBjfkTeBWHT
	e4Pg/R1JLX8jER13h1MV7FrG7MipmvA=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: davem@davemloft.net
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: hawk@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: sdf@google.com
X-Envelope-To: song@kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Message-ID: <26ba9ac3-28a8-43ee-98b1-285ec180583f@linux.dev>
Date: Mon, 15 Jul 2024 09:45:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel paging
 request in bpf_prog_ADDR (3)
Content-Language: en-GB
To: syzbot <syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c90eee061d236d37@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <000000000000c90eee061d236d37@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/13/24 9:24 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8b9b59e27aa8 i40e: fix: remove needless retries of NVM upd..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=135ee4f6980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad9ec60c8eaf69e6f99c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171399dd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e4054e980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/535b0bcd3e1f/disk-8b9b59e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/127f5ddff150/vmlinux-8b9b59e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a3ac9910529c/bzImage-8b9b59e2.xz
>
> The issue was bisected to:
>
> commit 1f1e864b65554e33fe74e3377e58b12f4302f2eb
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Fri Jul 28 01:12:07 2023 +0000
>
>      bpf: Handle sign-extenstin ctx member accesses
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121c054e980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=111c054e980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=161c054e980000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
> Fixes: 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses")
>
> BUG: unable to handle page fault for address: 000000002aebd040
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 80000000226b6067 P4D 80000000226b6067 PUD 226b7067 PMD 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 5096 Comm: syz-executor365 Not tainted 6.10.0-rc7-syzkaller-00133-g8b9b59e27aa8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> RIP: 0010:bpf_prog_82ec301e76077160+0x5c/0xa0
> Code: 0a b8 02 00 00 00 41 5d 5b c9 c3 48 89 df 48 8b b7 d8 00 00 00 48 63 f6 48 8b 57 50 48 89 f0 48 83 c0 08 48 39 c2 77 02 eb dc <48> 0f b7 5e 00 4c 0f bf eb 48 81 fb 0f ff 07 00 74 00 48 c1 e3 20
> RSP: 0018:ffffc900031f7980 EFLAGS: 00010292
> RAX: 000000002aebd048 RBX: 0000000000000000 RCX: ffff888076a99e00
> RDX: ffff88802aebd050 RSI: 000000002aebd040 RDI: ffff8880226b4b40
> RBP: ffffc900031f7990 R08: ffffffff8183cf51 R09: 1ffffffff1f5b295
> R10: dffffc0000000000 R11: ffffffffa0001f9c R12: ffffffff8998404e
> R13: dffffc0000000000 R14: ffffc90000ace030 R15: ffffc90000ace020
> FS:  0000555562a39380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002aebd040 CR3: 0000000021bc0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>   __bpf_prog_run include/linux/filter.h:691 [inline]
>   bpf_prog_run include/linux/filter.h:698 [inline]
>   bpf_test_run+0x409/0x910 net/bpf/test_run.c:425
>   bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1072
>   bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4292
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5706
>   __do_sys_bpf kernel/bpf/syscall.c:5795 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5793 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5793
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcd7dc9bbb9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc1893ff98 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd7dc9bbb9
> RDX: 000000000000004c RSI: 0000000020000240 RDI: 000000000000000a
> RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> CR2: 000000002aebd040
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bpf_prog_82ec301e76077160+0x5c/0xa0
> Code: 0a b8 02 00 00 00 41 5d 5b c9 c3 48 89 df 48 8b b7 d8 00 00 00 48 63 f6 48 8b 57 50 48 89 f0 48 83 c0 08 48 39 c2 77 02 eb dc <48> 0f b7 5e 00 4c 0f bf eb 48 81 fb 0f ff 07 00 74 00 48 c1 e3 20
> RSP: 0018:ffffc900031f7980 EFLAGS: 00010292
> RAX: 000000002aebd048 RBX: 0000000000000000 RCX: ffff888076a99e00
> RDX: ffff88802aebd050 RSI: 000000002aebd040 RDI: ffff8880226b4b40
> RBP: ffffc900031f7990 R08: ffffffff8183cf51 R09: 1ffffffff1f5b295
> R10: dffffc0000000000 R11: ffffffffa0001f9c R12: ffffffff8998404e
> R13: dffffc0000000000 R14: ffffc90000ace030 R15: ffffc90000ace020
> FS:  0000555562a39380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002aebd040 CR3: 0000000021bc0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>     0:	0a b8 02 00 00 00    	or     0x2(%rax),%bh
>     6:	41 5d                	pop    %r13
>     8:	5b                   	pop    %rbx
>     9:	c9                   	leave
>     a:	c3                   	ret
>     b:	48 89 df             	mov    %rbx,%rdi
>     e:	48 8b b7 d8 00 00 00 	mov    0xd8(%rdi),%rsi
>    15:	48 63 f6             	movslq %esi,%rsi
>    18:	48 8b 57 50          	mov    0x50(%rdi),%rdx
>    1c:	48 89 f0             	mov    %rsi,%rax
>    1f:	48 83 c0 08          	add    $0x8,%rax
>    23:	48 39 c2             	cmp    %rax,%rdx
>    26:	77 02                	ja     0x2a
>    28:	eb dc                	jmp    0x6
> * 2a:	48 0f b7 5e 00       	movzwq 0x0(%rsi),%rbx <-- trapping instruction
>    2f:	4c 0f bf eb          	movswq %bx,%r13
>    33:	48 81 fb 0f ff 07 00 	cmp    $0x7ff0f,%rbx
>    3a:	74 00                	je     0x3c
>    3c:	48 c1 e3 20          	shl    $0x20,%rbx
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

The failure is due to the following bpf code:
         r2 = *(s32 *)(r1 + 76)  /* __sk_buff->data */
         r3 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
         r0 = r2
         r0 += 8
         if r3 > r0 goto +1

After verification:
         r2 = *(u64 *)(r1 +208)
         r2 = (s32)r2    /* added in convert_ctx_accesses() */
         r3 = *(u64 *)(r1 +80)
         r0 = r2
         r0 += 8
         if r3 > r0 goto pc+1

The 'r2 = (s32)r2' will cause incorrect __sk_buff->data.
I will send a patch shortly.


