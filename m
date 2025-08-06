Return-Path: <bpf+bounces-65101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E63B1BEDA
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 04:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B28B3BB15B
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A61C700D;
	Wed,  6 Aug 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzXo0dcw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CD634
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754448047; cv=none; b=GYNI8njKRiNJ43pLSkunSdV55cU+0ccTc6zS4ayKv2/X/gvI0KPQSsDojoso4nmgh+N3+/WSC7gY/bhqYEgpDNrGih50MjWln3Ys2uX+6EwZ2hXgqPGA+tLkH5z3u61+CIUw0DdvZNMjn0abgHCNhpnISoSH7aomeZ9+gbdv7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754448047; c=relaxed/simple;
	bh=BBcM3FX+7eQ8Ix1zAWh8vD5HWjnIbtJLnWau1QmNEx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE5gsdIAONWD/x3Pzz5PdyuOsGaPijk+CC7ilET47MHpNHtqX5a1cHEsifWHmYjCy3Ej/ttzybhM5dWc0e345lw4ndBUPRzfBLqUUKDQk5VMilmfaBMFXNlJ3naKY2/TAOnGSD8ckA6EsvXlFXnFG2bOySProdP5AYbAydewz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzXo0dcw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so1685154f8f.1
        for <bpf@vger.kernel.org>; Tue, 05 Aug 2025 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754448044; x=1755052844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLlEipj5qbn5m1EPWZYCpWoD/dE/UtKNcnHCLbeeDf4=;
        b=bzXo0dcwh9sv1QQizVsF0ttThdjiRdAwVhsKaXrLqbidXnm3j1wA79zwiLP/nVCbzC
         ZoBRT47twpeB18P4QDkXJ1f0L7JL4BCdqE9XcUNpdAtCFNE3LeyTfHDSAojznVTi70G6
         /siCUmDzbwsakmaJ4+u4MSdfhxNKOY+/yoXcko1tHFvI7aDGvWDeRqwz16PyeHTwGE5Y
         Y267QRlkiJ5J0dpe4VkJFOUb0XOtmJzLiKQVGu4qvTnWVR3m5F1XhszHAG3mMGyWXn4x
         Q1+EkkUAwkN23mlQU2r0hu95UzDJqEzM6mFByY9FDQvuXl3/ceYJaMiqRaA4LFiw596/
         s9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754448044; x=1755052844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLlEipj5qbn5m1EPWZYCpWoD/dE/UtKNcnHCLbeeDf4=;
        b=CTkthHOHKinW8m7eSBBRC6rpmxjnsI3ohaLTAEqigM9+Clg1sVqlBzsTDJ/vhyVTcI
         WT6o1RIZSKTr1E5QwLX/7eQaGb3iPzNQaKFrtcGEBTc8Z3REut3VVGkhDAxvDr05wQgL
         odZ8+ZNcVUQ+QW+1PnDviJx0IFf3GFoW0mMMbW2pxiKWpDEYqZR1dF1vjGNVsK7Ht16U
         +UEGxkvXH5vM3frM94MsdA3qtY3nkYPaUjgWQMIAe+djoeMA/e2Uhn9lIhdIy565Zhm9
         yid9gKOmD5BYtiVcaRiqH0NT5TyHP41orxzxlggCxRwwC5jpnSJlg6TA9lYhBzemN1nx
         8j4A==
X-Gm-Message-State: AOJu0YxxhBEQDj1YdjFhD/j/pzmx4QvlaR2a4fHCWq/wFHp3RIEQdYMr
	NFD7FJ58aR1rT5KKUI8wO5gr3VvSQKH4te1WuNhlj9OoPFmHTOOITPLj89bk4uLNTs3SvjJAwvy
	lXAq/zyVF/kD1+ZCG2biRBWgW/9nZN8k=
X-Gm-Gg: ASbGnctVppeXJiluCBfOLIMaql0qP6o5tqrYkAnLk1swb7pObFPS9GL2Bv+CadsD0O6
	2cs2KfyimwyetqzWPp9djYBgp2MJ98Z9jc7s0FeENBLr5T3s0NqGgKg5toWZ3bnjyPUj6It2JQ0
	otFB/1rcOQMqmWu82P5jHxI84tYnnZZzEnbV4cmCG8922EQxBZwLPwAWB+DiMIE5Yla6+S9/K4f
	s7u+6SWJFUnMxZAcXyVygdtFvyjfFexGYXKlnn1b130E3o=
X-Google-Smtp-Source: AGHT+IEqQf+zIHee4jCOpPWCrFBxTHlSSwudoM9zCDhMPNBMCCOBFKlF9RfFmW1hP1ToEnN6mEMTigKm06t258o+Yt4=
X-Received: by 2002:a05:6000:22c7:b0:3b7:8984:5134 with SMTP id
 ffacd0b85a97d-3b8f41b2be7mr728075f8f.16.1754448043269; Tue, 05 Aug 2025
 19:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com> <aH-ztTONTcgjU7xl@hyeyoo>
In-Reply-To: <aH-ztTONTcgjU7xl@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Aug 2025 19:40:31 -0700
X-Gm-Features: Ac12FXzhE05PN0vHH-9uNGVO_3cAT3d4-7vs-buakhtDhbKITGrojhmx1nagYoM
Message-ID: <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:52=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>

Sorry for the delay. PTO plus merge window.

> On Thu, Jul 17, 2025 at 07:16:46PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > kmalloc_nolock() relies on ability of local_trylock_t to detect
> > the situation when per-cpu kmem_cache is locked.
>
> I think kmalloc_nolock() should be kmalloc_node_nolock() because
> it has `node` parameter?
>
> # Don't specify NUMA node       # Specify NUMA node
> kmalloc(size, gfp)              kmalloc_nolock(size, gfp)
> kmalloc_node(size, gfp, node)   kmalloc_node_nolock(size, gfp, node)
>
> ...just like kmalloc() and kmalloc_node()?

I think this is a wrong pattern to follow.
All this "_node" suffix/rename was done long ago to avoid massive
search-and-replace when NUMA was introduced. Now NUMA is mandatory.
The user of API should think what numa_id to use and if none
they should explicitly say NUMA_NO_NODE.
Hiding behind macros is not a good api.
I hate the "_node_align" suffixes too. It's a silly convention.
Nothing in the kernel follows such an outdated naming scheme.
mm folks should follow what the rest of the kernel does
instead of following a pattern from 20 years ago.

> > In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> > disables IRQs and marks s->cpu_slab->lock as acquired.
> > local_lock_is_locked(&s->cpu_slab->lock) returns true when
> > slab is in the middle of manipulating per-cpu cache
> > of that specific kmem_cache.
> >
> > kmalloc_nolock() can be called from any context and can re-enter
> > into ___slab_alloc():
> >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > or
> >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -=
> bpf ->
> >     kmalloc_nolock() -> ___slab_alloc(cache_B)
>
> > Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> > can be acquired without a deadlock before invoking the function.
> > If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> > retries in a different kmalloc bucket. The second attempt will
> > likely succeed, since this cpu locked different kmem_cache.
> >
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current _task_. In this case
> > re-entrance into the same kmalloc bucket is unsafe, and
> > kmalloc_nolock() tries a different bucket that is most likely is
> > not locked by the current task. Though it may be locked by a
> > different task it's safe to rt_spin_lock() and sleep on it.
> >
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
>
> A question; I was confused for a while thinking "If it can't be called
> from NMI and hard irq on PREEMPT_RT, why it can't just spin?"

It's not safe due to PI issues in RT.
Steven and Sebastian explained it earlier:
https://lore.kernel.org/bpf/20241213124411.105d0f33@gandalf.local.home/

I don't think I can copy paste the multi page explanation in
commit log or into comments.
So "not safe in NMI or hard irq on RT" is the summary.
Happy to add a few words, but don't know what exactly to say.
If Steven/Sebastian can provide a paragraph I can add it.

> And I guess it's because even in process context, when kmalloc_nolock()
> is called by bpf, it can be called by the task that is holding the local =
lock
> and thus spinning is not allowed. Is that correct?
>
> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > and (in_nmi() or in PREEMPT_RT).
> >
> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > spin_trylock_irqsave(&n->list_lock) to allocate,
> > while kfree_nolock() always defers to irq_work.
> >
> > Note, kfree_nolock() must be called _only_ for objects allocated
> > with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> > were skipped on allocation, hence obj =3D kmalloc(); kfree_nolock(obj);
> > will miss kmemleak/kfence book keeping and will cause false positives.
> > large_kmalloc is not supported by either kmalloc_nolock()
> > or kfree_nolock().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/kasan.h |  13 +-
> >  include/linux/slab.h  |   4 +
> >  mm/Kconfig            |   1 +
> >  mm/kasan/common.c     |   5 +-
> >  mm/slab.h             |   6 +
> >  mm/slab_common.c      |   3 +
> >  mm/slub.c             | 466 +++++++++++++++++++++++++++++++++++++-----
> >  7 files changed, 445 insertions(+), 53 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 54444bce218e..7de6da4ee46d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab=
 *slab)
> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >                       gfp_t gfp, bool new_slab)
> >  {
> > +     bool allow_spin =3D gfpflags_allow_spinning(gfp);
> >       unsigned int objects =3D objs_per_slab(s, slab);
> >       unsigned long new_exts;
> >       unsigned long old_exts;
> > @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struc=
t kmem_cache *s,
> >       gfp &=3D ~OBJCGS_CLEAR_MASK;
> >       /* Prevent recursive extension vector allocation */
> >       gfp |=3D __GFP_NO_OBJ_EXT;
> > -     vec =3D kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > -                        slab_nid(slab));
> > +     if (unlikely(!allow_spin)) {
> > +             size_t sz =3D objects * sizeof(struct slabobj_ext);
> > +
> > +             vec =3D kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
>
> In free_slab_obj_exts(), how do you know slabobj_ext is allocated via
> kmalloc_nolock() or kcalloc_node()?

Technically kmalloc_nolock()->kfree() isn't as bad as
kmalloc()->kfree_nolock(), since kmemleak/kfence can ignore
debug free-ing action without matching alloc side,
but you're right it's better to avoid it.

> I was going to say "add a new flag to enum objext_flags",
> but all lower 3 bits of slab->obj_exts pointer are already in use? oh...
>
> Maybe need a magic trick to add one more flag,
> like always align the size with 16?
>
> In practice that should not lead to increase in memory consumption
> anyway because most of the kmalloc-* sizes are already at least
> 16 bytes aligned.

Yes. That's an option, but I think we can do better.
OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
Here are two patches that fix this issue:

Subject: [PATCH 1/2] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL

Since the combination of valid upper bits in slab->obj_exts with
OBJEXTS_ALLOC_FAIL bit can never happen,
use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sentinel
instead of (1ull << 2) to free up bit 2.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/memcontrol.h | 4 +++-
 mm/slub.c                  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..daa78665f850 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -341,17 +341,19 @@ enum page_memcg_data_flags {
        __NR_MEMCG_DATA_FLAGS  =3D (1UL << 2),
 };

+#define __OBJEXTS_ALLOC_FAIL   MEMCG_DATA_OBJEXTS
 #define __FIRST_OBJEXT_FLAG    __NR_MEMCG_DATA_FLAGS

 #else /* CONFIG_MEMCG */

+#define __OBJEXTS_ALLOC_FAIL   (1UL << 0)
 #define __FIRST_OBJEXT_FLAG    (1UL << 0)

 #endif /* CONFIG_MEMCG */

 enum objext_flags {
        /* slabobj_ext vector failed to allocate */
-       OBJEXTS_ALLOC_FAIL =3D __FIRST_OBJEXT_FLAG,
+       OBJEXTS_ALLOC_FAIL =3D __OBJEXTS_ALLOC_FAIL,
        /* the next bit after the last actual flag */
        __NR_OBJEXTS_FLAGS  =3D (__FIRST_OBJEXT_FLAG << 1),
 };
diff --git a/mm/slub.c b/mm/slub.c
index bd4bf2613e7a..16e53bfb310e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1950,7 +1950,7 @@ static inline void
handle_failed_objexts_alloc(unsigned long obj_exts,
         * objects with no tag reference. Mark all references in this
         * vector as empty to avoid warnings later on.
         */
-       if (obj_exts & OBJEXTS_ALLOC_FAIL) {
+       if (obj_exts =3D=3D OBJEXTS_ALLOC_FAIL) {
                unsigned int i;

                for (i =3D 0; i < objects; i++)
--
2.47.3

Subject: [PATCH 2/2] slab: Use kfree_nolock() to free obj_exts

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/memcontrol.h | 1 +
 mm/slub.c                  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index daa78665f850..2e6c33fdd9c5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -354,6 +354,7 @@ enum page_memcg_data_flags {
 enum objext_flags {
     /* slabobj_ext vector failed to allocate */
     OBJEXTS_ALLOC_FAIL =3D __OBJEXTS_ALLOC_FAIL,
+    OBJEXTS_NOSPIN_ALLOC =3D __FIRST_OBJEXT_FLAG,
     /* the next bit after the last actual flag */
     __NR_OBJEXTS_FLAGS  =3D (__FIRST_OBJEXT_FLAG << 1),
 };
diff --git a/mm/slub.c b/mm/slub.c
index 16e53bfb310e..417d647f1f02 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2009,6 +2009,8 @@ int alloc_slab_obj_exts(struct slab *slab,
struct kmem_cache *s,
     }

     new_exts =3D (unsigned long)vec;
+    if (unlikely(!allow_spin))
+        new_exts |=3D OBJEXTS_NOSPIN_ALLOC;
 #ifdef CONFIG_MEMCG
     new_exts |=3D MEMCG_DATA_OBJEXTS;
 #endif
@@ -2056,7 +2058,10 @@ static inline void free_slab_obj_exts(struct slab *s=
lab)
      * the extension for obj_exts is expected to be NULL.
      */
     mark_objexts_empty(obj_exts);
-    kfree(obj_exts);
+    if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
+        kfree_nolock(obj_exts);
+    else
+        kfree(obj_exts);
     slab->obj_exts =3D 0;
 }

--
2.47.3


> > +     } else {
> > +             vec =3D kcalloc_node(objects, sizeof(struct slabobj_ext),=
 gfp,
> > +                                slab_nid(slab));
> > +     }
> >       if (!vec) {
> >               /* Mark vectors which failed to allocate */
> >               if (new_slab)
> > +static void defer_deactivate_slab(struct slab *slab, void *flush_freel=
ist);
> > +
> >  /*
> >   * Called only for kmem_cache_debug() caches to allocate from a freshl=
y
> >   * allocated slab. Allocate a single object instead of whole freelist
> >   * and put the slab to the partial (or full) list.
> >   */
> > -static void *alloc_single_from_new_slab(struct kmem_cache *s,
> > -                                     struct slab *slab, int orig_size)
> > +static void *alloc_single_from_new_slab(struct kmem_cache *s, struct s=
lab *slab,
> > +                                     int orig_size, gfp_t gfpflags)
> >  {
> > +     bool allow_spin =3D gfpflags_allow_spinning(gfpflags);
> >       int nid =3D slab_nid(slab);
> >       struct kmem_cache_node *n =3D get_node(s, nid);
> >       unsigned long flags;
> >       void *object;
> >
> > +     if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
>
> I think alloc_debug_processing() doesn't have to be called under
> n->list_lock here because it is a new slab?
>
> That means the code can be something like:
>
> /* allocate one object from slab */
> object =3D slab->freelist;
> slab->freelist =3D get_freepointer(s, object);
> slab->inuse =3D 1;
>
> /* Leak slab if debug checks fails */
> if (!alloc_debug_processing())
>         return NULL;
>
> /* add slab to per-node partial list */
> if (allow_spin) {
>         spin_lock_irqsave();
> } else if (!spin_trylock_irqsave()) {
>         slab->frozen =3D 1;
>         defer_deactivate_slab();
> }

No. That doesn't work. I implemented it this way
before reverting back to spin_trylock_irqsave() in the beginning.
The problem is alloc_debug_processing() will likely succeed
and undoing it is pretty complex.
So it's better to "!allow_spin && !spin_trylock_irqsave()"
before doing expensive and hard to undo alloc_debug_processing().

>
> > +             /* Unlucky, discard newly allocated slab */
> > +             slab->frozen =3D 1;
> > +             defer_deactivate_slab(slab, NULL);
> > +             return NULL;
> > +     }
> >
> >       object =3D slab->freelist;
> >       slab->freelist =3D get_freepointer(s, object);
> >       slab->inuse =3D 1;
> >
> > -     if (!alloc_debug_processing(s, slab, object, orig_size))
> > +     if (!alloc_debug_processing(s, slab, object, orig_size)) {
> >               /*
> >                * It's not really expected that this would fail on a
> >                * freshly allocated slab, but a concurrent memory
> >                * corruption in theory could cause that.
> > +              * Leak memory of allocated slab.
> >                */
> > +             if (!allow_spin)
> > +                     spin_unlock_irqrestore(&n->list_lock, flags);
> >               return NULL;
> > +     }
> >
> > -     spin_lock_irqsave(&n->list_lock, flags);
> > +     if (allow_spin)
> > +             spin_lock_irqsave(&n->list_lock, flags);
> >
> >       if (slab->inuse =3D=3D slab->objects)
> >               add_full(s, n, slab);
> > @@ -3164,6 +3201,44 @@ static void deactivate_slab(struct kmem_cache *s=
, struct slab *slab,
> >       }
> >  }
> >
> > +/*
> > + * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_c=
ache_cpu::lock
> > + * can be acquired without a deadlock before invoking the function.
> > + *
> > + * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() i=
s
> > + * using local_lock_is_locked() properly before calling local_lock_cpu=
_slab(),
> > + * and kmalloc() is not used in an unsupported context.
> > + *
> > + * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock=
_irqsave().
> > + * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
> > + * lockdep_assert() will catch a bug in case:
> > + * #1
> > + * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_no=
lock()
> > + * or
> > + * #2
> > + * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf=
 -> kmalloc_nolock()
> > + *
> > + * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> > + * disabled context. The lock will always be acquired and if needed it
> > + * block and sleep until the lock is available.
> > + * #1 is possible in !PREEMP_RT only.
>
> s/PREEMP_RT/PREEMPT_RT/

ok.

> > + * #2 is possible in both with a twist that irqsave is replaced with r=
t_spinlock:
> > + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> > + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kme=
m_cache_B)
> > + *
> > + * local_lock_is_locked() prevents the case kmem_cache_A =3D=3D kmem_c=
ache_B
> > + */
> > +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> > +#define local_lock_cpu_slab(s, flags)        \
> > +     local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> > +#else
> > +#define local_lock_cpu_slab(s, flags)        \
> > +     lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags)=
)
> > +#endif
> > +
> > +#define local_unlock_cpu_slab(s, flags)      \
> > +     local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
> > +
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >  static void __put_partials(struct kmem_cache *s, struct slab *partial_=
slab)
> >  {
> > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cache *s,=
 gfp_t gfpflags, int node,
> >       if (unlikely(!node_match(slab, node))) {
> >               /*
> >                * same as above but node_match() being false already
> > -              * implies node !=3D NUMA_NO_NODE
> > +              * implies node !=3D NUMA_NO_NODE.
> > +              * Reentrant slub cannot take locks necessary to
> > +              * deactivate_slab, hence ignore node preference.
>
> Now that we have defer_deactivate_slab(), we need to either update the
> code or comment?
>
> 1. Deactivate slabs when node / pfmemalloc mismatches
> or 2. Update comments to explain why it's still undesirable

Well, defer_deactivate_slab() is a heavy hammer.
In !SLUB_TINY it pretty much never happens.

This bit:

retry_load_slab:

        local_lock_cpu_slab(s, flags);
        if (unlikely(c->slab)) {

is very rare. I couldn't trigger it at all in my stress test.

But in this hunk the node mismatch is not rare, so ignoring node preference
for kmalloc_nolock() is a much better trade off.
I'll add a comment that defer_deactivate_slab() is undesired here.

> > +              * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> >                */
> > -             if (!node_isset(node, slab_nodes)) {
> > +             if (!node_isset(node, slab_nodes) ||
> > +                 !allow_spin) {
> >                       node =3D NUMA_NO_NODE;
> >               } else {
> >                       stat(s, ALLOC_NODE_MISMATCH);
>
> > @@ -4572,6 +4769,98 @@ static void __slab_free(struct kmem_cache *s, st=
ruct slab *slab,
> >       discard_slab(s, slab);
> >  }
> >
> > +/*
> > + * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
> > + * to take sleeping spin_locks from __slab_free() and deactivate_slab(=
).
> > + * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
> > + */
> > +static void free_deferred_objects(struct irq_work *work)
> > +{
> > +     struct defer_free *df =3D container_of(work, struct defer_free, w=
ork);
> > +     struct llist_head *objs =3D &df->objects;
> > +     struct llist_head *slabs =3D &df->slabs;
> > +     struct llist_node *llnode, *pos, *t;
> > +
> > +     if (llist_empty(objs) && llist_empty(slabs))
> > +             return;
> > +
> > +     llnode =3D llist_del_all(objs);
> > +     llist_for_each_safe(pos, t, llnode) {
> > +             struct kmem_cache *s;
> > +             struct slab *slab;
> > +             void *x =3D pos;
> > +
> > +             slab =3D virt_to_slab(x);
> > +             s =3D slab->slab_cache;
> > +
> > +             /*
> > +              * We used freepointer in 'x' to link 'x' into df->object=
s.
> > +              * Clear it to NULL to avoid false positive detection
> > +              * of "Freepointer corruption".
> > +              */
> > +             *(void **)x =3D NULL;
> > +
> > +             /* Point 'x' back to the beginning of allocated object */
> > +             x -=3D s->offset;
> > +             /*
> > +              * memcg, kasan_slab_pre are already done for 'x'.
> > +              * The only thing left is kasan_poison.
> > +              */
> > +             kasan_slab_free(s, x, false, false, true);
> > +             __slab_free(s, slab, x, x, 1, _THIS_IP_);
> > +     }
> > +
> > +     llnode =3D llist_del_all(slabs);
> > +     llist_for_each_safe(pos, t, llnode) {
> > +             struct slab *slab =3D container_of(pos, struct slab, llno=
de);
> > +
> > +#ifdef CONFIG_SLUB_TINY
> > +             discard_slab(slab->slab_cache, slab);
>
> ...and with my comment on alloc_single_from_new_slab(),
> The slab may not be empty anymore?

Exactly.
That's another problem with your suggestion in alloc_single_from_new_slab()=
.
That's why I did it as:
if (!allow_spin && !spin_trylock_irqsave(...)

and I still believe it's the right call.
The slab is empty here, so discard_slab() is appropriate.

>
> > +#else
> > +             deactivate_slab(slab->slab_cache, slab, slab->flush_freel=
ist);
> > +#endif
> > +     }
> > +}
> > @@ -4610,10 +4901,30 @@ static __always_inline void do_slab_free(struct=
 kmem_cache *s,
> >       barrier();
> >
> >       if (unlikely(slab !=3D c->slab)) {
> > -             __slab_free(s, slab, head, tail, cnt, addr);
> > +             if (unlikely(!allow_spin)) {
> > +                     /*
> > +                      * __slab_free() can locklessly cmpxchg16 into a =
slab,
> > +                      * but then it might need to take spin_lock or lo=
cal_lock
> > +                      * in put_cpu_partial() for further processing.
> > +                      * Avoid the complexity and simply add to a defer=
red list.
> > +                      */
> > +                     defer_free(s, head);
> > +             } else {
> > +                     __slab_free(s, slab, head, tail, cnt, addr);
> > +             }
> >               return;
> >       }
> >
> > +     if (unlikely(!allow_spin)) {
> > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> > +                 local_lock_is_locked(&s->cpu_slab->lock)) {
> > +                     defer_free(s, head);
> > +                     return;
> > +             }
> > +             cnt =3D 1; /* restore cnt. kfree_nolock() frees one objec=
t at a time */
> > +             kasan_slab_free(s, head, false, false, /* skip quarantine=
 */true);
> > +     }
>
> I'm not sure what prevents below from happening
>
> 1. slab =3D=3D c->slab && !allow_spin -> call kasan_slab_free()
> 2. preempted by something and resume
> 3. after acquiring local_lock, slab !=3D c->slab, release local_lock, got=
o redo
> 4. !allow_spin, so defer_free() will call kasan_slab_free() again later

yes. it's possible and it's ok.
kasan_slab_free(, no_quarantine =3D=3D true)
is poison_slab_object() only and one can do it many times.

> Perhaps kasan_slab_free() should be called before do_slab_free()
> just like normal free path and do not call kasan_slab_free() in deferred
> freeing (then you may need to disable KASAN while accessing the deferred
> list)?

I tried that too and didn't like it.
After kasan_slab_free() the object cannot be put on the llist easily.
One needs to do a kasan_reset_tag() dance which uglifies the code a lot.
Double kasan poison in a rare case is fine. There is no harm.

