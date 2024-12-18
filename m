Return-Path: <bpf+bounces-47228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD99F64E7
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE56216C6D6
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707E19CC20;
	Wed, 18 Dec 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GdBPYOLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F5195385
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521545; cv=none; b=NaS0UkyGA/LHBisg9490nqmc12VK527TCteCFHzv/9h+Sd1YLyvckZCvduCp4/xYMcAKfSlghq5YJKWCNgm3bh9l6XtfyF33xdr6sWNwKK08LziCFLElPhjZ0nM1c5up80jLg3qDd/jApMAaO5fCM11TKeVhXG3XXgqamkcwt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521545; c=relaxed/simple;
	bh=g7MD1ao0rMDOIVaI+rYkIEslv/AedL95ohwgwWfHVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbp5G43+yIrfcuWf1tAkreqg20sdPlTKINIgROLcXLCFQcg6AUiaJ+gcoQgF3Y2YPIYLzwHgfsfLfSK56liMmd04oI4Y8XcTsdBKxdEIFThem8HRisTwzcvhOWH88VFBCqYKCS+jVwSaniQN8JyN6SRXLSYVwAVglAWaVkIUG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GdBPYOLt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aabfb33aff8so64726766b.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734521542; x=1735126342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnQWqaCjqBtW62hSVEa2zhH4lywtPn54oTc9oEo9iq8=;
        b=GdBPYOLtjdKWKRQdYRoBL33T4Jy4G8rssecr6jbCtikKGP2S/iFKzeEyOR5CZTG+u4
         /uK4LRRKUAkypwauIBBclgjvdOw5JRsuw/B+FSpcE443b/2CDZZy9PAiDRHBHCDE9X71
         efTQ4Af/k/de4GpaxZaSLDN8HAzU6DgJeHGKWszmGobycTb046/WvevY+H8GqwvnCcnN
         zrHiPDAb3z9vF0XdrIh9Xo0gylA7goJGzpdwm72EiUDDg3XpBlrxv8QnuoUrWo84PFEe
         VPwfLXflQl5mfQWstRIFHCNqHkEkTpPjjOqkBh+gogH4DsCRLxLeoZNDTz+xFkM5jXnE
         yz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521542; x=1735126342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnQWqaCjqBtW62hSVEa2zhH4lywtPn54oTc9oEo9iq8=;
        b=nTMAgo7P72MEt3XsdppnRGkGVntue2lqJTXsuRrv5e17Y7hyHv44iKC5yAI+aySjNm
         Pi/hvKoBTtLV63f4r8wxaWrKoOl6Fxw6EU0S9+y3C/bNxMcOhdBMKL0M2F+Be8zLNY3h
         bznjroFdUo0GER9CVihMSSVPdEKyfAOyC9VP6e/0rtj8PZfNkU25FFTq8CcXzGRxiuSn
         KYp2AyOHNeyeNyB1T2ONEhdgsayX+SVdD96WtnPtFUYT0P9aClqpD4P6u85TawpoyioP
         hAyPsRIQ/fGAyPLbl0+kxS++apd6H8kqJ87SWZiq/JnxlTmW7s1GVNIV9+aannl5GxLj
         Mniw==
X-Gm-Message-State: AOJu0YwKhdGEIqbaUQn2uLm9osEdKyBJn6SrXE4szar3n6103X7rjsjI
	xgL05W7iq14J3cJq4zf0RQ/VhAgODstZZNmjAxVXxvwWWNb650Eo0hOW7iEcnu0=
X-Gm-Gg: ASbGncvcv1K9iHbZVMdd9gqKBe3bTSK13Z2L/GQFiJQCJjIJn3HYnySKXQABrsRwe1T
	xMELINBWA2gNBwkf7l8av1V/jnqhab/sW9XiX67g929jR4A0avMH20LQCjNBUohzUX5qsq0JOW+
	ae2ULbnOyUs/Uya4zdtaixsu4aIfdXAQfYegnq+s/NiXleMf4VT+Ch9FxoBrhZ6+qjTV5X7F4U5
	W+Bw2n5BS/G254UMvwRk7u0iSFt+/O2pe9oAHyZzADZl86Yo8TyGBUbOiOLxiXBqoE=
X-Google-Smtp-Source: AGHT+IEq9wnIESLmBVjyloaj2K7ZGM8pEepkcYNy7DpY/9QMzrt5l4lU7LiVeEPEXPuazvcO/CaAmA==
X-Received: by 2002:a17:906:ef0e:b0:aa6:bedc:2e4c with SMTP id a640c23a62f3a-aabdc833a77mr769119766b.3.1734521542051;
        Wed, 18 Dec 2024 03:32:22 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9600628asm554534566b.20.2024.12.18.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:32:21 -0800 (PST)
Date: Wed, 18 Dec 2024 12:32:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z2KyxEHA8NCNGF6u@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218030720.1602449-2-alexei.starovoitov@gmail.com>

I like this proposal better. I am still not convinced that we really
need internal __GFP_TRYLOCK though. 

If we reduce try_alloc_pages to the gfp usage we are at the following

On Tue 17-12-24 19:07:14, alexei.starovoitov@gmail.com wrote:
[...]
> +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> +{
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
> +			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;
> +	unsigned int alloc_flags = ALLOC_TRYLOCK;
[...]
> +	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> +			    &alloc_gfp, &alloc_flags);
[...]
> +	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> +
> +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> +
> +	trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
> +	kmsan_alloc_page(page, order, alloc_gfp);
[...]

From those that care about __GFP_TRYLOCK only kmsan_alloc_page doesn't
have alloc_flags. Those could make the locking decision based on
ALLOC_TRYLOCK.

I am not familiar with kmsan internals and my main question is whether
this specific usecase really needs a dedicated reentrant
kmsan_alloc_page rather than rely on gfp flag to be sufficient.
Currently kmsan_in_runtime bails out early in some contexts. The
associated comment about hooks is not completely clear to me though.
Memory allocation down the road is one of those but it is not really
clear to me whether this is the only one.
-- 
Michal Hocko
SUSE Labs

