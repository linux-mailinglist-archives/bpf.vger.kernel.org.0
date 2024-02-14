Return-Path: <bpf+bounces-21961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC185441C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FF128A38B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DC4696;
	Wed, 14 Feb 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bD1tbGyj"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9292581
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899799; cv=none; b=TPRoLn98PMnHYfDMeXDVH5REzDYAEYg8ZOgwKpfKhbvw014FhqqUsdtIbOMNkdE2N3c1u4ghyeoH03qUohloTIs1XtzbF0EVWrN6rVWYNMRM6s6xgf63qhimigQ7Yt9mMCde4hIhBP7fc+qw0OForY+Ex/b++8ciiRR7mq2IAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899799; c=relaxed/simple;
	bh=FAwnJq3izlpvEQ0ZenUQGoDOqeEXOLXqIb2haSeqqc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HesGV4pnGNuvKTjpqudX3Rif83F7L9mBtfvOv+HZst39bK4R6PHQnKNLIZAj6p5usID8aEJguw43eyxYPQVC5sNiL28rW1UIeEFJsrbmIJP6xswdG+/LkFyOwY6hIsF+Gu8qnpbOxUOzC5+Dn2kScpbuzXq3FBcBI9ULDuOOetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bD1tbGyj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ysgB/GGpyfayW7mHOvTqBQpAbr1V5Q1mXrOhN5+trOA=; b=bD1tbGyjej0aP5XLpeVu6se911
	aDrulCKCvfw0I1igpN6vIroKO/ldhvd4lgSAH09nzisa/jYFm2EW0ga7IlrcibKc6+D5d7PAtW5jX
	zQvJkVoOlfzT891jCFzG0/PjkTbozlM1egTfhigozVtl3h0S3axKS1LqJXm9+10hjA7f2x5M2kRQx
	G1RJlqqNEU5QCeremMtWP9hxoPhrjtQzOxC1vAe1eEnjrqc/qaUlIDLRDUCxdZXr92JUPpEmvNsAj
	nNqgWcCDXhoMjH+5SJlF7VDNqEkQlFfdmoSIoDEEM7d/h9D29fJb9hKfIyB/A+Fp3t4mdRWFckPAB
	n13h4doQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raAkv-0000000C9yS-1xDL;
	Wed, 14 Feb 2024 08:36:37 +0000
Date: Wed, 14 Feb 2024 00:36:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
Message-ID: <Zcx7lXfPxCEtNjDC@infradead.org>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209040608.98927-5-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NAK.  Please

On Thu, Feb 08, 2024 at 08:05:52PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> BPF would like to use the vmap API to implement a lazily-populated
> memory space which can be shared by multiple userspace threads.
> The vmap API is generally public and has functions to request and

What is "the vmap API"?

> For example, there is the public ioremap_page_range(), which is used
> to map device memory into addressable kernel space.

It's not really public.  It's a helper for the ioremap implementation
which really should not be arch specific to start with and are in
the process of beeing consolidatd into common code.

> The new BPF code needs the functionality of vmap_pages_range() in
> order to incrementally map privately managed arrays of pages into its
> vmap area. Indeed this function used to be public, but became private
> when usecases other than vmalloc happened to disappear.

Yes, for a freaking good reason.  The vmap area is not for general abuse
by random callers.  We have a few of those left, but we need to get rid
of that and not add more.


