Return-Path: <bpf+bounces-66724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB3B38B27
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7CA1BA6DE4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0203090E8;
	Wed, 27 Aug 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SWaJ2uAL"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB422750E6
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327840; cv=none; b=gjrWr+yFco8eMTgFqE3FRWqGZkjEMZDbRRNZgYJCOb8r1D2cdz+YLxA6zfohPpWENu4mSuYyoA2iToUCOxB2ZLTjnEV5gW7FQJgBeTzYZHiiAkaCPgi0MJB63+pbjbC/pB1o0ksOtOKq/9hjBviSe+F/7+hIbP6MWkzLmyO4tkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327840; c=relaxed/simple;
	bh=wFehsMslYl9iU+tcyd2Mfgyq9PTdiV+Go6sfA79dBdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FENeZK38OqwIFfljh8LxDdTqOoaZ/t15htMG6s21EgESqShFu6IvnOznqrjT9C8H458Fn4Nyzuo1AxBAEKarHK9mWwfLA8+RUKEwx/4tE6cn9zabtKqmr1FXkuj08yxPi0zd5Y7foToMbBSK119sYosCjMTW611QbLCXO+IptjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SWaJ2uAL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 13:50:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756327825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hU0YOlK0A/OqZMyBRHKhwszszuzq0q1K7KKT0zAgw28=;
	b=SWaJ2uALZ8vtxrsSMGlZicuxcZtKzYLZ5zOq+nER83qcGJHzjsbJG+3kQZgTR8c9LRHw+Z
	qs6XzeEp5SNJCVsppiIRiZiDLXzV26Afzt5nnqbN7wJLlHvU/ZX0CUx21gwCn/1NM1kznV
	kc5Trl+1k8U4eGZCKdMgZ+cjawMI08g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <3m6jhfndkoshnoj76wyjjgmqa55p4ij4desc45yz6g7gbpxnrd@xumacckayj4t>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 27, 2025 at 04:34:48PM +0100, Lorenzo Stoakes wrote:
> > +__bpf_kfunc_start_defs();
> > +
> > +/**
> > + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
> > + * @mm: The mm_struct to query
> > + *
> > + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
> > + *
> > + * Return: The associated mem_cgroup on success, or NULL on failure. Note that
> > + * this function depends on CONFIG_MEMCG being enabled - it will always return
> > + * NULL if CONFIG_MEMCG is not configured.
> 
> What kind of locking is assumed here?
> 
> Are we protected against mmdrop() clearing out the mm?

No locking is needed. Just the valid mm object or NULL. Usually the
underlying function (get_mem_cgroup_from_mm) is called in page fault
context where the current is holding mm. Here the only requirement is
that mm is valid either through explicit reference or the context.

> 
> > + */
> > +__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct *mm)
> > +{
> > +	return get_mem_cgroup_from_mm(mm);
> > +}
> > +
> > +/**
> > + * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_get_mem_cgroup()
> > + * @memcg: The memory cgroup to release
> > + */
> > +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +	if (!memcg)
> > +		return;
> > +	css_put(&memcg->css);
> 
> Feels weird to have an ifdef here but not elsewhere, maybe the whole thing
> should be ifdef...?
> 
> Is there not a put equivalent for get_mem_cgroup_from_mm()? That is a bit weird.
> 
> Also do we now refrence the memcg global? That's pretty gross, could we not
> actually implement such a helper?
> 
> Is it valid to do this also? Maybe cgroup people can chime in.

There is mem_cgroup_put() which should handle !CONFIG_MEMCG configs.


