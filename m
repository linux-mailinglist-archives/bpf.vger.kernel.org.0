Return-Path: <bpf+bounces-58328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E8AB8BC2
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B159166DAC
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9021ABB1;
	Thu, 15 May 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDi+M5+I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465826ACB;
	Thu, 15 May 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324874; cv=none; b=dFybL9vsUGiAwO1vbzQxsVygECI+JNfmUyqYb6yu+dLBKC6jSJBi4rbtQBCH/ypZ6cgotOH36NZV8x61VYh1V7nV4LLhiE0GsDPUsuPhdgc2IYKl4CjDOg1VcCsdwx5LThmkl/ahNOr87ZCRjmwPFfFa+efDZZGacHMcgdAH/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324874; c=relaxed/simple;
	bh=mO2vcNgJs8+C51CBW2wKe8JPfH5wo/ZFqAzhliVrj1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ8Wdx5Wk6Z9DYgRUPzSxebYj+hW0hXQmxj/p6onCMOQBB/N+Rmo+bE1CqAEOb6DAJ2PXXwJhbdexQlJSWp+MVXYErZHdr3sVLjnZEmHlcrV1+g7t2Fx8c61Uj6maHecz8M4/VVUlwL5tPLLBG2LlyR/GBFTNNPeqTGqfzu28LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDi+M5+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1DBC4CEE7;
	Thu, 15 May 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747324874;
	bh=mO2vcNgJs8+C51CBW2wKe8JPfH5wo/ZFqAzhliVrj1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDi+M5+IEOa8F8YxVPfRIoBbxDt0YTFoGBaBOVS70e9hMJCQ0t6D0ndEzpewYJOT4
	 0NMokKbLnbBVGZ2NjAk56NaIzsHOCrGH9g3Dkm9lLgOZkl+oidWYj+Bufki1PKuU6V
	 BZ1dWVFI2HgsVyeafoVJ7v3fDpSQrkqVE4KJ/1MJsDPZ3Q7gBM/S7Yn71c4payYMNU
	 GdjEP1gNRNWE64PoCaWfmml/BtK+kvZUUIR/syw5QDzWCElTgaq2dQVDXbWbu8vWA7
	 7+uGQV7mEUQwa4at9/shgXnShD5NLTQyz+MDO//3OCdjla0ypcgAnbgrHduR2zDMLx
	 JX0B2yekJMZdw==
Date: Thu, 15 May 2025 09:01:11 -0700
From: Kees Cook <kees@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <202505150900.13CFA05B7@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <202505150845.0F9E154@keescook>
 <202505150850.6F3E261D67@keescook>
 <CAEf4BzZbPMKwu49UDizqT_3ZuDPsNXvTa+Tp6pae0P_YkUT7JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZbPMKwu49UDizqT_3ZuDPsNXvTa+Tp6pae0P_YkUT7JQ@mail.gmail.com>

On Thu, May 15, 2025 at 08:55:47AM -0700, Andrii Nakryiko wrote:
> On Thu, May 15, 2025 at 8:53 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Thu, May 15, 2025 at 08:47:47AM -0700, Kees Cook wrote:
> > > On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> > > > Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> > > > support more granular vrealloc() sizing"[2]. To further zoom in the
> > >
> > > Can you try this patch? It's a clear bug fix, but if it doesn't improve
> > > things, I have another idea to rearrange the memset.
> >
> > Here's the patch (on top of the prior one) that relocates the memset:
> >
> >
> > From 0bc71b78603500705aca77f82de8ed1fc595c4c3 Mon Sep 17 00:00:00 2001
> > From: Kees Cook <kees@kernel.org>
> > Date: Thu, 15 May 2025 08:48:24 -0700
> > Subject: [PATCH] mm: vmalloc: Only zero-init on vrealloc shrink
> >
> > The common case is to grow reallocations, and since init_on_alloc will
> > have already zeroed the whole allocation, we only need to zero when
> > shrinking the allocation.
> >
> > Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing")
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: <linux-mm@kvack.org>
> > ---
> >  mm/vmalloc.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 74bd00fd734d..83bedb1559ac 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4093,8 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >          * would be a good heuristic for when to shrink the vm_area?
> >          */
> >         if (size <= old_size) {
> > -               /* Zero out "freed" memory. */
> > -               if (want_init_on_free())
> > +               /* Zero out "freed" memory, potentially for future realloc. */
> > +               if (want_init_on_free() || want_init_on_alloc(flags))
> >                         memset((void *)p + size, 0, old_size - size);
> >                 vm->requested_size = size;
> >                 kasan_poison_vmalloc(p + size, old_size - size);
> > @@ -4107,9 +4107,11 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >         if (size <= alloced_size) {
> >                 kasan_unpoison_vmalloc(p + old_size, size - old_size,
> >                                        KASAN_VMALLOC_PROT_NORMAL);
> > -               /* Zero out "alloced" memory. */
> > -               if (want_init_on_alloc(flags))
> > -                       memset((void *)p + old_size, 0, size - old_size);
> > +               /*
> > +                * No need to zero memory here, as unused memory will have
> > +                * already been zeroed at initial allocation time or during
> > +                * realloc shrink time.
> > +                */
> >                 vm->requested_size = size;
> 
> This vm->requested_size change you are adding should also fix the
> kasan issue reported by syzbot ([0]).
> 
>   [0] https://lore.kernel.org/bpf/68213ddf.050a0220.f2294.0045.GAE@google.com/

Yes, this looks very much like the kasan oops that motivated the initial
patch:

https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/

-- 
Kees Cook

