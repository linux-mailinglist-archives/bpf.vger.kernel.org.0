Return-Path: <bpf+bounces-42806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 025599AB571
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49252B225D8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14C1C244B;
	Tue, 22 Oct 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KolxZ12k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5491C242D;
	Tue, 22 Oct 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619280; cv=none; b=g6m9TO1AOKCzd1vP05aEQD5RHYjskWCgC9e65IIoX5Tegfghg6/aKg8ZuRrnFVcEph2dc8tlda8O0Lqy/sEGTLgA5o7fgAcjTik8aJqml4AXHFwpa/atTO32zsIwQVBAeiz/1JZBACF7AvKYogNrSzuC8oKbEMIKZwD1e7pmF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619280; c=relaxed/simple;
	bh=0jeHh94OYCmeLHdHs2fgO2Vhltp9K3H6c/3aZLMOYKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfvRGW4lWB7u4fLNBCIu9GZCI6gP37lRiuTus1D1m+pdgs6sIy54+h+mRCVgyZP49VxEe4A/aG8onlkhy1qK/KQsqFZ9SqQSOOcvK1vfHVBRCS1j6xYS8jaV7peeuffBxzjtavDed20I5+h1h4dI58kEJZtyfGsF7DLOCJi/C6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KolxZ12k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF1C4CEC7;
	Tue, 22 Oct 2024 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619280;
	bh=0jeHh94OYCmeLHdHs2fgO2Vhltp9K3H6c/3aZLMOYKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KolxZ12ktC00Wu2p9wtywMiAAO9nXET8nhdJ/64Cr0GQe3Gwdl8QMQkPC9UKsIRuF
	 4/y5vLeal4232S2bCaDxcXxPqVCvzfbYWMBg6uMGt1I99r3zoqTkiK+Vdnr5PbpNKJ
	 sb1rV93hMLmad4KXYSOEuUz/gPZ7iL5cxif3eQ01K1DFziDuaGInRfnufVikT8UO13
	 KwENnZBBKr0je1cvBTcOCg9EkrcsCXlaIy9eRUcgRbvMfLxokjzlIpsTMU/4UEVrLP
	 Q5+E/s7mopkU2KvLhKNjGCovC1hWlEK+IuClOpkwcmg0/VnS8XG4hqlrGQIh/US2HM
	 HDwMiyVFr/obw==
Date: Tue, 22 Oct 2024 10:47:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add open coded version of kmem_cache
 iterator
Message-ID: <ZxflTe2O2iktiv8G@google.com>
References: <20241017080604.541872-1-namhyung@kernel.org>
 <b3655d46-5c42-407e-adc1-b17865432e45@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3655d46-5c42-407e-adc1-b17865432e45@linux.dev>

Hello,

On Fri, Oct 18, 2024 at 11:22:00AM -0700, Martin KaFai Lau wrote:
> On 10/17/24 1:06 AM, Namhyung Kim wrote:
> > Add a new open coded iterator for kmem_cache which can be called from a
> > BPF program like below.  It doesn't take any argument and traverses all
> > kmem_cache entries.
> > 
> >    struct kmem_cache *pos;
> > 
> >    bpf_for_each(kmem_cache, pos) {
> >        ...
> >    }
> > 
> > As it needs to grab slab_mutex, it should be called from sleepable BPF
> > programs only.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   kernel/bpf/helpers.c         |  3 ++
> >   kernel/bpf/kmem_cache_iter.c | 87 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 90 insertions(+)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 073e6f04f4d765ff..d1dfa4f335577914 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3111,6 +3111,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >   BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >   BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> >   BTF_KFUNCS_END(common_btf_ids)
> >   static const struct btf_kfunc_id_set common_kfunc_set = {
> > diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
> > index ebc101d7da51b57c..31ddaf452b20a458 100644
> > --- a/kernel/bpf/kmem_cache_iter.c
> > +++ b/kernel/bpf/kmem_cache_iter.c
> > @@ -145,6 +145,93 @@ static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
> >   	.seq_ops		= &kmem_cache_iter_seq_ops,
> >   };
> > +/* open-coded version */
> > +struct bpf_iter_kmem_cache {
> > +	__u64 __opaque[1];
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_iter_kmem_cache_kern {
> > +	struct kmem_cache *pos;
> > +} __attribute__((aligned(8)));
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it)
> > +{
> > +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> > +
> > +	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
> > +	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
> > +
> > +	kit->pos = NULL;
> > +	return 0;
> > +}
> > +
> > +__bpf_kfunc struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it)
> > +{
> > +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> > +	struct kmem_cache *prev = kit->pos;
> > +	struct kmem_cache *next;
> > +	bool destroy = false;
> > +
> > +	mutex_lock(&slab_mutex);
> 
> I think taking mutex_lock here should be fine since sleepable tracing prog
> should be limited to the error injection whitelist. Those functions should
> not have held the mutex afaict.
> 
> > +
> > +	if (list_empty(&slab_caches)) {
> > +		mutex_unlock(&slab_mutex);
> > +		return NULL;
> > +	}
> > +
> > +	if (prev == NULL)
> > +		next = list_first_entry(&slab_caches, struct kmem_cache, list);
> > +	else if (list_last_entry(&slab_caches, struct kmem_cache, list) == prev)
> > +		next = NULL;
> 
> At the last entry, next is NULL.
> 
> > +	else
> > +		next = list_next_entry(prev, list);
> > +
> > +	/* boot_caches have negative refcount, don't touch them */
> > +	if (next && next->refcount > 0)
> > +		next->refcount++;
> > +
> > +	/* Skip kmem_cache_destroy() for active entries */
> > +	if (prev && prev->refcount > 1)
> > +		prev->refcount--;
> > +	else if (prev && prev->refcount == 1)
> > +		destroy = true;
> > +
> > +	mutex_unlock(&slab_mutex);
> > +
> > +	if (destroy)
> > +		kmem_cache_destroy(prev);
> > +
> > +	kit->pos = next;
> 
> so kit->pos will be NULL also. Does it mean the bpf prog will be able to
> call bpf_iter_kmem_cache_next() again and re-loop from the beginning of the
> slab_caches list?

Right, I'll mark the start pos differently to prevent that.

Thanks,
Namhyung

> 
> > +	return next;
> > +}
> > +
> > +__bpf_kfunc void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it)
> > +{
> > +	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
> > +	struct kmem_cache *s = kit->pos;
> > +	bool destroy = false;
> > +
> > +	if (s == NULL)
> > +		return;
> > +
> > +	mutex_lock(&slab_mutex);
> > +
> > +	/* Skip kmem_cache_destroy() for active entries */
> > +	if (s->refcount > 1)
> > +		s->refcount--;
> > +	else if (s->refcount == 1)
> > +		destroy = true;
> > +
> > +	mutex_unlock(&slab_mutex);
> > +
> > +	if (destroy)
> > +		kmem_cache_destroy(s);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> >   static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
> >   					    struct seq_file *seq)
> >   {
> 

