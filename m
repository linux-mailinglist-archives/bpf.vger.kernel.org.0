Return-Path: <bpf+bounces-77230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E28CD2777
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F04E3011F95
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9B2D73B1;
	Sat, 20 Dec 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pemPTR8e"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7321ABAA
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205732; cv=none; b=odwad2B55BJ48dOud/TOcz6/GFAcPWfCwc+ZHMDxCoOksk7UHAqd3L86AqD3XmrUuga6o87WKJtlPG/uXY0DKoCfw40R/+xDa9xtRXi60rZBM0ZMBpW1A+vxvi75eHtCABUcZUOUlB1sa2C6wsmy10vKUuY+4cEy9Nfm3zDlRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205732; c=relaxed/simple;
	bh=sfYEc3F560GQKzIRvivktKusbb6zO0e8pZAijXEv4QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QXeXmFIBqO1SpciALOUeJdHITNmXw6m4ib7qeo2yMfqHshR7GPuvwbaBlkXw3u9ajUL5pmzZGLTsuZMrXDSexgZiDnnXkOr1BCPG8ScAG9/xQX02h4AqvgnWrd1oiwuntn+5NaEZ4olN2bUjULKxy8ma1esejlANMim3/pFUbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pemPTR8e; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766205717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7Snbm0Eo1c02EpdvweabpFtfhZ7BzYRezRTB+jU0tU=;
	b=pemPTR8ev8HpuCLVTeOWEkRrVdoyuxKuCQGz0yU7B0TB8v58cGyViXXAAhEskmIXYycUiy
	Svz88HANmMEw1m33XBEX538UgrPaONSqyZS+zyc7j97jx/QGKfHWaMjY8LIWB1+HLGbmR+
	NWKRdWZzV3lCLByxaWlBylwGuemNA1A=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
  inwardvessel@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
 andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access
 memory events
In-Reply-To: <8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
	(bot's message of "Sat, 20 Dec 2025 04:29:44 +0000 (UTC)")
References: <20251220041250.372179-6-roman.gushchin@linux.dev>
	<8f23848b8ac657b4b4a2da04da242039c59e9ad9826a8d5fa0f5aee55acfecc9@mail.kernel.org>
Date: Fri, 19 Dec 2025 20:41:46 -0800
Message-ID: <87a4zdepdh.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index d84fe6f3ed43..858eb43766ce 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
>>  	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
>>  }
>>
>> +/**
>> + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
>> + * @memcg: memory cgroup
>> + * @event: memory event id
>> + *
>> + * Returns current memory event count.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
>> +						enum memcg_memory_event event)
>> +{
>> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
>> +		return (unsigned long)-1;
>
> Should this also check for negative values?  The enum type is typically
> signed, so a BPF program passing a negative event value would pass this
> check but cause an out-of-bounds read from memcg->memory_events[].
>
> The similar bpf_mem_cgroup_page_state() in this same file uses:
>
>     if (idx < 0 || idx >= MEMCG_NR_STAT)
>
> which checks both bounds.  Could the check here be changed to:
>
>     if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)
>
> to match that pattern?

No, the bpf verifier enforces event > 0.
It's a false positive.

