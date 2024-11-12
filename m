Return-Path: <bpf+bounces-44679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431299C64E2
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77221F23B59
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1221A71D;
	Tue, 12 Nov 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uadJHWcj"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB61531C4
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452928; cv=none; b=MkPjbGZ9EQfCisV/WSQc3sC6kP7pHzvszjOg3z7lRTAbH95C3lOWBVArGOlyL6b/CM8PbSFah9hnA2ERTcICsgAyTCL0s5vBao6/Njve/P+1mP4u0FItCVrzwbDp6fn+DITnkMQ++BnWtqeiHFfIdbf/X+00voqV+9PKQYSWPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452928; c=relaxed/simple;
	bh=PyPZdGqRb4qndSD6DQGdfvkAm+KTIbNw5CauytuG1yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8F1cpEZOWNqNFiJw7Q4gu1TRl4ihcv4+PqRplOu1ep1L44KKRXa6uiy/HwFG3pHToM60gcgVIhnwBz8rJcpzvFM+ZukfG8j441rpCCRfKGHNpZa3RUmz4/OzKvtZQTexRiquhimdoBCY7aI8V4SeQqd8Xdj+pWS2wPqKdwRzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uadJHWcj; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee3362bd-316e-47e5-83d9-8e00651c122a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731452924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fWYwA60GJ0ErbHibqk6QNFiJloMM9pyZR1q3j9lEZU=;
	b=uadJHWcjMU6nBgvxbEnwg8FLNzt9laA77lP6k8//g5777Tq93AqeTllQS7uHHPt7l+95zg
	oV9sZUEkE2pWhVyBR4Mt99DpcmFMg4Wfw1kwkdbvVvzOAuOKCVUcX79piciwjGLHUTqSIT
	OqYbSWlONtV1iK17YVSPmyIBUzRBksg=
Date: Tue, 12 Nov 2024 23:08:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, X86 ML <x86@kernel.org>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
 <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
 <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev>
 <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
 <4d2ee96cc12bf4bd84aa3e9716ce84793800f2f6.camel@gmail.com>
 <CAADnVQ+bYuda8bWtY9vtxh9WGUOBz+5hvS6V9X00i5gtHhLt1Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQ+bYuda8bWtY9vtxh9WGUOBz+5hvS6V9X00i5gtHhLt1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 22:27, Alexei Starovoitov wrote:
> On Tue, Nov 12, 2024 at 2:20 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Tue, 2024-11-12 at 13:53 -0800, Eduard Zingerman wrote:
>>> On Tue, 2024-11-12 at 21:39 +0000, Vadim Fedorenko wrote:
>>>
>>> [...]
>>>
>>>>>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>>>>> +                           imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>>>>> +                               /* Save RDX because RDTSC will use EDX:EAX to return u64 */
>>>>>> +                               emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>>>>>> +                               if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>>>>>> +                                       EMIT_LFENCE();
>>>>>> +                               EMIT2(0x0F, 0x31);
>>>>>> +
>>>>>> +                               /* shl RDX, 32 */
>>>>>> +                               maybe_emit_1mod(&prog, BPF_REG_3, true);
>>>>>> +                               EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>>>>>> +                               /* or RAX, RDX */
>>>>>> +                               maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>>>>>> +                               EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>>>>>> +                               /* restore RDX from R11 */
>>>>>> +                               emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
>>>>>
>>>>> Note: The default implementation of this kfunc uses __arch_get_hw_counter(),
>>>>>         which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
>>>>>         Here we don't do `& S64_MAX`.
>>>>>         The masking in __arch_get_hw_counter() was added by this commit:
>>>>>         77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
>>>>
>>>> I think we already discussed it with Alexey in v1, we don't really need
>>>> any masking here for BPF case. We can use values provided by CPU
>>>> directly. It will never happen that within one BPF program we will have
>>>> inlined and non-inlined implementation of this helper, hence the values
>>>> to compare will be of the same source.
>>>>
>>>>>         Also, the default implementation does not issue `lfence`.
>>>>>         Not sure if this makes any real-world difference.
>>>>
>>>> Well, it actually does. rdtsc_ordered is translated into `lfence; rdtsc`
>>>> or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the cpu
>>>> features.
>>>
>>> I see the following disassembly:
>>>
>>> 0000000000008980 <bpf_get_cpu_cycles>:
>>> ; {
>>>      8980: f3 0f 1e fa                   endbr64
>>>      8984: e8 00 00 00 00                callq   0x8989 <bpf_get_cpu_cycles+0x9>
>>>                  0000000000008985:  R_X86_64_PLT32       __fentry__-0x4
>>> ;       asm volatile(ALTERNATIVE_2("rdtsc",
>>>      8989: 0f 31                         rdtsc
>>>      898b: 90                            nop
>>>      898c: 90                            nop
>>>      898d: 90                            nop
>>> ;       return EAX_EDX_VAL(val, low, high);
>>>      898e: 48 c1 e2 20                   shlq    $0x20, %rdx
>>>      8992: 48 09 d0                      orq     %rdx, %rax
>>>      8995: 48 b9 ff ff ff ff ff ff ff 7f movabsq $0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
>>> ;               return (u64)rdtsc_ordered() & S64_MAX;
>>>      899f: 48 21 c8                      andq    %rcx, %rax
>>> ;       return __arch_get_hw_counter(1, NULL);
>>>      89a2: 2e e9 00 00 00 00             jmp     0x89a8 <bpf_get_cpu_cycles+0x28>
>>>
>>> Is it patched when kernel is loaded to replace nops with lfence?
>>> By real-world difference I meant difference between default
>>> implementation and inlined assembly.
>>
>> Talked with Vadim off-list, he explained that 'rttsc nop nop nop' is
>> indeed patched at kernel load. Regarding S64_MAX patching we just hope
>> this should never be an issue for BPF use-case.
>> So, no more questions from my side.
> 
> since s64 question came up twice it should be a comment.

sure, will do it.

> 
> nop nop as well.

do you mean why there are nop;nop instructions in the kernel's assembly?

> 
> pw-bot: cr


