Return-Path: <bpf+bounces-40741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A046898CD59
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8628617C
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72F839EB;
	Wed,  2 Oct 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Si0ettZm"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEC433A9
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851746; cv=none; b=kjJBM5T3NDEk+dDfKkHViuJMDm74NiOizKKKAo2uIGs5ECBZr7RJtHBoIyqGKvUUYB59mS9kNTCDH99O2c/sk9Tz+FULe2aSPyZwjIb26DaB8HHZ7bEmi1n3XfRSg1XzBOTsbpKmyla7QLP9VH2RwIF1ZBlHJgUO0WBk+qg4D4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851746; c=relaxed/simple;
	bh=bs0V9niQEq/DX4u6e6/Qdtb3UpO/5LkeAMb2zRWAhBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GJJPV4Ip4QBWzFY4/kmaduYOVwOc5RqvV+3Knikp0s6uKBsB9IuzFhD0rthkwZ6p5Ppv7hWj901MLvSMaCAsY9VQNhYobC+s00CdfVYA9LWtipYJcnO7N97cl4PXQ2r3A8bM5gY2Mk2IFN7fb/YV7ni87gkApApKIyPPkvkr8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Si0ettZm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6366e7d3-f81b-4837-b105-bced5217c95f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727851739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEdraAmQF9/P0QqnWL33aNgCzRj89B2W2T+RbBTzf6U=;
	b=Si0ettZmjPEgI3XKYPOIAAm3a207yuRxXyPgJmT399wQwD0pe4wAlWfPy6dhEfXdeNoSFM
	2v3b2KDqqfdRDmZWhVcY2MtcnLFuBjFX1QLfmh7S0rMpJoxN5/9/mZxDdUdt36sHr1qFUl
	9SCyH/7jif38VtSHe61Mm+tn+TuYNes=
Date: Tue, 1 Oct 2024 23:48:51 -0700
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
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <CAP01T75JUvKUJH4OKDOSySQcK5xP0nFs48FbW_dqMzeo9DhQOw@mail.gmail.com>
 <a1686631-3c65-4ed0-bdb6-90fa1f0c6242@linux.dev>
In-Reply-To: <a1686631-3c65-4ed0-bdb6-90fa1f0c6242@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/1/24 11:28 PM, Yonghong Song wrote:
>
> On 10/1/24 7:16 PM, Kumar Kartikeya Dwivedi wrote:
>> On Wed, 2 Oct 2024 at 03:26, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Tue, Oct 1, 2024 at 5:23 PM Kumar Kartikeya Dwivedi 
>>> <memxor@gmail.com> wrote:
>>>> Makes sense, though will we have cases where hierarchical scheduling
>>>> attaches the same prog at different points of the hierarchy?
>>> I'm not sure anyone was asking for such a use case.
>> I wondered because why would you then need a limit of 4 (say instead
>> of disallowing it)?
>>
>>>> Then the
>>>> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
>>> Well, 4 was the number from TJ.
>>>
>> Ok, then let's assume 4 would be enough.
>>
>>> Anyway the proposed pseudo code:
>>>
>>> __bpf_prog_enter_recur_limited()
>>> {
>>>    cnt = this_cpu_inc_return(*(prog->active));
>>>    if (cnt > 4) {
>>>       inc_miss
>>>       return 0;
>>>    }
>>>   // pass cnt into bpf prog somehow, like %rdx ?
>>>   // or re-read prog->active from prog
>>> }
>>>
>>>
>>> then in the prologue emit:
>>>
>>> push rbp
>>> mov rbp, rsp
>>> if %rdx == 1
>>>     // main prog is called for the first time
>>>     mov rsp, pcpu_priv_stack_top
>
> This sounds good in high level. I still need to figure out
> 'if %rdx == 1' part and how to implement this.

Okay, looks like trampoline could supply rdx == 1.

>
>>> else
>>>     // 2+nd time main prog is called or 1+ time subprog
>>>    sub rsp, stack_size
>>>    if rsp < pcpu_priv_stack_bottom
>>>      goto exit  // stack is too small, exit
>>> fi
>> I think we need just the second part for subprogs, right?
>> Since rdx is R3 (arg into subprog).
>> I guess that's what you meant in the pseudocode.
>> But otherwise sounds good.
>> The benefit with stack probing is we don't exactly limit to 4 cases.
>>
>> Another option instead of the branch in main prog is to divide in 4
>> slots (as you said before) and choose the slot based on cnt.
>> But then we're stuck with a max limit of 4. Since we're allocating
>> stack size of bpf + extra (which I guess is 8K?). rdx can be used to
>> pass in the priv_stack address of the right slot.
>>
>> So I think the probing version seems better. We can probably pass in
>> rdx = priv_stack and then test and cmov instead for main prog.
>
> Yes, we do not need to limit to 4, checking rsp < pcpu_priv_stack_bottom
> should be okay.
>
>>
>>> Since stack bottom/top are known at JIT time we can
>>> generate reliable stack overflow checks.
>>> Much better than guard pages and -fstack-protector.
>>> The prog can alloc percpu
>>> (stack size of main prog + subprogs + extra) * 4
>> extra will be 8K, I guess (same as kernel stack size)?
>> Just confirming.
>>
>>> and it likely will be enough.
>>> If not, the stack protection will gently exit the prog
>>> when the stack is too deep.
>> I like this stack probing version, since there's no hard limit on the
>> number of recursions, and it's safe against stack overflow as well.
>>
>>> kfunc won't have such a check, so we need a buffer zone.
>>> Can have a guard page too, but feels like overkill.
>> I was leaning toward saying yes for a guard page, since we'll atleast
>> have a hard error instead of random corruption if the kfunc goes
>> beyond the bottom after probing succeeds.
>>
>> But the better way might be doing if rsp < pcpu_priv_stack_bottom +
>> 8K, so we leave max headroom we reserve for kernel stuff (or say add
>> 4K instead, which should be good enough), and then skip execution.
>

