Return-Path: <bpf+bounces-63042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E696B01A5A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA625A6DEB
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EE289354;
	Fri, 11 Jul 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLkvah+C"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC2A920;
	Fri, 11 Jul 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232342; cv=none; b=IgG08yUqXsfblGwlJbLfavDubO7bMseWiUC9csOf6BqLasnOHSikXmR2CsJUvcNtRsDwaU2RWZirMlPXcSvDOjeUSVhQzCHf4w3LUu+Wweal+32nMDI9yS1UcGDoDDNOcyqOak10HBSY4zeMCaCf45hGmKwZjBngJE3FYklhCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232342; c=relaxed/simple;
	bh=i1zamw8OxrbK1pmX8AUAnMJhV/OqLlLcVIZD8H6BljY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2u6mevjERgmKr0Zpq9k6npk/UDBib/v9MMZOpHK6ba4vEVDgEJqlmzDe2ohhS8EhY4cJN0tOBwp2jwlLpSh/YKem4hHxnoqcK5seqYSaoBFhJjyYT4zypaCk4dVUqYXcVGHt6TM5C+MAHOAezbj4szF/U/eG0LCLphjU7YGDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLkvah+C; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 11 Jul 2025 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752232326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmvwVX29UC54z92FzAiIHfQJoLjVbikCZHEZdUt1Xvc=;
	b=DLkvah+Ci1VSJWI4/B4C7WOGb5TdMdc9dSeZ9dK00ZecpACf0ZdEUCsqcGwjBYJHYjIaoZ
	KEXe5G1id1Mo7NIyyIBpd/+vk1z25JzlHziVBL6phT9ji3SwNxXBtBcKCx6lnkPXEGAu3q
	2XwN2jD7fl3/bU8/nzOqQrS3+Gn1n+w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Message-ID: <2hiakuk5r3daujixvriejrc3nfqo4oiwmdygvyoxprsec3p6wv@k5i6nckj5tcu>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se>
 <aHDSLyHZ8b1ELeWe@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDSLyHZ8b1ELeWe@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 05:58:23PM +0900, Harry Yoo wrote:
> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
> > Reimplement k[v]realloc_node() to be able to set node and
> > alignment should a user need to do so. In order to do that while
> > retaining the maximal backward compatibility, add
> > k[v]realloc_node_align() functions and redefine the rest of API
> > using these new ones.
> > 
> > While doing that, we also keep the number of  _noprof variants to a
> > minimum, which implies some changes to the existing users of older
> > _noprof functions, that basically being bcachefs.
> > 
> > With that change we also provide the ability for the Rust part of
> > the kernel to set node and alignment in its K[v]xxx
> > [re]allocations.
> > 
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> > ---
> >  fs/bcachefs/darray.c   |  2 +-
> >  fs/bcachefs/util.h     |  2 +-
> >  include/linux/bpfptr.h |  2 +-
> >  include/linux/slab.h   | 38 +++++++++++++++----------
> >  lib/rhashtable.c       |  4 +--
> >  mm/slub.c              | 64 +++++++++++++++++++++++++++++-------------
> >  6 files changed, 72 insertions(+), 40 deletions(-)
>  
> > diff --git a/mm/slub.c b/mm/slub.c
> > index c4b64821e680..6fad4cdea6c4 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4845,7 +4845,7 @@ void kfree(const void *object)
> >  EXPORT_SYMBOL(kfree);
> >  
> >  static __always_inline __realloc_size(2) void *
> > -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> > +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
> >  {
> >  	void *ret;
> >  	size_t ks = 0;
> > @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> >  	if (!kasan_check_byte(p))
> >  		return NULL;
> >  
> > +	/* refuse to proceed if alignment is bigger than what kmalloc() provides */
> > +	if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
> > +		return NULL;
> 
> Hmm but what happens if `p` is aligned to `align`, but the new object is not?
> 
> For example, what will happen if we  allocate object with size=64, align=64
> and then do krealloc with size=96, align=64...
> 
> Or am I missing something?

You generally need size to be a multiple of align...

