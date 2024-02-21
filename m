Return-Path: <bpf+bounces-22378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C685D022
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 06:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D385B2450C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697539AF1;
	Wed, 21 Feb 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NiN7EbQJ"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AA3A1AC
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494736; cv=none; b=LYchNBTKoBq69VVEDDxEIcrzDS7FLpHejSvoMEagrpVBVJbdLMHyzbdMkRUBySdtaFGipZwYcIQEvplHPzBXvGs5y8SVU7gJ1GCZkeaC08qmOJNJeQhw4U/t2VgqckgZAODNYjAukyXvfNeqO4hjxdy/mDsknDsw3AycDOJZ51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494736; c=relaxed/simple;
	bh=dMSjqrA7qa54g2+SzoIciLB6oG2hHmcgMXm3LQeX86s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmzhNcwuHCz5c16IP/MBHDRbv9eOLC8OOUNmHNW5bl5LtNJ1ss0af1pZYopsS225mulhhnQ7BuG9oA70hjqXFtmlz0WUHBdQR26Fd/uvOUlorOr/YngBNgF2OUsSTjmPngCc0vbWwT/Fi8DA9kTLabbuTZ6fdgGD3VOz2eDMvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NiN7EbQJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UbNxQ1liHw+Zrw6EYvRDTxiCL1NoWqq2klpIUBju22A=; b=NiN7EbQJMivDDH04XSw2wwT8Q7
	ymkmtYksxuEvgW9GXmt8TsFhqWs4aFtICRWpTElPeEM7hh9Wf5mSPQNV5n+yWBTj3IOKJnRaU2HXB
	N4aFKolR/us4pGgPPhUOe50r4XF2bj0rzwyZiDbgKrXf7zyLfb7bbfit9K1wi8afBqvITSTtVl4Lk
	dfz1qusktLYFTgNPbOs64HGfdhs2rYW0EmAuVOWLET0yDhSkhYOt5Rh8enh/gzsZGqY21DPQKgg7I
	w1rLPXPV80gFailh9mvKqu3bsqjq3MAVHZc4nVpWbvTYbFlETJ6ydjmdyNlojTK/EBQWxv0ero0Ud
	RgMSoqUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfWg-0000000HGti-0kHQ;
	Wed, 21 Feb 2024 05:52:14 +0000
Date: Tue, 20 Feb 2024 21:52:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
Message-ID: <ZdWPjmwi8D0n01HP@infradead.org>
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 20, 2024 at 11:26:13AM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> vmap() API is used to map a set of pages into contiguous kernel virtual space.
> 
> BPF would like to extend the vmap API to implement a lazily-populated
> contiguous kernel virtual space which size and start address is fixed early.
> 
> The vmap API has functions to request and release areas of kernel address space:
> get_vm_area() and free_vm_area().

As said before I really hate growing more get_vm_area and
free_vm_area outside the core vmalloc code.  We have a few of those
mostly due to ioremap (which is beeing consolidate) and executable code
allocation (which there have been various attempts at consolidation,
and hopefully one finally succeeds..).  So let's take a step back and
think how we can do that without it.

For the dynamically growing part do you need a special allocator or
can we just go straight to the page allocator and implement this
in common code?

> For BPF use case the area_size will be 4Gbyte plus 64Kbyte of guard pages and
> area->addr known and fixed at the program verification time.

How is this ever going to to work on 32-bit platforms?


