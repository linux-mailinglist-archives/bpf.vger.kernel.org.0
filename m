Return-Path: <bpf+bounces-65490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C53AB240D7
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 08:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5922C1668D9
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D902C08A8;
	Wed, 13 Aug 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CNySx9tD"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E32BE640
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064804; cv=none; b=sTRPRr4aaILqAClpT78toSqgEl43WVyq6ftyy2YyPFak7x8IftLu9uYBWHQUWk2PMNMFLw43sjr5casTxkJeStLPQ1prAUPe1RTW8qWXPsp5x4LncSzMfy06Mo8KXvQVd5Yp7BN7Wj7NybDJGy/8j98RzLstd9PebG/qEY5MlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064804; c=relaxed/simple;
	bh=JF9fdZsv+ShJc346su7lt6oncbiLbBV/jASjYgXa4yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/0JN2D+i3YBe787yAcUru2fOjUUAxKutpFjEHsrtKEG5+7rgBBl2JYJV8UiRK5UJrxI69FbUoMpIdzLhPQcUjioxkyV+fjVzx3c2fE8/SpS3ESwkcGsbjy9XLQ+7vaILlA1hzeOq8hjRH7z6T0wRuY2te/ktMRk12huZ5vgg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CNySx9tD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <997d3b8a-4b3a-4720-8fa0-2f91447021bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755064799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv0mZfaoxWs8BQP4Uzbmx4o3hMgWue9gP2n4lIHpA6I=;
	b=CNySx9tD85R6hQwr6H0Ng+Fpr1aZ2L2e4bvv8GG34T1XeUrFHLW1dPqe1qEj6zjuMaokP8
	DrmXZuQWcTWT2X9uL+R3VC4BBVhxjU1/adh9jZdkD3m1KmBi7PScOXiKpiU4Xsaa7CnQWt
	54XK/S5/JG2eo3sWb4DI2xjGD0H2GFM=
Date: Tue, 12 Aug 2025 22:59:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250812193034.18848-1-contact@arnaud-lcm.com>
 <20250812193256.19029-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250812193256.19029-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/12/25 12:32 PM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
>
> Changes in v2:
>   - Fixed max_depth names across get stack id
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/stackmap.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index a267567e36dd..e1ee18cbbbb2 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -246,7 +246,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   }
>   
>   static long __bpf_get_stackid(struct bpf_map *map,
> -			      struct perf_callchain_entry *trace, u64 flags)
> +			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
>   {
>   	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>   	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> @@ -262,6 +262,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   
>   	trace_nr = trace->nr - skip;
>   	trace_len = trace_nr * sizeof(u64);
> +	trace_nr = min(trace_nr, max_depth - skip);
> +
>   	ips = trace->ip + skip;
>   	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>   	id = hash & (smap->n_buckets - 1);
> @@ -321,19 +323,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	   u64, flags)
>   {
> -	u32 max_depth = map->value_size / stack_map_data_size(map);
> -	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 elem_size = stack_map_data_size(map);
>   	bool user = flags & BPF_F_USER_STACK;
>   	struct perf_callchain_entry *trace;
>   	bool kernel = !user;
> +	u32 max_depth;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>   		return -EINVAL;
>   
> -	max_depth += skip;
> -	if (max_depth > sysctl_perf_event_max_stack)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>   
>   	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>   				   false, false);
> @@ -342,7 +342,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   		/* couldn't fetch the stack trace */
>   		return -EFAULT;
>   
> -	return __bpf_get_stackid(map, trace, flags);
> +	return __bpf_get_stackid(map, trace, flags, max_depth);
>   }
>   
>   const struct bpf_func_proto bpf_get_stackid_proto = {
> @@ -374,6 +374,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   	bool kernel, user;
>   	__u64 nr_kernel;
>   	int ret;
> +	u32 elem_size, max_depth;
>   
>   	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
>   	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> @@ -392,16 +393,18 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   		return -EFAULT;
>   
>   	nr_kernel = count_kernel_ip(trace);
> -
> +	elem_size = stack_map_data_size(map);
>   	if (kernel) {
>   		__u64 nr = trace->nr;
>   
>   		trace->nr = nr_kernel;
> -		ret = __bpf_get_stackid(map, trace, flags);
> +		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, max_depth);
>   
>   		/* restore nr */
>   		trace->nr = nr;
>   	} else { /* user */
> +

Remove the above empty line.

>   		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
>   
>   		skip += nr_kernel;
> @@ -409,7 +412,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   			return -EFAULT;
>   
>   		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -		ret = __bpf_get_stackid(map, trace, flags);
> +		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, max_depth);
>   	}
>   	return ret;
>   }


