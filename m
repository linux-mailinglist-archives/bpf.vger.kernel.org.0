Return-Path: <bpf+bounces-79355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B89D38B7C
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BFD5300E8DD
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB230FC16;
	Sat, 17 Jan 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckaBFZ0K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5024501B
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615876; cv=pass; b=L82C5rLO+7hkH00N6BOC3iU+hwiw8suZgY7Il0nOFPeFvsszL+g6igF/nTodeJ7tFsSYJP609GrIWyMU/u5pLpsqqwUIaaSnkOT878DJJiMeRVo89GKb0JwE4smimXJB1eQeGbkmKoCwzJhQk75jplaufvSc3L6nsvTbdDyfBp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615876; c=relaxed/simple;
	bh=oidOtNJnku2S6cVt6JlSLpEyGp2/mdpd0iSErBFe6Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8y0E2XMEkodDv45ExESFEXfRUYTBPhMGv0RrR441WIiIIFju8rA9Ffa8s5YEsapD4OVmSANaPf/YU4uUrBBZ5wbPQqzQny9JEgu+gb2XOyNk1eDtKD+5HNRd1C7S0B+3uktxKwiqdj4WKw8UwIQDs00MUzW+x0Dy4aoPuE9DUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckaBFZ0K; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50299648ae9so112361cf.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 18:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768615873; cv=none;
        d=google.com; s=arc-20240605;
        b=RsAKSj7CMNsgAhbxat+JMK4h8TWfpOuBddDXHMvnBPv999DkFmVHnXEugG5RMpclJn
         cdF7fbdSG9sYLr0Y1JQqzdo7PgCd/N7eXzcPg91qIwqABOnF8HPZUHscfdwX/4AcqkEN
         S3V7CI+dLofSkp7VvwM0gqc0s3K95MMO947TpXOC3sWbV4fbE7mQfrnL0y7ANk6Q0rwM
         qDxSmsh/VOsanXnXtWhjawXPzf7Wa2Es26pwNdAT4TkFT+cUzHkbLm6/BVI5WAGSuFou
         QXgQ/tpRHQK8waRtCEPepyckZ7sH6sUwcRd13bDrS/skBs+v5+IGqhLI1QhYATpVrEJ4
         dM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8XfzdTcYbKXbttOZYCkhexZVaSChWM1LNoqV+hh1gE=;
        fh=rSBVU5mBVyT5g8nYdFuLb56SMKe1cx+Mz/Lvo/hZZAI=;
        b=Vbg41pmU+UoVFLTN1tB1VfJ4Loi29WGYhSXauZODX8PhTLREYHgjQ01Mf3xPCZE70V
         ZoSNKEeRnQt7QmLKpjlv9nY921GrF7Q/oKOvVY4whQatrntRz1/FRhlZH0chJVBAqe2z
         Jw1z4RpJEJcu2LNaotUdGhppyvnTBfsJj/oil6JWbs7xsxPsnlD8qNSxq8oCwZNs/K2J
         bw9KXFaI4j5pB8RdcHbTnlYCvlkTuA0uAoR9WK3j+f0/BVf/cHK9nQtVub6b97xepkQv
         1qxLrFMDLYRVFgtDnEF476cdb+Kv0j6vbhNB/YlTVYb296AYXu7wh/KdhueVSbONsTMx
         ZpOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768615873; x=1769220673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8XfzdTcYbKXbttOZYCkhexZVaSChWM1LNoqV+hh1gE=;
        b=ckaBFZ0K9nkK/pEAPBZwxOtdLCIugUbKtuCt+nxMrEvmUrNXDycSXJaOB8AcGLX7tL
         KTR6gBk2ZRFod9OVfIlbilN83HYCFp6P54rjn7O+1gS1DEEN+8hC0p/LVYywNJvqMKFt
         nGQN46pI/hkvBc1j06xmLpC2UFjZFBspzNMuGy8ckCA9div3Oy7E+lrKKH/HmnQag9Bt
         ONL9fgalW3/UHW+1ha96SWCcm8scfpS6RZOhkEElcp5YgRXS9W97gSh4C79Hf/LKVe6T
         a0x8psXxXcLjeTV47Ha8K9NTpRTfNDr/5/+wGyVadf6WYMVYuKRzSf9uhjthNLFsdcih
         tWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768615873; x=1769220673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8XfzdTcYbKXbttOZYCkhexZVaSChWM1LNoqV+hh1gE=;
        b=ZdFOkzRTADt3xVQfSORuPTrg9V3EEUczi5nlSbry5nV3UQ6hlcPSioetMFEEo20C1E
         M/UapJD3gJyew7TzlIRIi333uAYJLkJKL/TN5oSLL2vKeefXYRVn0oqoVKPLxbBtYZBh
         AH+7aC252yLnq8BUX6O+quu9DKplFihcc4frrLk/p2aLCJkPRrWG7ObbOqOthQYfctCO
         RMcMm9k89774vQP9c8gkSrP2FB7BivJceJLwnlc8N3I1Jy6XlLFMz7ZlnkOPAWSW2Xvi
         ECbmzOVE8Dbq0oyPKlkmwm4yq/wZEXXBvbG/ufOS+XkH1wP55j9sz1kURPoRZ0axyqLU
         olxg==
X-Forwarded-Encrypted: i=1; AJvYcCVhLknDGHGhAZ8xLX8xk8teFXn7hJ7s2sRW02BdN2eexPe/WrgW4+qToQBbPl6PCYDZsKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOyUQvVmRt5it80XDzQgg/lyfzf3mpFzKOXIy7iOaE6uuYcPG
	ny3MP+xwFbZadTpRJaB31BWV18sQGtUu3UhL9snGn5B0Q5BLJfDsxsxxRuoBoFUepQrBa67AYld
	KAb4ZLA/rLoSELL2gTEMBV/2B5fZyMMM7QWcqs6nS
X-Gm-Gg: AY/fxX7ifybbn9q7lS6F86GMS1sqgxnYGsRuAl//sbKZqChjM3nXbnWEFbSf1vF+J+j
	ueQ44fHzdZlPZmiPfCAWSA544N35BmlsHRMLYMw8AoAnCAidc1UhNBCHMsRkcHpY1SNil04wts9
	7K9fXlkO9nw+rbvg+laViC5QKfsCVN+6bsEl4kU3aBukfy4DvpHJ13qhdP2TH0XlJXUwVvBa2ck
	KRIhE4ykqkDwvJ2TDdGgYkba+dCBEFoj453vKJaWIKy4XTP3jb637LzDpMlesK25PeNTmS+duQm
	tIZ91A7Ct1MkoipMWdH9wiZJ4xcPdNocpQ==
X-Received: by 2002:a05:622a:607:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-502afa038cbmr4649721cf.12.1768615873084; Fri, 16 Jan 2026
 18:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 17 Jan 2026 02:11:02 +0000
X-Gm-Features: AZwV_QgrFpJPgQWV97FWxIc0ZsJ8CltGCxNFZv_PPGY8cU_AH1jVOdq1pMTHKpM
Message-ID: <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/21] slab: introduce percpu sheaves bootstrap
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
> sheaves enabled. Since we want to enable them for almost all caches,
> it's suboptimal to test the pointer in the fast paths, so instead
> allocate it for all caches in do_kmem_cache_create(). Instead of testing
> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
> kmem_cache->sheaf_capacity for being 0, where needed, using a new
> cache_has_sheaves() helper.
>
> However, for the fast paths sake we also assume that the main sheaf
> always exists (pcs->main is !NULL), and during bootstrap we cannot
> allocate sheaves yet.
>
> Solve this by introducing a single static bootstrap_sheaf that's
> assigned as pcs->main during bootstrap. It has a size of 0, so during
> allocations, the fast path will find it's empty. Since the size of 0
> matches sheaf_capacity of 0, the freeing fast paths will find it's
> "full". In the slow path handlers, we use cache_has_sheaves() to
> recognize that the cache doesn't (yet) have real sheaves, and fall back.

I don't think kmem_cache_prefill_sheaf() handles this case, does it?
Or do you rely on the caller to never try prefilling a bootstrapped
sheaf?
kmem_cache_refill_sheaf() and kmem_cache_return_sheaf() operate on a
sheaf obtained by calling kmem_cache_prefill_sheaf(), so if
kmem_cache_prefill_sheaf() never returns a bootstrapped sheaf we don't
need special handling there.

> Thus sharing the single bootstrap sheaf like this for multiple caches
> and cpus is safe.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 119 ++++++++++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 81 insertions(+), 38 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index edf341c87e20..706cb6398f05 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -501,6 +501,18 @@ struct kmem_cache_node {
>         struct node_barn *barn;
>  };
>
> +/*
> + * Every cache has !NULL s->cpu_sheaves but they may point to the
> + * bootstrap_sheaf temporarily during init, or permanently for the boot =
caches
> + * and caches with debugging enabled, or all caches with CONFIG_SLUB_TIN=
Y. This
> + * helper distinguishes whether cache has real non-bootstrap sheaves.
> + */
> +static inline bool cache_has_sheaves(struct kmem_cache *s)
> +{
> +       /* Test CONFIG_SLUB_TINY for code elimination purposes */
> +       return !IS_ENABLED(CONFIG_SLUB_TINY) && s->sheaf_capacity;
> +}
> +
>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int=
 node)
>  {
>         return s->node[node];
> @@ -2855,6 +2867,10 @@ static void pcs_destroy(struct kmem_cache *s)
>                 if (!pcs->main)
>                         continue;
>
> +               /* bootstrap or debug caches, it's the bootstrap_sheaf */
> +               if (!pcs->main->cache)
> +                       continue;

I wonder why we can't simply check cache_has_sheaves(s) at the
beginning and skip the loop altogether.
I realize that __kmem_cache_release()->pcs_destroy() is called in the
failure path of do_kmem_cache_create() and s->cpu_sheaves might be
partially initialized if alloc_empty_sheaf() fails somewhere in the
middle of the loop inside init_percpu_sheaves(). But for that,
s->sheaf_capacity should still be non-zero, so checking
cache_has_sheaves() at the beginning of pcs_destroy() should still
work, no?

BTW, I see one last check for s->cpu_sheaves that you didn't replace
with cache_has_sheaves() inside __kmem_cache_release(). I think that's
because it's also in the failure path of do_kmem_cache_create() and
it's possible that s->sheaf_capacity > 0 while s->cpu_sheaves =3D=3D NULL
(if alloc_percpu(struct slub_percpu_sheaves) fails). It might be
helpful to add a comment inside __kmem_cache_release() to explain why
cache_has_sheaves() can't be used there.

> +
>                 /*
>                  * We have already passed __kmem_cache_shutdown() so ever=
ything
>                  * was flushed and there should be no objects allocated f=
rom
> @@ -4030,7 +4046,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache=
 *s)
>  {
>         struct slub_percpu_sheaves *pcs;
>
> -       if (!s->cpu_sheaves)
> +       if (!cache_has_sheaves(s))
>                 return false;
>
>         pcs =3D per_cpu_ptr(s->cpu_sheaves, cpu);
> @@ -4052,7 +4068,7 @@ static void flush_cpu_slab(struct work_struct *w)
>
>         s =3D sfw->s;
>
> -       if (s->cpu_sheaves)
> +       if (cache_has_sheaves(s))
>                 pcs_flush_all(s);
>
>         flush_this_cpu_slab(s);
> @@ -4157,7 +4173,7 @@ void flush_all_rcu_sheaves(void)
>         mutex_lock(&slab_mutex);
>
>         list_for_each_entry(s, &slab_caches, list) {
> -               if (!s->cpu_sheaves)
> +               if (!cache_has_sheaves(s))
>                         continue;
>                 flush_rcu_sheaves_on_cache(s);
>         }
> @@ -4179,7 +4195,7 @@ static int slub_cpu_dead(unsigned int cpu)
>         mutex_lock(&slab_mutex);
>         list_for_each_entry(s, &slab_caches, list) {
>                 __flush_cpu_slab(s, cpu);
> -               if (s->cpu_sheaves)
> +               if (cache_has_sheaves(s))
>                         __pcs_flush_all_cpu(s, cpu);
>         }
>         mutex_unlock(&slab_mutex);
> @@ -4979,6 +4995,12 @@ __pcs_replace_empty_main(struct kmem_cache *s, str=
uct slub_percpu_sheaves *pcs,
>
>         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>
> +       /* Bootstrap or debug cache, back off */
> +       if (unlikely(!cache_has_sheaves(s))) {
> +               local_unlock(&s->cpu_sheaves->lock);
> +               return NULL;
> +       }
> +
>         if (pcs->spare && pcs->spare->size > 0) {
>                 swap(pcs->main, pcs->spare);
>                 return pcs;
> @@ -5165,6 +5187,11 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache=
 *s, size_t size, void **p)
>                 struct slab_sheaf *full;
>                 struct node_barn *barn;
>
> +               if (unlikely(!cache_has_sheaves(s))) {
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       return allocated;
> +               }
> +
>                 if (pcs->spare && pcs->spare->size > 0) {
>                         swap(pcs->main, pcs->spare);
>                         goto do_alloc;
> @@ -5244,8 +5271,7 @@ static __fastpath_inline void *slab_alloc_node(stru=
ct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       if (s->cpu_sheaves)
> -               object =3D alloc_from_pcs(s, gfpflags, node);
> +       object =3D alloc_from_pcs(s, gfpflags, node);
>
>         if (!object)
>                 object =3D __slab_alloc_node(s, gfpflags, node, addr, ori=
g_size);
> @@ -5355,17 +5381,6 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp=
_t gfp, unsigned int size)
>
>         if (unlikely(size > s->sheaf_capacity)) {
>
> -               /*
> -                * slab_debug disables cpu sheaves intentionally so all
> -                * prefilled sheaves become "oversize" and we give up on
> -                * performance for the debugging. Same with SLUB_TINY.
> -                * Creating a cache without sheaves and then requesting a
> -                * prefilled sheaf is however not expected, so warn.
> -                */
> -               WARN_ON_ONCE(s->sheaf_capacity =3D=3D 0 &&
> -                            !IS_ENABLED(CONFIG_SLUB_TINY) &&
> -                            !(s->flags & SLAB_DEBUG_FLAGS));
> -
>                 sheaf =3D kzalloc(struct_size(sheaf, objects, size), gfp)=
;
>                 if (!sheaf)
>                         return NULL;
> @@ -6082,6 +6097,12 @@ __pcs_replace_full_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs)
>  restart:
>         lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
>
> +       /* Bootstrap or debug cache, back off */
> +       if (unlikely(!cache_has_sheaves(s))) {
> +               local_unlock(&s->cpu_sheaves->lock);
> +               return NULL;
> +       }
> +
>         barn =3D get_barn(s);
>         if (!barn) {
>                 local_unlock(&s->cpu_sheaves->lock);
> @@ -6280,6 +6301,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj)
>                 struct slab_sheaf *empty;
>                 struct node_barn *barn;
>
> +               /* Bootstrap or debug cache, fall back */
> +               if (unlikely(!cache_has_sheaves(s))) {
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       goto fail;
> +               }
> +
>                 if (pcs->spare && pcs->spare->size =3D=3D 0) {
>                         pcs->rcu_free =3D pcs->spare;
>                         pcs->spare =3D NULL;
> @@ -6674,9 +6701,8 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>         if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s)=
, false)))
>                 return;
>
> -       if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
> -                                    slab_nid(slab) =3D=3D numa_mem_id())
> -                          && likely(!slab_test_pfmemalloc(slab))) {
> +       if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa=
_mem_id())
> +           && likely(!slab_test_pfmemalloc(slab))) {
>                 if (likely(free_to_pcs(s, object)))
>                         return;
>         }
> @@ -7379,7 +7405,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, siz=
e_t size, void **p)
>          * freeing to sheaves is so incompatible with the detached freeli=
st so
>          * once we go that way, we have to do everything differently
>          */
> -       if (s && s->cpu_sheaves) {
> +       if (s && cache_has_sheaves(s)) {
>                 free_to_pcs_bulk(s, size, p);
>                 return;
>         }
> @@ -7490,8 +7516,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache =
*s, gfp_t flags, size_t size,
>                 size--;
>         }
>
> -       if (s->cpu_sheaves)
> -               i =3D alloc_from_pcs_bulk(s, size, p);
> +       i =3D alloc_from_pcs_bulk(s, size, p);

Doesn't the above change make this fastpath a bit longer? IIUC,
instead of bailing out right here we call alloc_from_pcs_bulk() and
bail out from there because pcs->main->size is 0.

>
>         if (i < size) {
>                 /*
> @@ -7702,6 +7727,7 @@ static inline int alloc_kmem_cache_cpus(struct kmem=
_cache *s)
>
>  static int init_percpu_sheaves(struct kmem_cache *s)
>  {
> +       static struct slab_sheaf bootstrap_sheaf =3D {};
>         int cpu;
>
>         for_each_possible_cpu(cpu) {
> @@ -7711,7 +7737,28 @@ static int init_percpu_sheaves(struct kmem_cache *=
s)
>
>                 local_trylock_init(&pcs->lock);
>
> -               pcs->main =3D alloc_empty_sheaf(s, GFP_KERNEL);
> +               /*
> +                * Bootstrap sheaf has zero size so fast-path allocation =
fails.
> +                * It has also size =3D=3D s->sheaf_capacity, so fast-pat=
h free
> +                * fails. In the slow paths we recognize the situation by
> +                * checking s->sheaf_capacity. This allows fast paths to =
assume
> +                * s->cpu_sheaves and pcs->main always exists and is vali=
d.

s/is/are

> +                * It's also safe to share the single static bootstrap_sh=
eaf
> +                * with zero-sized objects array as it's never modified.
> +                *
> +                * bootstrap_sheaf also has NULL pointer to kmem_cache so=
 we
> +                * recognize it and not attempt to free it when destroyin=
g the
> +                * cache

missing a period at the end of the above sentence.

> +                *
> +                * We keep bootstrap_sheaf for kmem_cache and kmem_cache_=
node,
> +                * caches with debug enabled, and all caches with SLUB_TI=
NY.
> +                * For kmalloc caches it's used temporarily during the in=
itial
> +                * bootstrap.
> +                */
> +               if (!s->sheaf_capacity)
> +                       pcs->main =3D &bootstrap_sheaf;
> +               else
> +                       pcs->main =3D alloc_empty_sheaf(s, GFP_KERNEL);
>
>                 if (!pcs->main)
>                         return -ENOMEM;
> @@ -7809,7 +7856,7 @@ static int init_kmem_cache_nodes(struct kmem_cache =
*s)
>                         continue;
>                 }
>
> -               if (s->cpu_sheaves) {
> +               if (cache_has_sheaves(s)) {
>                         barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL, =
node);
>
>                         if (!barn)
> @@ -8127,7 +8174,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         flush_all_cpus_locked(s);
>
>         /* we might have rcu sheaves in flight */
> -       if (s->cpu_sheaves)
> +       if (cache_has_sheaves(s))
>                 rcu_barrier();
>
>         /* Attempt to free all objects */
> @@ -8439,7 +8486,7 @@ static int slab_mem_going_online_callback(int nid)
>                 if (get_node(s, nid))
>                         continue;
>
> -               if (s->cpu_sheaves) {
> +               if (cache_has_sheaves(s)) {
>                         barn =3D kmalloc_node(sizeof(*barn), GFP_KERNEL, =
nid);
>
>                         if (!barn) {
> @@ -8647,12 +8694,10 @@ int do_kmem_cache_create(struct kmem_cache *s, co=
nst char *name,
>
>         set_cpu_partial(s);
>
> -       if (s->sheaf_capacity) {
> -               s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheave=
s);
> -               if (!s->cpu_sheaves) {
> -                       err =3D -ENOMEM;
> -                       goto out;
> -               }
> +       s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheaves);
> +       if (!s->cpu_sheaves) {
> +               err =3D -ENOMEM;
> +               goto out;
>         }
>
>  #ifdef CONFIG_NUMA
> @@ -8671,11 +8716,9 @@ int do_kmem_cache_create(struct kmem_cache *s, con=
st char *name,
>         if (!alloc_kmem_cache_cpus(s))
>                 goto out;
>
> -       if (s->cpu_sheaves) {
> -               err =3D init_percpu_sheaves(s);
> -               if (err)
> -                       goto out;
> -       }
> +       err =3D init_percpu_sheaves(s);
> +       if (err)
> +               goto out;
>
>         err =3D 0;
>
>
> --
> 2.52.0
>

