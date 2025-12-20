Return-Path: <bpf+bounces-77229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC7CD276B
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6850A30115C7
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020129D289;
	Sat, 20 Dec 2025 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CM4GWEWM"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CA63CB
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205592; cv=none; b=j95vbcFNzxa4Fz1v0BgrezVHy2JLYuxbKOFkRCHdC3RNqxUcqWJvrzAQPBIutBsZflU5EW+0WvnY9G+xG6uIs3Ir+R2eUGKorSLjZqvEKrE/CQ5ige8aty7nGB7eZPYT48YtfTAN2wus4WNCGrjq8puSOTNmNtnxdOUeSf8u3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205592; c=relaxed/simple;
	bh=ml6zz+8StkbbtKAwW4KxrMT9ceV943xnniDN2apBfLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rd/ThKKyZcC/qJ1k37tGKHtRWoujgVv05mDF6FiyFmwNit/SGLXdRfHY6+YxoRADzbiOxlhysVk8JmwZZ/YmM9zN9on0VA2O2OhcynOp5s9LtMPqbxNBlHzVFwbmWQyG4xHbrructDrxFGwk7tCrIYeEET8qYoGi/ZCsNlUH2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CM4GWEWM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766205586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjpDIwqwh7awqQg3Av0KcHl6j1llQuC0S7I0UlnqixQ=;
	b=CM4GWEWMDv80MKD/woyY3hmlF+mdwLT9ORWJeEnvWxuPD0dXeZd2YBNMbq5yl/MLIjsllY
	1T8Cu+9kwGr/OXk4zpla5rNaUNkECwS/42OQABliKhhTt3CrNANOanUVAeU+7ht5DOzeU7
	9E9b6NjSWaA3RD9ej89BHN+lKwfzVfM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
  inwardvessel@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
 mhocko@suse.com, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 4/7] mm: introduce BPF kfuncs to access
 memcg statistics and events
In-Reply-To: <1b78506003b674f5e66bc7ac61f279a363f5cacc8d2fcb615d06abb0316ef00c@mail.kernel.org>
	(bot's message of "Sat, 20 Dec 2025 04:29:43 +0000 (UTC)")
References: <20251220041250.372179-5-roman.gushchin@linux.dev>
	<1b78506003b674f5e66bc7ac61f279a363f5cacc8d2fcb615d06abb0316ef00c@mail.kernel.org>
Date: Fri, 19 Dec 2025 20:39:39 -0800
Message-ID: <873455n4vo.fsf@linux.dev>
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
>> index 2d518ad2ad3f..d84fe6f3ed43 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -78,6 +78,57 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>>  	css_put(&memcg->css);
>>  }
>>
>> +/**
>> + * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
>> + * @memcg: memory cgroup
>> + * @event: event id
>> + *
>> + * Allows to read memory cgroup event counters.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
>> +						enum vm_event_item event)
>> +{
>> +	return memcg_events(memcg, event);
>> +}
>
> Should this function validate the event parameter before passing it to
> memcg_events()?
>
> The call chain bpf_mem_cgroup_vm_events()->memcg_events()->memcg_events_index()
> reaches an array access in memcg_events_index():
>
>     static inline int memcg_events_index(enum vm_event_item idx)
>     {
>         return mem_cgroup_events_index[idx];
>     }
>
> The array mem_cgroup_events_index is declared with size NR_VM_EVENT_ITEMS.
> If a BPF program passes an event value >= NR_VM_EVENT_ITEMS, this would
> cause an out-of-bounds array read.
>
> For comparison, bpf_mem_cgroup_page_state() below validates its idx
> parameter before calling memcg_page_state_output(). A similar check here
> would prevent the potential out-of-bounds access:
>
>     if (event < 0 || event >= NR_VM_EVENT_ITEMS)
>         return (unsigned long)-1;

No, it's a false positive, as explained in a reply to the similar comment
to v1.

