Return-Path: <bpf+bounces-36590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EBA94AEBD
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48E51C21A0D
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DF13C66F;
	Wed,  7 Aug 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e3GlDODG"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF836BB4B
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051166; cv=none; b=rNsl1aA0GfzqlTmTKK822sAbjIrDQcM5KOU8jU0YyUDAGrXGFuTX65JxB4dFlOZyoaf85i18yTENEriquVxgebdhjauoHR/MlS/dEyM4ziU6UgqIe8/0BrLeD89OXNPOsH0nOOXOX1P8pdwdtHAAo7gmO+Bqc8sEWJBRZMSjirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051166; c=relaxed/simple;
	bh=lzdlgzgXUmWA8a3QZSWFKoy76vjtgu66pAjtOzrhpeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU8+OQDdq4mlLza4SGSiiqhOSFyQ+feueRJELA38SSl6To8ClQuiA5jcQ1F4Fw8EPfy2reawdknuO0qFnkgyjqdlBSGBkO1o+8+AR7sSXGzpcOsl8g1jh6UD8ssVbBJ2fw25zKsqBNKSfrFntg/k62M32jywz0N1SxE8sG8KDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e3GlDODG; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Aug 2024 10:19:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723051159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDolMjLogvtLOKvCLFCxWtwsIPRwEgozqSd5qcFw9Pc=;
	b=e3GlDODG9suTdSWE+91C7RlAJ1bIebFi8uP2+BP4ji91tFEerU/LeUlFqoeb5IkEYAHzuE
	MToLCFjyykdsEv0PqtYgCVkDtYFNhWKVI1pVSbFOaWY8VPQr0f5jtwmNLY8NU2NsGlzlBT
	hT7KD901dQx0Kox3tmYpe623zA6cs2U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrOStYOrlFr21jRc@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 04:28:53PM GMT, Matthew Wilcox wrote:
> On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> > +	union {
> > +		struct {
> > +			struct address_space *mapping;
> > +			struct page *page;
> 
> NAK.  All the page-based interfaces are deprecated.  Only we can't mark
> them as deprecated because our tooling is a pile of crap.
> 
> > +			void *page_addr;
> > +			u64 file_off;
> 
> loff_t pos.
> 
> > +	r->page = find_get_page(r->mapping, pg_off);
> 
> r->folio = read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, ...)
> 
> OK, for network filesystems, you're going to need to retain the struct
> file that's used to access them.  So maybe this becomes
> 	read_mapping_folio(r->file->f_mapping, r->pos, r->file)

This code path can be called from non-sleepable context. What would be
the appropriate way to get the folio in that case?

> 
> > +	r->page_addr = kmap_local_page(r->page);
> 
> kmap_local_folio(r->folio, offset_in_folio(r->folio, r->pos));
> 

