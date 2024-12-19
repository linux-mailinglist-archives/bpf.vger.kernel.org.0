Return-Path: <bpf+bounces-47305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940B9F753A
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DBB7A3C01
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80569216E0F;
	Thu, 19 Dec 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c8fzfWUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7398BE7
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592706; cv=none; b=qmCZlFEfnZVvyixp1kCPULiRGNABX194ZUUQpWr8FVBKsNQx1iA86Axc3xuOoQ9vVwsjP1KB7vI+CUrVY9P2uiIJZAirmv22Us6Ol71MQsgmAFDXQNvJz+CeLdU75yLQHkzlX1HOCB3rH0HtHR7uTA2bHfFwL67lYbjrUyoNC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592706; c=relaxed/simple;
	bh=X25t5Hh9nWKlMB85Fq3P5bTyEp15jNVswWpg3cEU2m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es+2iObbtLGdpU3p3pLOk9vmhdgF2Ik2QZGduNPbrOMzbyZydqlPCJC1f94BAG2h6nBCqaDpmj1+Oj0KOqfqouKfX0Qe1qdN/diBgAyoei+XcDtylJFwB2kiCsds46675KyzbLuHn/eT4Iyl7dA0VCEreOy7EMRLDsKQvhvXRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c8fzfWUV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e2880606so319719f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734592702; x=1735197502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kws6F4aGXDE2zQGbUn1q8E6/DvmEpDpQpDP0JLhajdM=;
        b=c8fzfWUVirdGIn5rsTuiQBacu4EBfaUI0aeTNUIiVu9dMAb6FGgsYicGXJIvZog98h
         98x6x3z11rrARZfML2A6LEcnE1eXotNSxnHPKduq6iZj1n4NRJ+0oPBL/hTy0XwhN0GG
         NdQTyVFHeioChbz/VEVPuo+lBpUNuw7pAg9vuRX3RkzaBM7RLZCzEDcREvb4p0MqCk9e
         wHRudWNgkFUoBAcXYnGAd/bhZyWisqQkrFkHuidA2dsuXvNTQhTb8aTeysD+7yorqji0
         IOXklOW3qjdPW4FqFpRkNgWKmJnejWGPy3mDDe2Z27CMGxF6oIretmgKh9LBhlK+Vsbz
         FSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734592702; x=1735197502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kws6F4aGXDE2zQGbUn1q8E6/DvmEpDpQpDP0JLhajdM=;
        b=oYZbgQBV16geRoD8vnOBn1OHOUX7Qf3XBfebeRtTIwZRowxN7/9tlpxh1hDrWQnZDz
         3vfcyC92xQBWSx/t5F+QYwwVgmRMlxM02BaE+R7cvE+duq1HIrIYdgGRqVP+pFyEFrHN
         igIeP/W53BtbHRDTFXslYEW2xBlAnUfZNyrQ7xlSlvSee9rGteaa+yIaZgSGMen2k41E
         8k55U0gFXpdmzXaMGZV7bsA7OhBF5fg+7Kts3d1WbfcbAOsl/LDdwyK3qVLRA024ugD0
         09NhVKzRXOdzqE8xw2d5NkgkI/KDJtM3fQnMUIDInZk6kCpUVFL26E57OhBLcbMhmNiE
         3/lg==
X-Forwarded-Encrypted: i=1; AJvYcCXugixlvPHIbxU5huG3ewHmwiGCeZUisWBsBkZuk6sEndLXszchTcoUcOc4ZpNPbKQsLX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbpFgXfRved2yQUrEZwl9Ng2D1vczvozsdQbztEKKUIIktq/Y
	HE6AoyjlB8nlm90Q74deMoANMenqZhHw4acgJoOJObIcLs2080LnWzigpW7+6UY=
X-Gm-Gg: ASbGncsm82eS89jOwZ61wqjuqmVUxxr5m9iuSnA7KTO38Cbi1esvKu1DSLn4SlyayQj
	nkk2jtENo6u3helCqbVHMGwEdBJbQeh0Xn0jyYGYTDK7F0BKx/edZOH1W+Ina3OHDRXTfUyJ05E
	repMtHJrUsznFbeX11m/+lD+UBfG75TgQtFay9pQGHuS8WUA7dy/fvuec5S8eWnOxqlEAbwOULQ
	r2urpu4UsT5GvchOnOOVDlcUkauJGmb+ACaoosJaCfxpPGi6dKQjK4ogO2yJfZ+
X-Google-Smtp-Source: AGHT+IFoaJwkmK5fLiU8iusoSRP2x655MlL86kCImDrAnz+sbhdizEPk0PkRzRaNgqHEocZ3EndW+g==
X-Received: by 2002:a05:6000:1a8b:b0:386:3903:86eb with SMTP id ffacd0b85a97d-38a19b05278mr2083037f8f.23.1734592702217;
        Wed, 18 Dec 2024 23:18:22 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82eb6asm34457066b.27.2024.12.18.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:18:21 -0800 (PST)
Date: Thu, 19 Dec 2024 08:18:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org,
	vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org,
	houtao1@huawei.com, hannes@cmpxchg.org, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z2PIva9w8OKW9yYv@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
 <Z2KyxEHA8NCNGF6u@tiehlicka>
 <mnvsu2v4tnhhbzmebzg6mdmglcs3kq2nxqj2kz3v6p2eigcy6l@c5amf2pgd4zq>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnvsu2v4tnhhbzmebzg6mdmglcs3kq2nxqj2kz3v6p2eigcy6l@c5amf2pgd4zq>

On Wed 18-12-24 16:05:25, Shakeel Butt wrote:
> On Wed, Dec 18, 2024 at 12:32:20PM +0100, Michal Hocko wrote:
> > I like this proposal better. I am still not convinced that we really
> > need internal __GFP_TRYLOCK though. 
> > 
> > If we reduce try_alloc_pages to the gfp usage we are at the following
> > 
> > On Tue 17-12-24 19:07:14, alexei.starovoitov@gmail.com wrote:
> > [...]
> > > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > > +{
> > > +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
> > > +			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;
> > > +	unsigned int alloc_flags = ALLOC_TRYLOCK;
> > [...]
> > > +	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > > +			    &alloc_gfp, &alloc_flags);
> > [...]
> > > +	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> > > +
> > > +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> > > +
> > > +	trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
> > > +	kmsan_alloc_page(page, order, alloc_gfp);
> > [...]
> > 
> > From those that care about __GFP_TRYLOCK only kmsan_alloc_page doesn't
> > have alloc_flags. Those could make the locking decision based on
> > ALLOC_TRYLOCK.
> > 
> > I am not familiar with kmsan internals and my main question is whether
> > this specific usecase really needs a dedicated reentrant
> > kmsan_alloc_page rather than rely on gfp flag to be sufficient.
> > Currently kmsan_in_runtime bails out early in some contexts. The
> > associated comment about hooks is not completely clear to me though.
> > Memory allocation down the road is one of those but it is not really
> > clear to me whether this is the only one.
> 
> Is the suggestion that just introduce and use ALLOC_TRYLOCK without the
> need of __GFP_TRYLOCK?

Exactly! Because ALLOC_$FOO is strictly internal allocator flag that
cannot leak out to external users by design. __GFP_TRYLOCK in this
implementation tries to achieve the same by hiding it which would work
but it is both ugly and likely unnecessary.
-- 
Michal Hocko
SUSE Labs

