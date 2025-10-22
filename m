Return-Path: <bpf+bounces-71753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2FDBFCD2A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3783A1FB9
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A534C12E;
	Wed, 22 Oct 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDv9PvMw"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7734C98A
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146108; cv=none; b=lHChNzv3hthQAN6TTXU9NOpptExr0jUqoK+rAVYhdf7AQPSxX6xsOMbh1lVLBqJYwqrl9I9/o7n0uj0vG7r57OFOd/BONzSrj1qxSfy+IaoxWVqkup3N5qcJTjh6ZAsjJ3WZAU+cC3DlOx8qEQaIv+OlXkfE4GKtxFw93Hhtg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146108; c=relaxed/simple;
	bh=4mblRB768g0mR+5jJ6ggp8VkkejsrNbpM/I/hxaLvgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sT3BuMTNyPppBgRqC6YO2PVzXHh1Af20Uz11yoq2YJbb+C57vqFIkfZnieJgjjEHZfEyMPCC5QxSYnaWbAZTOqlJVdABLO8VCXiVUIwCXdymHigp17396wU1eODYDmZtTzLZf3H+16MksJcp8iv/TAfPu5Cxfghe+uxwtDG6s5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDv9PvMw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <947b1121-ddfc-4f49-825d-103699b62d0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761146101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPD7KYgHjZ2Kx2EBhuhfRI/lFZmifGXs9ZgWPA9xXqg=;
	b=gDv9PvMwi7yFV5RizFwxLazuRUHH3JAn2AKGNIfPpXeMPmJmGEaUAgN4Ns2irU/AQMwql+
	AcxaIN3Jh4BpVJWspOqCcRpLJjth8UmNYw1q1uN+iFQoCvEshG5BYuyFS7xMdtaieY32/Y
	Wr3OEOsJJ8w4GhFNCE7pHbAqFab3CwE=
Date: Wed, 22 Oct 2025 23:14:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] perf: Use extern perf_callchain_entry for
 get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
 <20251019170118.2955346-2-chen.dylane@linux.dev>
 <20251020114040.GT3419281@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20251020114040.GT3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/20 19:40, Peter Zijlstra 写道:

Hi, Peter

> On Mon, Oct 20, 2025 at 01:01:17AM +0800, Tao Chen wrote:
>>  From bpf stack map, we want to use our own buffers to avoid unnecessary
>> copy, so let us pass it directly. BPF will use this in the next patch.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
> 
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 808c0d7a31f..851e8f9d026 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
>> @@ -217,8 +217,8 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
>>   }
>>   
>>   struct perf_callchain_entry *
>> -get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -		   u32 max_stack, bool crosstask, bool add_mark)
>> +get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
>> +		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark)
>>   {
>>   	struct perf_callchain_entry *entry;
>>   	struct perf_callchain_entry_ctx ctx;
>> @@ -228,7 +228,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>   	if (crosstask && user && !kernel)
>>   		return NULL;
>>   
>> -	entry = get_callchain_entry(&rctx);
>> +	if (external_entry)
>> +		entry = external_entry;
>> +	else
>> +		entry = get_callchain_entry(&rctx);
>> +
>>   	if (!entry)
>>   		return NULL;
>>   
>> @@ -260,7 +264,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>   	}
>>   
>>   exit_put:
>> -	put_callchain_entry(rctx);
>> +	if (!external_entry)
>> +		put_callchain_entry(rctx);
>>   
>>   	return entry;
>>   }
> 
> Urgh.. How about something like the below, and then you fix up
> __bpf_get_stack() a little like this:
> 

Your solution seems to be more scalable, i will develop based on 
yours，thanks a lot.

> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4d53cdd1374c..8b85b49cecf7 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -303,8 +303,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	u32 max_depth = map->value_size / stack_map_data_size(map);
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>   	bool user = flags & BPF_F_USER_STACK;
> +	struct perf_callchain_entry_ctx ctx;
>   	struct perf_callchain_entry *trace;
> -	bool kernel = !user;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> @@ -314,8 +314,13 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	if (max_depth > sysctl_perf_event_max_stack)
>   		max_depth = sysctl_perf_event_max_stack;
>   
> -	trace = get_perf_callchain(regs, kernel, user, max_depth,
> -				   false, false);
> +	trace = your-stuff;
> +
> +	__init_perf_callchain_ctx(&ctx, trace, max_depth, false);
> +	if (!user)
> +		__get_perf_callchain_kernel(&ctx, regs);
> +	else
> +		__get_perf_callchain_user(&ctx, regs);
>   
>   	if (unlikely(!trace))
>   		/* couldn't fetch the stack trace */
> 
> 
> 
> ---
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fd1d91017b99..14a382cad1dd 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>   	u32				nr;
>   	short				contexts;
>   	bool				contexts_maxed;
> +	bool				add_mark;
>   };
>   
>   typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
> @@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>   
>   extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>   extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
> +
> +extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
> +				      struct perf_callchain_entry *entry,
> +				      u32 max_stack, bool add_mark);
> +
> +extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
> +extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
> +
>   extern struct perf_callchain_entry *
>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark);
> +		   u32 max_stack, bool crosstask);
>   extern int get_callchain_buffers(int max_stack);
>   extern void put_callchain_buffers(void);
>   extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 808c0d7a31fa..edd76e3bb139 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -216,50 +216,70 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
>   #endif
>   }
>   
> +void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
> +			       struct perf_callchain_entry *entry,
> +			       u32 max_stack, bool add_mark)
> +
> +{
> +	ctx->entry		= entry;
> +	ctx->max_stack		= max_stack;
> +	ctx->nr			= entry->nr = 0;
> +	ctx->contexts		= 0;
> +	ctx->contexts_maxed	= false;
> +	ctx->add_mark		= add_mark;
> +}
> +
> +void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
> +{
> +	if (user_mode(regs))
> +		return;
> +
> +	if (ctx->add_mark)
> +		perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> +	perf_callchain_kernel(ctx, regs);
> +}
> +
> +void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs)
> +{
> +	int start_entry_idx;
> +
> +	if (!user_mode(regs)) {
> +		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> +			return;
> +		regs = task_pt_regs(current);
> +	}
> +
> +	if (ctx->add_mark)
> +		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
> +
> +	start_entry_idx = entry->nr;
> +	perf_callchain_user(ctx, regs);
> +	fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
> +}
> +
>   struct perf_callchain_entry *
>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool crosstask, bool add_mark)
> +		   u32 max_stack, bool crosstask)
>   {
> -	struct perf_callchain_entry *entry;
>   	struct perf_callchain_entry_ctx ctx;
> -	int rctx, start_entry_idx;
> +	struct perf_callchain_entry *entry;
> +	int rctx;
>   
>   	/* crosstask is not supported for user stacks */
>   	if (crosstask && user && !kernel)
>   		return NULL;
>   
> -	entry = get_callchain_entry(&rctx);
> +	entry = get_callchain_entry(&rctx, regs);
>   	if (!entry)
>   		return NULL;
>   
> -	ctx.entry		= entry;
> -	ctx.max_stack		= max_stack;
> -	ctx.nr			= entry->nr = 0;
> -	ctx.contexts		= 0;
> -	ctx.contexts_maxed	= false;
> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);
>   
> -	if (kernel && !user_mode(regs)) {
> -		if (add_mark)
> -			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> -		perf_callchain_kernel(&ctx, regs);
> -	}
> +	if (kernel)
> +		__get_perf_callchain_kernel(&ctx, regs);
> +	if (user && !crosstask)
> +		__get_perf_callchain_user(&ctx, regs);
>   
> -	if (user && !crosstask) {
> -		if (!user_mode(regs)) {
> -			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> -				goto exit_put;
> -			regs = task_pt_regs(current);
> -		}
> -
> -		if (add_mark)
> -			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> -
> -		start_entry_idx = entry->nr;
> -		perf_callchain_user(&ctx, regs);
> -		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
> -	}
> -
> -exit_put:
>   	put_callchain_entry(rctx);
>   
>   	return entry;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 177e57c1a362..cbe073d761a8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>   		return &__empty_callchain;
>   
>   	callchain = get_perf_callchain(regs, kernel, user,
> -				       max_stack, crosstask, true);
> +				       max_stack, crosstask);
>   	return callchain ?: &__empty_callchain;
>   }
>   


-- 
Best Regards
Tao Chen

