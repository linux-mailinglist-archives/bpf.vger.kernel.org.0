Return-Path: <bpf+bounces-1341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B874771303C
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 01:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2022818D1
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F62D24F;
	Fri, 26 May 2023 23:09:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04415B7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 23:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC46AC4339C;
	Fri, 26 May 2023 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685142555;
	bh=Hv/Mz68aappF/7aspxN/rwpWMy0Vm93OkMO579fOZDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndxp+4nD+QWTup0aJk3TopkGjfTDZkIlg1waaEnbn082ktkf/c6BYmiGAyo7ZGJj0
	 ms1w2K/K9GheVQcWzPzLUPyj7vxKl0Rcqb68dLZOIaszPvwaUhY6h5jCTaYkyKsKU0
	 C2QlYzVjI0UrJqbKIQ9j+GVbyXgyff8kDsB3zGV/xyMVXZxuDiC1LGjYCSzTf5C1a3
	 tMcaQhaUj0WuInp6H+7wbDqYuPBrbNPNYLpfNPOd2RkPQ6GPBGYFhj/vPdwxnNIbwY
	 DHKoUbDdNA92p4AiraD4mwhcVmBVBMK24YRpUgpDOaP3kZId6WbHtEDl3l04HXVHYD
	 WGx6fkF6TRivw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so1455864e87.1;
        Fri, 26 May 2023 16:09:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDw+V7gUC9mjPmGmmtue82DkDutvxjs+GrtxgG2kvOu8Y8F2iXfM
	uIJfSANowg7Ey2NsQA8sjCJt+D9McqCiGcA1kMo=
X-Google-Smtp-Source: ACHHUZ7oNBMPkHum3nV3JyiF/+M6RMF0UATUSObYIASqQnX2ekIFOdmQkvAJ5MNzStOmaT0WgwHvl4ohnlZAIfsOlig=
X-Received: by 2002:ac2:4d18:0:b0:4f1:43b9:a600 with SMTP id
 r24-20020ac24d18000000b004f143b9a600mr959572lfi.60.1685142553635; Fri, 26 May
 2023 16:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <20230526051529.3387103-2-song@kernel.org>
 <ZHEy5SkFwI+dZjOC@moria.home.lan>
In-Reply-To: <ZHEy5SkFwI+dZjOC@moria.home.lan>
From: Song Liu <song@kernel.org>
Date: Fri, 26 May 2023 16:09:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
Message-ID: <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 3:30=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 25, 2023 at 10:15:27PM -0700, Song Liu wrote:
> > Introduce memory type aware module_alloc_type, which provides a unified
> > allocator for all different archs. This work was discussed in [1].
> >
> > Each arch can configure the allocator to do the following:
> >
> >    1. Specify module_vaddr and module_end
> >    2. Random module start address for KASLR
> >    3. kasan_alloc_module_shadow()
> >    4. kasan_reset_tag()
> >    5. Preferred and secondary module address ranges
> >
> > enum mod_alloc_params_flags are used to control the behavior of
> > module_alloc_type. Specifically: MOD_ALLOC_FALLBACK let module_alloc_ty=
pe
> > fallback to existing module_alloc. MOD_ALLOC_SET_MEMORY let
> > module_alloc_type to protect the memory before returning to the user.
> >
> > module_allocator_init() call is added to start_kernel() to initialize
> > module_alloc_type.
> >
>
> ...
>
> > +/**
> > + * struct vmalloc_params - Parameters to call __vmalloc_node_range()
> > + * @start:          Address space range start
> > + * @end:            Address space range end
> > + * @gfp_mask:       The gfp_t mask used for this range
> > + * @pgprot:         The page protection for this range
> > + * @vm_flags        The vm_flag used for this range
> > + */
> > +struct vmalloc_params {
> > +     unsigned long   start;
> > +     unsigned long   end;
> > +     gfp_t           gfp_mask;
> > +     pgprot_t        pgprot;
> > +     unsigned long   vm_flags;
> > +};
> > +
> > +/**
> > + * struct mod_alloc_params - Parameters for module allocation type
> > + * @flags:          Properties in mod_alloc_params_flags
> > + * @granularity:    The allocation granularity (PAGE/PMD) in bytes
> > + * @alignment:      The allocation alignment requirement
> > + * @vmp:            Parameters used to call vmalloc
> > + * @fill:           Function to fill allocated space. If NULL, use mem=
cpy()
> > + * @invalidate:     Function to invalidate memory space.
> > + *
> > + * If @granularity > @alignment the allocation can reuse free space in
> > + * previously allocated pages. If they are the same, then fresh pages
> > + * have to be allocated.
> > + */
> > +struct mod_alloc_params {
> > +     unsigned int            flags;
> > +     unsigned int            granularity;
> > +     unsigned int            alignment;
> > +     struct vmalloc_params   vmp[MOD_MAX_ADDR_SPACES];
> > +     void *                  (*fill)(void *dst, const void *src, size_=
t len);
> > +     void *                  (*invalidate)(void *ptr, size_t len);
> > +};
> > +
> > +struct mod_type_allocator {
> > +     struct mod_alloc_params params;
> > +};
> > +
> > +struct mod_allocators {
> > +     struct mod_type_allocator *types[MOD_MEM_NUM_TYPES];
> > +};
> > +
> > +void *module_alloc_type(size_t size, enum mod_mem_type type);
> > +void module_memfree_type(void *ptr, enum mod_mem_type type);
> > +void module_memory_fill_type(void *dst, void *src, size_t len, enum mo=
d_mem_type type);
> > +void module_memory_invalidate_type(void *ptr, size_t len, enum mod_mem=
_type type);
> > +void module_memory_protect(void *ptr, size_t len, enum mod_mem_type ty=
pe);
> > +void module_memory_unprotect(void *ptr, size_t len, enum mod_mem_type =
type);
> > +void module_memory_force_protect(void *ptr, size_t len, enum mod_mem_t=
ype type);
> > +void module_memory_force_unprotect(void *ptr, size_t len, enum mod_mem=
_type type);
> > +void module_alloc_type_init(struct mod_allocators *allocators);
>
> This is a pretty big and complicated interface, and I haven't been able
> to find any reasoning or justification for why it's needed.
>
> Why is this going in module.h? Don't do that, this is supposed to be a
> general purpose allocator for executable memory so start a new file.

The goal of this work is to build a memory allocator for modules, text,
rw data, and ro data. So it is not the same as execmem_alloc or jitalloc.

>
> What is vmalloc_params doing here? Why is it needed? Can we just get rid
> of it?

We need it to have an interface for all archs. They are all using different
variations of vmalloc for module_alloc.

>
> module_memory_protect() and module_memory_unprotect() looks like a
> completely broken interface for supporting sub-page allocations -
> different threads with different allocations on the same page will race.

These two APIs allow the core code work with all archs. They won't break
sub-page allocations. (not all archs will have sub-page allocations)

OTOH, the "force" version of the two APIs should be removed later. In this
set, we only need them for arch_prepare_bpf_trampoline(). I plan to remove
this limitation for x86 soon.

>
> The text_poke() abstraction works; the exposed interface should look
> like that.
>
> Please kill MOD_ALLOC_SET_MEMORY, and _only_ return memory that is
> read-only. You should be able to kill mod_alloc_params entirely.
>
> Our other memory allocators don't expose kasan - why does this one?
> Again, that looks wrong.
>
> I would like to see something much simpler (that doesn't encode awkward
> assumptions from module and bpf!): please look at the code I sketched
> out below and tell me why this interface won't work - or if it can, go
> with _that_.

I think we need to align the goal here. PS: we did align the goal about
6 months ago when I proposed the execmem_alloc() set.

My current goal is to build an allocator for all the use cases of modules,
text, data, rodata, etc. Then the same allocator can be used by other
dynamic kernel text: bpf, ftrace, kprobe, bcachefs, etc.

OTOH, jit_alloc (as-is) solves a subset of the problem (only the text).
We can probably use it (with some updates) instead of the vmap_area
based allocator. But I guess we need to align the direction first.

Thanks,
Song

>
> commit 80ceffd6b1108afc7593bdf060954c73eaf0ffc4
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Wed May 17 01:22:06 2023 -0400
>
>     mm: jit/text allocator
>
>     This provides a new, very simple slab allocator for jit/text, i.e. bp=
f,
>     ftrace trampolines, or bcachefs unpack functions.
>
>     With this API we can avoid ever mapping pages both writeable and
>     executable (not implemented in this patch: need to tweak
>     module_alloc()), and it also supports sub-page sized allocations.
>
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> diff --git a/include/linux/jitalloc.h b/include/linux/jitalloc.h
> new file mode 100644
> index 0000000000..f1549d60e8
> --- /dev/null
> +++ b/include/linux/jitalloc.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_JITALLOC_H
> +#define _LINUX_JITALLOC_H
> +
> +void jit_update(void *buf, void *new_buf, size_t len);
> +void jit_free(void *buf);
> +void *jit_alloc(void *buf, size_t len);
> +
> +#endif /* _LINUX_JITALLOC_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f..ff26a4f0c9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1202,6 +1202,9 @@ config LRU_GEN_STATS
>           This option has a per-memcg and per-node memory overhead.
>  # }
>
> +config JITALLOC
> +       bool
> +
>  source "mm/damon/Kconfig"
>
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index c03e1e5859..25e82db9e8 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) +=3D io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) +=3D ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) +=3D shrinker_debug.o
> +obj-$(CONFIG_JITALLOC) +=3D jitalloc.o
> diff --git a/mm/jitalloc.c b/mm/jitalloc.c
> new file mode 100644
> index 0000000000..7c4d621802
> --- /dev/null
> +++ b/mm/jitalloc.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/gfp.h>
> +#include <linux/highmem.h>
> +#include <linux/jitalloc.h>
> +#include <linux/mm.h>
> +#include <linux/moduleloader.h>
> +#include <linux/mutex.h>
> +#include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/text-patching.h>
> +
> +static DEFINE_MUTEX(jit_alloc_lock);
> +
> +struct jit_cache {
> +       unsigned                obj_size_bits;
> +       unsigned                objs_per_slab;
> +       struct list_head        partial;
> +};
> +
> +#define JITALLOC_MIN_SIZE      16
> +#define NR_JIT_CACHES          ilog2(PAGE_SIZE / JITALLOC_MIN_SIZE)
> +
> +static struct jit_cache jit_caches[NR_JIT_CACHES];
> +
> +struct jit_slab {
> +       unsigned long           __page_flags;
> +
> +       struct jit_cache        *cache;
> +       void                    *executably_mapped;;
> +       unsigned long           *objs_allocated; /* bitmap of free object=
s */
> +       struct list_head        list;
> +};
> +
> +#define folio_jit_slab(folio)          (_Generic((folio),               =
       \
> +       const struct folio *:           (const struct jit_slab *)(folio),=
       \
> +       struct folio *:                 (struct jit_slab *)(folio)))
> +
> +#define jit_slab_folio(s)              (_Generic((s),                   =
       \
> +       const struct jit_slab *:        (const struct folio *)s,         =
       \
> +       struct jit_slab *:              (struct folio *)s))
> +
> +static struct jit_slab *jit_slab_alloc(struct jit_cache *cache)
> +{
> +       void *executably_mapped =3D module_alloc(PAGE_SIZE);
> +       struct page *page;
> +       struct folio *folio;
> +       struct jit_slab *slab;
> +       unsigned long *objs_allocated;
> +
> +       if (!executably_mapped)
> +               return NULL;
> +
> +       objs_allocated =3D kcalloc(BITS_TO_LONGS(cache->objs_per_slab), s=
izeof(unsigned long), GFP_KERNEL);
> +       if (!objs_allocated ) {
> +               vfree(executably_mapped);
> +               return NULL;
> +       }
> +
> +       set_vm_flush_reset_perms(executably_mapped);
> +       set_memory_rox((unsigned long) executably_mapped, 1);
> +
> +       page =3D vmalloc_to_page(executably_mapped);
> +       folio =3D page_folio(page);
> +
> +       __folio_set_slab(folio);
> +       slab                    =3D folio_jit_slab(folio);
> +       slab->cache             =3D cache;
> +       slab->executably_mapped =3D executably_mapped;
> +       slab->objs_allocated =3D objs_allocated;
> +       INIT_LIST_HEAD(&slab->list);
> +
> +       return slab;
> +}
> +
> +static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *ca=
che)
> +{
> +       struct jit_slab *s =3D
> +               list_first_entry_or_null(&cache->partial, struct jit_slab=
, list) ?:
> +               jit_slab_alloc(cache);
> +       unsigned obj_idx, nr_allocated;
> +
> +       if (!s)
> +               return NULL;
> +
> +       obj_idx =3D find_first_zero_bit(s->objs_allocated, cache->objs_pe=
r_slab);
> +
> +       BUG_ON(obj_idx >=3D cache->objs_per_slab);
> +       __set_bit(obj_idx, s->objs_allocated);
> +
> +       nr_allocated =3D bitmap_weight(s->objs_allocated, s->cache->objs_=
per_slab);
> +
> +       if (nr_allocated =3D=3D s->cache->objs_per_slab) {
> +               list_del_init(&s->list);
> +       } else if (nr_allocated =3D=3D 1) {
> +               list_del(&s->list);
> +               list_add(&s->list, &s->cache->partial);
> +       }
> +
> +       return s->executably_mapped + (obj_idx << cache->obj_size_bits);
> +}
> +
> +void jit_update(void *buf, void *new_buf, size_t len)
> +{
> +       text_poke_copy(buf, new_buf, len);
> +}
> +EXPORT_SYMBOL_GPL(jit_update);
> +
> +void jit_free(void *buf)
> +{
> +       struct page *page;
> +       struct folio *folio;
> +       struct jit_slab *s;
> +       unsigned obj_idx, nr_allocated;
> +       size_t offset;
> +
> +       if (!buf)
> +               return;
> +
> +       page    =3D vmalloc_to_page(buf);
> +       folio   =3D page_folio(page);
> +       offset  =3D offset_in_folio(folio, buf);
> +
> +       if (!folio_test_slab(folio)) {
> +               vfree(buf);
> +               return;
> +       }
> +
> +       s =3D folio_jit_slab(folio);
> +
> +       mutex_lock(&jit_alloc_lock);
> +       obj_idx =3D offset >> s->cache->obj_size_bits;
> +
> +       __clear_bit(obj_idx, s->objs_allocated);
> +
> +       nr_allocated =3D bitmap_weight(s->objs_allocated, s->cache->objs_=
per_slab);
> +
> +       if (nr_allocated =3D=3D 0) {
> +               list_del(&s->list);
> +               kfree(s->objs_allocated);
> +               folio_put(folio);
> +       } else if (nr_allocated + 1 =3D=3D s->cache->objs_per_slab) {
> +               list_del(&s->list);
> +               list_add(&s->list, &s->cache->partial);
> +       }
> +
> +       mutex_unlock(&jit_alloc_lock);
> +}
> +EXPORT_SYMBOL_GPL(jit_free);
> +
> +void *jit_alloc(void *buf, size_t len)
> +{
> +       unsigned jit_cache_idx =3D ilog2(roundup_pow_of_two(len) / 16);
> +       void *p;
> +
> +       if (jit_cache_idx < NR_JIT_CACHES) {
> +               mutex_lock(&jit_alloc_lock);
> +               p =3D jit_cache_alloc(buf, len, &jit_caches[jit_cache_idx=
]);
> +               mutex_unlock(&jit_alloc_lock);
> +       } else {
> +               p =3D module_alloc(len);
> +               if (p) {
> +                       set_vm_flush_reset_perms(p);
> +                       set_memory_rox((unsigned long) p, DIV_ROUND_UP(le=
n, PAGE_SIZE));
> +               }
> +       }
> +
> +       if (p && buf)
> +               jit_update(p, buf, len);
> +
> +       return p;
> +}
> +EXPORT_SYMBOL_GPL(jit_alloc);
> +
> +static int __init jit_alloc_init(void)
> +{
> +       for (unsigned i =3D 0; i < ARRAY_SIZE(jit_caches); i++) {
> +               jit_caches[i].obj_size_bits     =3D ilog2(JITALLOC_MIN_SI=
ZE) + i;
> +               jit_caches[i].objs_per_slab     =3D PAGE_SIZE >> jit_cach=
es[i].obj_size_bits;
> +
> +               INIT_LIST_HEAD(&jit_caches[i].partial);
> +       }
> +
> +       return 0;
> +}
> +core_initcall(jit_alloc_init);

