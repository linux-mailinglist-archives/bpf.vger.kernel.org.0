Return-Path: <bpf+bounces-77597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CBCEC4EB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4940E3009FA8
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F8296BDB;
	Wed, 31 Dec 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oo8vQsKc"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074851DE4DC
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200541; cv=none; b=nw1+oHJIn+0s1davnLsSDVttgTBIREn2R/3Z7oCcVdKTsUwaPPUTN6Y8TUr3ORntvSsXsymLle2+DIUlDmvpdEYz7brnzyCvuiksk9OKXvD9UwTj8xG5e3XnoQiPmsesq+Q+ibHcukgXYWY6uzubNz2eVQxlAoFItcLghntF3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200541; c=relaxed/simple;
	bh=u/wR7+mcchXTm4HPa5r8L0m4sN4R1m6YVQa807w30p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t544woP6aJk0Ds46BvfV3zpWuAlbmK7RpdJXWA2/8xSzQM//7g6Q8Q90kaf9UwHew1ls4invpbb0hianjmBNy8ZWIaTOAsL1r4JjvTnBE++0HCYd24LXAeiwmDZJyyWnKdE7Lsu/OnNf7KwZJVsndh9X6qnM3o2J4J0rjjtCbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oo8vQsKc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767200533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6I0h3kezoKxK3IDpc47mY2gwi29RX44rQplizDpRGo=;
	b=Oo8vQsKc6quUCd98ROWFbf+fWzFq8lj/cuYDwgh1BY3HtZGuM6BSf0E/nhEVf/mcBVfrCA
	M8FyzK0R16mXX2PIbI6IeZpJLOZDinkySZf26rVKzHwYIie4yq7qwMWtNVB/X7NnSfv4eU
	2RqCs5Fjk0SrJboZA6l8A8HgzfWAFkg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  JP Kobryn <inwardvessel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Michal Hocko <mhocko@kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
In-Reply-To: <aVTTxjwgNgWMF-9Q@google.com> (Matt Bobrowski's message of "Wed,
	31 Dec 2025 07:41:58 +0000")
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
	<20251223044156.208250-4-roman.gushchin@linux.dev>
	<aVQ1zvBE9csQYffT@google.com> <7ia4ms2zwuqb.fsf@castle.c.googlers.com>
	<aVTTxjwgNgWMF-9Q@google.com>
Date: Wed, 31 Dec 2025 09:02:03 -0800
Message-ID: <87qzsaoa9g.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matt Bobrowski <mattbobrowski@google.com> writes:

> On Tue, Dec 30, 2025 at 09:00:28PM +0000, Roman Gushchin wrote:
>> Matt Bobrowski <mattbobrowski@google.com> writes:
>> 
>> > On Mon, Dec 22, 2025 at 08:41:53PM -0800, Roman Gushchin wrote:
>> >> Introduce a BPF kfunc to get a trusted pointer to the root memory
>> >> cgroup. It's very handy to traverse the full memcg tree, e.g.
>> >> for handling a system-wide OOM.
>> >> 
>> >> It's possible to obtain this pointer by traversing the memcg tree
>> >> up from any known memcg, but it's sub-optimal and makes BPF programs
>> >> more complex and less efficient.
>> >> 
>> >> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
>> >> however in reality it's not necessary to bump the corresponding
>> >> reference counter - root memory cgroup is immortal, reference counting
>> >> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
>> >> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
>> >> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
>> >> 
>> >> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> >> ---
>> >>  mm/bpf_memcontrol.c | 20 ++++++++++++++++++++
>> >>  1 file changed, 20 insertions(+)
>> >> 
>> >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> >> index 82eb95de77b7..187919eb2fe2 100644
>> >> --- a/mm/bpf_memcontrol.c
>> >> +++ b/mm/bpf_memcontrol.c
>> >> @@ -10,6 +10,25 @@
>> >>  
>> >>  __bpf_kfunc_start_defs();
>> >>  
>> >> +/**
>> >> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
>> >> + *
>> >> + * The function has KF_ACQUIRE semantics, even though the root memory
>> >> + * cgroup is never destroyed after being created and doesn't require
>> >> + * reference counting. And it's perfectly safe to pass it to
>> >> + * bpf_put_mem_cgroup()
>> >> + *
>> >> + * Return: A pointer to the root memory cgroup.
>> >> + */
>> >> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>> >> +{
>> >> +	if (mem_cgroup_disabled())
>> >> +		return NULL;
>> >> +
>> >> +	/* css_get() is not needed */
>> >> +	return root_mem_cgroup;
>> >> +}
>> >> +
>> >>  /**
>> >>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>> >>   * @css: pointer to the css structure
>> >> @@ -64,6 +83,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>> >>  __bpf_kfunc_end_defs();
>> >>  
>> >>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> >> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>> >
>> > I feel as though relying on KF_ACQUIRE semantics here is somewhat
>> > odd. Users of this BPF kfunc will now be forced to call
>> > bpf_put_mem_cgroup() on the returned root_mem_cgroup, despite it being
>> > completely unnecessary.
>> 
>> A agree that it's annoying, but I doubt this extra call makes any
>> difference in the real world.
>
> Sure, that certainly holds true.
>
>> Also, the corresponding kernel code designed to hide the special
>> handling of the root cgroup. css_get()/css_put() are simple no-ops for
>> the root cgroup, but are totally valid.
>
> Yes, I do see that.
>
>> So in most places the root cgroup is handled as any other, which
>> simplifies the code. I guess the same will be true for many bpf
>> programs.
>
> I see, however the same might not necessarily hold for all other
> global pointers which end up being handed out by a BPF kfunc (not
> necessarily bpf_get_root_mem_cgroup()). This is why I was wondering
> whether there's some sense to introducing another KF flag (or
> something similar) which allows returned values from BPF kfuncs to be
> implicitly treated as trusted.

Agree. It sounds like a good idea to me.

