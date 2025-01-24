Return-Path: <bpf+bounces-49666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96BDA1B7AD
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912233A5CB6
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658C3BB54;
	Fri, 24 Jan 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCDzT1bX"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4970101C8
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728198; cv=none; b=nDkFYypIQT7Qw3CN5aAfL2Yp6o4m0HMdyJmJUNm0KsBNqNOjvROqkrYMe6EmBOiOXMPRa4LMepMQN0ebwMrVvo49FvNQGcLDExh8Eac8NMpdtLgRlLrt1fdL2lJ5oqEXfPKJoYpxnraM7StpntFl2Vt60fkGUB3g93Os+rVcy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728198; c=relaxed/simple;
	bh=dwnzQ4G4lXjsV/AdsTtPZa918Gtgi9iY27cBS50d9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3C6vHzIiqkAqLnEIH2eWkdKiz7WIeiInaLKs66vilS5iBUWBIupd4CE2S3ttnUz81bZH1YyYar0mv9GjnD3EOqYokwDoFaPlnpb2mIXBXazm+Jo44L9L6q+VSK3Ehi/prIOlGCGb8lQMwbAw+3ZEGHjfUVV4i5xr4Hse9tKxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mCDzT1bX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UeNtGGSFfj0bZDFmWGy23XwFx1PtMWKQH4oxaud+FZs=; b=mCDzT1bXtXa0gN3cRpykLCgIQc
	8GBM3nQd94xY+sse2sCYPhhdSx8tcG0CBNnO4e0icl5a5QaRFwLSR0SL2OCv9H0+ZMfeRxGI7rFWB
	/ajmmAVhWJRPWCEQwua2VgCFvPBzJFyKZy9PCcrw0G9UIrc6sNNUTy7yMw7fFMTP3o01m2GLCCdNh
	45o8VpAkVhoRd5Feo0mokjstF/p+F+pJ7gA1dYPl2vjJCI87Q/vYdkY5eGu1R4RYDhrg4aPPfXp0+
	eL4/eviJ5mbOB7N1JmFXyYi5FK3Kby1uqq5Fc+w/9r/A1uA5ZoVsGPQEjmYSPihgm5lm33aIqpCnJ
	f7aWorNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKU1-0000000GAVQ-2Ax4;
	Fri, 24 Jan 2025 14:16:29 +0000
Date: Fri, 24 Jan 2025 14:16:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
Message-ID: <Z5OgvePdlqRoKMyx@casper.infradead.org>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>

On Thu, Jan 23, 2025 at 07:56:49PM -0800, Alexei Starovoitov wrote:
> - Considered using __GFP_COMP in try_alloc_pages to simplify
>   free_pages_nolock a bit, but then decided to make it work
>   for all types of pages, since free_pages_nolock() is used by
>   stackdepot and currently it's using non-compound order 2.
>   I felt it's best to leave it as-is and make free_pages_nolock()
>   support all pages.

We're trying to eliminate non-use of __GFP_COMP.  Because people don't
use __GFP_COMP, there's a security check that we can't turn on.  Would
you reconsider this change you made?

