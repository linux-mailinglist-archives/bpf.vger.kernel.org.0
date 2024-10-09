Return-Path: <bpf+bounces-41361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39992996080
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCC2B216A5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55E17BEC6;
	Wed,  9 Oct 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/JtnS/x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AF17B4E5;
	Wed,  9 Oct 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458235; cv=none; b=WnJ6PB/nQFuhlsrwSz2G8sCbolwETYuk7ucRi6xsNJIqhroLDDcQ4RSKfGZkHAj9bGHI3ZLc6WfWqmFrPKdhFp3l8g+LxdbXOCOAg9LsteyGhOPaH7MK7azSOk/XnlOZZE0Y/8jhnIgOTl9XxAFPeHbq3qgXZyRRUgQhcO5HpVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458235; c=relaxed/simple;
	bh=ZDpUR/d9x6HyZchR7dYoPFacl55AF1BezrHDctlUiAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEaEVXssqqtAaZIt1WPf5FA2eBOpaMeB63IdpsqaJfVuIe78wkuOzo/gdHVdW2FfavSnDYA8U0pAgY8qwdeCikKgxy3T/xrja90SFX5Earq8uw3VsBPDLfKz/txC2T/V5qZqP/24kv1ry2kX3aO6itEWZ24g+f4bHVuM9XsjNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/JtnS/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F094DC4CEC5;
	Wed,  9 Oct 2024 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728458234;
	bh=ZDpUR/d9x6HyZchR7dYoPFacl55AF1BezrHDctlUiAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/JtnS/xiutlw1jgQ3MfXRrsGNU4sHqr6KAgt1TcSyqwqBE+w0oGUMomCSFBdJRSg
	 M43GnngsfQwHBrxZw+XeTX5UAmoNziSZK/x9VbQnqCHzrzIi6PCgTh/1/8dF9bgoLj
	 DzvORX9hZprQKDoxMYW1VrZ+UjjZbkIn3sOWnCCLbWNQiijGY6nU311fPB13XaWlGc
	 lFZ8tvsDSoL8RUW2ijjosnnmBi0JAJ+qEkjRDuj7R+EMYN3+AwFFiUzMMghyPZIusR
	 7M279TDhrpXXH0tiZtZ7cVVGNvnYb+Wds/r0Fe0PVzYc4TaDuy6jiz3Wmd+2zYPjQt
	 x55A9kqGHQVLA==
Date: Wed, 9 Oct 2024 00:17:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>,
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwYt-GJfzMoozTOU@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>

On Mon, Oct 07, 2024 at 02:57:08PM +0200, Vlastimil Babka wrote:
> On 10/4/24 11:25 PM, Roman Gushchin wrote:
> > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> >> On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> The bpf_get_kmem_cache() is to get a slab cache information from a
> >>> virtual address like virt_to_cache().  If the address is a pointer
> >>> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> >>> NULL is returned.
> >>>
> >>> It doesn't grab a reference count of the kmem_cache so the caller is
> >>> responsible to manage the access.  The intended use case for now is to
> >>> symbolize locks in slab objects from the lock contention tracepoints.
> >>>
> >>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> >>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> >>> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> 
> So IIRC from our discussions with Namhyung and Arnaldo at LSF/MM I
> thought the perf use case was:
> 
> - at the beginning it iterates the kmem caches and stores anything of
> possible interest in bpf maps or somewhere - hence we have the iterator
> - during profiling, from object it gets to a cache, but doesn't need to
> access the cache - just store the kmem_cache address in the perf record
> - after profiling itself, use the information in the maps from the first
> step together with cache pointers from the second step to calculate
> whatever is necessary

Correct.

> 
> So at no point it should be necessary to take refcount to a kmem_cache?
> 
> But maybe "bpf_get_kmem_cache()" is implemented here as too generic
> given the above use case and it should be implemented in a way that the
> pointer it returns cannot be used to access anything (which could be
> unsafe), but only as a bpf map key - so it should return e.g. an
> unsigned long instead?

Yep, this should work for my use case.  Maybe we don't need the
iterator when bpf_get_kmem_cache() kfunc returns the valid pointer as
we can get the necessary info at the moment.  But I think it'd be less
efficient as more work need to be done at the event (lock contention).
It'd better setting up necessary info in a map before monitoring (using
the iterator), and just looking up the map with the kfunc while
monitoring the lock contention.

Thanks,
Namhyung

> 
> >>> ---
> >>>  kernel/bpf/helpers.c |  1 +
> >>>  mm/slab_common.c     | 19 +++++++++++++++++++
> >>>  2 files changed, 20 insertions(+)
> >>>
> >>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>> index 4053f279ed4cc7ab..3709fb14288105c6 100644
> >>> --- a/kernel/bpf/helpers.c
> >>> +++ b/kernel/bpf/helpers.c
> >>> @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >>>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >>>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >>>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >>> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> >>>  BTF_KFUNCS_END(common_btf_ids)
> >>>
> >>>  static const struct btf_kfunc_id_set common_kfunc_set = {
> >>> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >>> index 7443244656150325..5484e1cd812f698e 100644
> >>> --- a/mm/slab_common.c
> >>> +++ b/mm/slab_common.c
> >>> @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> >>>  }
> >>>  EXPORT_SYMBOL(ksize);
> >>>
> >>> +#ifdef CONFIG_BPF_SYSCALL
> >>> +#include <linux/btf.h>
> >>> +
> >>> +__bpf_kfunc_start_defs();
> >>> +
> >>> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> >>> +{
> >>> +       struct slab *slab;
> >>> +
> >>> +       if (!virt_addr_valid(addr))
> >>> +               return NULL;
> >>> +
> >>> +       slab = virt_to_slab((void *)(long)addr);
> >>> +       return slab ? slab->slab_cache : NULL;
> >>> +}
> >>
> >> Do we need to hold a refcount to the slab_cache? Given
> >> we make this kfunc available everywhere, including
> >> sleepable contexts, I think it is necessary.
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

