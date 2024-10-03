Return-Path: <bpf+bounces-40814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FB98E9AE
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735CF1F244FE
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 06:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65806770F5;
	Thu,  3 Oct 2024 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gE5k9ZT/"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9C2564
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936281; cv=none; b=T+Z0mSd3KgVzDgwpic2c/lWS2hX/JNyaPpK0VZ1kEiUCv8tsK8aKESOrDRm6fAvv1YpwR6HqxaFWHNOaiteGFU5xotHMJ2ZUk//4K52ucrcafFSInkLuFaW6xPxggzdlvBUzBjYcMTN10f1h26HEIVLF4UU9ajNyCm0qf0FDVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936281; c=relaxed/simple;
	bh=fIIFQBsw7bb8sbXQLz60tMfAUWKmJJDxvjZuycx22co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZN77Ey3rKW3fuIMRMRh542qKE+9a5vCyWsFcLPwDINh8fWhcj/VIWyHF9arb+vawATkCxuCg/cFZ4/Do+wOkn9fXUX6bpLxtafDinjbZN6O12psSWL5Ocos0OEFlEaUAbdXklotqVCgshwpsooFt2JWBIcybtiNOCnmLG7vomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gE5k9ZT/; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727936276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1ae8gTA1k7GPD69d8GTFlpuY5yjiGiTxZ/jQFwsw5I=;
	b=gE5k9ZT/2KmSj6SI07P9WtWOZBeZP5u5KhbrqLxooONjKtxAZoGXnCNi6c3QJb1L7icgJx
	aNUwJm8SMOHrdQhctSNGy9ZRji8mewabPMACXBdIbGZIrYeDqrMZZV5NV+OHaw8Zq5Eywx
	xbbjDDftwvEiPX2j/c8W4X4IiJeg51g=
Date: Wed, 2 Oct 2024 23:17:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev>
 <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/1/24 6:26 PM, Alexei Starovoitov wrote:
> On Tue, Oct 1, 2024 at 5:23 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> Makes sense, though will we have cases where hierarchical scheduling
>> attaches the same prog at different points of the hierarchy?
> I'm not sure anyone was asking for such a use case.
>
>> Then the
>> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
> Well, 4 was the number from TJ.
>
> Anyway the proposed pseudo code:
>
> __bpf_prog_enter_recur_limited()
> {
>    cnt = this_cpu_inc_return(*(prog->active));
>    if (cnt > 4) {
>       inc_miss
>       return 0;
>    }
>   // pass cnt into bpf prog somehow, like %rdx ?
>   // or re-read prog->active from prog
> }
>
>
> then in the prologue emit:
>
> push rbp
> mov rbp, rsp
> if %rdx == 1
>     // main prog is called for the first time
>     mov rsp, pcpu_priv_stack_top
> else
>     // 2+nd time main prog is called or 1+ time subprog
>    sub rsp, stack_size
>    if rsp < pcpu_priv_stack_bottom
>      goto exit  // stack is too small, exit
> fi

I have tried to implement this approach (not handling
recursion yet) based on the above approach. It works
okay with nested bpf subprogs like
    main prog  // set rsp = pcpu_priv_stack_top
      subprog1 // some stack
        subprog2 // some stack

The pcpu_priv_stack is allocated like
   priv_stack_ptr = __alloc_percpu_gfp(1024 * 16, 8, GFP_KERNEL);

But whenever the prog called an external function,
e.g. a helper in this case, I will get a double fault.
An example could be
    main prog  // set rsp = pcpu_priv_stack_top
      subprog1 // some stack
        subprog2 // some stack
      call bpf_seq_printf
(I modified bpf_iter_ipv6_route.c bpf prog for the above
purpose.)
I added some printk statements from the beginning of bpf_seq_printf and
nothing printed out either and of course traps still happens.

I tried another example without subprog and the mainprog calls
a helper and the same double traps happens below too.

The error log looks like

[   54.024955] traps: PANIC: double fault, error_code: 0x0
[   54.024969] Oops: double fault: 0000 [#1] PREEMPT SMP KASAN PTI
[   54.024977] CPU: 3 UID: 0 PID: 1946 Comm: test_progs Tainted: G           OE      6.11.0-10577-gf25c172fd840-dirty #968
[   54.024982] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   54.024983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   54.024986] RIP: 0010:error_entry+0x1e/0x140
[   54.024996] Code: ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <41> 57 56 31 f6 31 d1
[   54.024999] RSP: 0018:ffffe8ffff580000 EFLAGS: 00010806
[   54.025002] RAX: f3f3f300f1f1f1f1 RBX: fffff91fffeb0044 RCX: ffffffff84201701
[   54.025005] RDX: fffff91fffeb0044 RSI: ffffffff8420128d RDI: ffffe8ffff580178
[   54.025007] RBP: ffffe8ffff580140 R08: 0000000000000000 R09: 0000000000000000
[   54.025009] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
[   54.025010] R13: 1ffffd1fffeb0014 R14: 0000000000000003 R15: ffffe8ffff580178
[   54.025012] FS:  00007fd076525d00(0000) GS:ffff8881f7180000(0000) knlGS:0000000000000000
[   54.025015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.025017] CR2: ffffe8ffff57fff8 CR3: 000000010cd80002 CR4: 0000000000370ef0
[   54.025021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.025022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.025024] Call Trace:
[   54.025026]  <#DF>
[   54.025028]  ? __die_body+0xaf/0xc0
[   54.025032]  ? die+0x2f/0x50
[   54.025036]  ? exc_double_fault+0x73/0x80
[   54.025040]  ? asm_exc_double_fault+0x23/0x30
[   54.025044]  ? common_interrupt_return+0xb1/0xcc
[   54.025048]  ? asm_exc_page_fault+0xd/0x30
[   54.025051]  ? error_entry+0x1e/0x140
[   54.025055]  </#DF>
[   54.025056] Modules linked in: bpf_testmod(OE)
[   54.025061] ---[ end trace 0000000000000000 ]---

Maybe somebody could give a hint why I got a double fault
when calling external functions (outside of bpf programs)
with allocated stack?

>
> Since stack bottom/top are known at JIT time we can
> generate reliable stack overflow checks.
> Much better than guard pages and -fstack-protector.
> The prog can alloc percpu
> (stack size of main prog + subprogs + extra) * 4
> and it likely will be enough.
> If not, the stack protection will gently exit the prog
> when the stack is too deep.
> kfunc won't have such a check, so we need a buffer zone.
> Can have a guard page too, but feels like overkill.

