Return-Path: <bpf+bounces-36622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0914C94B1A0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB93B20E8C
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5A14659F;
	Wed,  7 Aug 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmPJnw79"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8BB82D66
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064003; cv=none; b=sFFMtj/xeSPuOAuaQZPEejdgNneC4qTz9RDRZD6JfZu/kZFD/Hferf1YGedaTuVa+K5dd4At24r1CIVQYtBK74+MP8oUrIQvUyiF5AZ3uyjx8iCvKu2gaLu3FhvwiA62keLaC9Q98qljx+rj0mFoAznBx/S3DAF9IiLtY0QP0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064003; c=relaxed/simple;
	bh=jxxixEQMJvbvQsLLgLMVXJzrlZWYMk+2RKUu2p96HCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqBlAcAXDnTwFZgQX9QsO9hVzXmNPStjaMy78tQAf6cXGM4phrUlRAB0B2UqxhdJt765dTr4hiAoOTLEyj2hIbAYY0vbQuVW2dSeaQieJcNy8xvxK9jOG7ZgVR3GFJB60Plyde01LHrLwfoZApBO3iw7amUlyofyP1Sshb19E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmPJnw79; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Aug 2024 13:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723063992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CpJebiw3rug0SKTHZUe013GB9cfIBU9Cc9EOAsSgh48=;
	b=AmPJnw797QD5mmAhWLAdHmUwwGcm23y0i8hcEUCu9QpxADD8AE6VrwDS+Fr4DCNrnSHMfj
	bE4S1kSDFXa5YlTNsdKhcZ+mD0x7HPjjclsjAW4gZnGES+tCDjlQpZRUeYvlZaJ5DP8Sjt
	l8c2tkdKfV92puIv+y9uZFR0nzxRTYY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <66tqr5zljbeeaz2dcdkzlgndfzx6cyklee4kydve6ktwckt25f@gx54qvvtubn7>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org>
 <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
 <ZrOy2GFv5KDmFlZt@casper.infradead.org>
 <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 10:54:08AM GMT, Shakeel Butt wrote:
> On Wed, Aug 07, 2024 at 06:46:00PM GMT, Matthew Wilcox wrote:
> > On Wed, Aug 07, 2024 at 10:19:11AM -0700, Shakeel Butt wrote:
> > > On Wed, Aug 07, 2024 at 04:28:53PM GMT, Matthew Wilcox wrote:
> > > > On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> > > > > +	union {
> > > > > +		struct {
> > > > > +			struct address_space *mapping;
> > > > > +			struct page *page;
> > > > 
> > > > NAK.  All the page-based interfaces are deprecated.  Only we can't mark
> > > > them as deprecated because our tooling is a pile of crap.
> > > > 
> > > > > +			void *page_addr;
> > > > > +			u64 file_off;
> > > > 
> > > > loff_t pos.
> > > > 
> > > > > +	r->page = find_get_page(r->mapping, pg_off);
> > > > 
> > > > r->folio = read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, ...)
> > > > 
> > > > OK, for network filesystems, you're going to need to retain the struct
> > > > file that's used to access them.  So maybe this becomes
> > > > 	read_mapping_folio(r->file->f_mapping, r->pos, r->file)
> > > 
> > > This code path can be called from non-sleepable context. What would be
> > > the appropriate way to get the folio in that case?
> > 
> > There isn't.  If there's no folio, or the folio isn't uptodate, we need
> > to sleep to wait for I/O.  We can't busy-wait for I/O.
> > 
> 
> Failure is fine if there is no folio or the folio is not uptodate. I
> assume we can do:
> 
> 	folio = __filemap_get_folio(r->mapping, pg_off, 0, 0);
> 	if (!folio || !folio_test_uptodate(folio))
> 		return -EFAULT;

And a folio_put(folio) if we return due to !folio_test_uptodate().

> 
> Is this appropriate here?

