Return-Path: <bpf+bounces-36592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8C94AF13
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F3E1C2187B
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375A13E033;
	Wed,  7 Aug 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPYTZWLn"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172A12CDBA
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052770; cv=none; b=TDNeU8Y8+WspV6gQ1+PX/jTUtp4ASKKX+R2doPGhf6PoQP9Dqs9OoQyN2ciWS8H+QJPbjjuv6MOdBB06ZlgPILNzo2ARgYPL2MoVFBkAz7qi6E2UwHRD/GK/nMCWDMeqPmp6z2WqVvRZ209e9JDZHMFJoKl6ACCzYrrzeYPn7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052770; c=relaxed/simple;
	bh=6kBRvvI/8tL9GRxn7poIp1rj/1RieNzwLBd1qehIwLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYyjUSWlmWUmA9/bO2QG23T/EIgc/CRA0mMnPapg6bEKNyP5FUH4SnIyQ+2k+V/byf0SgNSLX9ogAWt+40r5j6uQF1yCDtGcaFgdNidmJ/JQDQFnASD3GrVrsz4CRkKXUBdBp6Yra6wVlnjBpcit5xqpjlYOY2Urht+EHax8RxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tPYTZWLn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EtYRS+Oi93Ncw0e7KaodQd6bbVnEoZrxKxW79PBbhEA=; b=tPYTZWLnmcGYvZrCTBWbzu18Mt
	jISnwxh11ftau0UcalGuqEfX1k0LuiBqd8Qo0ZUOBw7gnmHFTwzETlwjiHl5/U4Bxiy+fIgerbwpA
	QNPOAxrGwra2sc55NV58aupuzLIWMhHMDHtfJqLIizC2cw9W9O92QpaRSzpmlABCz5SChV7cejdIz
	NQNtMNmc2bzb8cvxgu4VUjl8j9ns3vYg33wqYHAUuELIEmCord0M6BVO/1enD3ceiwPjAWq/5933s
	SoaJzMbFd/2ygW236opN129yUEaPEYXwHyZql5gcLAx1MGZLA7aZy2q0AigfnSD3BLaPQ54XazE7M
	wpsEOo9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbkjZ-00000007i3R-076v;
	Wed, 07 Aug 2024 17:46:01 +0000
Date: Wed, 7 Aug 2024 18:46:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com,
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com,
	song@kernel.org, jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZrOy2GFv5KDmFlZt@casper.infradead.org>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org>
 <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>

On Wed, Aug 07, 2024 at 10:19:11AM -0700, Shakeel Butt wrote:
> On Wed, Aug 07, 2024 at 04:28:53PM GMT, Matthew Wilcox wrote:
> > On Tue, Jul 30, 2024 at 01:39:06PM -0700, Andrii Nakryiko wrote:
> > > +	union {
> > > +		struct {
> > > +			struct address_space *mapping;
> > > +			struct page *page;
> > 
> > NAK.  All the page-based interfaces are deprecated.  Only we can't mark
> > them as deprecated because our tooling is a pile of crap.
> > 
> > > +			void *page_addr;
> > > +			u64 file_off;
> > 
> > loff_t pos.
> > 
> > > +	r->page = find_get_page(r->mapping, pg_off);
> > 
> > r->folio = read_mapping_folio(r->mapping, r->pos / PAGE_SIZE, ...)
> > 
> > OK, for network filesystems, you're going to need to retain the struct
> > file that's used to access them.  So maybe this becomes
> > 	read_mapping_folio(r->file->f_mapping, r->pos, r->file)
> 
> This code path can be called from non-sleepable context. What would be
> the appropriate way to get the folio in that case?

There isn't.  If there's no folio, or the folio isn't uptodate, we need
to sleep to wait for I/O.  We can't busy-wait for I/O.


