Return-Path: <bpf+bounces-77542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46DCEAA45
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 22:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D03C030039FA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CE21257E;
	Tue, 30 Dec 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jcgg3koN"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A186277
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767128450; cv=none; b=WBFd1XPViwnTy3hROfM/8IfKHyLjH7/IyUDBQ10j4L9VASXQQa/RM4xP7QefEHjOYEmAcduQ5wNmiAZ/yGCvoJIR12Ayfw8k2kJIPm7NKlow+aVoSq3HqiF0a/St18EqVQjBWTHWyA4gAu1SeExP3w63EgjX+uKQpdtKN3qroXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767128450; c=relaxed/simple;
	bh=sRHnSGP7g7dDd2fLFipIadb4Oxxlop9f0gCs+2vWyWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ou3TDaM3rWle9KuRsDiL1QtBhSMY//xQIuDL6k2mea0pE5ybTF+SzOWBkXg8rkGeq+7V+egThsxOHKstIlXtwlyNOyzoC4YxduXeIwtEg/TN1LxhiT+qnv/c5k1icIdvA82WbAxSYJJS7FHLGBQlkYkrY0ik+FlV4f8ftNwnNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jcgg3koN; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767128443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRIHEk0dRJ5d7qN6JdXfLwTI0SjQwuqnSM6RZ2ji4I0=;
	b=jcgg3koNkQo7ZKi4SR5FHC6HWg81ZfOljZo3eST1XZvTvfO/oiXaYQ7Q+SL33fi1A8xrwl
	k5aWAU8mm93npTJU2oGM4EJbtSFNVxstrD9How00yt51w0t46olSWtRJ2QQT5eEPHLvdXa
	ud3k5VybY7LYIiN+gOgczUKpUf7Okcs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  JP Kobryn <inwardvessel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Michal Hocko <mhocko@kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
In-Reply-To: <aVQ1zvBE9csQYffT@google.com> (Matt Bobrowski's message of "Tue,
	30 Dec 2025 20:27:58 +0000")
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
	<20251223044156.208250-4-roman.gushchin@linux.dev>
	<aVQ1zvBE9csQYffT@google.com>
Date: Tue, 30 Dec 2025 21:00:28 +0000
Message-ID: <7ia4ms2zwuqb.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matt Bobrowski <mattbobrowski@google.com> writes:

> On Mon, Dec 22, 2025 at 08:41:53PM -0800, Roman Gushchin wrote:
>> Introduce a BPF kfunc to get a trusted pointer to the root memory
>> cgroup. It's very handy to traverse the full memcg tree, e.g.
>> for handling a system-wide OOM.
>> 
>> It's possible to obtain this pointer by traversing the memcg tree
>> up from any known memcg, but it's sub-optimal and makes BPF programs
>> more complex and less efficient.
>> 
>> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
>> however in reality it's not necessary to bump the corresponding
>> reference counter - root memory cgroup is immortal, reference counting
>> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
>> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
>> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/bpf_memcontrol.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>> 
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 82eb95de77b7..187919eb2fe2 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -10,6 +10,25 @@
>>  
>>  __bpf_kfunc_start_defs();
>>  
>> +/**
>> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
>> + *
>> + * The function has KF_ACQUIRE semantics, even though the root memory
>> + * cgroup is never destroyed after being created and doesn't require
>> + * reference counting. And it's perfectly safe to pass it to
>> + * bpf_put_mem_cgroup()
>> + *
>> + * Return: A pointer to the root memory cgroup.
>> + */
>> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>> +{
>> +	if (mem_cgroup_disabled())
>> +		return NULL;
>> +
>> +	/* css_get() is not needed */
>> +	return root_mem_cgroup;
>> +}
>> +
>>  /**
>>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>>   * @css: pointer to the css structure
>> @@ -64,6 +83,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>>  __bpf_kfunc_end_defs();
>>  
>>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>
> I feel as though relying on KF_ACQUIRE semantics here is somewhat
> odd. Users of this BPF kfunc will now be forced to call
> bpf_put_mem_cgroup() on the returned root_mem_cgroup, despite it being
> completely unnecessary.

A agree that it's annoying, but I doubt this extra call makes any
difference in the real world.

Also, the corresponding kernel code designed to hide the special
handling of the root cgroup. css_get()/css_put() are simple no-ops for
the root cgroup, but are totally valid. So in most places the root
cgroup is handled as any other, which simplifies the code. I guess
the same will be true for many bpf programs.

Thanks!

