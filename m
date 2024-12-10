Return-Path: <bpf+bounces-46497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC899EAB47
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 10:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774CB1637F1
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276EE23279C;
	Tue, 10 Dec 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JiV2yYcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0D23278B
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821527; cv=none; b=Z08VdfYC8zq/OruZqkcz3lDYJAn+R5O53gzGStbesD+3Um9p3flOdWQo+DYEZC6j2EOKqUDiTraHDOgUP3XU2lX/XGNU5AbwrTI54NaZ6VauRtyWtEF/kxgq79riKZ11X+rggyqJusdMGP7i+hoiz7d2juEU+SoUS5GSMzJaWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821527; c=relaxed/simple;
	bh=akmv0nQLvNQQ1OsptTv1/Ng7PJq84X0IQ75Y5GICxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXYYsoZiYhCFATiGbVX84e4fD1ql//kVAWIqWaM3Ig1rXlEbFHhFewBzRvQONkcGiS7PPoclOO1I9kXr/ZDiTawKsizJJnFWF6ZhfcCFyGZyUJaB/dG49O+QUlapy2wNBfD7iyygVXBOng6Kx037oeAIZweqrDR40BD/qSv15bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JiV2yYcd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso57685135e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733821524; x=1734426324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSWf57S3pNx/JU1MiKz6Yk8eQ8jvmeUXwiP4HDO3kQM=;
        b=JiV2yYcdsPIKaSiDZho0z/isCCJRR4QHx0IEgAaLraO9cACBuijzX4zzYM2JhIgIQY
         3Fs99FYiJmMXYHmI9Pxs9YNVrQttHvrrTzsy66pf9XVWnqoaByEP+cbkQjwr2CiT092x
         m/pyhCHA45BmiDhNZeH87zNTYBg9ZPJx8fiJKJptmZECH3VO1LOEaqLmMmgOVnldat70
         ZBmmpskJuiF7w/iqO+oVUg7qw5LmWYmcFdsPxt/2Oxvd/iq3EdTnmLdyGXGOaEKo/+1e
         BdqyfvWFIlyJjROLMVBoW26EF6ics2wYItMh5Fg+WTn9JbPkcML1ilV47AruKYy5D/0q
         D9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821524; x=1734426324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSWf57S3pNx/JU1MiKz6Yk8eQ8jvmeUXwiP4HDO3kQM=;
        b=tm5XPDU86HkX/4KLpxAfSX7ViP8mO+3Hl1LRB5s/vfnABdrS6WJ5+FaxMsX6PwlX4I
         +3+BGROMCBQ0U/+sZgbynsf2IiahABR4Q1g2RjtV2eSTS1oXMee+13uG2UCI1laJ2dAF
         Rh8suL1kxsFbjaEMYYFGVO3+qvbaMexCHEeuz3gT5RloXxE3k4zGcwzpcCcm5WaY2bvf
         OmxdWKN/9TrcmieptHF7+vKTUpVm85Xn2LtVoJjh8VineyetkyAYM3ZMO1fMWklo4gmw
         CrKR4FaerpUS9dAieHUDbiH8kdCt3rzCg5cAZ1XNZUEI7EXPLduOsAxrLM5esZjRw5hk
         70cg==
X-Gm-Message-State: AOJu0YyouUAjKQarQzepJRBzDl9xBb/jpunWu7J3Gr64K7WFij4c5Uaa
	rIikV7BN7L9+QH+83koO3sXIfBjW0Ftggmk7VD1nbE/15QaAVuzygSvEHTBmRUc=
X-Gm-Gg: ASbGncuxR2iY+5uk2rC9iDY3YxMVK1Zcq3ASUsoH/CrS9HGWQLva4dZ8Wy2PpatgM2M
	uQEK21sKGGBv1wV1iz6xZaSpyQ1OPX5LaF2NbFktjL+n7YKsqCwqAq234EsIkhAjDvLP61FJYZk
	hUauQRPEK0NsQW44QcgO+jgXx9Vxa8aSGPPzMQctPmKY4etVPfSc6Yqbuw3IpNDVFTGPLdXerRW
	9fXuULKAbf+4BIivzwczFoJem8QYteAw+vWrpTOur+34l3j6FsufzUZKPpiK4ZL/bc=
X-Google-Smtp-Source: AGHT+IF2iKP0yVCjz96JB1POvOOwu3Kr/+2xWFzVMMQtlBZ+Vt7KGeprjZJWL+m+4hqQSdJVSQqriQ==
X-Received: by 2002:a7b:cc90:0:b0:434:ea21:e152 with SMTP id 5b1f17b1804b1-434ea21e3b2mr83111495e9.5.1733821523820;
        Tue, 10 Dec 2024 01:05:23 -0800 (PST)
Received: from localhost (109-81-86-131.rct.o2.cz. [109.81.86.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434e8ec8072sm114404685e9.18.2024.12.10.01.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:05:23 -0800 (PST)
Date: Tue, 10 Dec 2024 10:05:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, tglx@linutronix.de,
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <Z1gEUmHkF1ikgbor@tiehlicka>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1fSMhHdSTpurYCW@casper.infradead.org>

On Tue 10-12-24 05:31:30, Matthew Wilcox wrote:
> On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > +	if (preemptible() && !rcu_preempt_depth())
> > +		return alloc_pages_node_noprof(nid,
> > +					       GFP_NOWAIT | __GFP_ZERO,
> > +					       order);
> > +	return alloc_pages_node_noprof(nid,
> > +				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> > +				       order);
> 
> [...]
> 
> > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> >  	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> >  	 */
> >  	alloc_flags |= (__force int)
> > -		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
> 
> It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
> I was originally wondering if this wasn't a memalloc_nolock_save() /
> memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),
> but I wonder if we can simply do:
> 
> 	if (!preemptible() || rcu_preempt_depth())
> 		alloc_flags |= ALLOC_TRYLOCK;

preemptible is unusable without CONFIG_PREEMPT_COUNT but I do agree that
__GFP_TRYLOCK is not really a preferred way to go forward. For 3
reasons. 

First I do not really like the name as it tells what it does rather than
how it should be used. This is a general pattern of many gfp flags
unfotrunatelly and historically it has turned out error prone. If a gfp
flag is really needed then something like __GFP_ANY_CONTEXT should be
used.  If the current implementation requires to use try_lock for
zone->lock or other changes is not an implementation detail but the user
should have a clear understanding that allocation is allowed from any
context (NMI, IRQ or otherwise atomic contexts).

Is there any reason why GFP_ATOMIC cannot be extended to support new
contexts? This allocation mode is already documented to be usable from
atomic contexts except from NMI and raw_spinlocks. But is it feasible to
extend the current implementation to use only trylock on zone->lock if
called from in_nmi() to reduce unexpected failures on contention for
existing users?

Third, do we even want such a strong guarantee in the generic page
allocator path and make it even more complex and harder to maintain? We
already have a precence in form of __alloc_pages_bulk which is a special
case allocator mode living outside of the page allocator path. It seems
that it covers most of your requirements except the fallback to the
regular allocation path AFAICS. Is this something you could piggy back
on?
-- 
Michal Hocko
SUSE Labs

