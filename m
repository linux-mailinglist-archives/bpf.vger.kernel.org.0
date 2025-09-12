Return-Path: <bpf+bounces-68255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD2B556E9
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFEDAA6540
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63C33472D;
	Fri, 12 Sep 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4c6cVOO"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AC32BF38
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705265; cv=none; b=jJmpuCbR85tlTAPSglsl8BCw/zc7V9NnERof6cyWY0HeFB3DbMkxxSuaO7Ti9CrFjAQo9FbK4H+vz4C+KsxXrgIqWqgU0kZuwqswoJHEZXGnX2pS9iwCWkVS/bATiWZVokIzskxv/lAm6DKy8heEGGxVhODZAUiqcZMw/RCrRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705265; c=relaxed/simple;
	bh=0kXH3MZfzjdPYKN5GHO+sU36RHfP+mcqOFthuCeDh1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leCUf+o8ApCuQzWaBS/4DmnLFqKnaOU5SH0IvjMnMELFaX3XoxPAkbxatPctb46QoDdG+oB9ClazKByuCFzCvN886LoblgGE06PZq/xuiziOM2TmEazW/oXjuJzYS+opoYnEYJwF1wiqonFo5g2mix337lSCorB40FSNFGENJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4c6cVOO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 12:27:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757705261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExXevDn+7ykaskoO7a8ZpNNYaKFfGSwxcpOAezuUCvI=;
	b=o4c6cVOO96AdX8Fjafc3zvAlboi73GPkU2UPTpPb0+c7R79fSvoO7fbF4tXTlRlgRso/9Q
	k/57cS6gIvTBhLNdSI5qr2BXMsK+OzcVrGYP6IiaYY4KtSlUEUsy7z/MQXuvq9ewQEGJQW
	MYP1JzIqQdKf5gT1ijxwjA4HnQHIers=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org, surenb@google.com, roman.gushchin@linux.dev
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

+Suren, Roman

On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Since the combination of valid upper bits in slab->obj_exts with
> OBJEXTS_ALLOC_FAIL bit can never happen,
> use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> instead of (1ull << 2) to free up bit 2.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Are we low on bits that we need to do this or is this good to have
optimization but not required?

I do have some questions on the state of slab->obj_exts even before this
patch for Suren, Roman, Vlastimil and others:

Suppose we newly allocate struct slab for a SLAB_ACCOUNT cache and tried
to allocate obj_exts for it which failed. The kernel will set
OBJEXTS_ALLOC_FAIL in slab->obj_exts (Note that this can only be set for
new slab allocation and only for SLAB_ACCOUNT caches i.e. vec allocation
failure for memory profiling does not set this flag).

Now in the post alloc hook, either through memory profiling or through
memcg charging, we will try again to allocate the vec and before that we
will call slab_obj_exts() on the slab which has:

	unsigned long obj_exts = READ_ONCE(slab->obj_exts);

	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS), slab_page(slab));

It seems like the above VM_BUG_ON_PAGE() will trigger because obj_exts
will have OBJEXTS_ALLOC_FAIL but it should not, right? Or am I missing
something? After the following patch we will aliasing be MEMCG_DATA_OBJEXTS
and OBJEXTS_ALLOC_FAIL and will avoid this trigger though which also
seems unintended.

Next question: OBJEXTS_ALLOC_FAIL is for memory profiling and we never
set it when memcg is disabled and memory profiling is enabled or even
with both memcg and memory profiling are enabled but cache does not have
SLAB_ACCOUNT. This seems unintentional as well, right?

Also I think slab_obj_exts() needs to handle OBJEXTS_ALLOC_FAIL explicitly.


> ---
>  include/linux/memcontrol.h | 10 ++++++++--
>  mm/slub.c                  |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 785173aa0739..d254c0b96d0d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -341,17 +341,23 @@ enum page_memcg_data_flags {
>  	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
>  };
>  
> +#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
>  #define __FIRST_OBJEXT_FLAG	__NR_MEMCG_DATA_FLAGS
>  
>  #else /* CONFIG_MEMCG */
>  
> +#define __OBJEXTS_ALLOC_FAIL	(1UL << 0)
>  #define __FIRST_OBJEXT_FLAG	(1UL << 0)
>  
>  #endif /* CONFIG_MEMCG */
>  
>  enum objext_flags {
> -	/* slabobj_ext vector failed to allocate */
> -	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
> +	/*
> +	 * Use bit 0 with zero other bits to signal that slabobj_ext vector
> +	 * failed to allocate. The same bit 0 with valid upper bits means
> +	 * MEMCG_DATA_OBJEXTS.
> +	 */
> +	OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
>  	/* the next bit after the last actual flag */
>  	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
>  };
> diff --git a/mm/slub.c b/mm/slub.c
> index 212161dc0f29..61841ba72120 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2051,7 +2051,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>  	 * objects with no tag reference. Mark all references in this
>  	 * vector as empty to avoid warnings later on.
>  	 */
> -	if (obj_exts & OBJEXTS_ALLOC_FAIL) {
> +	if (obj_exts == OBJEXTS_ALLOC_FAIL) {
>  		unsigned int i;
>  
>  		for (i = 0; i < objects; i++)
> -- 
> 2.47.3
> 

