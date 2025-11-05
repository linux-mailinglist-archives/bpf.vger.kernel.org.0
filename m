Return-Path: <bpf+bounces-73737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B6C382A5
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAB4F56EE
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1283D2F12A3;
	Wed,  5 Nov 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jiZyxjTG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFC2E888C
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381050; cv=none; b=taS1UQuN89gV/oAkkUsbfSe7bIx27DA9htujX0E76Ol8noQvCosJdmpySbw6G+9M8rf8L3pIkOuUT6m7fNYGvQFrx4q9HL+xncBlCcbRLphk+894SxJpUoTlZTVbu363HVk5q0LhYMq0wk8OgiaOYyVWfKM/rH/3cnuuYzHYIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381050; c=relaxed/simple;
	bh=IoB9iZlMwRfHd737NI7jBIhjtchxI0N+tT4/xrisp/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyAGyGwCHfLr/8x+fhX8W4hA4VJZwr5xbClVcaPbNJBaKpXzuJpWysVf9TsIq6Grw+nrAgfxn9UY0/7Bfasz9KRGjDpwGxvlb0fwsI/ftKdKMrc7K8q7lmDJi8s7pN4DHtmR2gxaU7/o0cqvfXAKOvGb0wf7nl1bTShmLAnf/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jiZyxjTG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c352f357-1417-47b5-9d8c-28d99f20f5a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762381036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKgffc4Q2YFxCE+a40kbJ/fp+ky+zJPizqh+vpPjXZU=;
	b=jiZyxjTGo46+JtYMDBd6kq8Uwv0MXIdokM3ej89Vla93H2ztbJVIcSyGhtss/qLYJwLxbQ
	Z0qT5RaIFFmyMBOnUbnWbY6D9mEzPkRe6jKLLLcYu7ZEaPLDF2AgdcC/8fHKbiH370KhLP
	d+/HWQd3lTolZ+hOiizVKU9ng/cnrP0=
Date: Wed, 5 Nov 2025 14:16:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Hold the perf callchain entry until
 used completely
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251028162502.3418817-1-chen.dylane@linux.dev>
 <20251028162502.3418817-3-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251028162502.3418817-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/28/25 9:25 AM, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 61 ++++++++++++++++++++++++++++++++++---------
>   1 file changed, 48 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e28b35c7e0b..70d38249083 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -188,13 +188,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
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
> +	entry = get_callchain_entry(rctx);
>   
>   	if (!entry)
>   		return NULL;
> @@ -216,8 +215,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   			to[i] = (u64)(from[i]);
>   	}
>   
> -	put_callchain_entry(rctx);
> -
>   	return entry;
>   #else /* CONFIG_STACKTRACE */
>   	return NULL;
> @@ -297,6 +294,31 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
> +	entry = get_callchain_entry(rctx);

I think this may not work. Let us say we have two bpf programs
both pinned to a particular cpu (migrate disabled but preempt enabled).
get_callchain_entry() calls get_recursion_context() to get the
buffer for a particulart level.

static inline int get_recursion_context(u8 *recursion)
{
         unsigned char rctx = interrupt_context_level();
         
         if (recursion[rctx])
                 return -1;
         
         recursion[rctx]++;
         barrier();
         
         return rctx;
}

It is possible that both tasks (at process level) may
reach right before "recursion[rctx]++;".
In such cases, both tasks will be able to get
buffer and this is not right.

To fix this, we either need to have preempt disable
in bpf side, or maybe we have some kind of atomic
operation (cmpxchg or similar things), or maybe
has a preempt disable between if statement and recursion[rctx]++,
so only one task can get buffer?


> +	if (unlikely(!entry))
> +		return NULL;
> +
> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, false);
> +	if (kernel)
> +		__get_perf_callchain_kernel(&ctx, regs);
> +	if (user && !crosstask)
> +		__get_perf_callchain_user(&ctx, regs);
> +
> +	return entry;
> +}
> +
> +static void bpf_put_callchain_entry(int rctx)

we have bpf_get_perf_callchain(), maybe rename the above
to bpf_put_perf_callchain()?

> +{
> +	put_callchain_entry(rctx);
> +}
> +

[...]


