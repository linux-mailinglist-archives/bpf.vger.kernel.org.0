Return-Path: <bpf+bounces-66043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A127EB2CE6C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 23:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905351B61FE8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583126D4C0;
	Tue, 19 Aug 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGuM87G9"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488D2EB873
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638155; cv=none; b=HaUIb6suyOOV7botLIlULNW0Wix7i1YdmaYzghD0X1ZcFpA6PdMksuQaqh786zjsWe3zAhmnBcp6jMmikBzlJKCJJ6FkFw0oZBTLHRv1yLOrp+u3Kx9XeGJmmgLP4QuXwgk2LxDFebE4pJtFyRT0OuHNDERGlWa7o7BWQlGdfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638155; c=relaxed/simple;
	bh=Kcmtw1SZqqnrUX4Pm9hd7A8p6P84NFZYeq3s6aCruOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVszwqEkLXzA2gRe249QfzuP5hz8lQ1RHRQAsOvL5OL/dEB/U3TjIdz6zuoeRMxiMXc6QJMWaCodzsWj7UOyFPD+5BBSjNFRh/Jkm8LIppEWHYFc2RLWTuMP5UpG1mJS1+LdVvomz+ubjNX9iKmEg8Yd8zmuesN70dWSXX2Rq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGuM87G9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d8fe484-2889-4367-9405-91aeee7d2ef0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755638142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShCNXUlDFKixmBPum6gITWmou0RkPrZF8Uv21LjgDng=;
	b=GGuM87G9FuFa6XPQEfZh+gmLc5qCa33Tgu+LhABXESCl1slLrMjWOBKvH3sNrVHhUzJXCq
	URIlYCVxK5AG6tLDvKladglvQpdtbzMtpj4vmeZFpKjnPjqTYElqCqHn+bDe7uPnPjCDXf
	Zge4zQdhfeR7ncN/KnPr8T9UYtouhIc=
Date: Tue, 19 Aug 2025 14:15:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next RESEND v4 1/2] bpf: refactor max_depth
 computation in bpf_get_stack()
To: Arnaud Lecomte <contact@arnaud-lcm.com>, yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, song@kernel.org
References: <20250819162652.8776-1-contact@arnaud-lcm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250819162652.8776-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/19/25 9:26 AM, Arnaud Lecomte wrote:
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
> 
> Changes in v2:
>   - Removed the checking 'map_size % map_elem_size' from
>     stack_map_calculate_max_depth
>   - Changed stack_map_calculate_max_depth params name to be more generic
> 
> Changes in v3:
>   - Changed map size param to size in max depth helper
> 
> Changes in v4:
>   - Fixed indentation in max depth helper for args
> 
> Link to v3: https://lore.kernel.org/all/09dc40eb-a84e-472a-8a68-36a2b1835308@linux.dev/
> 
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..b9cc6c72a2a5 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct bpf_map *map)
>   		sizeof(struct bpf_stack_build_id) : sizeof(u64);
>   }
>   
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
> + * @size:  Size of the buffer/map value in bytes
> + * @elem_size:  Size of each stack trace element
> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stored
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
> +{
> +	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 max_depth;
> +
> +	max_depth = size / elem_size;
> +	max_depth += skip;
> +	if (max_depth > sysctl_perf_event_max_stack)
> +		return sysctl_perf_event_max_stack;

hmm... this looks a bit suspicious. Is it possible that 
sysctl_perf_event_max_stack is being changed to a larger value in parallel?

> +
> +	return max_depth;
> +}
> +
>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>   {
>   	u64 elem_size = sizeof(struct stack_map_bucket) +
> @@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   			    struct perf_callchain_entry *trace_in,
>   			    void *buf, u32 size, u64 flags, bool may_fault)
>   {
> -	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +	u32 trace_nr, copy_len, elem_size, max_depth;
>   	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>   	bool crosstask = task && task != current;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		goto clear;
>   	}
>   
> -	num_elem = size / elem_size;
> -	max_depth = num_elem + skip;
> -	if (sysctl_perf_event_max_stack < max_depth)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>   
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */
> @@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	trace_nr = trace->nr - skip;
> -	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;

I suspect it was fine because trace_nr was still bounded by num_elem.

> +	trace_nr = min(trace_nr, max_depth - skip);

but now the min() is also based on max_depth which could be 
sysctl_perf_event_max_stack.

beside, if I read it correctly, in "max_depth - skip", the max_depth could also 
be less than skip. I assume trace->nr is bound by max_depth, so should be less 
of a problem but still a bit unintuitive to read.

>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;


