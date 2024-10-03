Return-Path: <bpf+bounces-40858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9798F683
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A1BB22280
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93E1AB515;
	Thu,  3 Oct 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jb9waOxp"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D91A3A9B
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981606; cv=none; b=aOXhRXQ6dlBAF2DaVq/IfvhHluXixodRV8raHgtLt0Q8BCCOT95M2pMTQxfNl2GeVfg2GwXja8VCWcNAiAtkOrVTXUoGsnUKNM1qDMxJ+PxyenE1Oxcf8tisJl33/bXTi4TanL9gMg22FlqMJUvjEeyuGg2EU6GR4hvOD/czl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981606; c=relaxed/simple;
	bh=kvQb/ogb0I5fqx/vjlyCkumizXiHqxG+w56PFQWNcys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb0WLkToON39RL3HKPTosueSCC5rbRhh5S+31BpMxjn+N5OZRW8kHSbA5rvTEmBg9tSUqy6HGlLSQTyEtIRZwhEEfgw9mEA/RMOFw682bhlPAL7phFWQjszg+JpKXoJqHt15mwYCos1g4c2jOWCp6aQh+AX/LWGQaw3z6mUWJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jb9waOxp; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4dbee577-af8f-4b27-9099-d56956c8e772@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727981600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eszk3sNqij3NLdzQux9S4INK5vDEPqrRJhwv6sLmoh4=;
	b=Jb9waOxpQQjBJkCm3oahL56ZGAFCcPXOvfjzlgSWQhRIxZEO6kQvcmIlLkwrCROQ60VRoZ
	Rbavl9oZv/vQEcLkm8dUyDkEV2XW0OL+H7XzCslh7eFEp0ck/chgo1EWR+Jt3nuUEPTQCc
	17uWMCqPwpREojuy1TIrAPVUX29GXC0=
Date: Thu, 3 Oct 2024 11:53:13 -0700
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
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
 <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/3/24 10:35 AM, Alexei Starovoitov wrote:
> On Thu, Oct 3, 2024 at 6:40 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> On Thu, 3 Oct 2024 at 08:17, Yonghong Song <yonghong.song@linux.dev> wrote:
>>>
>>> On 10/1/24 6:26 PM, Alexei Starovoitov wrote:
>>>> On Tue, Oct 1, 2024 at 5:23 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>>> Makes sense, though will we have cases where hierarchical scheduling
>>>>> attaches the same prog at different points of the hierarchy?
>>>> I'm not sure anyone was asking for such a use case.
>>>>
>>>>> Then the
>>>>> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
>>>> Well, 4 was the number from TJ.
>>>>
>>>> Anyway the proposed pseudo code:
>>>>
>>>> __bpf_prog_enter_recur_limited()
>>>> {
>>>>     cnt = this_cpu_inc_return(*(prog->active));
>>>>     if (cnt > 4) {
>>>>        inc_miss
>>>>        return 0;
>>>>     }
>>>>    // pass cnt into bpf prog somehow, like %rdx ?
>>>>    // or re-read prog->active from prog
>>>> }
>>>>
>>>>
>>>> then in the prologue emit:
>>>>
>>>> push rbp
>>>> mov rbp, rsp
>>>> if %rdx == 1
>>>>      // main prog is called for the first time
>>>>      mov rsp, pcpu_priv_stack_top
>>>> else
>>>>      // 2+nd time main prog is called or 1+ time subprog
>>>>     sub rsp, stack_size
>>>>     if rsp < pcpu_priv_stack_bottom
>>>>       goto exit  // stack is too small, exit
>>>> fi
>>> I have tried to implement this approach (not handling
>>> recursion yet) based on the above approach. It works
>>> okay with nested bpf subprogs like
>>>      main prog  // set rsp = pcpu_priv_stack_top
>>>        subprog1 // some stack
>>>          subprog2 // some stack
>>>
>>> The pcpu_priv_stack is allocated like
>>>     priv_stack_ptr = __alloc_percpu_gfp(1024 * 16, 8, GFP_KERNEL);
>>>
>>> But whenever the prog called an external function,
>>> e.g. a helper in this case, I will get a double fault.
>>> An example could be
>>>      main prog  // set rsp = pcpu_priv_stack_top
>>>        subprog1 // some stack
>>>          subprog2 // some stack
>>>        call bpf_seq_printf
>>> (I modified bpf_iter_ipv6_route.c bpf prog for the above
>>> purpose.)
>>> I added some printk statements from the beginning of bpf_seq_printf and
>>> nothing printed out either and of course traps still happens.
>>>
>>> I tried another example without subprog and the mainprog calls
>>> a helper and the same double traps happens below too.
>>>
>>> The error log looks like
>>>
>>> [   54.024955] traps: PANIC: double fault, error_code: 0x0
>>> [   54.024969] Oops: double fault: 0000 [#1] PREEMPT SMP KASAN PTI
>>> [   54.024977] CPU: 3 UID: 0 PID: 1946 Comm: test_progs Tainted: G           OE      6.11.0-10577-gf25c172fd840-dirty #968
>>> [   54.024982] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>> [   54.024983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>> [   54.024986] RIP: 0010:error_entry+0x1e/0x140
>>> [   54.024996] Code: ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <41> 57 56 31 f6 31 d1
>>> [   54.024999] RSP: 0018:ffffe8ffff580000 EFLAGS: 00010806
>>> [   54.025002] RAX: f3f3f300f1f1f1f1 RBX: fffff91fffeb0044 RCX: ffffffff84201701
>>> [   54.025005] RDX: fffff91fffeb0044 RSI: ffffffff8420128d RDI: ffffe8ffff580178
>>> [   54.025007] RBP: ffffe8ffff580140 R08: 0000000000000000 R09: 0000000000000000
>>> [   54.025009] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
>>> [   54.025010] R13: 1ffffd1fffeb0014 R14: 0000000000000003 R15: ffffe8ffff580178
>>> [   54.025012] FS:  00007fd076525d00(0000) GS:ffff8881f7180000(0000) knlGS:0000000000000000
>>> [   54.025015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   54.025017] CR2: ffffe8ffff57fff8 CR3: 000000010cd80002 CR4: 0000000000370ef0
>>> [   54.025021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   54.025022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   54.025024] Call Trace:
>>> [   54.025026]  <#DF>
>>> [   54.025028]  ? __die_body+0xaf/0xc0
>>> [   54.025032]  ? die+0x2f/0x50
>>> [   54.025036]  ? exc_double_fault+0x73/0x80
>>> [   54.025040]  ? asm_exc_double_fault+0x23/0x30
>>> [   54.025044]  ? common_interrupt_return+0xb1/0xcc
>>> [   54.025048]  ? asm_exc_page_fault+0xd/0x30
>>> [   54.025051]  ? error_entry+0x1e/0x140
>>> [   54.025055]  </#DF>
>>> [   54.025056] Modules linked in: bpf_testmod(OE)
>>> [   54.025061] ---[ end trace 0000000000000000 ]---
>>>
>>> Maybe somebody could give a hint why I got a double fault
>>> when calling external functions (outside of bpf programs)
>>> with allocated stack?
>>>
>> I will help in debugging. Can you share the patch you applied locally
>> so I can reproduce?
> Looks like the idea needs more thought.
>
> in_task_stack() won't recognize the private stack,
> so it will look like stack overflow and double fault.

Thanks. Good point. For a particular helper, if the helper is
doing nothing, it works fine. As soon as I add a printk,
it will have double fault. Maybe some case kernel functions
also do check in_task_stack() as well.

>
> do you have CONFIG_VMAP_STACK ?

No. But I can try.


