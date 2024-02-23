Return-Path: <bpf+bounces-22599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536AD861922
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667511C25027
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B613A272;
	Fri, 23 Feb 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YpgQJqfu"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CF13A26C
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708480; cv=none; b=nLMCI36Z9ThtaOnENz1UtlLKwWU3i7m15pN7i21II6j7T5Z5EgzeNZ6s9noLskmb2uKEryKMUZCe8w3ofZYVXkzY4/TLr7MjcgFw4pzHsZyi3EuRbqS0Duo2UVRI1nX18FwZuV+8xREsFVCCNU7iyJzuyVKL/FYliB5Vei9lelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708480; c=relaxed/simple;
	bh=/rt6Aoab0bVOxud5NCUS2Nl4t9T3C2Cwc7N0UXCxnMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsgrlLrAuvAv3rDzhPRi715rcT5HmVvOsyZ5ct79I43mOB8RrCcgkHgyzpVEqsqH5BH6qgt5uqR8U+6s7MK7I247MSIAhpvl+V0LT+G3hE67tNWPoVKdtF77Iw2p6IdlY3Cx3X1cgD9owxYvnTsJnsebt8lwd3XpRHXJV9p6W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YpgQJqfu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/BOPk2iS7Br1xX5zeG3rpD9r3RFQpg0wP8kaK+pzgpg=; b=YpgQJqfuJ2nnIrdpxTnHAdWhmU
	9Uf2cynx4zMmA1h0nI7Bsli1Wy6qWyUh3+dVJJPZzN901dsnTk0f9hu+hm1PgpgX5JHaiYHDX/hS9
	Uia9Eu31Q9mhk7KKCrZMWnOBKiSlnJYbCj8DsVZLmxXPntqXxP8LsiC3xydyuN20uck2YuxQJHhdw
	5n/347Fm1/en+6zJRbiTJjGdIiEyUytGjFY62mmU2IYR0tHMGg0vbmm0XpfFbCFGnNVlJ88iW7y8V
	m+O8buUagYJ0gVK7hPRGKnb7LS+jajAgubRak4unfIYCddb8SPVo0LPrx7tZnt6ZKq7QZP004TuqP
	h0lPNKJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdZ89-0000000AQTr-1fNa;
	Fri, 23 Feb 2024 17:14:37 +0000
Date: Fri, 23 Feb 2024 09:14:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, bpf <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
Message-ID: <ZdjSfSBu2yO1Z8Tq@infradead.org>
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
 <ZdWPjmwi8D0n01HP@infradead.org>
 <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 21, 2024 at 11:05:09AM -0800, Alexei Starovoitov wrote:
> +#define VM_BPF                 0x00000800      /* bpf_arena pages */
> 
> +static inline struct vm_struct *get_bpf_vm_area(unsigned long size)
> +{
> +       return get_vm_area(size, VM_BPF);
> +}
> 
> and enforce that flag in vm_area_[un]map_pages() ?
> 
> vmallocinfo can display it or skip it.
> Things like find_vm_area() can do something different with such an area
> (if that was the concern).

Well, a growing allocation is a generally useful feature.  I'd
rather not limit it to bpf if we can.

> > For the dynamically growing part do you need a special allocator or
> > can we just go straight to the page allocator and implement this
> > in common code?
> 
> It's a bit special allocator that is using maple tree to manage
> range within 4G region and
> alloc_pages_node(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT)
> to grab pages.
> With extra dance:
>         memcg = bpf_map_get_memcg(map);
>         old_memcg = set_active_memcg(memcg);
> to make sure memcg accounting is done the common way for all bpf maps.

Ok, so it's not just a growing allocation but actually sparse and
all over the place?  That doesn't really make it easier to come
up with a good enough interface.  How do you decide what gets placed
where?

> struct vm_struct *area = get_sparse_vm_area(size);
> vm_area_alloc_pages(struct vm_struct *area, ulong addr, int page_cnt,
> int numa_id);
> 
> and vm_area_alloc_pages() will allocate pages and vmap_pages_range()
> them while all code in mm/vmalloc.c ?

My vague hope was that we could just start out with an area and
grow it.  But it sounds like you need something much more complex
that that.

But yes, a more specific API is probably a better idea.  And maybe
the cookie should be a VM area either but a structure dedicated to
this.

