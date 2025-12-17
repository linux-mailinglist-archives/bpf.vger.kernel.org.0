Return-Path: <bpf+bounces-76894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0DACC9485
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3159A304B009
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B22836BE;
	Wed, 17 Dec 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oV1hdoNW"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7F280A29
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995851; cv=none; b=dTyDL3LbDZ68gtKxbjYmjfWoGvJbvOj172ICiSET9NKN95fnMiJyHdRIT0TPeK03Khnqw9bMRTx6aM+f/9Gau8xgh/6gDQeeUmLXMyLg+Zqp/ohvYU4VA/TQqo9KelmaNY05voW8e8aU8cVrDfRE8W+8w6N46NiIs+BWTfEpsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995851; c=relaxed/simple;
	bh=fov+4ytrQdDmeHy0L9U5EGYYHmLIhjDUjmNzK5vU+ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yqo3jRGZUaXhrLfGl1PjcVfSLwNwuoIiI7Yz2JRpEq6j0JKwGhvhP8WxGiW5w3W4PR9/StUWY/KxSWGslSgbXhQ0+ufuHAxP0EOCcel65o8y9JBrrNke7hhAhNCcWBneOxK0GYWEQMPzujJ0DY7QHrGrWiwW1nv91bbMzjeuOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oV1hdoNW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51466fd3-c837-46a6-af50-28a8336fd8cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765995847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev+GLglo0I9y0Cglcge+QiXghbE/SPBhJSBF3frc4FA=;
	b=oV1hdoNWb8L1eF+62OovjEqJtFSHrow7bmioRSoN4+jr9WCFakAzU7zIrj7cONWHEWYduI
	td5TYT7uIkuQc2njPiSIVqweo3NcRR4G+T7dATl+xRHmibGZniiLkUoAXhdAbvDldBIW28
	yYjoTMXeEWitIoJ75YdztTJ1R4AjLDo=
Date: Wed, 17 Dec 2025 10:23:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, puranjay@kernel.org, bpf@vger.kernel.org
Cc: puranjay12@gmail.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, kernel-team@meta.com, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20251217162830.2597286-3-puranjay@kernel.org>
 <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/17/25 8:56 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 2da986136d26..654fb94bf60c 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> [ ... ]
>
>> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>>
>>   static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
>>   {
>> +#ifdef CONFIG_ARM64
>> +	u8 rctx = interrupt_context_level();
>> +	u8 *active = this_cpu_ptr(prog->active);
>> +
>> +	active[rctx]++;
>> +	barrier();
>> +	if (get_unaligned_le32(active) != BIT(rctx * 8))
>> +		return false;
>> +
>> +	return true;
>> +#else
>>   	return this_cpu_inc_return(*(prog->active)) == 1;
>> +#endif
>>   }
> Can preemption between the increment and check cause a counter leak on
> CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> (documented at include/linux/rcupdate.h:856).
>
> Consider this scenario on an ARM64 system with PREEMPT_RCU:
>
> 1. Thread A increments active[0] to 1
> 2. Preemption occurs before Thread A reaches the check
> 3. Thread B on same CPU increments active[0] to 2
> 4. Thread B checks: sees 2 != BIT(0), returns false
> 5. Thread A resumes, checks: sees 2 != BIT(0), returns false
> 6. Both threads return false, neither runs BPF
> 7. Neither calls bpf_prog_put_recursion_context() (see
>     __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> 8. Counter permanently stuck at 2, all future BPF on this CPU fails
>
> The old atomic code handled this correctly because this_cpu_inc_return()
> completes atomically, ensuring Thread A reads the value 1 before Thread B
> can interfere. With non-atomic operations, Thread A increments but hasn't
> read the value yet, allowing Thread B to interfere and cause both threads
> to see the modified value.
>
> Is there a guarantee that same-context preemption cannot occur in the BPF
> execution path on ARM64, or does this need additional synchronization?

AI is correct here. See below for another thread:
   https://lore.kernel.org/bpf/20251217093326.1745307-1-chen.dylane@linux.dev/T/#m906fd4502fbbedd4609c586122a393363003312a
where preempt_disable is necessary to prevent the above scenario.

But adding preempt_disable may impact the overall system-level performance.

Does this patch can improve performance for *all* ARM64 cpu versions?
Do you have numbers to show how much performance improvement?

>
>> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>>
>>   static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
>>   {
>> +#ifdef CONFIG_ARM64
>> +	u8 rctx = interrupt_context_level();
>> +	u8 *active = this_cpu_ptr(prog->active);
>> +
>> +	barrier();
>> +	active[rctx]--;
>> +#else
>>   	this_cpu_dec(*(prog->active));
>> +#endif
>>   }
[...]

