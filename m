Return-Path: <bpf+bounces-72589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A783EC15EC1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4AB4E8FEC
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1537343D88;
	Tue, 28 Oct 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9XyJNAQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F284889
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669829; cv=none; b=YVTlMzEq8KSFwYYJHuWzvLLUKachvsCScg5CQwllhbmewKwc2cofYqn7Q3BXT6Pu1uNG7qq61us8sxU0E2H9evEwUfeDm01WbB6uXUqwayLmw1l5SCVh+QwPAEEbVuCkMQTtH8goPR8ds14s1w9WeGHNP+JVRnyOfetxry0THKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669829; c=relaxed/simple;
	bh=nf40Jfi8RubCITdyh8WZ7pq2NikxPd5ZwWauOZT+p2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9U5AzyE1AxTZcypZOXHgXJxnzys5uOSK/qUlNFkxwj6M8v5A9iBe3fBQZe7Uporf3aWze7DqVt225LAq0tqi8T58D8zJsFhDUBS2v+PFNgncHHDehQcDJhd5GcgTGDYhjiInNlP5zKoXJqjf+GwQuO7R+QTiDBtSlrMGZkaqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9XyJNAQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761669824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSNkRhOJhrPtd4Js2oBI0wr+MEc/sKamTAOCSggnfZY=;
	b=C9XyJNAQbLdaKmF6tYaMQJgBraElANn8UZADDHK2VL+pgdD76IApnxrZRyQYAaT6rFTarg
	tYoLJbg0VWb22xMZArp0wH2Ft+STPLO0i2hYX2TtGMWEJM/N10vBHM5tQfD5nGj0ItMa51
	otG8PaOIqzlX0JNrVvhEtQ7NWlSELLQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
In-Reply-To: <2b04ce21d82f2118c291c49ace22d685bcbbd45d203b2f676556d3e5a90eebd1@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:57:21 +0000 (UTC)")
References: <20251027232206.473085-3-roman.gushchin@linux.dev>
	<2b04ce21d82f2118c291c49ace22d685bcbbd45d203b2f676556d3e5a90eebd1@mail.kernel.org>
Date: Tue, 28 Oct 2025 09:43:36 -0700
Message-ID: <87cy673rk7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit bce57b9b96e05731a14c7e10a364fdd9b733cda2
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> mm: introduce bpf_out_of_memory() BPF kfunc
>
> This patch introduces bpf_out_of_memory() BPF kfunc to allow BPF programs
> to declare OOM events and trigger the kernel OOM handling mechanism. The
> function accepts a nullable memcg pointer for system-wide or memcg-scoped
> OOMs.
>
>> diff --git a/include/linux/oom.h b/include/linux/oom.h
>> index 721087952..3cbdcd013 100644
>> --- a/include/linux/oom.h
>> +++ b/include/linux/oom.h
>> @@ -21,6 +21,11 @@ enum oom_constraint {
>>  	CONSTRAINT_MEMCG,
>>  };
>>
>> +enum bpf_oom_flags {
>> +	BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK = 1 << 0,
>> +	BPF_OOM_FLAGS_LAST = 1 << 1,
>> +};
>> +
>>  /*
>>   * Details of the page allocation that triggered the oom killer that are used to
>>   * determine what should be killed.
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 3c86cd755..d7fca4bf5 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>
> [ ... ]
>
>> +/**
>> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
>> + * @memcg__nullable: memcg or NULL for system-wide OOMs
>> + * @order: order of page which wasn't allocated
>> + * @flags: flags
>> + * @constraint_text__nullable: custom constraint description for the OOM report
>> + *
>> + * Declares the Out Of Memory state and invokes the OOM killer.
>> + *
>> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
>> + * is true, the function will wait on it. Otherwise it bails out with -EBUSY
>> + * if oom_lock is contended.
>> + *
>> + * Generally it's advised to pass wait_on_oom_lock=false for global OOMs
>> + * and wait_on_oom_lock=true for memcg-scoped OOMs.
>> + *
>> + * Returns 1 if the forward progress was achieved and some memory was freed.
>> + * Returns a negative value if an error occurred.
>> + */
>> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>> +				  int order, u64 flags)
>> +{
>> +	struct oom_control oc = {
>> +		.memcg = memcg__nullable,
>> +		.order = order,
>> +	};
>
> Can bpf_out_of_memory() work correctly for system-wide OOMs with
> uninitialized gfp_mask?
>
> Looking at out_of_memory():
>
>     if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
>         return true;
>
> With gfp_mask=0 and memcg=NULL (system-wide OOM), this evaluates to:
> !(0 & __GFP_FS) && !false = true, causing an early return without
> invoking the OOM killer. The comment in out_of_memory() explains this
> check is about allocation context: "The OOM killer does not compensate
> for IO-less reclaim."
>
> All other callers of out_of_memory() initialize gfp_mask:
> - mm/page_alloc.c: .gfp_mask = gfp_mask
> - mm/memcontrol.c: .gfp_mask = gfp_mask
>
> For memcg OOMs, the code works because is_memcg_oom(oc) is true,
> bypassing the check. But for system-wide OOMs (NULL memcg), won't this
> cause the function to return immediately without killing any process?

This is a good catch! It must be .gfp_mask = GFP_KERNEL.

Fixed.

Thanks!

