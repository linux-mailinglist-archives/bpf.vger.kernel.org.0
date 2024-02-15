Return-Path: <bpf+bounces-22065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C0855AE2
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 07:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0462944D0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637CBE65;
	Thu, 15 Feb 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ap220Frv"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE4BA37
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980305; cv=none; b=JqXpWokG0UHEGy2e6m9/s1z02LHfS4SCvg1Brt4EOnwqiZake8OIiyET5hGE+TpaIVijMJ8eRSFzOXFd0RYcXFBOQS4Lj1LKVn4NPzceEPbPjN25vcrJRRt2WkBSB+/DhN7AMfz5ImG48LvdjoNtTVQSE3/oEtpRuK1SBw97wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980305; c=relaxed/simple;
	bh=rrqrakVMh2CwiqgT49VVbRBSSEZK4ZNwEF8E3zVPwAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlXLfExP29hu+1MFhkbYrIZa6ZgBh0/VO5aotDGyaRqks3PrqAtY9QgNPx8yQMrO6KYHgbYi6qDBcsi+guKe/HnDVLkZMdZuqY0rlOv2nVM6MBGksH9Mn+oZPLUlwIbqa9EPWSgAaNOkBsubGOAjrxTwjUNMNa8+AckaVm6R/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ap220Frv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4U8Tkg5NEwftO2A4hO+rPpqrK6CjKdnJ9oxED/Cw8Bs=; b=ap220FrviDH5PR7HF5N4sqkMy0
	pHMmBmgQrKAlQohHs7zCZ8TMwiDE2JJShawCnko8tGjULaOkbrbNJ5/oT0FIUJniFQBQcmHJAXbjC
	ZmdOHR71Iqog9Y4ALTLpJp/ndfiUeUtM89q5VnmYridWw1McoCw6Kd3nLotNVSNGEsRSwMLvYU/Pf
	iQZFXtlf9GiiiensomuHn3vK2WWjm6N6AvFHBaTtlhB87nCZAFxpsH5N5s8exGRMAyumYLaWHWV/U
	u3MRh7XFmNhugeR4FNdwpi5FlHvVyhI7YzMxTickdPEmrEpzIQMrUzZtmi55tQAJ3Gt5o4bI5QpUh
	fnThg4bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVhO-0000000F9jf-0NzZ;
	Thu, 15 Feb 2024 06:58:22 +0000
Date: Wed, 14 Feb 2024 22:58:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
Message-ID: <Zc22DluhMNk5_Zfn@infradead.org>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com>
 <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 14, 2024 at 12:53:42PM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 14, 2024 at 12:36 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > NAK.  Please
> 
> What is the alternative?
> Remember, maintainers cannot tell developers "go away".
> They must suggest a different path.

That criteria is something you've made up.   Telling that something
is not ok is the most important job of not just maintainers but all
developers.  Maybe start with a description of the problem you're
solving and why you think it matters and needs different APIs.

> . get_vm_area - external
> . free_vm_area - EXPORT_SYMBOL_GPL
> . vunmap_range - external
> . vmalloc_to_page - EXPORT_SYMBOL
> . apply_to_page_range - EXPORT_SYMBOL_GPL
> 
> and the last one is pretty much equivalent to vmap_pages_range,
> hence I'm surprised by push back to make vmap_pages_range available to bpf.

And the last we've been trying to get rid of by ages because we don't
want random modules to 

> > > For example, there is the public ioremap_page_range(), which is used
> > > to map device memory into addressable kernel space.
> >
> > It's not really public.  It's a helper for the ioremap implementation
> > which really should not be arch specific to start with and are in
> > the process of beeing consolidatd into common code.
> 
> Any link to such consolidation of ioremap ? I couldn't find one.

Second hit on google:

https://lore.kernel.org/lkml/20230609075528.9390-1-bhe@redhat.com/T/

> I surely don't want bpf_arena to cause headaches to mm folks.
> 
> Anyway, ioremap_page_range() was just an example.
> I could have used vmap() as an equivalent example.
> vmap is EXPORT_SYMBOL, btw.

vmap is a good well defined API.  vmap_pages_range is not.

> What bpf_arena needs is pretty much vmap(), but instead of
> allocating all pages in advance, allocate them and insert on demand.

So propose an API that does that instead of exposing random low-level
details.


