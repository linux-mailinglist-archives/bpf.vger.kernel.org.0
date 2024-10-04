Return-Path: <bpf+bounces-41027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF09911EC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1252841BC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102311B4F14;
	Fri,  4 Oct 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLV3swEQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB21339B1;
	Fri,  4 Oct 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079093; cv=none; b=m26ip54JsFJXJLZfXczyRQwZeK6tItUxJq7juHSvfuRb5X+KrUFaqKZ2BMIwxEsIlaNDkrplcYGnSMKcmwXHROxHTU7J1M6PGDazpJvei1CA8wEKmpnKno9POzyryBrLIPyicUs4vaCnV4x4dmMPnj0NgIC53ZVwOMgxQ3kjmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079093; c=relaxed/simple;
	bh=uyBiC8TMq18uQv1PsbbayjsAVacLQRvcD/6Q3GJE+3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okS8tOMa2OWobJpQUwRGRH2pzamepbvcUhHT/9vhk4ym1ezin8yyNsT7HOjUvqWvWCIRgyFh4YLRoFAzg5dPlZPJLgiZCR1X5SxonamfwIuKSc52AbM4zbwfaTGU7l2aejWvHrPv4sqDAP8sCW0tqj37q1a6rGZlyqj2AcoHEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLV3swEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385AEC4CECC;
	Fri,  4 Oct 2024 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079093;
	bh=uyBiC8TMq18uQv1PsbbayjsAVacLQRvcD/6Q3GJE+3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLV3swEQutk8gH54bI5uf7RM60RwpRAzvkRhfqCAw8SBzoFmt0umcKAvykcvTNy/o
	 u3MB+NEg814mDllNTaPnwcfAYPLtFrVAbdq8oQd2FW7g5m0EF9utJrvaxYo4sLq4oJ
	 +m/VAjTFrd+eO4uK8j7dreYC3rHEuToZYdyIq8O02Sy8k4iYLLzA/K2dAXVAwICn7D
	 dIQt3KRpUhLCp0HXPv/C3OogsWVOneTgtPSNl1upretN16eHjIzgADCz5ely62q0QO
	 RHb/0ShPlj7Yeo0T4JDHSXjTj7mFRCfclevgPJhcy/qPqZr88IrDeIxMl1BYSwwnJj
	 QCUyEovsc1xzw==
Date: Fri, 4 Oct 2024 14:58:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwBk8i23odCe7qVK@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>

On Fri, Oct 04, 2024 at 02:36:30PM -0700, Song Liu wrote:
> On Fri, Oct 4, 2024 at 2:25 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > virtual address like virt_to_cache().  If the address is a pointer
> > > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > NULL is returned.
> > > >
> > > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > > responsible to manage the access.  The intended use case for now is to
> > > > symbolize locks in slab objects from the lock contention tracepoints.
> > > >
> > > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  kernel/bpf/helpers.c |  1 +
> > > >  mm/slab_common.c     | 19 +++++++++++++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> > > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > > >  BTF_KFUNCS_END(common_btf_ids)
> > > >
> > > >  static const struct btf_kfunc_id_set common_kfunc_set = {
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > index 7443244656150325..5484e1cd812f698e 100644
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> > > >  }
> > > >  EXPORT_SYMBOL(ksize);
> > > >
> > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > +#include <linux/btf.h>
> > > > +
> > > > +__bpf_kfunc_start_defs();
> > > > +
> > > > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > > > +{
> > > > +       struct slab *slab;
> > > > +
> > > > +       if (!virt_addr_valid(addr))
> > > > +               return NULL;
> > > > +
> > > > +       slab = virt_to_slab((void *)(long)addr);
> > > > +       return slab ? slab->slab_cache : NULL;
> > > > +}
> > >
> > > Do we need to hold a refcount to the slab_cache? Given
> > > we make this kfunc available everywhere, including
> > > sleepable contexts, I think it is necessary.
> >
> > It's a really good question.
> >
> > If the callee somehow owns the slab object, as in the example
> > provided in the series (current task), it's not necessarily.
> >
> > If a user can pass a random address, you're right, we need to
> > grab the slab_cache's refcnt. But then we also can't guarantee
> > that the object still belongs to the same slab_cache, the
> > function becomes racy by the definition.
> 
> To be safe, we can limit the kfunc to sleepable context only. Then
> we can lock slab_mutex for virt_to_slab, and hold a refcount
> to slab_cache. We will need a KF_RELEASE kfunc to release
> the refcount later.

Then it needs to call kmem_cache_destroy() for release which contains
rcu_barrier. :(

> 
> IIUC, this limitation (sleepable context only) shouldn't be a problem
> for perf use case?

No, it would be called from the lock contention path including
spinlocks. :(

Can we limit it to non-sleepable ctx and not to pass arbtrary address
somehow (or not to save the result pointer)?

Thanks,
Namhyung


