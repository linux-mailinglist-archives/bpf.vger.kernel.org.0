Return-Path: <bpf+bounces-72154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04DC07F1F
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E763AE72D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EB2D77E8;
	Fri, 24 Oct 2025 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRXTaFOD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573282C0F8E
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335014; cv=none; b=LCsV1mTyrkPachXDgkqpD2w0OjBuRGlIHjEQaI9Cs3TMgi/s4lp/m1x0Y1k6eKk9n4gWJfQB67T5lF9KXArSOyShX9PV2A7X0P2QJMCW+/TEox9Ywfd686/h6JQp3ELTbgjzmU408evcHFtHMMy8umgorudz5uy1vetghI/iL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335014; c=relaxed/simple;
	bh=GhnYeUgW9HNrnbNuXebyBgs91nhB/UF1Y9z4XhqgECw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia7jg1B189oIZ/+JOEza6haW9oKaa5gYhkH1EUAtPsQ6LcKAuH87Z8fVqqvYHM8xSHIDMKAjOIykWTS67wAZnjxZKWNK7H4atT32xyo32WideYXeA4ON2hTxB/vjTDisOPtEJejj9eSekp0SI5TeGGaka8kmZajhvrn4hTc7UMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRXTaFOD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471b80b994bso34176245e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761335010; x=1761939810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90XaxFEyCpkV47QCzVcKxG5N1KKEds9BtveeKPxtNeE=;
        b=QRXTaFODlGVVO20BunHLNVYW9aB63Ucl9U8p+2nnU68xlX90lpZUtsjxc+lXHmx0hc
         EShBr4LRNZKTSsyKlhJ3BFSO7bJOq/4/VHbZltBLzwIAwH9O1/KW4gYsHC/kH302XhFR
         2RVpyGFAqc6W3es49M94+KHF6ic/eE1X5789Q455ZAOHBMtBl9sis0MOP47QD0Bo9R9z
         K8MdRo022dtfEg6fY/m3knGIpcV7Blr4eYita9UlJpWUItZMFZs1vJXHJrd1gKHlU3Lo
         Len6KN1bri+7TOPV6MPNQH3aYOe1MTdQ3xqUSLjjkdpJewukDMYYhGS+ueg7IhxEATA1
         Yz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761335010; x=1761939810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90XaxFEyCpkV47QCzVcKxG5N1KKEds9BtveeKPxtNeE=;
        b=MrnHX0YG0Jeb9u3bCMtQo9Vwz9JSlAxXR2JKnkKc58o+ow6aldiEId6bc4PqE/yOP/
         /ZxxLbYhi1FClYjJgL9ufWjRfBKpWJ3qlac+XI90Ibfki2t0StcqfhZoOKvQ6zNG3NZr
         Uc/njFL9ZcBtDrDOq7D1+evTGBqPO9/dpZdLt3i69vRJAAKUrNHgDBJYWBSu2UooJ2/1
         kqR28tFhy2J8Aqv6ubreIK9AfGAaHFT+yFhMPg60Gis0Dmj/SI0YRlwdqJZnYe5nru3Z
         cz+pNR1nTrHlvPsrOT/1CRgIpjFPbQoT5jWdPwRBcuP7Othplc2eplY78NqntzqH8858
         +Z/A==
X-Forwarded-Encrypted: i=1; AJvYcCXo1SLh/1lz52mDXFJhzuPcCecfxniPIAR1T0Q9leiiVAgEKgBRhQkp4Barw7SciZzsrE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrohloyDzOT8/33uNrYZBdZhaPVYGSMioftp41hILsM/CF0zwi
	FrRXuG+mUXDEq7n7189MbPAY9fkPwniw+wD3LYLv1T5Usm0s2r0hHEJxbs9LyNZBqyoFbJSsXJG
	MbCIMqxecRaG63Db2bHQ6PwvmC600b1U=
X-Gm-Gg: ASbGncuwPFXy6FK8WinRdXGTtYdQ79ZNhA/bZAuuMxnkX2erEPgBCjohbc3D8wYM/GM
	8Mo+fP8QTC/GcKDXXJPZQPH7nZyhPuJMHXTwUH9PhvpDAIuVWyd04U20ASxFOqwAOMGKktj9TqN
	0NmwBwXDJwYpVSui129zvVuDsYpKrwn2/cUtEvk1oI7U8jrvThElhhKztK11YwD6TtVAISfsUe/
	Zc0kwHUHjHLLKygQEmjF0GqIsrZIz+xAizCSsONU3mO//y3z1sR4x+e7qaUCVdmowd2B4CogKIx
	L4v2+RgTbaDyWnPfSCWtOylgb7Wq
X-Google-Smtp-Source: AGHT+IGlhgaHR7jFg9+tMxl+vQhbMYL40wY/+fohU6NDJjpXaCt4CPnZUsK/fNBWdwfFYQyXTJ3GI3NvxqyaKNwKNEI=
X-Received: by 2002:a05:600c:3149:b0:46f:b43a:aef0 with SMTP id
 5b1f17b1804b1-47117925e63mr211257905e9.41.1761335010286; Fri, 24 Oct 2025
 12:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-7-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-7-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 12:43:18 -0700
X-Gm-Features: AWmQ_bk-kyewHYgpxUqtmCiyFoLA8j75cYs74Mz6Re-SJFA0srIhl0qtPOmknRs
Message-ID: <CAADnVQLAFkYLLJbMjEyzEu=Q7aJSs19Ddb1qXqEWNnxm6=CDFg@mail.gmail.com>
Subject: Re: [PATCH RFC 07/19] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
To: Vlastimil Babka <vbabka@suse.cz>, Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
>
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
>
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 52 insertions(+), 22 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ecb10ed5acfe..5d0b2cf66520 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2876,7 +2876,8 @@ static void pcs_destroy(struct kmem_cache *s)
>         s->cpu_sheaves =3D NULL;
>  }
>
> -static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
> +                                              bool allow_spin)
>  {
>         struct slab_sheaf *empty =3D NULL;
>         unsigned long flags;
> @@ -2884,7 +2885,10 @@ static struct slab_sheaf *barn_get_empty_sheaf(str=
uct node_barn *barn)
>         if (!data_race(barn->nr_empty))
>                 return NULL;
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return NULL;
>
>         if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty,
> @@ -2961,7 +2965,8 @@ static struct slab_sheaf *barn_get_full_or_empty_sh=
eaf(struct node_barn *barn)
>   * change.
>   */
>  static struct slab_sheaf *
> -barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empt=
y)
> +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empt=
y,
> +                        bool allow_spin)
>  {
>         struct slab_sheaf *full =3D NULL;
>         unsigned long flags;
> @@ -2969,7 +2974,10 @@ barn_replace_empty_sheaf(struct node_barn *barn, s=
truct slab_sheaf *empty)
>         if (!data_race(barn->nr_full))
>                 return NULL;
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return NULL;
>
>         if (likely(barn->nr_full)) {
>                 full =3D list_first_entry(&barn->sheaves_full, struct sla=
b_sheaf,
> @@ -2990,7 +2998,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, st=
ruct slab_sheaf *empty)
>   * barn. But if there are too many full sheaves, reject this with -E2BIG=
.
>   */
>  static struct slab_sheaf *
> -barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
> +                       bool allow_spin)
>  {
>         struct slab_sheaf *empty;
>         unsigned long flags;
> @@ -3001,7 +3010,10 @@ barn_replace_full_sheaf(struct node_barn *barn, st=
ruct slab_sheaf *full)
>         if (!data_race(barn->nr_empty))
>                 return ERR_PTR(-ENOMEM);
>
> -       spin_lock_irqsave(&barn->lock, flags);
> +       if (likely(allow_spin))
> +               spin_lock_irqsave(&barn->lock, flags);
> +       else if (!spin_trylock_irqsave(&barn->lock, flags))
> +               return NULL;

AI did a good job here. I spent an hour staring at the patch
for other reasons. Noticed this bug too and then went
"ohh, wait, AI mentioned it already". Time to retire.

>         if (likely(barn->nr_empty)) {
>                 empty =3D list_first_entry(&barn->sheaves_empty, struct s=
lab_sheaf,
> @@ -5000,7 +5012,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs,
>                 return NULL;
>         }
>
> -       full =3D barn_replace_empty_sheaf(barn, pcs->main);
> +       full =3D barn_replace_empty_sheaf(barn, pcs->main,
> +                                       gfpflags_allow_spinning(gfp));
>
>         if (full) {
>                 stat(s, BARN_GET);
> @@ -5017,7 +5030,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs,
>                         empty =3D pcs->spare;
>                         pcs->spare =3D NULL;
>                 } else {
> -                       empty =3D barn_get_empty_sheaf(barn);
> +                       empty =3D barn_get_empty_sheaf(barn, true);
>                 }
>         }
>
> @@ -5154,7 +5167,8 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>  }
>
>  static __fastpath_inline
> -unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void=
 **p)
> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t=
 size,
> +                                void **p)
>  {
>         struct slub_percpu_sheaves *pcs;
>         struct slab_sheaf *main;
> @@ -5188,7 +5202,8 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, size_t size, void **p)
>                         return allocated;
>                 }
>
> -               full =3D barn_replace_empty_sheaf(barn, pcs->main);
> +               full =3D barn_replace_empty_sheaf(barn, pcs->main,
> +                                               gfpflags_allow_spinning(g=
fp));
>
>                 if (full) {
>                         stat(s, BARN_GET);
> @@ -5693,7 +5708,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_=
flags, int node)
>         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>         struct kmem_cache *s;
>         bool can_retry =3D true;
> -       void *ret =3D ERR_PTR(-EBUSY);
> +       void *ret;
>
>         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>                                       __GFP_NO_OBJ_EXT));
> @@ -5720,6 +5735,13 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp=
_flags, int node)
>                  */
>                 return NULL;
>
> +       ret =3D alloc_from_pcs(s, alloc_gfp, node);
> +

I would remove the empty line here.

> +       if (ret)
> +               goto success;
> +
> +       ret =3D ERR_PTR(-EBUSY);
> +
>         /*
>          * Do not call slab_alloc_node(), since trylock mode isn't
>          * compatible with slab_pre_alloc_hook/should_failslab and
> @@ -5756,6 +5778,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_=
flags, int node)
>                 ret =3D NULL;
>         }
>
> +success:
>         maybe_wipe_obj_freeptr(s, ret);
>         slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
>                              slab_want_init_on_alloc(alloc_gfp, s), size)=
;
> @@ -6047,7 +6070,8 @@ static void __pcs_install_empty_sheaf(struct kmem_c=
ache *s,
>   * unlocked.
>   */
>  static struct slub_percpu_sheaves *
> -__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves=
 *pcs)
> +__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves=
 *pcs,
> +                       bool allow_spin)
>  {
>         struct slab_sheaf *empty;
>         struct node_barn *barn;
> @@ -6071,7 +6095,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>         put_fail =3D false;
>
>         if (!pcs->spare) {
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, allow_spin);
>                 if (empty) {
>                         pcs->spare =3D pcs->main;
>                         pcs->main =3D empty;
> @@ -6085,7 +6109,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>                 return pcs;
>         }
>
> -       empty =3D barn_replace_full_sheaf(barn, pcs->main);
> +       empty =3D barn_replace_full_sheaf(barn, pcs->main, allow_spin);
>
>         if (!IS_ERR(empty)) {
>                 stat(s, BARN_PUT);
> @@ -6093,6 +6117,11 @@ __pcs_replace_full_main(struct kmem_cache *s, stru=
ct slub_percpu_sheaves *pcs)
>                 return pcs;
>         }
>
> +       if (!allow_spin) {
> +               local_unlock(&s->cpu_sheaves->lock);
> +               return NULL;
> +       }

and would add a comment here to elaborate that the next
steps like sheaf_flush_unused() and alloc_empty_sheaf()
cannot handle !allow_spin.


> +
>         if (PTR_ERR(empty) =3D=3D -E2BIG) {
>                 /* Since we got here, spare exists and is full */
>                 struct slab_sheaf *to_flush =3D pcs->spare;
> @@ -6160,7 +6189,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struc=
t slub_percpu_sheaves *pcs)
>   * The object is expected to have passed slab_free_hook() already.
>   */
>  static __fastpath_inline
> -bool free_to_pcs(struct kmem_cache *s, void *object)
> +bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  {
>         struct slub_percpu_sheaves *pcs;
>
> @@ -6171,7 +6200,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object=
)
>
>         if (unlikely(pcs->main->size =3D=3D s->sheaf_capacity)) {
>
> -               pcs =3D __pcs_replace_full_main(s, pcs);
> +               pcs =3D __pcs_replace_full_main(s, pcs, allow_spin);
>                 if (unlikely(!pcs))
>                         return false;
>         }
> @@ -6278,7 +6307,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *=
obj)
>                         goto fail;
>                 }
>
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, true);
>
>                 if (empty) {
>                         pcs->rcu_free =3D empty;
> @@ -6398,7 +6427,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>                 goto no_empty;
>
>         if (!pcs->spare) {
> -               empty =3D barn_get_empty_sheaf(barn);
> +               empty =3D barn_get_empty_sheaf(barn, true);

I'm allergic to booleans in arguments. They make callsites
hard to read. Especially if there are multiple bools.
We have horrendous lines in the verifier that we still need
to clean up due to bools:
check_load_mem(env, insn, true, false, false, "atomic_load");

barn_get_empty_sheaf(barn, true); looks benign,
but I would still use enum { DONT_SPIN, ALLOW_SPIN }
and use that in all functions instead of 'bool allow_spin'.

Aside from that I got worried that sheaves fast path
may be not optimized well by the compiler:
if (unlikely(pcs->main->size =3D=3D 0)) ...
object =3D pcs->main->objects[pcs->main->size - 1];
// object is accessed here
pcs->main->size--;

since object may alias into pcs->main and the compiler
may be tempted to reload 'main'.
Looks like it's fine, since object point is not actually read or written.
gcc15 asm looks good:
        movq    8(%rbx), %rdx   # _68->main, _69
        movl    24(%rdx), %eax  # _69->size, _70
# ../mm/slub.c:5129:    if (unlikely(pcs->main->size =3D=3D 0)) {
        testl   %eax, %eax      # _70
        je      .L2076  #,
.L1953:
# ../mm/slub.c:5135:    object =3D pcs->main->objects[pcs->main->size - 1];
        leal    -1(%rax), %esi  #,
# ../mm/slub.c:5135:    object =3D pcs->main->objects[pcs->main->size - 1];
        movq    32(%rdx,%rsi,8), %rdi   # prephitmp_309->objects[_81], obje=
ct
# ../mm/slub.c:5135:    object =3D pcs->main->objects[pcs->main->size - 1];
        movq    %rsi, %rax      #,
# ../mm/slub.c:5137:    if (unlikely(node_requested)) {
        testb   %r15b, %r15b    # node_requested
        jne     .L2077  #,
.L1954:
# ../mm/slub.c:5149:    pcs->main->size--;
        movl    %eax, 24(%rdx)  # _81, prephitmp_30->size

