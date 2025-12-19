Return-Path: <bpf+bounces-77117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34459CCE4C4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 946F8302E5A1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31D283FD6;
	Fri, 19 Dec 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lXUnWFOj"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD366277C9E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112697; cv=none; b=BKAfxy8OEMLcYqTnSBrj5fkDfaIAt2o49r1Nw5w9BT0fpB/XPBDdU+5x35fvUtWVscVkaRrr2rgsLq4zRUIl+pLoxJpu4MzdA43Oxy4IQYuGCJCp6gr9F02tbrUPDoEbjg5IsVAwurjgM9JUmmtyLL8SB15QUpBbCUWjI+2Ds7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112697; c=relaxed/simple;
	bh=jAOIueH1laJyi3b5aKBHyRqK/3PeRooLBsh0b6GIZ0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gZgmvevAh8F3+/z+Ti45AkgOUK2MC5WXlGTqWBe0kS/al2SBkIvPt88ZiobI7qV6d/iRfeKefC9dCCVk/4xnOu5u9LJeD6QJxGcWIAnEsjJCbhibeUieruWghEHsiWDB7Vb8lghuQ3lQU0iAgVSIaaVDdmKnyl+DHDLrmonr0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lXUnWFOj; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766112689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX9EdKmymQBf6dTDpGNXCbWaUIzPPXzTY2GtSXhpfr4=;
	b=lXUnWFOjmasnyhi98G8wHqdqJ411bv16T/4L+YoejiUdO0fpW3TqnCGHIdx3f8yFsRwk8p
	YlyVWZh6UBZJZbW+pajOOEUocfoYU0Gh4BzANXLTw1MDAeXqTw393pirs7nOpCh/RPGfw+
	2sxUkLngcYgWoIOn9ZZa0Qsu0+18rZg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
  inwardvessel@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
 andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v1 5/6] mm: introduce BPF kfunc to access
 memory events
In-Reply-To: <cf8d48e8bcdba2515366bc8b6c85f581ca3d18ead24db9cb3ba9b98db252e0b9@mail.kernel.org>
	(bot's message of "Fri, 19 Dec 2025 02:21:40 +0000 (UTC)")
References: <20251219015750.23732-6-roman.gushchin@linux.dev>
	<cf8d48e8bcdba2515366bc8b6c85f581ca3d18ead24db9cb3ba9b98db252e0b9@mail.kernel.org>
Date: Thu, 18 Dec 2025 18:51:23 -0800
Message-ID: <873457b2vo.fsf@linux.dev>
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
>> index 4d9d7d909f6c..75076d682f75 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>
> [ ... ]
>
>> +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
>> +						enum memcg_memory_event event)
>> +{
>> +	if (event >= MEMCG_NR_MEMORY_EVENTS)
>> +		return (unsigned long)-1;
>> +
>> +	return atomic_long_read(&memcg->memory_events[event]);
>> +}
>
> Could this cause an out-of-bounds access if a BPF program passes a negative
> value for event? The enum type is signed, so if event is -1, the check
> "event >= MEMCG_NR_MEMORY_EVENTS" would evaluate to false (-1 >= 10 is
> false), allowing access to memcg->memory_events[-1].
>
> The existing bpf_mem_cgroup_page_state() in the same file uses both lower
> and upper bound checks:
>
>     if (idx < 0 || idx >= MEMCG_NR_STAT)
>         return (unsigned long)-1;
>
> Should bpf_mem_cgroup_memory_events() follow the same pattern with:
>
>     if (event < 0 || event >= MEMCG_NR_MEMORY_EVENTS)

Same here: the check is enforced by the bpf verifier based on the type
information. Not a real issue.

