Return-Path: <bpf+bounces-77116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB61CCE4AF
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA606305B938
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941592356BA;
	Fri, 19 Dec 2025 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pI4nKNEv"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5127D782
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112595; cv=none; b=WAblrMsLcBdu6JmD4OBqcB4o+8uxUfWOG/TjCiT03S148y3Qj5KR09YIFA8Na4b4pemSlduGF9Y9l93fGROZWnr3489SVJrFQTP16MS06KpPH7R+XwlICSYYfML648dJxWLdNSQ9nlf4MqTUNakmtisTVKTWtNW4aFI/67GrV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112595; c=relaxed/simple;
	bh=9FvASLSTjwxknBjCG4rdJsjMOWtZIKeboVSpxEUCHj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWs9PV7M+SOg0NnW3Ae+OeDjZm4HXUXN0DI4wRQNY46qBIqDdlRbTRSC8YAVVd+I0T8qVpEWa3m2wAOOxabFWX+CEcMUL3wDaldKI5z6lrOWCV5FqpWOBjg6Xf9ktG53qv8ysoAOw/OUic56CqJyq8pZORGXC7SiijBbSbgM/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pI4nKNEv; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766112576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=abd/44gPrDqvBL/2LyNnB1pB9d9gpdKplEObPG4utUA=;
	b=pI4nKNEv57QpGkjms+FO+OVqvN/dvP3YiYsx0xarnEsiCnH4BErdFjMIC9Pe/5Z8eWZ+zv
	hmJofNw0nk7tikxTe/wsF8R16TfIFQmAvU/5WGTCVz8J0VCQiq5uL7Di6bdR/twt3OIc+a
	hFzrgZV0SJJtPpec9hJMioiFImoD1Go=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
  inwardvessel@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
 mhocko@suse.com, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v1 4/6] mm: introduce BPF kfuncs to access
 memcg statistics and events
In-Reply-To: <e80e8faecbfd7099950485f4de08a1226ae10282ec44fe9e6b3610fcb00c8400@mail.kernel.org>
	(bot's message of "Fri, 19 Dec 2025 02:15:11 +0000 (UTC)")
References: <20251219015750.23732-5-roman.gushchin@linux.dev>
	<e80e8faecbfd7099950485f4de08a1226ae10282ec44fe9e6b3610fcb00c8400@mail.kernel.org>
Date: Thu, 18 Dec 2025 18:49:29 -0800
Message-ID: <87bjjvb2yu.fsf@linux.dev>
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
>> index 6d0d73bf0dd1..4d9d7d909f6c 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>
> [ ... ]
>
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
> Should bpf_mem_cgroup_vm_events() validate the event parameter before
> passing it to memcg_events()? The call chain is:
>
>   bpf_mem_cgroup_vm_events() -> memcg_events() -> memcg_events_index()
>
> And memcg_events_index() does:
>
>   return mem_cgroup_events_index[idx];
>
> where mem_cgroup_events_index is an array of size NR_VM_EVENT_ITEMS. If a
> BPF program passes event >= NR_VM_EVENT_ITEMS, this would be an
> out-of-bounds array read.
>
> The sister function bpf_mem_cgroup_page_state() below validates its idx
> parameter before calling its callee:

It's a false positive: the check is enforced by the bpf verifier based
on type information.

>
>> +/**
>> + * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
>> + * @memcg: memory cgroup
>> + * @idx: counter idx
>> + *
>> + * Allows to read memory cgroup statistics. The output is in bytes.
>> + */
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
>> +{
>> +	if (idx < 0 || idx >= MEMCG_NR_STAT)
>> +		return (unsigned long)-1;
>> +
>> +	return memcg_page_state_output(memcg, idx);
>> +}
>
> Should bpf_mem_cgroup_vm_events() have a similar bounds check, perhaps:
>
>   if (event >= NR_VM_EVENT_ITEMS)
>       return (unsigned long)-1;
>
> before calling memcg_events()?

No. Here is required because idx is a simple int.

