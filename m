Return-Path: <bpf+bounces-77345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81569CD83FF
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82003016724
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED33009C7;
	Tue, 23 Dec 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLzRWiM/"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3F1DA60D
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471360; cv=none; b=pyMhTFgU9hmsXe9pSUEYLlihDOniLpnXqKNUkH+w/O830WhvZQDzxYTLJFf4xxxC9W9TU2Qqw+ek/J8SMdEMEfka2oBKWwkrH/VSS+ujqv6lAIDJ30Ndv+an+xAkUUP3B/+zk4ufhsmHmtdMJl+403B9jb2j+Qg2vqcLOfJkR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471360; c=relaxed/simple;
	bh=qORk4yp2evfGOATcTKdgCQ313S7aRANC62giFfsLgNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACsOnGMN7EWAytAgBassXjfsHutHFYKHOmZmgizK60+E9YdvuhuR/JjfY0WsgFJ5e88d9VRaW067oMMAzfXQ96dXqSF5bULfNo4qdaqDEiygMXDGW3xKqDEDQbaIPKPBrZmfWG17hLVkBw3VxJLnoDAiMMhn6Hw8VMpxKzTDr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLzRWiM/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db97ccea-8cb4-40ea-b040-79f0f63a398e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766471356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJTQ2ReNoo6Q4R+IKYXTKJ87V/9b3dLaaA5dLOP+k0Q=;
	b=wLzRWiM/N4A1E1UXIolnMYZ/kUILb4ovDfFGGVZ4to98nPZIOs2Y2sPxuoD01nwLXqREGc
	GvvlvjPk73zQDhHEKkzo2+bvuQzIPZfHkXiu5TQk5OwI5jBJu3o54wrQqAMMGXnemMd0Ih
	0EZ7m2pJH9WuDzuf/sbsjUjvutPJgfA=
Date: Tue, 23 Dec 2025 14:29:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
 <20251217093326.1745307-3-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20251217093326.1745307-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/17 17:33, Tao Chen 写道:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
> 
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
> 
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c1..3bdd99a630d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   }
>   
>   static struct perf_callchain_entry *
> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 max_depth)
>   {
>   #ifdef CONFIG_STACKTRACE
>   	struct perf_callchain_entry *entry;
> -	int rctx;
>   
> -	entry = get_callchain_entry(&rctx);
> +	preempt_disable();
> +	entry = get_callchain_entry(rctx);
> +	preempt_enable();
>   
>   	if (!entry)
>   		return NULL;
> @@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   			to[i] = (u64)(from[i]);
>   	}
>   
> -	put_callchain_entry(rctx);
> -
>   	return entry;
>   #else /* CONFIG_STACKTRACE */
>   	return NULL;
> @@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   	return id;
>   }
>   
> +static struct perf_callchain_entry *
> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, bool user,
> +		       int max_stack, bool crosstask)
> +{
> +	struct perf_callchain_entry_ctx ctx;
> +	struct perf_callchain_entry *entry;
> +
> +	preempt_disable();
> +	entry = get_callchain_entry(rctx);
> +	preempt_enable();
> +
> +	if (unlikely(!entry))
> +		return NULL;
> +
> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, false);
> +	if (kernel)
> +		__get_perf_callchain_kernel(&ctx, regs);
> +	if (user && !crosstask)
> +		__get_perf_callchain_user(&ctx, regs, 0);
> +
> +	return entry;
> +}
> +
> +static void bpf_put_perf_callchain(int rctx)
> +{
> +	put_callchain_entry(rctx);
> +}
> +
>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	   u64, flags)
>   {
> @@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	struct perf_callchain_entry *trace;
>   	bool kernel = !user;
>   	u32 max_depth;
> +	int rctx, ret;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>   		return -EINVAL;
>   
>   	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> -	trace = get_perf_callchain(regs, kernel, user, max_depth,
> -				   false, false, 0);
> +
> +	trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
> +				       false);
>   
>   	if (unlikely(!trace))
>   		/* couldn't fetch the stack trace */
>   		return -EFAULT;
>   
> -	return __bpf_get_stackid(map, trace, flags);
> +	ret = __bpf_get_stackid(map, trace, flags);
> +	bpf_put_perf_callchain(rctx);
> +
> +	return ret;
>   }
>   
>   const struct bpf_func_proto bpf_get_stackid_proto = {
> @@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	bool kernel = !user;
>   	int err = -EINVAL;
>   	u64 *ips;
> +	int rctx;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_USER_BUILD_ID)))
> @@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		trace = trace_in;
>   		trace->nr = min_t(u32, trace->nr, max_depth);
>   	} else if (kernel && task) {
> -		trace = get_callchain_entry_for_task(task, max_depth);
> +		trace = get_callchain_entry_for_task(&rctx, task, max_depth);
>   	} else {
> -		trace = get_perf_callchain(regs, kernel, user, max_depth,
> -					   crosstask, false, 0);
> +		trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
> +					       crosstask);
>   	}
>   
> -	if (unlikely(!trace) || trace->nr < skip) {
> +	if (unlikely(!trace)) {
>   		if (may_fault)
>   			rcu_read_unlock();
>   		goto err_fault;
>   	}
>   
> +	if (trace->nr < skip) {
> +		if (may_fault)
> +			rcu_read_unlock();
> +		if (!trace_in)
> +			bpf_put_perf_callchain(rctx);
> +		goto err_fault;
> +	}
> +
>   	trace_nr = trace->nr - skip;
>   	copy_len = trace_nr * elem_size;
>   
> @@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	if (may_fault)
>   		rcu_read_unlock();
>   
> +	if (!trace_in)
> +		bpf_put_perf_callchain(rctx);
> +
>   	if (user_build_id)
>   		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>   

Hi Peter,

As Alexei said, the patch needs your ack, please review again, thanks.

-- 
Best Regards
Tao Chen

