Return-Path: <bpf+bounces-41357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7D995F84
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952151C213EF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00B169AE6;
	Wed,  9 Oct 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HylYzFhF"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5136D
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454369; cv=none; b=LAihqZbG1RbwiQtxmpXZZTbWO5vUP66SrFpzpeMukEblwyE9EtKpekhtYDlaiJRC81PSVEvG9S3yHIDBiMjRISGxvSARPViNAY259kDyh7fcplczoPLo/BEZGN/FoBCj0up5257j2Y9AK/uwamwurrbmHYwdwxwwsAw68VvSO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454369; c=relaxed/simple;
	bh=INmkbduyosecaOO7n5JUBhx3MW9mJHjPw9yuzGjOw8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDNai3Q+ew94FsOZ2TJwnMGp5clvZeXmFMt9D/bsHr5Pjmrxh6alU85/j5BXO0lzlFWFh5KtS60cUrnC0fhbelLCZo3uCM6pUM6PJE0wI8P0UmulDfyX5251tW5O7a2tfrF8zXxETb4aok0AS4mYylqUeMUBmrhx5bgaD2zi3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HylYzFhF; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1ae454a-4647-40a5-b48b-60cc140e51aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728454364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Q8ta8XQPvr3T9L8r76aNVjUFZuA2LjlmRqImNveLXE=;
	b=HylYzFhFXqawTwy/egKG2q4U90IbHFRDGU/w4MZ759L3nGt+GjLqoKFLT4s+JWKAjxvfbe
	5ZiCMUqarYASAmAmt2P/v5daapZZ37E4Bsaov+4wOIzevrl9Fd6M9cw1J0IVQof3f8SuMh
	d1pqs4Uur7uFlOFoSruqLUapaY3vpBo=
Date: Tue, 8 Oct 2024 23:12:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
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
 <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
 <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com>
 <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev>
 <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/8/24 3:10 PM, Alexei Starovoitov wrote:
> On Fri, Oct 4, 2024 at 7:03 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 10/4/24 12:52 PM, Alexei Starovoitov wrote:
>>> On Fri, Oct 4, 2024 at 12:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> On 10/3/24 10:22 PM, Yonghong Song wrote:
>>>>> On 10/3/24 3:32 PM, Alexei Starovoitov wrote:
>>>>>> On Thu, Oct 3, 2024 at 1:44 PM Yonghong Song
>>>>>> <yonghong.song@linux.dev> wrote:
>>>>>>>> Looks like the idea needs more thought.
>>>>>>>>
>>>>>>>> in_task_stack() won't recognize the private stack,
>>>>>>>> so it will look like stack overflow and double fault.
>>>>>>>>
>>>>>>>> do you have CONFIG_VMAP_STACK ?
>>>>>>> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard
>>>>>>> private stack support with
>>>>>>> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
>>>>>>> CONFIG_VMAP_STACK or not.
>>>>>> Good! but I'm surprised it makes a difference.
>>>>> That only for the test case I tried. Now I tried the whole bpf selftests
>>>>> with CONFIG_VMAP_STACK on. There are still some failures. Some of them
>>>>> due to stack protector. I disabled stack protector and then those stack
>>>>> protector error gone. But some other errors show up like below:
>>>>>
>>>>> [   27.186581] kernel tried to execute NX-protected page - exploit
>>>>> attempt? (uid: 0)
>>>>> [   27.187480] BUG: unable to handle page fault for address:
>>>>> ffff888109572800
>>>>> [   27.188299] #PF: supervisor instruction fetch in kernel mode
>>>>> [   27.189085] #PF: error_code(0x0011) - permissions violation
>>>>>
>>>>> or
>>>>>
>>>>> [   27.736844] BUG: unable to handle page fault for address:
>>>>> 0000000080000000
>>>>> [   27.737759] #PF: supervisor instruction fetch in kernel mode
>>>>> [   27.738631] #PF: error_code(0x0010) - not-present page
>>>>> [   27.739455] PGD 0 P4D 0
>>>>> [   27.739818] Oops: Oops: 0010 [#1] PREEMPT SMP PTI
>>>>>
>>>>> ...
>>>>>
>>>>> Some further investigations are needed.
>>>> I found one failure case (with stackprotector disabled):
>>>>
>>>> [   20.032611] traps: PANIC: double fault, error_code: 0x0
>>>> [   20.032615] Oops: double fault: 0000 [#1] PREEMPT SMP PTI
>>>> [   20.032619] CPU: 0 UID: 0 PID: 1959 Comm: test_progs Tainted: G           OE      6.11.0-10576-g17baa0096769-dirty #1006
>>>> [   20.032623] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>> [   20.032624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>> [   20.032626] RIP: 0010:error_entry+0x17/0x140
>>>> [   20.032633] Code: ff 0f 01 f8 e9 56 fe ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 49
>>>> [   20.032635] RSP: 0018:ffffe8ffff400000 EFLAGS: 00010093
>>>> [   20.032637] RAX: ffffe8ffff4000a8 RBX: ffffe8ffff4000a8 RCX: ffffffff82201737
>>>> [   20.032639] RDX: 0000000000000000 RSI: ffffffff8220128d RDI: ffffe8ffff4000a8
>>>> [   20.032640] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>>> [   20.032641] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>> [   20.032642] R13: 0000000000000000 R14: 000000000002ed80 R15: 0000000000000000
>>>> [   20.032643] FS:  00007f8a3a2006c0(0000) GS:ffff888237c00000(0000) knlGS:ffff888237c00000
>>>> [   20.032645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   20.032646] CR2: ffffe8ffff3ffff8 CR3: 0000000103580002 CR4: 0000000000370ef0
>>>> [   20.032649] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [   20.032650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [   20.032651] Call Trace:
>>>> [   20.032660]  <#DF>
>>>> [   20.032664]  ? __die_body+0xaf/0xc0
>>>> [   20.032667]  ? die+0x2f/0x50
>>>> [   20.032670]  ? exc_double_fault+0xbf/0xd0
>>>> [   20.032674]  ? asm_exc_double_fault+0x23/0x30
>>>> [   20.032678]  ? restore_regs_and_return_to_kernel+0x1b/0x1b
>>>> [   20.032681]  ? asm_exc_page_fault+0xd/0x30
>>>> [   20.032684]  ? error_entry+0x17/0x140
>>>> [   20.032687]  </#DF>
>>>>
>>>> The private stack for cpu 0:
>>>>      priv_stack_ptr cpu 0 = [ffffe8ffff434000, ffffe8ffff438000] (total 16KB)
>>>> That is, the top stack is ffffe8ffff438000 and the bottom stack is ffffe8ffff434000.
>>>>
>>>> During bpf execution, a softirq may happen, at that point,
>>>> stack pointer becomes:
>>>>       RSP: 0018:ffffe8ffff400000 (see above)
>>>> and there is a read/write (mostly write) to address
>>>>       CR2: ffffe8ffff3ffff8
>>>> And this may cause a fault.
>>>> After this fault, there are some further access and probably because
>>>> of invalid stack, double fault happens.
>>>>
>>>> So the quesiton is why RSP is reset to ffffe8ffff400000?
>>> 0x38000 bytes consumed by stack or rounded down?
>>> That's unlikely.
>>>
>>>> I have not figured out which code changed this? Maybe somebody can help?
>>> As Kumar said earlier pls share the patch. Link to github? or whichever.
>>>
>>> Double check that any kind of tail-call logic is not mixed with priv stack.
>> Here is the reproducer. Two attached files:
>> priv_stack.config: the config file to build the kernel
>> 0001-bpf-implement-private-stack.patch: the patch to apply to the top of bpf-next.
>>
>> The top bpf-next commit in my test:
>> commit 9502a7de5a61bec3bda841a830560c5d6d40ecac (origin/master, origin/HEAD, master)
>> Author: Mykyta Yatsenko <yatsenko@meta.com>
>> Date:   Tue Oct 1 00:15:22 2024 +0100
>>
>>       selftests/bpf: Emit top frequent code lines in veristat
>>
>>
>> I am using clang18 to build the kernel and selftests.
>> The build command line:
>>     make LLVM=1 -j
>>     make -C tools/testing/selftests/bpf LLVM=1 -j
>>
>> In qemu vm, tools/testing/selftests/bpf directory, run the following script:
>>
>> $ cat run.sh
>> cat /proc/sys/net/core/bpf_jit_limit
>> echo 796917760 > /proc/sys/net/core/bpf_jit_limit
>> # ./test_progs -n 339/4
>> ./test_progs -t task_local_storage/nodeadlock
>>
>> With private stack on by default, in my environment, booting will failure.
>> So by default, private stack is off.
>> In the above
>>     echo 796917760 > /proc/sys/net/core/bpf_jit_limit
>> intends to enable private stack.
> well, the patch is written in a way that
>    cat /proc/sys/net/core/bpf_jit_limit
> is enough to enable priv stack.
Ok. Good to know.

>
>> +       if (yhs && !is_subprog && !tail_call_reachable && bpf_prog->aux->priv_stack_ptr) {
>> +               EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8) + 16);
> this part is unnecessary.
> Just setting rsp to the top is enough to start doing things

This is a hack. I run out of ideas so added some hack above for debugging purpose.


> in a new stack, but I'm afraid this is a dead end.
> I've played with orc and frame pointer unwders.
> Both are not happy with our hack.
> get_stack_info() returns unknown, so any logic that needs to collect
> the stack gets into the loop that exhausts our broken stack and
> it eventually dies with NULL deref or double fault.
> The simplest way to repro the brokeness is with:
>
> @@ -255,6 +255,8 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *,
> map, struct task_struct *,
>          if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
>                  return (unsigned long)NULL;
>
> +       dump_stack();

Indeed this won't work and the stack trace cannot be properly
presented due to private stack range is outside the default
kernel range.

Without dump_stack(), there are some other unknown errors.

> +       return 0;
>
> (in addition to your patch that calls it from
> task_local_storage/nodeadlock test).
> It will loop like:
> [   17.708612] bad stack ffffe8fffd620000
> [   17.714759] CPU: 0 UID: 0 PID: 2186 Comm: test_progs Not tainted
> 6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
> [   17.715692] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   17.715692] Call Trace:
> [   17.715692] bad stack ffffe8fffd620000
> [   17.721814] CPU: 0 UID: 0 PID: 2182 Comm: test_progs Not tainted
> 6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
> [   17.722763] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   17.722763] Call Trace:
> [   17.722763] bad stack ffffe8fffd620000
> [   17.728865] CPU: 0 UID: 0 PID: 2156 Comm: test_progs Not tainted
> 6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
> [   17.729826] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>
> To make it less broken it requires a bunch of work in
> arch/x86/kernel/dumpstack.c
> I tried to hack things up, but wasn't successful.
> Even if we do succeed eventually this is too risky.
> We don't have a strong reason to introduce another stack type
> along with all the delicate logic to recognize it based on rsp
> value alone. If our percpu stack is per prog the get_stack_info()
> logic gets complicated and that's not acceptable.
> We need to scrap this idea.
> Let's go back to push/pop r11 around calls :(

