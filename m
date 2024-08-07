Return-Path: <bpf+bounces-36601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7D94AF32
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC6F1C218E8
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77B13D63E;
	Wed,  7 Aug 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PEUyEeVs"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A12F3E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053258; cv=none; b=H5Fr/JJzdos8iIeP6gkBptQhD/KpJHpqUyBmEHXELbTfx1kv48RkD249Pa2gWDdjhbIc4+RFUenuGiYbSemSEzj3jF0PJ+7v2rQ8JF+BCj6tik/n081wcXGYpQiJ/ftI6fnRs69qkuRCsYCYflS87p6jnaBzR1Sv3z4PSIJDLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053258; c=relaxed/simple;
	bh=6seFhQ5B0derFqlcuc+efp2ZP4XCLtKs8bQhBAqO87Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovXdThOez7QIOxtLG8pgKYLxf1Pwsxsz5Dl42DNqorJUrUuMUb710EHW+njy4w1u8qrP+4c1fU+HtBsyuhI8WarDkADL+B9aCmvQKKBddNOhcooKYcDfibc1hbAOGtp55IvyzkWAMMyHf3SbNp85t1YrufJnD4WMfwSe8rykrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PEUyEeVs; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Aug 2024 10:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723053253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/gRiZ4u85fdbUyPuHXMYBPAy734NZeZvYCyZw5ZMIw=;
	b=PEUyEeVsssUP9Rnu+g+mH5LvNo+RYyWdYubmqmYCW4leg4nLp3Cfdmsw/zIH6TNfSxRaui
	MV4y/OEvjzY8QFF3PyKvhqhVAy+ApBxD4ANDL5bRyH4rwQ1pSgCAd08aGnL2m8JwaikDnJ
	cNpFASL1yTO4LwddyjmlvWgq+uOjdIo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org>
 <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
 <ZrOy2GFv5KDmFlZt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrOy2GFv5KDmFlZt@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 06:46:00PM GMT, Matthew Wilcox wrote:
> On Wed, Aug 07, 2024 at 10:19:11AM -0700, Shakeel Butt wrote:
> > On Wed, Aug 07, 2024 at 04:28:53PM GMT, Matthew Wilcox wrote:
> > > On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> > > > +	union {
> > > > +		struct {
> > > > +			struct address_space *mapping;
> > > > +			struct page *page;
> > > 
> > > NAK.  All the page-based interfaces are deprecated.  Only we can't mark
> > > them as deprecated because our tooling is a pile of crap.
> > > 
> > > > +			void *page_addr;
> > > > +			u64 file_off;
> > > 
> > > loff_t pos.
> > > 
> > > > +	r->page = find_get_page(r->mapping, pg_off);
> > > 
> > > r->folio = read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, ...)
> > > 
> > > OK, for network filesystems, you're going to need to retain the struct
> > > file that's used to access them.  So maybe this becomes
> > > 	read_mapping_folio(r->file->f_mapping, r->pos, r->file)
> > 
> > This code path can be called from non-sleepable context. What would be
> > the appropriate way to get the folio in that case?
> 
> There isn't.  If there's no folio, or the folio isn't uptodate, we need
> to sleep to wait for I/O.  We can't busy-wait for I/O.
> 

Failure is fine if there is no folio or the folio is not uptodate. I
assume we can do:

	folio = __filemap_get_folio(r->mapping, pg_off, 0, 0);
	if (!folio || !folio_test_uptodate(folio))
		return -EFAULT;

Is this appropriate here?

