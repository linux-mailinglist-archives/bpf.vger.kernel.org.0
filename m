Return-Path: <bpf+bounces-41007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37C9910AA
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14921B2E1FC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D21DE2B1;
	Fri,  4 Oct 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8DlFaVx"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE4231CBF
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070088; cv=none; b=UnboZqQ2Kq6B7UNp/KkM+X2LCAYbb5EhLcY0GQAgfxhKmXcLykTEJ/MKWdN7xIwvIMCQvP3dJiMLDbeS/dcaP3ircTMXraZVsbSAliHp95beFF803Kb02rBeiRvMwgOVew8R9Mhsnds+iaTjt8ns68XJtN9D/YITMFaixvnKHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070088; c=relaxed/simple;
	bh=O2cB0liHSo08e/idGpj0/onE+EIzJw2YiBcAJ6UU1lQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oidDp0DyX9bZdnZd6aYSaimHTk2DKnskesfdG6zFYN8COUp2dcS3tWfMBOjiyusIqE/benNUj1hyU8ovTQ4U4ygVYmKvaGKy0zYYcB6W0NWqkSCLW9bCo6SMmmdtjVeOfkbLOPrsjXPApfDZZdJmtFnAGry3nt9rUYwDBc0vewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8DlFaVx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728070081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iscizTRfcMiQQZhQKKOOR76+jYVPmHZR3+Up9FwulA=;
	b=j8DlFaVxWKfXAhg5YQ0LqS4AeJH2Mm6XSoQmAZYoXNAhXtzPrmQRbVSYzo2IurgTWjvlca
	1Q/3PxXfa/dSBUQQG+fknp2+QL3tu+6o98X32wKMs8zQMaGp51mTRpa3zC3PwQgDPb4BPj
	EMo2T++IGKQClBh6Qdzpm6HNixMwkQ8=
Date: Fri, 4 Oct 2024 12:27:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
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
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
 <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
 <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev>
In-Reply-To: <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/3/24 10:22 PM, Yonghong Song wrote:
>
> On 10/3/24 3:32 PM, Alexei Starovoitov wrote:
>> On Thu, Oct 3, 2024 at 1:44 PM Yonghong Song 
>> <yonghong.song@linux.dev> wrote:
>>>> Looks like the idea needs more thought.
>>>>
>>>> in_task_stack() won't recognize the private stack,
>>>> so it will look like stack overflow and double fault.
>>>>
>>>> do you have CONFIG_VMAP_STACK ?
>>> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard 
>>> private stack support with
>>> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
>>> CONFIG_VMAP_STACK or not.
>> Good! but I'm surprised it makes a difference.
>
> That only for the test case I tried. Now I tried the whole bpf selftests
> with CONFIG_VMAP_STACK on. There are still some failures. Some of them
> due to stack protector. I disabled stack protector and then those stack
> protector error gone. But some other errors show up like below:
>
> [   27.186581] kernel tried to execute NX-protected page - exploit 
> attempt? (uid: 0)
> [   27.187480] BUG: unable to handle page fault for address: 
> ffff888109572800
> [   27.188299] #PF: supervisor instruction fetch in kernel mode
> [   27.189085] #PF: error_code(0x0011) - permissions violation
>
> or
>
> [   27.736844] BUG: unable to handle page fault for address: 
> 0000000080000000
> [   27.737759] #PF: supervisor instruction fetch in kernel mode
> [   27.738631] #PF: error_code(0x0010) - not-present page
> [   27.739455] PGD 0 P4D 0
> [   27.739818] Oops: Oops: 0010 [#1] PREEMPT SMP PTI
>
> ...
>
> Some further investigations are needed.


I found one failure case (with stackprotector disabled):

[   20.032611] traps: PANIC: double fault, error_code: 0x0
[   20.032615] Oops: double fault: 0000 [#1] PREEMPT SMP PTI
[   20.032619] CPU: 0 UID: 0 PID: 1959 Comm: test_progs Tainted: G           OE      6.11.0-10576-g17baa0096769-dirty #1006
[   20.032623] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   20.032624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   20.032626] RIP: 0010:error_entry+0x17/0x140
[   20.032633] Code: ff 0f 01 f8 e9 56 fe ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 49
[   20.032635] RSP: 0018:ffffe8ffff400000 EFLAGS: 00010093
[   20.032637] RAX: ffffe8ffff4000a8 RBX: ffffe8ffff4000a8 RCX: ffffffff82201737
[   20.032639] RDX: 0000000000000000 RSI: ffffffff8220128d RDI: ffffe8ffff4000a8
[   20.032640] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   20.032641] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   20.032642] R13: 0000000000000000 R14: 000000000002ed80 R15: 0000000000000000
[   20.032643] FS:  00007f8a3a2006c0(0000) GS:ffff888237c00000(0000) knlGS:ffff888237c00000
[   20.032645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.032646] CR2: ffffe8ffff3ffff8 CR3: 0000000103580002 CR4: 0000000000370ef0
[   20.032649] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.032650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.032651] Call Trace:
[   20.032660]  <#DF>
[   20.032664]  ? __die_body+0xaf/0xc0
[   20.032667]  ? die+0x2f/0x50
[   20.032670]  ? exc_double_fault+0xbf/0xd0
[   20.032674]  ? asm_exc_double_fault+0x23/0x30
[   20.032678]  ? restore_regs_and_return_to_kernel+0x1b/0x1b
[   20.032681]  ? asm_exc_page_fault+0xd/0x30
[   20.032684]  ? error_entry+0x17/0x140
[   20.032687]  </#DF>

The private stack for cpu 0:
   priv_stack_ptr cpu 0 = [ffffe8ffff434000, ffffe8ffff438000] (total 16KB)
That is, the top stack is ffffe8ffff438000 and the bottom stack is ffffe8ffff434000.

During bpf execution, a softirq may happen, at that point,
stack pointer becomes:
    RSP: 0018:ffffe8ffff400000 (see above)
and there is a read/write (mostly write) to address
    CR2: ffffe8ffff3ffff8
And this may cause a fault.
After this fault, there are some further access and probably because
of invalid stack, double fault happens.

So the quesiton is why RSP is reset to ffffe8ffff400000?
I have not figured out which code changed this? Maybe somebody can help?

>
>> Please still root cause the crash without VMAP_STACK.
>
> Sure. Let me investigate cases with VMAP_STACK first and
> then will try to look at it without VMAP_STACK.
>
>>
>> We need to do a lot more homework here before proceeding.
>> Look at arch/x86/kernel/dumpstack_64.c
>> At least we need new stack_type for priv stack.
>> stack_type_unknown doesn't inspire confidence.
>> Need to make sure stack trace is still reliable with priv stack.
>> Though it may look appealing from performance pov.
>> We may need to go back to r9 approach with push/pop around calls,
>> since that is surely keeping unwinder happy
>> while this approach will have to teach unwinder.
>
> Good point.
>
>

