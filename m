Return-Path: <bpf+bounces-65489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D5B240C9
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 07:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1431F5A1A56
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E52BEFE0;
	Wed, 13 Aug 2025 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d6bgEZpr"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8E2BE05F
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064462; cv=none; b=rLXPb5OtiWkQVheEEJR0zqb0J8HWpeI88GWVIw4TDWptngjCE1RS6mMPbuQ/IiR+rNQWLLTF2+Uu120vV9VUOLKlWWh60zygCe19ixwBeRNqTlYNoiJN/w08GhgPvVmA1/4r8T6+PvicpvphPWLGLvOEKefTzOOnfTUT6jPVn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064462; c=relaxed/simple;
	bh=fZOVSL1aaBMqAX7y8C8YBr0X/fLnGUZLq38WeFWRXkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3f9VIRaE7zE+LevKqaqlZKeupIpcq7BFXk/iXomuHbXDf7hIqtXV1fRpOVlrUuxAlkKV13mp7+4vrAOFcdjzL2T6ue2w4AOtzvP98oSfSOViLMQshS7wh0dSqaV0j0WGC9kayIMFsHdm2j0+R1kZA8xKZ9QovNe5GIdzZm49l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d6bgEZpr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09dc40eb-a84e-472a-8a68-36a2b1835308@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755064456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPwnB9ps9W0P2V8Lp6Eg8bH+ecaPEc7707QvrsMdmYQ=;
	b=d6bgEZpr5Uz5ABoe5truZsmAVAosr4BsOTslxGJ9yd68JukM8py6clULdHLPcEaQZtLJoK
	askYi/r+jaEcihlGv/Qn7wS4joZQNIX0I7hQUz74iglTK/JJKfomIvmfkGxDUkCtME83lo
	xsjLDuFqO+Lz63FsTHNrCIxVG+CG5PQ=
Date: Tue, 12 Aug 2025 22:54:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <ef33d3cb-4346-41af-9e0e-541fdc007f89@linux.dev>
 <20250812193034.18848-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250812193034.18848-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/12/25 12:30 PM, Arnaud Lecomte wrote:
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
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

LGTM with a small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..a267567e36dd 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct bpf_map *map)
>   		sizeof(struct bpf_stack_build_id) : sizeof(u64);
>   }
>   
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
> + * @size:        Size of the buffer/map value in bytes
> + * @elem_size:       Size of each stack trace element
> + * @flags:       BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)

Let us have consistent format, e.g.
  * @size:  Size of ...
  * @elem_size:  Size of ...
  * @flags:  BPF stack trace ...

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
> +	trace_nr = min(trace_nr, max_depth - skip);
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;


