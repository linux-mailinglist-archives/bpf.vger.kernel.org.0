Return-Path: <bpf+bounces-76911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0CCC96FA
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D3E304A8D2
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EC2ECE86;
	Wed, 17 Dec 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUG314Pw"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0022B8B6
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000735; cv=none; b=MIZIH7qe1GOuH43CHgpBLDGrBRLd53l5ynyh6XhGBhZwvBJWrRJYXKlqTA8ngYS/mTUEJCWXE/EPbx3ovJu0uCswbCjU+HV9xUHuRLyygKU1AXeBkMZ+4OTtp6faMTPwLUwVc1pVadoGl4L90jTSnFxpUT03TxElBCCcz+nqBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000735; c=relaxed/simple;
	bh=I2eef3syObG7yF5V5IDthxx8Dn305KIRQ27o0gWXdpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6G5UEmSu5BGfuuZ/wC587nzVoHvAZw7SY2skhJ+ULMNVclxMq/7pIOtCqAFqhm5qmQ+KqtO1xR8wVp3PFYc6n/7ABbFDGM1JHEqce4vqtSNaOloKHAJlye/c+WlViDwFxjiCsy0NG89R1YNRHvkMmEUmlMg589Cb1lR/nE9cCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUG314Pw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26a8d10a-eede-4ebc-b51a-5c08ea02dda5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766000723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjGwRrRHeV9FhtskgH+muWu/+jggYeeNnurTJDnS9vg=;
	b=qUG314PwFgg2RdQNIFrCrdHqgfehWDIyEoqPBZ84evg+L/OJiFbWYwFwhXEOPtv40iv40j
	rscC47bEdPu78Yi6I8Mvvpx+pxe/Q+Xg4pSaTBWplNAmgnf+ZB/ZgfWjWn2UA63TvQUHXk
	oYX2AX4Xso4Wx/WXzA77PL1pL+GNrrM=
Date: Wed, 17 Dec 2025 11:45:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20251217162830.2597286-3-puranjay@kernel.org>
 <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <51466fd3-c837-46a6-af50-28a8336fd8cd@linux.dev>
 <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/17/25 10:44 AM, Puranjay Mohan wrote:
> On Wed, Dec 17, 2025 at 6:24 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 12/17/25 8:56 AM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 2da986136d26..654fb94bf60c 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>> [ ... ]
>>>
>>>> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>>>>
>>>>    static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
>>>>    {
>>>> +#ifdef CONFIG_ARM64
>>>> +    u8 rctx = interrupt_context_level();
>>>> +    u8 *active = this_cpu_ptr(prog->active);
>>>> +
>>>> +    active[rctx]++;
>>>> +    barrier();
>>>> +    if (get_unaligned_le32(active) != BIT(rctx * 8))
>>>> +            return false;
>>>> +
>>>> +    return true;
>>>> +#else
>>>>       return this_cpu_inc_return(*(prog->active)) == 1;
>>>> +#endif
>>>>    }
>>> Can preemption between the increment and check cause a counter leak on
>>> CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
>>> rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
>>> (documented at include/linux/rcupdate.h:856).
>>>
>>> Consider this scenario on an ARM64 system with PREEMPT_RCU:
>>>
>>> 1. Thread A increments active[0] to 1
>>> 2. Preemption occurs before Thread A reaches the check
>>> 3. Thread B on same CPU increments active[0] to 2
>>> 4. Thread B checks: sees 2 != BIT(0), returns false
>>> 5. Thread A resumes, checks: sees 2 != BIT(0), returns false
>>> 6. Both threads return false, neither runs BPF
>>> 7. Neither calls bpf_prog_put_recursion_context() (see
>>>      __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
>>> 8. Counter permanently stuck at 2, all future BPF on this CPU fails
>>>
>>> The old atomic code handled this correctly because this_cpu_inc_return()
>>> completes atomically, ensuring Thread A reads the value 1 before Thread B
>>> can interfere. With non-atomic operations, Thread A increments but hasn't
>>> read the value yet, allowing Thread B to interfere and cause both threads
>>> to see the modified value.
>>>
>>> Is there a guarantee that same-context preemption cannot occur in the BPF
>>> execution path on ARM64, or does this need additional synchronization?
>> AI is correct here. See below for another thread:
>>     https://lore.kernel.org/bpf/20251217093326.1745307-1-chen.dylane@linux.dev/T/#m906fd4502fbbedd4609c586122a393363003312a
>> where preempt_disable is necessary to prevent the above scenario.
> See my other reply, the above scenario presented by AI is wrong
> because step 7 is wrong.

Thanks for explanation. I missed the case that bpf_trampoline_exit()
is always executed. In such cases, the active[rctx] counter will be
always corrected.

>
>> But adding preempt_disable may impact the overall system-level performance.
>>
>> Does this patch can improve performance for *all* ARM64 cpu versions?
>> Do you have numbers to show how much performance improvement?
> This should improve performance on all arm64 CPUs because atomics are
> expensive because they are atomic across all cpus.

Good to know. Thanks!

>
> I see a 33% improvement in the fentry trigger benchmark, but I can do
> more benchmarking.
>
>>>> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>>>>
>>>>    static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
>>>>    {
>>>> +#ifdef CONFIG_ARM64
>>>> +    u8 rctx = interrupt_context_level();
>>>> +    u8 *active = this_cpu_ptr(prog->active);
>>>> +
>>>> +    barrier();
>>>> +    active[rctx]--;
>>>> +#else
>>>>       this_cpu_dec(*(prog->active));
>>>> +#endif
>>>>    }
>> [...]


