Return-Path: <bpf+bounces-72963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CEBC1E240
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 03:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC8C3A5400
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEEC32ABC4;
	Thu, 30 Oct 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X9QtkD2P"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A990126BF1;
	Thu, 30 Oct 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791856; cv=none; b=kgjPqIglyym4WCVGlR+LQvQVCjldyIFPBXwgGsOX8uBGwmcx6pra3PhCUKJ/9T83E+1vKMRxf2/bAVp/QSt0JwWN780W/I1ynvd+cSqISpXPeRhzkmg/t/gMLQtFyJp+hHQ08oWIR6cDyYoZIk3FjbEAw8RexStW0d2YIbxJGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791856; c=relaxed/simple;
	bh=oC9Ig42hWklRcp3NJPqZXoxu09JQxObjX3p/oUGkPV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyuh93Fxr0Li7fP/FtWaWSJJsdUxFsy/BeWUmqyaxd+R3KnBLCKq+iASTgPAzFAuXaYuNRJ+VjZNk1JHN5DRbPOeybRiuyGspSEqUodAMbSLrrPBx4O7/dfQdovNEy/lEfsK08BDayYSa1SBP6buGv2QfYTkZx8UWcLIiUS1/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9QtkD2P; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2dbebe3a-5b96-4076-a3e3-00ae8de990d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLvjLcI/0DbJGC9Bc0bi6CFAYKKHC4jWpCjENERXsTk=;
	b=X9QtkD2Pe4Zq+yV7u5SP7kxWg9suXEIuWSxXX/Cqm88rD33ASllGFv4Irl77jhnU4j7jGu
	/2mgDdOxQq8KhUF/nWoWrTT7jCbQiOhOZzZ4Y8h1piJo/BSJ5MC8/ioiIxOBeqteaoV3md
	mo5DVcWFR08U4A66r1UUeE0wG1G8tRc=
Date: Thu, 30 Oct 2025 10:36:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] perf: Refactor get_perf_callchain
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20251028162502.3418817-2-chen.dylane@linux.dev>
 <a48e281e6912037490270da40f79e45c1ad1e430c8c1cc84c48306106b06113a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <a48e281e6912037490270da40f79e45c1ad1e430c8c1cc84c48306106b06113a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/29 01:09, bot+bpf-ci@kernel.org 写道:
> 
> ```
> commit 59cfc61f83ad4ec998f4242ca000c554e3001b47
> Author: Tao Chen <chen.dylane@linux.dev>
> 
> perf: Refactor get_perf_callchain
> 
> This patch refactors get_perf_callchain() by extracting logic into new
> helper functions to provide more flexible stack-sampling APIs for BPF.
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index fd1d91017..14a382cad 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>>   	u32				nr;
>>   	short				contexts;
>>   	bool				contexts_maxed;
>> +	bool				add_mark;
>>   };
> 
> [ ... ]
> 
>> @@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>>
>>   extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>>   extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>> +
>> +extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
>> +				      struct perf_callchain_entry *entry,
>> +				      u32 max_stack, bool add_mark);
>> +
>> +extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
>> +extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
>> +
>>   extern struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -		   u32 max_stack, bool crosstask, bool add_mark);
>> +		   u32 max_stack, bool crosstask);
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4d53cdd13..e28b35c7e 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>   		max_depth = sysctl_perf_event_max_stack;
>>
>>   	trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -				   false, false);
>> +				   false);
>                                         ^^^^^ removed last parameter
> 
> Previously bpf_get_stackid() passed add_mark=false to get_perf_callchain().
> Now the parameter is gone, but get_perf_callchain() hardcodes add_mark=true
> when calling __init_perf_callchain_ctx(). This means BPF stack traces will
> now include PERF_CONTEXT_KERNEL/PERF_CONTEXT_USER marker values when they
> didn't before.
> 

The entire modification involves changes to two subsystems. To make the 
review easier, the get_perf_callchain has been simply adapted here. In 
the next patch, BPF will no longer use get_perf_callchain, and add_mark 
will be set to false.

> The markers get added by __get_perf_callchain_kernel() and
> __get_perf_callchain_user() when ctx->add_mark is true. These markers are
> sentinel values (-128 for KERNEL, -512 for USER) that appear in the trace
> IP array alongside actual instruction pointers.
> 
>>
>>   	if (unlikely(!trace))
>>   		/* couldn't fetch the stack trace */
>> @@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>   		trace = get_callchain_entry_for_task(task, max_depth);
>>   	else
>>   		trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -					   crosstask, false);
>> +					   crosstask);
>                                                     ^^^^^ same issue here
> 
> Same problem in __bpf_get_stack() which was also passing add_mark=false.
> 
> This changes BPF stack map behavior in user-visible ways:
> 
> 1) bpf_get_stackid() hashes the entire trace->ip[] array including any
>     markers, so identical stacks will now produce different stack IDs.
> 
> 2) bpf_get_stack() copies trace->ip[] directly to userspace buffers,
>     so BPF programs will see marker values mixed with instruction pointers.
> 
> Can BPF tools handle these unexpected marker values? The commit message
> says "The next patch will modify the BPF part" but doesn't explain this
> intermediate behavior change.
> 
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 808c0d7a3..2c36e4906 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
> 
> [ ... ]
> 
>>   struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -		   u32 max_stack, bool crosstask, bool add_mark)
>> +		   u32 max_stack, bool crosstask)
>>   {
>>   	struct perf_callchain_entry *entry;
>>   	struct perf_callchain_entry_ctx ctx;
>> -	int rctx, start_entry_idx;
>> +	int rctx;
>>
>>   	/* crosstask is not supported for user stacks */
>>   	if (crosstask && user && !kernel)
>> @@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>   	if (!entry)
>>   		return NULL;
>>
>> -	ctx.entry		= entry;
>> -	ctx.max_stack		= max_stack;
>> -	ctx.nr			= entry->nr = 0;
>> -	ctx.contexts		= 0;
>> -	ctx.contexts_maxed	= false;
>> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);
>                                                                  ^^^^
> Here's where add_mark is hardcoded to true for all callers. The old code
> allowed callers to control this via parameter. BPF was passing false,
> perf_callchain() was passing true. Now both get true unconditionally.
> 
> [ ... ]
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7541f6f85..eb0f11059 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>   		return &__empty_callchain;
>>
>>   	callchain = get_perf_callchain(regs, kernel, user,
>> -				       max_stack, crosstask, true);
>> +				       max_stack, crosstask);
>>   	return callchain ?: &__empty_callchain;
>>   }
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `perf: Refactor get_perf_callchain`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18882141979


-- 
Best Regards
Tao Chen

