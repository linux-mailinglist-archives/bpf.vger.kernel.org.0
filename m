Return-Path: <bpf+bounces-42322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998B9A2927
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE1CB2857B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC931DE2C9;
	Thu, 17 Oct 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ScJR6ayF"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDE1DE4DA;
	Thu, 17 Oct 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182947; cv=none; b=WgXLrKgqskLOftRf930NsInJ2sozOm5FzgVQByGCFrCOhmlg8WTzMooW9qKWWv1koZGuDn3KxNhEB2k8NV0/3Dfez9EKTmN/CETiABZjLcqcbViUZwzId0JI4/uwoZLeq76u2kgD1C61kDwl37/dXVBGCrnNnJocH2yls9EVsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182947; c=relaxed/simple;
	bh=daLlGC19T5Jl/YCRIT2Tq3tej/qcwu0XX2d0AuNf0ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6F+BgxDDr2w365TRtkOCcHT3VHSYPvJw28DtNmBEUp937QD+n/yt8lYoIQkNKZUaXbdGeTGDPXtdFOb/YskVa8AAH+k4vm0TziVI8hB4X985DpZVQrSRFooGg8tFsIaoKhrw9zQkIJMtlEnqwNxPeByheA2pjxMH9sipa9rXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ScJR6ayF; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Oct 2024 09:35:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729182940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uv4u/dmDTQJhJoxVvRtBaO6HLRbACzvQxs5bHjLIACw=;
	b=ScJR6ayFPyLgeWRn4F5FTI6XN6xRijnlkjHUdIvQEfwkDZx8BgeDSaUof4NZtSP6Lpoqdd
	nqqyColVTwsmvwl2sYQy3h5y+KqLBMoszqHpWe2DSSUDktNroHVLwc83Zy3XEmGmoFnauU
	a63TZ/9zXeaSeMUy2Reu3B8zB/wgfss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>, g@linux.dev
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, rppt@kernel.org, 
	yosryahmed@google.com, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <oeoujpsqousyabzgnnavwoinq6lrojbdejvblxdwtav7o5wamw@6dyfuoc7725j>
References: <20241016221629.1043883-1-andrii@kernel.org>
 <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 11:18:34AM GMT, David Hildenbrand wrote:
> On 17.10.24 00:16, Andrii Nakryiko wrote:
> >  From memfd_secret(2) manpage:
> > 
> >    The memory areas backing the file created with memfd_secret(2) are
> >    visible only to the processes that have access to the file descriptor.
> >    The memory region is removed from the kernel page tables and only the
> >    page tables of the processes holding the file descriptor map the
> >    corresponding physical memory. (Thus, the pages in the region can't be
> >    accessed by the kernel itself, so that, for example, pointers to the
> >    region can't be passed to system calls.)
> > 
> > So folios backed by such secretmem files are not mapped into kernel
> > address space and shouldn't be accessed, in general.
> > 
> > To make this a bit more generic of a fix and prevent regression in the
> > future for similar special mappings, do a generic check of whether the
> > folio we got is mapped with kernel_page_present(), as suggested in [1].
> > This will handle secretmem, and any future special cases that use
> > a similar approach.
> > 
> > Original report and repro can be found in [0].
> > 
> >    [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> >    [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com/
> > 
> > Reported-by: Yi Lai <yi1.lai@intel.com>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   lib/buildid.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 290641d92ac1..90df64fd64c1 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -5,6 +5,7 @@
> >   #include <linux/elf.h>
> >   #include <linux/kernel.h>
> >   #include <linux/pagemap.h>
> > +#include <linux/set_memory.h>
> >   #define BUILD_ID 3
> > @@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
> >   		filemap_invalidate_unlock_shared(r->file->f_mapping);
> >   	}
> > -	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
> > +	if (IS_ERR(r->folio) ||
> > +	    !kernel_page_present(&r->folio->page) ||
> > +	    !folio_test_uptodate(r->folio)) {
> >   		if (!IS_ERR(r->folio))
> >   			folio_put(r->folio);
> >   		r->folio = NULL;
> 
> As replied elsewhere, can't we take a look at the mapping?
> 
> We do the same thing in gup_fast_folio_allowed() where we check
> secretmem_mapping().

Responded on the v1 but I think we can go with v1 of this work as
whoever will be working on unmapping folios from direct map will need to
fix gup_fast_folio_allowed(), they can fix this code as well. Also it
seems like some arch don't have kernel_page_present() and builds are
failing.

Andrii, let's move forward with the v1 patch.

> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

