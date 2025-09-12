Return-Path: <bpf+bounces-68248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D8B55594
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE681D62F77
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA743164CA;
	Fri, 12 Sep 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qe2cX+Zw"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511219004E
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699210; cv=none; b=kwdIVyRyRAScJo+FoDIntmB8quP7GZSgxbyxP/DGX/lZZpm4pfsAB/iAv9u7vJEC6ksi+J5kBDaFwLF7vXljMTFgpHa3le4To+jQjh2mFukQs3PFuSGpGUm2j/RYzh7P+GXj7vk8ZGu1/MnBDUBHJ5pvRQ5YXnuwaAvdXtXB2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699210; c=relaxed/simple;
	bh=0eE5CNvYRuk00/tG+lKvuE8CKlGPcH049Xe0wEcZFHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFMO1jMl24/XPtzAQx9+BejVlQKyBm1k1zepwwLpjoXEXo0besS5n7Gq9yQY2Q45TuxvjE0cl2FJC0aFZvTzLQudUEbpYYjVac5KncIzbpyV5yNQRSq829ejxwd/Yqo/AvepVizQZ0xUhkhot1t5aMzA/YscRNgk1N3ZwCMkVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qe2cX+Zw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 10:46:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757699205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw7f5TtJIYqwNPOyneHeov3n6RLT179M/tH+XL6psMs=;
	b=Qe2cX+Zw6g/o/Vyywjq1zLa6mXLmwCwRkOo7yknYXmUVxxh4yTZQHIKkPA3GDUlDAJCpo0
	o1w0bFnPJ0q+wkrUU8W5/3FPVQ7llM6tfnurK+cZ3D5UyE2pFyWBmvIfxoYrBgaN8lxDF6
	lDw+2UrHRpQ7+R61IHCGY2ASSTRLfSo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in
 alloc_pages_nolock().
Message-ID: <jcofoqbchq37v5ypzrolh4yn5qmjikmdgqkhqb7nemkzjh2igk@26kcqwo723xv>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-3-alexei.starovoitov@gmail.com>
 <2kaahuvnmke2bj27cu4tu3sr5ezeohra56btxj2iu4ijof5dim@thdwhzjjqzgd>
 <aMRVNqH47mdkl5Ke@casper.infradead.org>
 <CAADnVQJbx0Wf4xrAEfQyZhhpC13zJH6NqdFjYQ+StQzzi+Y=Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJbx0Wf4xrAEfQyZhhpC13zJH6NqdFjYQ+StQzzi+Y=Nw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 10:34:15AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 12, 2025 at 10:15 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Sep 12, 2025 at 10:11:26AM -0700, Shakeel Butt wrote:
> > > On Mon, Sep 08, 2025 at 06:00:03PM -0700, Alexei Starovoitov wrote:
> > > [...]
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index d1d037f97c5f..30ccff0283fd 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -7480,6 +7480,7 @@ static bool __free_unaccepted(struct page *page)
> > > >
> > > >  /**
> > > >   * alloc_pages_nolock - opportunistic reentrant allocation from any context
> > > > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
> > >
> > > If only __GFP_ACCOUNT is allowed then why not use a 'bool account' in the
> > > parameter and add __GFP_ACCOUNT if account is true?
> >
> > It's clearer in the callers to call alloc_pages_nolock(__GFP_ACCOUNT)
> > than it is to call alloc_pages_nolock(true).
> >
> > I can immediately tell what the first one does.  I have no idea what
> > the polarity of 'true' might be (does it mean accounted or unaccounted?)
> > Is it rlated to accounting, GFP_COMP, highmem, whether it's OK to access
> > atomic reserves ... or literally anything else that you might want to
> > select when allocating memory.
> >
> > This use of unadorned booleans is an antipattern.  Nobody should be
> > advocating for such things.
> 
> +1.
> We strongly discourage bool in arguments in any function.
> It makes callsites unreadable.
> 
> We learned it the hard way though :(
> Some of the verifier code became a mess like:
>         err = check_load_mem(env, insn, true, false, false, "atomic_load");
> 
> it's on our todo to clean this up.

Sounds good.

