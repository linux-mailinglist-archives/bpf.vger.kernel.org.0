Return-Path: <bpf+bounces-38332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC89636EB
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6284B2355F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE6DDC5;
	Thu, 29 Aug 2024 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+39IN8v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314536B;
	Thu, 29 Aug 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891918; cv=none; b=DThHXNR0dfbiyhq9FC+QylZ0hcH+/NKWFuaRNkECeCBSaS0MlDmAotGBpBaYv6Fl+L8fMdLx9liEs8vIDm7lFnZzceVTwZ6IsExjci/Mkho1q3gI1yclulUshQGnNDifysFOYJf1nye8sAyB1nDlx2Xca8ywclfD3ZII6eKjhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891918; c=relaxed/simple;
	bh=H/Us5usGxDS5wVRR+GqgLPHopjD00i4j8HH8GeuvDEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBlGFMBx8oobWUF8td2am5c3lwOSpFPqlqAoSvJUB78V7ZYFUr3/V5yN0DOIzJlqAzMGJ1uPjC+8SJ2rH/Kt8zcts7SpJfFIypLb5x0XshaeJEu4LFsJ1OAiO6wPGaFNg0vvk7f9oS/EaSOf8j50xkM45pucIXwcHul5KCl6qyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+39IN8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE3C4CEC0;
	Thu, 29 Aug 2024 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724891917;
	bh=H/Us5usGxDS5wVRR+GqgLPHopjD00i4j8HH8GeuvDEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+39IN8v8PiE2fCMazeCrm6GKNThs9g20kxKk9yyAC5UgyXNrRT6lnMBjGcGhwInV
	 AdCb2q7qy7XkyeAGCtJe79ZbI4QnkrjTriMxVolZ5Cbqd53LwBW9z0kAT5vaLItSVg
	 0+LfFlPgiuGvFmFr5eYLeGsVSPSs+9RsuIvY9eoVHXiCFp7Mu64SlxByT4T1l9ZOw/
	 P15osE9Zqd6RMnO0MH6UrjzymJDQaguyNynrVtxNNCb5THpWKG2yALm4Mp7jym1vZD
	 DZ9H08x/jvLaqxW+5Gq6KxOaTbMAvwzwuuDTnU5d2aoOtKVIZ/2z3EYD58LHA8IPUq
	 2X9NRwX0ox25Q==
Date: Wed, 28 Aug 2024 17:38:36 -0700
From: Kees Cook <kees@kernel.org>
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: luto@amacapital.net, wad@chromium.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: BUG: null pointer dereference in seccomp
Message-ID: <202408281719.8BBA257@keescook>
References: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>

On Tue, Aug 27, 2024 at 09:09:49PM -0700, Juefei Pu wrote:
> Hello,
> We found the following null-pointer-dereference issue using syzkaller
> on Linux v6.10.

In seccomp! Yikes.

> Unfortunately, the syzkaller failed to generate a reproducer.

That's a bummer.

> But at least we have the report:
> 
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]

This doesn't look like a NULL deref, this looks like a corrupted
pointer: 0xdffffc0000000006. Is prog bad or dfunc bad? I assume the
former, as dfunc is hard-coded below...

                ret = dfunc(ctx, prog->insnsi, prog->bpf_func);

> RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]

        return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);

> RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]

        ret = bpf_prog_run(prog, ctx);

> RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426

                u32 cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);

> Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
> 48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
> 08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
> RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
> RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
> R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
> R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
> FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f897d771b08 CR3: 00000000195fe000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __seccomp_filter+0x46f/0x1c70 kernel/seccomp.c:1222
>  syscall_trace_enter+0xa4/0x140 kernel/entry/common.c:52
>  syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
>  syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
>  do_syscall_64+0x5d/0x150 arch/x86/entry/common.c:79
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f

Has anything changed in BPF in this area lately?

> RIP: 0033:0x7f897ed171e4
> Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
> 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
> RSP: 002b:00007ffd4ae74a60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00005627cd785ed0 RCX: 00007f897ed171e4
> RDX: 0000000000290000 RSI: 00007f897f010d0a RDI: 00000000ffffff9c
> RBP: 00007f897f010d0a R08: 0000000000000000 R09: 0034353132303865
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000290000
> R13: 00007ffd4ae74d20 R14: 0000000000000000 R15: 00007ffd4ae74e28
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]
> RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]
> RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]
> RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426
> Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
> 48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
> 08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
> RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
> RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
> R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
> R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
> FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f521f8ca000 CR3: 00000000195fe000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0: 00 00                 add    %al,(%rax)
>    2: e8 99 36 d2 ff       call   0xffd236a0
>    7: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
>    c: e8 cf 58 ff ff       call   0xffff58e0
>   11: 48 8d 5d 48           lea    0x48(%rbp),%rbx
>   15: 48 83 c5 30           add    $0x30,%rbp
>   19: 48 89 e8             mov    %rbp,%rax
>   1c: 48 c1 e8 03           shr    $0x3,%rax
>   20: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
>   27: fc ff df
> * 2a: 80 3c 08 00           cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
>   2e: 74 08                 je     0x38
>   30: 48 89 ef             mov    %rbp,%rdi
>   33: e8 c8 63 62 00       call   0x626400
>   38: 4c 8b 5d 00           mov    0x0(%rbp),%r11
>   3c: 48 8b 3c 24           mov    (%rsp),%rdi

What's the movabs? I don't have anything like that in my vmlinux binary
output. Is this KASAN perhaps?

Regardless, I don't see how prog could be NULL. :( It shouldn't be
possible without some kind of major refcounting bug.

-Kees

-- 
Kees Cook

