Return-Path: <bpf+bounces-41661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C844D99958C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B01C21682
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E51E7C00;
	Thu, 10 Oct 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRbt76lN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA941BCA0A;
	Thu, 10 Oct 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601001; cv=none; b=md4ywhSCVJRErm4aisAfYNlNnwhGcoGQG9lRUGurYUGR8lbqIMBGL58i2IiIuxn2F9MIztKDnIg6Hf9tVC7DE6f/V06lSPjFvCZxXMJJPf/GvwfX8HhuktxMKBbC3EfEv83JNAjk2gs6MJuq+MoHDwWySHWOHaBhJ/OoPIX60Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601001; c=relaxed/simple;
	bh=S0gsjnawtQCm9QTdFF7z0fX/jdedpHOu7Gvko5BM2YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/ijUEdURBz7fPcANYvKczUJkhQSf4833Jw3Ad5SuMqQFHPYtdprW/2jbrmPDPtor2VE+2zavwFKF7SqTx66y+CGhntsP/S7RJU6tcmvn5sh4t2ulOc4Q/XhXdwmYUbbIkIkDm6Y+a5PX6vsbCT73KQai03vhFworemqTGRu/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRbt76lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDAC4CEC5;
	Thu, 10 Oct 2024 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728601000;
	bh=S0gsjnawtQCm9QTdFF7z0fX/jdedpHOu7Gvko5BM2YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRbt76lNthqIjZaczXutLVF3+ryQvMPukms0RG7RvHK1oSsfHbSq0GOMcJR5aCqNh
	 dpU+o0y13D/BLhiV7RCxbh99qlf05DB7aXXHYFmLdYJ0yDWvZ7Rk5ziWXkWKMcCroM
	 IEs92G2llaOOarLsK1xbRPvTI7tKCdxy0XvEPdoDSqASvIV7GCc5fUWtBbZGM29wFQ
	 JR9JpOBkRA4QdohJu5/rWBpqXgzafig0AhdQ2pyGlEsdwNf/oQsRjskwnlOKc3eaOf
	 Iag8+sMv1B/CdlT+tNFV2oD1jGaIRcfPwqh4WyN8J5VH77DqlpL/DR2Zp7nXwhh/27
	 /Aal1ZgZPnvxg==
Date: Thu, 10 Oct 2024 15:56:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwhbpuClULAFl6IL@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>
 <ZwYt-GJfzMoozTOU@google.com>
 <ZwgEykf_XmVpEE8_@google.com>
 <CAADnVQLXrS0coJrk5RPxvik5Sz2yFko5z=+PXdGfju_7Lxj=mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLXrS0coJrk5RPxvik5Sz2yFko5z=+PXdGfju_7Lxj=mQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 10:04:24AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 9:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 09, 2024 at 12:17:12AM -0700, Namhyung Kim wrote:
> > > On Mon, Oct 07, 2024 at 02:57:08PM +0200, Vlastimil Babka wrote:
> > > > On 10/4/24 11:25 PM, Roman Gushchin wrote:
> > > > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > > >> On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >>>
> > > > >>> The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > >>> virtual address like virt_to_cache().  If the address is a pointer
> > > > >>> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > >>> NULL is returned.
> > > > >>>
> > > > >>> It doesn't grab a reference count of the kmem_cache so the caller is
> > > > >>> responsible to manage the access.  The intended use case for now is to
> > > > >>> symbolize locks in slab objects from the lock contention tracepoints.
> > > > >>>
> > > > >>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > > >>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > > >>> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > > >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > >
> > > > So IIRC from our discussions with Namhyung and Arnaldo at LSF/MM I
> > > > thought the perf use case was:
> > > >
> > > > - at the beginning it iterates the kmem caches and stores anything of
> > > > possible interest in bpf maps or somewhere - hence we have the iterator
> > > > - during profiling, from object it gets to a cache, but doesn't need to
> > > > access the cache - just store the kmem_cache address in the perf record
> > > > - after profiling itself, use the information in the maps from the first
> > > > step together with cache pointers from the second step to calculate
> > > > whatever is necessary
> > >
> > > Correct.
> > >
> > > >
> > > > So at no point it should be necessary to take refcount to a kmem_cache?
> > > >
> > > > But maybe "bpf_get_kmem_cache()" is implemented here as too generic
> > > > given the above use case and it should be implemented in a way that the
> > > > pointer it returns cannot be used to access anything (which could be
> > > > unsafe), but only as a bpf map key - so it should return e.g. an
> > > > unsigned long instead?
> > >
> > > Yep, this should work for my use case.  Maybe we don't need the
> > > iterator when bpf_get_kmem_cache() kfunc returns the valid pointer as
> > > we can get the necessary info at the moment.  But I think it'd be less
> > > efficient as more work need to be done at the event (lock contention).
> > > It'd better setting up necessary info in a map before monitoring (using
> > > the iterator), and just looking up the map with the kfunc while
> > > monitoring the lock contention.
> >
> > Maybe it's still better to return a non-refcounted pointer for future
> > use.  I'll leave it for v5.
> 
> Pls keep it as:
> __bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> 
> just make sure it's PTR_UNTRUSTED.

Sure, will do.

> No need to make it return long or void *.
> The users can do:
>   bpf_core_cast(any_value, struct kmem_cache);
> anyway, but it would be an unnecessary step.

Yeah I thought there would be a way to do that.

Thanks,
Namhyung


