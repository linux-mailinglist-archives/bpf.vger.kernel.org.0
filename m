Return-Path: <bpf+bounces-68244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E29B55565
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16A7560E2B
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086D258CFA;
	Fri, 12 Sep 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dq1gGAGU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D234238C15
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697341; cv=none; b=FpE1jW+t9iRe7iHlk/xgrT5zS+WCG23mfo31yb2ryPBLe+iNNws4HKHtKCuIUEgixMIyROxOO5xH4hUyION8Rqkc0tqKgBIK8W2gLPxd2hE9NW+9ccwS5ZXAiVlSXZA4ymZH8KmaYqhrd1gk8IUbWlwyAW+G0Yx+H/l/Xp+1Qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697341; c=relaxed/simple;
	bh=6IKo1OZr4n/GI2HcZjY8nMJyl8MbIwDIZEFuJkhd78U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt2bhjUWAe9sy8Z+LnsjPYLPKFD37jqSAUbRsjh0wzLtzmSXeAsS5mCloSBYMr01K58QjKt7rbJRETZL8N1YBG9l+RTrNjlN/JvHQXPCbbseJqVnSvVkqh1K6LUVOTuIDRELlptnWa+qviNnduh23Ti3gq5gKN16R7//cmSe9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dq1gGAGU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/mACRupVkoZ303cQFM5AZgG0pe40b2jKBdiZV9tXrW0=; b=Dq1gGAGUIecMjVoAzgNv5v3/cV
	ceIGzx5xvAC2s9XYb7P3QdEsMuqHC7hkxLq6OL/Aazr3KQ8gUn39C5JcS0f2lGlqgHpHrwwe1LU8W
	3Thv5U9l/Gl9Kz1g3vR1Y/u58/8TKFVcfcngDgrEm7moMzmne4+SbTIowX/yNVCAYMILzETWABQyg
	WJA30A8m/P/lQ/XWqf5Stdbh3z81h6hzf8QJrE/ME80HdxTwX5Yba4oAxtm2BSgzNkCwrjSXWdDws
	+AOhUY/HItwivIj9tX2u12eMPRZcl/0OvQO7cYEKTjtlxcXMDmMXuKRD4iBgGz9z+r3awCb3fDWlT
	RP0hFlZA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux7N0-00000002jb4-2eKQ;
	Fri, 12 Sep 2025 17:15:34 +0000
Date: Fri, 12 Sep 2025 18:15:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, vbabka@suse.cz, harry.yoo@oracle.com,
	mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org,
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org,
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in
 alloc_pages_nolock().
Message-ID: <aMRVNqH47mdkl5Ke@casper.infradead.org>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-3-alexei.starovoitov@gmail.com>
 <2kaahuvnmke2bj27cu4tu3sr5ezeohra56btxj2iu4ijof5dim@thdwhzjjqzgd>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2kaahuvnmke2bj27cu4tu3sr5ezeohra56btxj2iu4ijof5dim@thdwhzjjqzgd>

On Fri, Sep 12, 2025 at 10:11:26AM -0700, Shakeel Butt wrote:
> On Mon, Sep 08, 2025 at 06:00:03PM -0700, Alexei Starovoitov wrote:
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d1d037f97c5f..30ccff0283fd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7480,6 +7480,7 @@ static bool __free_unaccepted(struct page *page)
> >  
> >  /**
> >   * alloc_pages_nolock - opportunistic reentrant allocation from any context
> > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
> 
> If only __GFP_ACCOUNT is allowed then why not use a 'bool account' in the
> parameter and add __GFP_ACCOUNT if account is true?

It's clearer in the callers to call alloc_pages_nolock(__GFP_ACCOUNT)
than it is to call alloc_pages_nolock(true).

I can immediately tell what the first one does.  I have no idea what
the polarity of 'true' might be (does it mean accounted or unaccounted?)
Is it rlated to accounting, GFP_COMP, highmem, whether it's OK to access
atomic reserves ... or literally anything else that you might want to
select when allocating memory.

This use of unadorned booleans is an antipattern.  Nobody should be
advocating for such things.

