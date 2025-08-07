Return-Path: <bpf+bounces-65237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993FB1DD4C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23A47A874A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5AF221737;
	Thu,  7 Aug 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CrxDhWEc"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DC8F6E
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593535; cv=none; b=TLrlQuk4hCvLZlDXHrINbsHffuAVAwKJbsygHIHiNtTRdd2Bpx6f89YmQkDLu3q2W+VOpmB9+fX7egN2A3+Q2rMF0WuIoETir46+fV1dKlxzuyl+VqBV2h2sDF+fvvqE04fmGHuPjda+bGEQerWJkyoGXcNx+ub1gvSERMQw6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593535; c=relaxed/simple;
	bh=dE+AVwYniT3vJHP+UoI8xx4iQ9ExHzmQRWkDYBFHlG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkndXbCg3ZKuG/5m9bplkZ+h10w4z0LZsI4SZQm4Uodt/6bUlKEzYGeCH3mp+WAOflmI5COJ2cy0YrYA84cH75GscBxrbFfxLX3e8en1xZgHTQX6163X8I2stqerld64Brafhmw9jj2oqv2+AD92lLYbPtUd7gccFJzZw0B4ZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CrxDhWEc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfffe2d9-1d2a-4376-abb6-a8746a8a3a69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754593529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9mKcMRuq6jINq5ANG/Ei6hvRGRifdTxiEw9xKT697k=;
	b=CrxDhWEcZS33BnpYpxKbyUZQNRwX0NeaXuFlJgj+4DnB3z99uyFAkxDpFvwwjB5JZCQ3ZM
	YKrVUS+sQqvB7T6+2w1Y3rATiHxbuKWX4h6DQi/QbiffHlff5cQkaKzrRgrrfPthmMMznh
	5NJZ+p4V7W8p75Gg74aH9HtBPl92Q6U=
Date: Thu, 7 Aug 2025 12:05:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250807175032.7381-1-contact@arnaud-lcm.com>
 <20250807175258.7613-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250807175258.7613-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/7/25 10:52 AM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   kernel/bpf/stackmap.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 14e034045310..d7ef840971f0 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -250,7 +250,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   }
>   
>   static long __bpf_get_stackid(struct bpf_map *map,
> -			      struct perf_callchain_entry *trace, u64 flags)
> +			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
>   {
>   	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>   	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> @@ -266,6 +266,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   
>   	trace_nr = trace->nr - skip;
>   	trace_len = trace_nr * sizeof(u64);
> +	trace_nr = min(trace_nr, max_depth - skip);
> +
>   	ips = trace->ip + skip;
>   	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>   	id = hash & (smap->n_buckets - 1);
> @@ -325,19 +327,19 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
> +	if (max_depth < 0)
> +		return -EFAULT;

the above condition is not needed.

>   
>   	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>   				   false, false);
> @@ -346,7 +348,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   		/* couldn't fetch the stack trace */
>   		return -EFAULT;
>   
> -	return __bpf_get_stackid(map, trace, flags);
> +	return __bpf_get_stackid(map, trace, flags, max_depth);
>   }
>   
>   const struct bpf_func_proto bpf_get_stackid_proto = {
> @@ -378,6 +380,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   	bool kernel, user;
>   	__u64 nr_kernel;
>   	int ret;
> +	u32 elem_size, pe_max_depth;

pe_max_depth -> max_depth.

>   
>   	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
>   	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> @@ -396,24 +399,25 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
> +		pe_max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, pe_max_depth);
>   
>   		/* restore nr */
>   		trace->nr = nr;
>   	} else { /* user */
>   		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
> -

please keep an empty line here.

>   		skip += nr_kernel;
>   		if (skip > BPF_F_SKIP_FIELD_MASK)
>   			return -EFAULT;
>   
>   		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -		ret = __bpf_get_stackid(map, trace, flags);
> +		pe_max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		ret = __bpf_get_stackid(map, trace, flags, pe_max_depth);
>   	}
>   	return ret;
>   }


