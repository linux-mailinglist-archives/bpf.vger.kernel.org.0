Return-Path: <bpf+bounces-1339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50723713017
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 00:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125B52819A4
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E852A9C1;
	Fri, 26 May 2023 22:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FD15B7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 22:39:23 +0000 (UTC)
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 15:39:21 PDT
Received: from out-19.mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D0A4
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 15:39:20 -0700 (PDT)
Date: Fri, 26 May 2023 18:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685140201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLkyA3MihFlBm285V4Sv+RVJrrbLMzI6prX1lylHDK4=;
	b=LEua3M1EuMJv1BLZLMgLFIpDNQsc4m7YiyetfV9XIOnKzMfz2ETDdgkVlKq9UP8EkY8ty7
	p7JZzl5KZIGFadior8MxOTP0dDD8qtzK4gd1oEpG/tUt3a2o7Mhj6/ugmNMCqQnLGtGsQZ
	yCW5ekz+yZrH5S8DbntrAL66dMM4wyk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
Message-ID: <ZHEy5SkFwI+dZjOC@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
 <20230526051529.3387103-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526051529.3387103-2-song@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 10:15:27PM -0700, Song Liu wrote:
> Introduce memory type aware module_alloc_type, which provides a unified
> allocator for all different archs. This work was discussed in [1].
> 
> Each arch can configure the allocator to do the following:
> 
>    1. Specify module_vaddr and module_end
>    2. Random module start address for KASLR
>    3. kasan_alloc_module_shadow()
>    4. kasan_reset_tag()
>    5. Preferred and secondary module address ranges
> 
> enum mod_alloc_params_flags are used to control the behavior of
> module_alloc_type. Specifically: MOD_ALLOC_FALLBACK let module_alloc_type
> fallback to existing module_alloc. MOD_ALLOC_SET_MEMORY let
> module_alloc_type to protect the memory before returning to the user.
> 
> module_allocator_init() call is added to start_kernel() to initialize
> module_alloc_type.
> 

...

> +/**
> + * struct vmalloc_params - Parameters to call __vmalloc_node_range()
> + * @start:          Address space range start
> + * @end:            Address space range end
> + * @gfp_mask:       The gfp_t mask used for this range
> + * @pgprot:         The page protection for this range
> + * @vm_flags        The vm_flag used for this range
> + */
> +struct vmalloc_params {
> +	unsigned long	start;
> +	unsigned long	end;
> +	gfp_t		gfp_mask;
> +	pgprot_t	pgprot;
> +	unsigned long	vm_flags;
> +};
> +
> +/**
> + * struct mod_alloc_params - Parameters for module allocation type
> + * @flags:          Properties in mod_alloc_params_flags
> + * @granularity:    The allocation granularity (PAGE/PMD) in bytes
> + * @alignment:      The allocation alignment requirement
> + * @vmp:            Parameters used to call vmalloc
> + * @fill:           Function to fill allocated space. If NULL, use memcpy()
> + * @invalidate:     Function to invalidate memory space.
> + *
> + * If @granularity > @alignment the allocation can reuse free space in
> + * previously allocated pages. If they are the same, then fresh pages
> + * have to be allocated.
> + */
> +struct mod_alloc_params {
> +	unsigned int		flags;
> +	unsigned int		granularity;
> +	unsigned int		alignment;
> +	struct vmalloc_params	vmp[MOD_MAX_ADDR_SPACES];
> +	void *			(*fill)(void *dst, const void *src, size_t len);
> +	void *			(*invalidate)(void *ptr, size_t len);
> +};
> +
> +struct mod_type_allocator {
> +	struct mod_alloc_params	params;
> +};
> +
> +struct mod_allocators {
> +	struct mod_type_allocator *types[MOD_MEM_NUM_TYPES];
> +};
> +
> +void *module_alloc_type(size_t size, enum mod_mem_type type);
> +void module_memfree_type(void *ptr, enum mod_mem_type type);
> +void module_memory_fill_type(void *dst, void *src, size_t len, enum mod_mem_type type);
> +void module_memory_invalidate_type(void *ptr, size_t len, enum mod_mem_type type);
> +void module_memory_protect(void *ptr, size_t len, enum mod_mem_type type);
> +void module_memory_unprotect(void *ptr, size_t len, enum mod_mem_type type);
> +void module_memory_force_protect(void *ptr, size_t len, enum mod_mem_type type);
> +void module_memory_force_unprotect(void *ptr, size_t len, enum mod_mem_type type);
> +void module_alloc_type_init(struct mod_allocators *allocators);

This is a pretty big and complicated interface, and I haven't been able
to find any reasoning or justification for why it's needed.

Why is this going in module.h? Don't do that, this is supposed to be a
general purpose allocator for executable memory so start a new file.

What is vmalloc_params doing here? Why is it needed? Can we just get rid
of it?

module_memory_protect() and module_memory_unprotect() looks like a
completely broken interface for supporting sub-page allocations -
different threads with different allocations on the same page will race.

The text_poke() abstraction works; the exposed interface should look
like that.

Please kill MOD_ALLOC_SET_MEMORY, and _only_ return memory that is
read-only. You should be able to kill mod_alloc_params entirely.

Our other memory allocators don't expose kasan - why does this one?
Again, that looks wrong.

I would like to see something much simpler (that doesn't encode awkward
assumptions from module and bpf!): please look at the code I sketched
out below and tell me why this interface won't work - or if it can, go
with _that_.

commit 80ceffd6b1108afc7593bdf060954c73eaf0ffc4
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed May 17 01:22:06 2023 -0400

    mm: jit/text allocator
    
    This provides a new, very simple slab allocator for jit/text, i.e. bpf,
    ftrace trampolines, or bcachefs unpack functions.
    
    With this API we can avoid ever mapping pages both writeable and
    executable (not implemented in this patch: need to tweak
    module_alloc()), and it also supports sub-page sized allocations.
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/include/linux/jitalloc.h b/include/linux/jitalloc.h
new file mode 100644
index 0000000000..f1549d60e8
--- /dev/null
+++ b/include/linux/jitalloc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_JITALLOC_H
+#define _LINUX_JITALLOC_H
+
+void jit_update(void *buf, void *new_buf, size_t len);
+void jit_free(void *buf);
+void *jit_alloc(void *buf, size_t len);
+
+#endif /* _LINUX_JITALLOC_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f..ff26a4f0c9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,9 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config JITALLOC
+	bool
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index c03e1e5859..25e82db9e8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_JITALLOC) += jitalloc.o
diff --git a/mm/jitalloc.c b/mm/jitalloc.c
new file mode 100644
index 0000000000..7c4d621802
--- /dev/null
+++ b/mm/jitalloc.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/jitalloc.h>
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/mutex.h>
+#include <linux/set_memory.h>
+#include <linux/vmalloc.h>
+
+#include <asm/text-patching.h>
+
+static DEFINE_MUTEX(jit_alloc_lock);
+
+struct jit_cache {
+	unsigned		obj_size_bits;
+	unsigned		objs_per_slab;
+	struct list_head	partial;
+};
+
+#define JITALLOC_MIN_SIZE	16
+#define NR_JIT_CACHES		ilog2(PAGE_SIZE / JITALLOC_MIN_SIZE)
+
+static struct jit_cache jit_caches[NR_JIT_CACHES];
+
+struct jit_slab {
+	unsigned long		__page_flags;
+
+	struct jit_cache	*cache;
+	void			*executably_mapped;;
+	unsigned long		*objs_allocated; /* bitmap of free objects */
+	struct list_head	list;
+};
+
+#define folio_jit_slab(folio)		(_Generic((folio),			\
+	const struct folio *:		(const struct jit_slab *)(folio),	\
+	struct folio *:			(struct jit_slab *)(folio)))
+
+#define jit_slab_folio(s)		(_Generic((s),				\
+	const struct jit_slab *:	(const struct folio *)s,		\
+	struct jit_slab *:		(struct folio *)s))
+
+static struct jit_slab *jit_slab_alloc(struct jit_cache *cache)
+{
+	void *executably_mapped = module_alloc(PAGE_SIZE);
+	struct page *page;
+	struct folio *folio;
+	struct jit_slab *slab;
+	unsigned long *objs_allocated;
+
+	if (!executably_mapped)
+		return NULL;
+
+	objs_allocated = kcalloc(BITS_TO_LONGS(cache->objs_per_slab), sizeof(unsigned long), GFP_KERNEL);
+	if (!objs_allocated ) {
+		vfree(executably_mapped);
+		return NULL;
+	}
+
+	set_vm_flush_reset_perms(executably_mapped);
+	set_memory_rox((unsigned long) executably_mapped, 1);
+
+	page = vmalloc_to_page(executably_mapped);
+	folio = page_folio(page);
+
+	__folio_set_slab(folio);
+	slab			= folio_jit_slab(folio);
+	slab->cache		= cache;
+	slab->executably_mapped	= executably_mapped;
+	slab->objs_allocated = objs_allocated;
+	INIT_LIST_HEAD(&slab->list);
+
+	return slab;
+}
+
+static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *cache)
+{
+	struct jit_slab *s =
+		list_first_entry_or_null(&cache->partial, struct jit_slab, list) ?:
+		jit_slab_alloc(cache);
+	unsigned obj_idx, nr_allocated;
+
+	if (!s)
+		return NULL;
+
+	obj_idx = find_first_zero_bit(s->objs_allocated, cache->objs_per_slab);
+
+	BUG_ON(obj_idx >= cache->objs_per_slab);
+	__set_bit(obj_idx, s->objs_allocated);
+
+	nr_allocated = bitmap_weight(s->objs_allocated, s->cache->objs_per_slab);
+
+	if (nr_allocated == s->cache->objs_per_slab) {
+		list_del_init(&s->list);
+	} else if (nr_allocated == 1) {
+		list_del(&s->list);
+		list_add(&s->list, &s->cache->partial);
+	}
+
+	return s->executably_mapped + (obj_idx << cache->obj_size_bits);
+}
+
+void jit_update(void *buf, void *new_buf, size_t len)
+{
+	text_poke_copy(buf, new_buf, len);
+}
+EXPORT_SYMBOL_GPL(jit_update);
+
+void jit_free(void *buf)
+{
+	struct page *page;
+	struct folio *folio;
+	struct jit_slab *s;
+	unsigned obj_idx, nr_allocated;
+	size_t offset;
+
+	if (!buf)
+		return;
+
+	page	= vmalloc_to_page(buf);
+	folio	= page_folio(page);
+	offset	= offset_in_folio(folio, buf);
+
+	if (!folio_test_slab(folio)) {
+		vfree(buf);
+		return;
+	}
+
+	s = folio_jit_slab(folio);
+
+	mutex_lock(&jit_alloc_lock);
+	obj_idx = offset >> s->cache->obj_size_bits;
+
+	__clear_bit(obj_idx, s->objs_allocated);
+
+	nr_allocated = bitmap_weight(s->objs_allocated, s->cache->objs_per_slab);
+
+	if (nr_allocated == 0) {
+		list_del(&s->list);
+		kfree(s->objs_allocated);
+		folio_put(folio);
+	} else if (nr_allocated + 1 == s->cache->objs_per_slab) {
+		list_del(&s->list);
+		list_add(&s->list, &s->cache->partial);
+	}
+
+	mutex_unlock(&jit_alloc_lock);
+}
+EXPORT_SYMBOL_GPL(jit_free);
+
+void *jit_alloc(void *buf, size_t len)
+{
+	unsigned jit_cache_idx = ilog2(roundup_pow_of_two(len) / 16);
+	void *p;
+
+	if (jit_cache_idx < NR_JIT_CACHES) {
+		mutex_lock(&jit_alloc_lock);
+		p = jit_cache_alloc(buf, len, &jit_caches[jit_cache_idx]);
+		mutex_unlock(&jit_alloc_lock);
+	} else {
+		p = module_alloc(len);
+		if (p) {
+			set_vm_flush_reset_perms(p);
+			set_memory_rox((unsigned long) p, DIV_ROUND_UP(len, PAGE_SIZE));
+		}
+	}
+
+	if (p && buf)
+		jit_update(p, buf, len);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(jit_alloc);
+
+static int __init jit_alloc_init(void)
+{
+	for (unsigned i = 0; i < ARRAY_SIZE(jit_caches); i++) {
+		jit_caches[i].obj_size_bits	= ilog2(JITALLOC_MIN_SIZE) + i;
+		jit_caches[i].objs_per_slab	= PAGE_SIZE >> jit_caches[i].obj_size_bits;
+
+		INIT_LIST_HEAD(&jit_caches[i].partial);
+	}
+
+	return 0;
+}
+core_initcall(jit_alloc_init);

