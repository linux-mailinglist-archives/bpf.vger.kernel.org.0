Return-Path: <bpf+bounces-41031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29389912FB
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBB31F238BC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6071015359A;
	Fri,  4 Oct 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1VOzuKo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AE146A68;
	Fri,  4 Oct 2024 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084483; cv=none; b=KpDCKKEC7SlTiSocf3xxDC2UKaVxowPT73aN8thnAyHBmJS+AJo+z2oIc7BopZXfd6208RmnymL/TU7RTUMyNdM+/+7uWrKWW15LXa027Ix2pYhEPSL9NQo9E6zxrtan9+OUC/fRzyBpOh2UcWkO2WConGM5SJ3BKsQMycKiHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084483; c=relaxed/simple;
	bh=i6orkJt58R7hUtyqlR8RvKjXczmkJgle1PuY39oWi9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwjb3qJ15TpGvYaKysc21CfflTHiceZmg1I3zXBsFfMDkplTqVQoeAW5AWVOyfQJtg3/AgSILdn5hFBlq+ltR8kGhsl6ORJfJj2kmaEDM64FhVgZ1BD5VTM2axMRI5gLJdlNN6gDh2uubkMOCgdW7v1N1+2f+xE1wB5YPSPKPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1VOzuKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE61C4CEC6;
	Fri,  4 Oct 2024 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084483;
	bh=i6orkJt58R7hUtyqlR8RvKjXczmkJgle1PuY39oWi9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1VOzuKoVyAioEhxd68OM6vFa6mtJi6TfqX324QocuWEoUIhuugHSvCI8DOrsgmWW
	 mhXHU0AyNlYlpNJUlPZ8qe6Hyq1l059sqh4v7gbZ+mqGEH+XZfqXjRBb4cmOh8SDbC
	 oCeUzOVfX698B5n/WYdN9EdziTcqjTRAmY90yL1/WsXzWM3utFVjDRog4LmtJ2sRi7
	 0o8GluwbBZwosxKbAmS8gBzqtPNZwuevpx2/7ZwZPn0Vx3fbjvUvvEtYB0QkvAp+eK
	 3AViSZgdQl4LfT5JjxRKMrsX3scqmsm7uQBfFhMSkqjMDrSr+m423mMIJ3zLnk31ig
	 GLi1Dfpe5+ghQ==
Date: Fri, 4 Oct 2024 16:28:01 -0700
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
Message-ID: <ZwB6ARVa7ea8Vvxi@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
 <ZwBk8i23odCe7qVK@google.com>
 <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>

On Fri, Oct 04, 2024 at 03:57:26PM -0700, Song Liu wrote:
> On Fri, Oct 4, 2024 at 2:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Oct 04, 2024 at 02:36:30PM -0700, Song Liu wrote:
> > > On Fri, Oct 4, 2024 at 2:25 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > >
> > > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > > > On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > > > virtual address like virt_to_cache().  If the address is a pointer
> > > > > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > > > NULL is returned.
> > > > > >
> > > > > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > > > > responsible to manage the access.  The intended use case for now is to
> > > > > > symbolize locks in slab objects from the lock contention tracepoints.
> > > > > >
> > > > > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > ---
> > > > > >  kernel/bpf/helpers.c |  1 +
> > > > > >  mm/slab_common.c     | 19 +++++++++++++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > > > > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > > > > >  BTF_KFUNCS_END(common_btf_ids)
> > > > > >
> > > > > >  static const struct btf_kfunc_id_set common_kfunc_set = {
> > > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > > index 7443244656150325..5484e1cd812f698e 100644
> > > > > > --- a/mm/slab_common.c
> > > > > > +++ b/mm/slab_common.c
> > > > > > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(ksize);
> > > > > >
> > > > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > > > +#include <linux/btf.h>
> > > > > > +
> > > > > > +__bpf_kfunc_start_defs();
> > > > > > +
> > > > > > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > > > > > +{
> > > > > > +       struct slab *slab;
> > > > > > +
> > > > > > +       if (!virt_addr_valid(addr))
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       slab = virt_to_slab((void *)(long)addr);
> > > > > > +       return slab ? slab->slab_cache : NULL;
> > > > > > +}
> > > > >
> > > > > Do we need to hold a refcount to the slab_cache? Given
> > > > > we make this kfunc available everywhere, including
> > > > > sleepable contexts, I think it is necessary.
> > > >
> > > > It's a really good question.
> > > >
> > > > If the callee somehow owns the slab object, as in the example
> > > > provided in the series (current task), it's not necessarily.
> > > >
> > > > If a user can pass a random address, you're right, we need to
> > > > grab the slab_cache's refcnt. But then we also can't guarantee
> > > > that the object still belongs to the same slab_cache, the
> > > > function becomes racy by the definition.
> > >
> > > To be safe, we can limit the kfunc to sleepable context only. Then
> > > we can lock slab_mutex for virt_to_slab, and hold a refcount
> > > to slab_cache. We will need a KF_RELEASE kfunc to release
> > > the refcount later.
> >
> > Then it needs to call kmem_cache_destroy() for release which contains
> > rcu_barrier. :(
> >
> > >
> > > IIUC, this limitation (sleepable context only) shouldn't be a problem
> > > for perf use case?
> >
> > No, it would be called from the lock contention path including
> > spinlocks. :(
> >
> > Can we limit it to non-sleepable ctx and not to pass arbtrary address
> > somehow (or not to save the result pointer)?
> 
> I hacked something like the following. It is not ideal, because we are
> taking spinlock_t pointer instead of void pointer. To use this with void
> 'pointer, we will need some verifier changes.

Thanks a lot for doing this!!  I'll take a look at the verifier what
needs to be done.

Namhyung

> 
> 
> diff --git i/kernel/bpf/helpers.c w/kernel/bpf/helpers.c
> index 3709fb142881..7311a26ecb01 100644
> --- i/kernel/bpf/helpers.c
> +++ w/kernel/bpf/helpers.c
> @@ -3090,7 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL | KF_TRUSTED_ARGS
> | KF_RCU_PROTECTED)
>  BTF_KFUNCS_END(common_btf_ids)
> 
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git i/mm/slab_common.c w/mm/slab_common.c
> index 5484e1cd812f..3e3e5f172f2e 100644
> --- i/mm/slab_common.c
> +++ w/mm/slab_common.c
> @@ -1327,14 +1327,15 @@ EXPORT_SYMBOL(ksize);
> 
>  __bpf_kfunc_start_defs();
> 
> -__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(spinlock_t *addr)
>  {
>         struct slab *slab;
> +       unsigned long a = (unsigned long)addr;
> 
> -       if (!virt_addr_valid(addr))
> +       if (!virt_addr_valid(a))
>                 return NULL;
> 
> -       slab = virt_to_slab((void *)(long)addr);
> +       slab = virt_to_slab(addr);
>         return slab ? slab->slab_cache : NULL;
>  }
> 
> @@ -1346,4 +1347,3 @@ EXPORT_TRACEPOINT_SYMBOL(kmalloc);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
> -
> diff --git i/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> w/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> index 3f6ec15a1bf6..8238155a5055 100644
> --- i/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> +++ w/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> @@ -16,7 +16,7 @@ struct {
>         __uint(max_entries, 1024);
>  } slab_hash SEC(".maps");
> 
> -extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> +extern struct kmem_cache *bpf_get_kmem_cache(spinlock_t *addr) __ksym;
> 
>  /* result, will be checked by userspace */
>  int found;
> @@ -46,21 +46,23 @@ int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
>  SEC("raw_tp/bpf_test_finish")
>  int BPF_PROG(check_task_struct)
>  {
> -       __u64 curr = bpf_get_current_task();
> +       struct task_struct *curr = bpf_get_current_task_btf();
>         struct kmem_cache *s;
>         char *name;
> 
> -       s = bpf_get_kmem_cache(curr);
> +       s = bpf_get_kmem_cache(&curr->alloc_lock);
>         if (s == NULL) {
>                 found = -1;
>                 return 0;
>         }
> 
> +       bpf_rcu_read_lock();
>         name = bpf_map_lookup_elem(&slab_hash, &s);
>         if (name && !bpf_strncmp(name, 11, "task_struct"))
>                 found = 1;
>         else
>                 found = -2;
> +       bpf_rcu_read_unlock();
> 
>         return 0;
>  }

