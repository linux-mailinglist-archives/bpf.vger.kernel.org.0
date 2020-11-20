Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475D02BB6DF
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgKTUaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:10342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbgKTUaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:04 -0500
IronPort-SDR: W4MOjHU9HYtjsN/9DhJKYpLZ2EM8XHpoYfBpi4H6SdFVzHydcYc6tklvzTFHohZvOm4JpzrPYj
 VJ+XshVrAJAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683282"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:02 -0800
IronPort-SDR: 4EVD3vMNLGoH0Np7LYUKnNgabAJgZMMnIs6Lx+X10YEqMDM3aj3KjYo3lzjY+vGS6GOFlrwCog
 3yuhQaxTifTA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163287"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:01 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 03/10] module: Use perm_alloc() for modules
Date:   Fri, 20 Nov 2020 12:24:19 -0800
Message-Id: <20201120202426.18009-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Today modules uses single allocation for each of the core and init
allocation lifetimes. Subsections of these allocations are broken into
different permission types. In order to allow arch breakouts to allocate
permissions more efficiently, change the module loader to operate on
these as separate allocations. Track these broken out subsection
allocations in struct module_layout.

Drop the unneeded frob_() functions previously used for each permission
transition. Since transitioning ro_after_init still requires a flush,
instead provide module_map() to handle the initial mapping and
ro_after_init transition.

Similar to how a flag was stuffed into the upper bits of sh_entsize in
order to communicate which (core or init) allocation a section should
be placed, create 4 new flags to communicate which permission allocation
a subsection should be in.

To prevent disturbing any architectures that may have relocation
limitiations that require subsections to be close together, layout these
perm_allocation's out of a single module_alloc() allocation by default.
This way architectures can work as they did before, but they can have the
opportunity to do things more efficiently if supported.

So this should not have any functional change yet. It is just a change
to how the different regions of the module allocations are tracked in
module.c such that future patches can actually make the regions separate
allocations.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/module.h |  44 ++--
 kernel/module.c        | 547 +++++++++++++++++++++++++----------------
 2 files changed, 362 insertions(+), 229 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 6264617bab4d..9964f909d879 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -26,6 +26,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
+#include <linux/vmalloc.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -318,23 +319,32 @@ struct mod_tree_node {
 	struct latch_tree_node node;
 };
 
-struct module_layout {
-	/* The actual code + data. */
-	void *base;
-	/* Total size. */
+struct mod_alloc {
+	struct perm_allocation *alloc;
 	unsigned int size;
-	/* The size of the executable code.  */
-	unsigned int text_size;
-	/* Size of RO section of the module (text+rodata) */
-	unsigned int ro_size;
-	/* Size of RO after init section */
-	unsigned int ro_after_init_size;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 	struct mod_tree_node mtn;
 #endif
 };
 
+struct module_layout {
+	/*
+	 * The start of the allocations for arch's that have
+	 * them as contiguous regions.
+	 */
+	void *base;
+
+	/* The actual code + data. */
+	struct mod_alloc text;
+	struct mod_alloc ro;
+	struct mod_alloc ro_after_init;
+	struct mod_alloc rw;
+
+	/* Total size. */
+	unsigned int size;
+};
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
 #define __module_layout_align ____cacheline_aligned
@@ -562,19 +572,25 @@ bool is_module_address(unsigned long addr);
 bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
+struct perm_allocation *module_get_allocation(struct module *mod, unsigned long addr);
+bool module_perm_alloc(struct module_layout *layout);
+void module_perm_free(struct module_layout *layout);
 
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
-	return (unsigned long)mod->core_layout.base <= addr &&
-	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
+	return within_perm_alloc(mod->core_layout.text.alloc, addr) ||
+		within_perm_alloc(mod->core_layout.ro.alloc, addr) ||
+		within_perm_alloc(mod->core_layout.ro_after_init.alloc, addr) ||
+		within_perm_alloc(mod->core_layout.rw.alloc, addr);
 }
 
 static inline bool within_module_init(unsigned long addr,
 				      const struct module *mod)
 {
-	return (unsigned long)mod->init_layout.base <= addr &&
-	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
+	return within_perm_alloc(mod->init_layout.text.alloc, addr) ||
+		within_perm_alloc(mod->init_layout.ro.alloc, addr) ||
+		within_perm_alloc(mod->init_layout.rw.alloc, addr);
 }
 
 static inline bool within_module(unsigned long addr, const struct module *mod)
diff --git a/kernel/module.c b/kernel/module.c
index a4fa44a652a7..0b31c44798e2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -80,6 +80,12 @@
 
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
+#define TEXT_OFFSET_MASK (1UL << (BITS_PER_LONG-2))
+#define RO_OFFSET_MASK (1UL << (BITS_PER_LONG-3))
+#define RO_AFTER_INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-4))
+#define RW_OFFSET_MASK (1UL << (BITS_PER_LONG-5))
+#define ALL_OFFSET_MASK (INIT_OFFSET_MASK | TEXT_OFFSET_MASK | RO_OFFSET_MASK | \
+			 RO_AFTER_INIT_OFFSET_MASK | RW_OFFSET_MASK)
 
 /*
  * Mutex protects:
@@ -109,16 +115,16 @@ static LLIST_HEAD(init_free_list);
 
 static __always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
 {
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+	struct mod_alloc *modalloc = container_of(n, struct mod_alloc, mtn.node);
 
-	return (unsigned long)layout->base;
+	return perm_alloc_address(modalloc->alloc);
 }
 
 static __always_inline unsigned long __mod_tree_size(struct latch_tree_node *n)
 {
-	struct module_layout *layout = container_of(n, struct module_layout, mtn.node);
+	struct mod_alloc *modalloc = container_of(n, struct mod_alloc, mtn.node);
 
-	return (unsigned long)layout->size;
+	return (unsigned long)modalloc->size;
 }
 
 static __always_inline bool
@@ -170,29 +176,51 @@ static void __mod_tree_remove(struct mod_tree_node *node)
 	latch_tree_erase(&node->node, &mod_tree.root, &mod_tree_ops);
 }
 
+static void __mod_tree_insert_layout(struct module_layout *layout, struct module *mod)
+{
+	layout->text.mtn.mod = mod;
+	layout->ro.mtn.mod = mod;
+	layout->ro_after_init.mtn.mod = mod;
+	layout->rw.mtn.mod = mod;
+
+	if (layout->text.alloc)
+		__mod_tree_insert(&layout->text.mtn);
+	if (layout->ro.alloc)
+		__mod_tree_insert(&layout->ro.mtn);
+	if (layout->ro_after_init.alloc)
+		__mod_tree_insert(&layout->ro_after_init.mtn);
+	if (layout->rw.alloc)
+		__mod_tree_insert(&layout->rw.mtn);
+}
+
+static void __mod_tree_remove_layout(struct module_layout *layout)
+{
+	__mod_tree_remove(&layout->text.mtn);
+	__mod_tree_remove(&layout->ro.mtn);
+	__mod_tree_remove(&layout->ro_after_init.mtn);
+	__mod_tree_remove(&layout->rw.mtn);
+}
+
 /*
  * These modifications: insert, remove_init and remove; are serialized by the
  * module_mutex.
  */
 static void mod_tree_insert(struct module *mod)
 {
-	mod->core_layout.mtn.mod = mod;
-	mod->init_layout.mtn.mod = mod;
-
-	__mod_tree_insert(&mod->core_layout.mtn);
+	__mod_tree_insert_layout(&mod->core_layout, mod);
 	if (mod->init_layout.size)
-		__mod_tree_insert(&mod->init_layout.mtn);
+		__mod_tree_insert_layout(&mod->init_layout, mod);
 }
 
 static void mod_tree_remove_init(struct module *mod)
 {
 	if (mod->init_layout.size)
-		__mod_tree_remove(&mod->init_layout.mtn);
+		__mod_tree_remove_layout(&mod->init_layout);
 }
 
 static void mod_tree_remove(struct module *mod)
 {
-	__mod_tree_remove(&mod->core_layout.mtn);
+	__mod_tree_remove_layout(&mod->core_layout);
 	mod_tree_remove_init(mod);
 }
 
@@ -234,10 +262,16 @@ static struct module *mod_find(unsigned long addr)
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
  */
-static void __mod_update_bounds(void *base, unsigned int size)
+static void __mod_update_bounds(struct mod_alloc *modalloc)
 {
-	unsigned long min = (unsigned long)base;
-	unsigned long max = min + size;
+	unsigned long min;
+	unsigned long max;
+
+	if (!modalloc->alloc)
+		return;
+
+	min = (unsigned long)perm_alloc_address(modalloc->alloc);
+	max = min + perm_alloc_size(modalloc->alloc);
 
 	if (min < module_addr_min)
 		module_addr_min = min;
@@ -247,9 +281,14 @@ static void __mod_update_bounds(void *base, unsigned int size)
 
 static void mod_update_bounds(struct module *mod)
 {
-	__mod_update_bounds(mod->core_layout.base, mod->core_layout.size);
-	if (mod->init_layout.size)
-		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
+	__mod_update_bounds(&mod->core_layout.text);
+	__mod_update_bounds(&mod->core_layout.ro);
+	__mod_update_bounds(&mod->core_layout.ro_after_init);
+	__mod_update_bounds(&mod->core_layout.rw);
+	__mod_update_bounds(&mod->init_layout.text);
+	__mod_update_bounds(&mod->init_layout.ro);
+	__mod_update_bounds(&mod->init_layout.ro_after_init);
+	__mod_update_bounds(&mod->init_layout.rw);
 }
 
 #ifdef CONFIG_KGDB_KDB
@@ -1995,100 +2034,48 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
 }
 
-/*
- * LKM RO/NX protection: protect module's text/ro-data
- * from modification and any data from execution.
- *
- * General layout of module is:
- *          [text] [read-only-data] [ro-after-init] [writable data]
- * text_size -----^                ^               ^               ^
- * ro_size ------------------------|               |               |
- * ro_after_init_size -----------------------------|               |
- * size -----------------------------------------------------------|
- *
- * These values are always page-aligned (as is base)
- */
-
-/*
- * Since some arches are moving towards PAGE_KERNEL module allocations instead
- * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
- * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
- * whether we are strict.
- */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-static void frob_text(const struct module_layout *layout,
-		      int (*set_memory)(unsigned long start, int num_pages))
+#ifdef CONFIG_STRICT_MODULE_RWX
+static void map_core_regions(const struct module *mod,
+			     virtual_perm text_perm,
+			     virtual_perm ro_perm,
+			     virtual_perm ro_after_init_perm,
+			     virtual_perm rw_perm)
 {
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base,
-		   layout->text_size >> PAGE_SHIFT);
-}
+	const struct module_layout *layout = &mod->core_layout;
 
-static void module_enable_x(const struct module *mod)
-{
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
+	perm_change(layout->text.alloc, text_perm);
+	perm_change(layout->ro.alloc, ro_perm);
+	perm_change(layout->ro_after_init.alloc, ro_after_init_perm);
+	perm_change(layout->rw.alloc, rw_perm);
 }
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
-#ifdef CONFIG_STRICT_MODULE_RWX
-static void frob_rodata(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->text_size,
-		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
-}
 
-static void frob_ro_after_init(const struct module_layout *layout,
-				int (*set_memory)(unsigned long start, int num_pages))
+static void map_init_regions(const struct module *mod,
+			     virtual_perm text_perm, virtual_perm ro_perm)
 {
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->ro_size,
-		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
-}
+	const struct module_layout *layout = &mod->init_layout;
 
-static void frob_writable_data(const struct module_layout *layout,
-			       int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->ro_after_init_size,
-		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
+	perm_change(layout->text.alloc, text_perm);
+	perm_change(layout->ro.alloc, ro_perm);
 }
 
-static void module_enable_ro(const struct module *mod, bool after_init)
+static void module_map(const struct module *mod, bool after_init)
 {
-	if (!rodata_enabled)
-		return;
+	virtual_perm after_init_perm = PERM_R;
 
-	set_vm_flush_reset_perms(mod->core_layout.base);
-	set_vm_flush_reset_perms(mod->init_layout.base);
-	frob_text(&mod->core_layout, set_memory_ro);
+	perm_writable_finish(mod->core_layout.text.alloc);
+	perm_writable_finish(mod->core_layout.ro.alloc);
+	perm_writable_finish(mod->init_layout.text.alloc);
+	perm_writable_finish(mod->init_layout.ro.alloc);
 
-	frob_rodata(&mod->core_layout, set_memory_ro);
-	frob_text(&mod->init_layout, set_memory_ro);
-	frob_rodata(&mod->init_layout, set_memory_ro);
+	if (!rodata_enabled)
+		return;
 
-	if (after_init)
-		frob_ro_after_init(&mod->core_layout, set_memory_ro);
-}
+	if (!after_init)
+		after_init_perm |= PERM_W;
 
-static void module_enable_nx(const struct module *mod)
-{
-	frob_rodata(&mod->core_layout, set_memory_nx);
-	frob_ro_after_init(&mod->core_layout, set_memory_nx);
-	frob_writable_data(&mod->core_layout, set_memory_nx);
-	frob_rodata(&mod->init_layout, set_memory_nx);
-	frob_writable_data(&mod->init_layout, set_memory_nx);
+	map_core_regions(mod, PERM_RX, PERM_R, after_init_perm, PERM_RW);
+	map_init_regions(mod, PERM_RX, PERM_R);
 }
 
 static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
@@ -2109,8 +2096,7 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 }
 
 #else /* !CONFIG_STRICT_MODULE_RWX */
-static void module_enable_nx(const struct module *mod) { }
-static void module_enable_ro(const struct module *mod, bool after_init) {}
+static void module_map(const struct module *mod, bool after_init) {}
 static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				       char *secstrings, struct module *mod)
 {
@@ -2211,6 +2197,8 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
+void module_perm_free(struct module_layout *layout);
+
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
@@ -2252,15 +2240,16 @@ static void free_module(struct module *mod)
 
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
-	module_memfree(mod->init_layout.base);
+	module_perm_free(&mod->init_layout);
 	kfree(mod->args);
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range((void *)perm_alloc_address(mod->core_layout.rw.alloc),
+			       mod->core_layout.rw.size);
 
 	/* Finally, free the core (containing the module structure) */
-	module_memfree(mod->core_layout.base);
+	module_perm_free(&mod->core_layout);
 }
 
 void *__symbol_get(const char *symbol)
@@ -2436,10 +2425,56 @@ static long get_offset(struct module *mod, unsigned int *size,
 
 	*size += arch_mod_section_prepend(mod, section);
 	ret = ALIGN(*size, sechdr->sh_addralign ?: 1);
-	*size = ret + sechdr->sh_size;
+	*size = debug_align(ret + sechdr->sh_size);
+
 	return ret;
 }
 
+static inline unsigned int *get_size_from_layout(struct module_layout *layout,
+						 unsigned long offset_mask)
+{
+	if (offset_mask & TEXT_OFFSET_MASK)
+		return &layout->text.size;
+	if (offset_mask & RO_OFFSET_MASK)
+		return &layout->ro.size;
+	if (offset_mask & RO_AFTER_INIT_OFFSET_MASK)
+		return &layout->ro_after_init.size;
+	return &layout->rw.size; /*RW_OFFSET_MASK*/
+}
+
+static inline struct perm_allocation *get_alloc_from_layout(struct module_layout *layout,
+							    unsigned long offset_mask)
+{
+	if (offset_mask & TEXT_OFFSET_MASK)
+		return layout->text.alloc;
+	if (offset_mask & RO_OFFSET_MASK)
+		return layout->ro.alloc;
+	if (offset_mask & RO_AFTER_INIT_OFFSET_MASK)
+		return layout->ro_after_init.alloc;
+	return layout->rw.alloc; /*RW_OFFSET_MASK*/
+}
+
+static void set_total_size(struct module_layout *layout)
+{
+	layout->size = debug_align(layout->text.size + layout->ro.size +
+		       layout->ro_after_init.size + layout->rw.size);
+}
+
+struct perm_allocation *module_get_allocation(struct module *mod, unsigned long addr)
+{
+	struct perm_allocation *allocs[] = { mod->core_layout.text.alloc, mod->core_layout.ro.alloc,
+					mod->core_layout.ro_after_init.alloc,
+					mod->core_layout.rw.alloc, mod->init_layout.text.alloc,
+					mod->init_layout.ro.alloc, mod->init_layout.rw.alloc };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(allocs); i++)
+		if (within_perm_alloc(allocs[i], addr))
+			return allocs[i];
+
+	return NULL;
+}
+
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
@@ -2456,6 +2491,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 }
 	};
+	unsigned int *section_size;
 	unsigned int m, i;
 
 	for (i = 0; i < info->hdr->e_shnum; i++)
@@ -2463,6 +2499,8 @@ static void layout_sections(struct module *mod, struct load_info *info)
 
 	pr_debug("Core section allocation order:\n");
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		unsigned long offset_mask = (1UL << (BITS_PER_LONG - (m + 2)));
+
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
@@ -2472,30 +2510,19 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || module_init_section(sname))
 				continue;
-			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
+			section_size = get_size_from_layout(&mod->core_layout, offset_mask);
+			s->sh_entsize = get_offset(mod, section_size, s, i) | offset_mask;
+
 			pr_debug("\t%s\n", sname);
 		}
-		switch (m) {
-		case 0: /* executable */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.text_size = mod->core_layout.size;
-			break;
-		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_size = mod->core_layout.size;
-			break;
-		case 2: /* RO after init */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_after_init_size = mod->core_layout.size;
-			break;
-		case 4: /* whole core */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			break;
-		}
 	}
 
+	set_total_size(&mod->core_layout);
+
 	pr_debug("Init section allocation order:\n");
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		unsigned long offset_mask = (1UL << (BITS_PER_LONG - (m + 2)));
+
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
@@ -2505,31 +2532,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || !module_init_section(sname))
 				continue;
-			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
-					 | INIT_OFFSET_MASK);
+
+			section_size = get_size_from_layout(&mod->init_layout, offset_mask);
+			s->sh_entsize = get_offset(mod, section_size, s, i);
+			s->sh_entsize |= INIT_OFFSET_MASK | offset_mask;
 			pr_debug("\t%s\n", sname);
 		}
-		switch (m) {
-		case 0: /* executable */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
-			mod->init_layout.text_size = mod->init_layout.size;
-			break;
-		case 1: /* RO: text and ro-data */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
-			mod->init_layout.ro_size = mod->init_layout.size;
-			break;
-		case 2:
-			/*
-			 * RO after init doesn't apply to init_layout (only
-			 * core_layout), so it just takes the value of ro_size.
-			 */
-			mod->init_layout.ro_after_init_size = mod->init_layout.ro_size;
-			break;
-		case 4: /* whole init */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
-			break;
-		}
 	}
+
+	set_total_size(&mod->init_layout);
 }
 
 static void set_license(struct module *mod, const char *license)
@@ -2724,7 +2735,7 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 
 	/* Put symbol section at end of init part of module. */
 	symsect->sh_flags |= SHF_ALLOC;
-	symsect->sh_entsize = get_offset(mod, &mod->init_layout.size, symsect,
+	symsect->sh_entsize = get_offset(mod, &mod->init_layout.rw.size, symsect,
 					 info->index.sym) | INIT_OFFSET_MASK;
 	pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
 
@@ -2742,27 +2753,28 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	}
 
 	/* Append room for core symbols at end of core part. */
-	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
-	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
-	mod->core_layout.size += strtab_size;
-	info->core_typeoffs = mod->core_layout.size;
+	info->symoffs = ALIGN(mod->core_layout.rw.size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod->core_layout.rw.size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod->core_layout.rw.size += strtab_size;
+	info->core_typeoffs = mod->core_layout.rw.size;
 	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = debug_align(mod->core_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
-	strsect->sh_entsize = get_offset(mod, &mod->init_layout.size, strsect,
+	strsect->sh_entsize = get_offset(mod, &mod->init_layout.rw.size, strsect,
 					 info->index.str) | INIT_OFFSET_MASK;
 	pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
 
 	/* We'll tack temporary mod_kallsyms on the end. */
-	mod->init_layout.size = ALIGN(mod->init_layout.size,
-				      __alignof__(struct mod_kallsyms));
-	info->mod_kallsyms_init_off = mod->init_layout.size;
-	mod->init_layout.size += sizeof(struct mod_kallsyms);
-	info->init_typeoffs = mod->init_layout.size;
-	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = debug_align(mod->init_layout.size);
+	mod->init_layout.rw.size = ALIGN(mod->init_layout.rw.size,
+					 __alignof__(struct mod_kallsyms));
+	info->mod_kallsyms_init_off = mod->init_layout.rw.size;
+	mod->init_layout.rw.size += sizeof(struct mod_kallsyms);
+	info->init_typeoffs = mod->init_layout.rw.size;
+	mod->init_layout.rw.size += nsrc * sizeof(char);
+
+	set_total_size(&mod->core_layout);
+	set_total_size(&mod->init_layout);
 }
 
 /*
@@ -2777,23 +2789,25 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Sym *dst;
 	char *s;
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+	void *core_rw = (void *)perm_alloc_address(mod->core_layout.rw.alloc);
+	void *init_rw = (void *)perm_alloc_address(mod->init_layout.rw.alloc);
 
 	/* Set up to point into init section. */
-	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
+	mod->kallsyms = init_rw + info->mod_kallsyms_init_off;
 
 	mod->kallsyms->symtab = (void *)symsec->sh_addr;
 	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
 	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
-	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
+	mod->kallsyms->typetab = init_rw + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
 	 * and set types up while we still have access to sections.
 	 */
-	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
-	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
-	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
+	mod->core_kallsyms.symtab = dst = core_rw + info->symoffs;
+	mod->core_kallsyms.strtab = s = core_rw + info->stroffs;
+	mod->core_kallsyms.typetab = core_rw + info->core_typeoffs;
 	src = mod->kallsyms->symtab;
 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
 		mod->kallsyms->typetab[i] = elf_type(src + i, info);
@@ -2845,6 +2859,110 @@ bool __weak module_init_section(const char *name)
 	return strstarts(name, ".init");
 }
 
+static void set_perm_alloc(struct perm_allocation *alloc, struct vm_struct *area,
+			   unsigned long offset, unsigned long size)
+{
+	if (!alloc)
+		return;
+
+	alloc->area = area;
+	alloc->offset = offset;
+	alloc->size = size;
+}
+
+/*
+ * Layout perm_allocs as they would have been by a straight module_alloc call in case any arch's
+ * care about that.
+ */
+bool __weak module_perm_alloc(struct module_layout *layout)
+{
+	void *addr = module_alloc(layout->size);
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO;
+	struct vm_struct *area;
+
+	layout->text.alloc = NULL;
+	layout->ro.alloc = NULL;
+	layout->ro_after_init.alloc = NULL;
+	layout->rw.alloc = NULL;
+
+	if (!addr)
+		return false;
+
+	layout->base = addr;
+
+	if (IS_ENABLED(CONFIG_MMU)) {
+		area = find_vm_area(addr);
+	} else {
+		area = kmalloc(sizeof(*area), flags);
+		if (!area) {
+			module_memfree(addr);
+			return NULL;
+		}
+		area->addr = addr;
+	}
+
+	/*
+	 * This is a bit of an awkward hack. modules.c now expects all of the different permission
+	 * ranges to be in separate allocations, but we want to make this perm_allocation transition
+	 * without disturbing any arch, which may have unknown relocation rules. So to make sure
+	 * there is no functional change, allocate using the arch's module_alloc() and lay fake
+	 * perm_allocations over the top of it. This way all the sections would be laid out exactly
+	 * as before struct special_alloc was introduced until an arch adds their own
+	 * module_perm_alloc().
+	 */
+	layout->text.alloc = kmalloc(sizeof(*layout->text.alloc), flags);
+	layout->ro.alloc = kmalloc(sizeof(*layout->ro.alloc), flags);
+	layout->ro_after_init.alloc = kmalloc(sizeof(*layout->ro_after_init.alloc), flags);
+	layout->rw.alloc = kmalloc(sizeof(*layout->rw.alloc), flags);
+	if (!(layout->text.alloc && layout->ro.alloc && layout->ro_after_init.alloc &&
+	      layout->rw.alloc)) {
+		module_perm_free(layout);
+		layout->text.alloc = NULL;
+		layout->ro.alloc = NULL;
+		layout->ro_after_init.alloc = NULL;
+		layout->rw.alloc = NULL;
+		return false;
+	}
+
+	set_perm_alloc(layout->text.alloc, area, 0, layout->text.size);
+	set_perm_alloc(layout->ro.alloc, area, layout->text.size, layout->ro.size);
+	set_perm_alloc(layout->ro_after_init.alloc, area, layout->ro.alloc->offset +
+		       layout->ro.size, layout->ro_after_init.size);
+	set_perm_alloc(layout->rw.alloc, area,
+		       layout->ro_after_init.alloc->offset + layout->ro_after_init.size,
+		       layout->rw.size);
+
+	set_vm_flush_reset_perms(addr);
+
+	return true;
+}
+
+static void unset_layout_allocs(struct module_layout *layout)
+{
+	layout->text.alloc = NULL;
+	layout->ro.alloc = NULL;
+	layout->ro_after_init.alloc = NULL;
+	layout->rw.alloc = NULL;
+}
+
+void __weak module_perm_free(struct module_layout *layout)
+{
+	void *addr;
+
+	if (!layout->text.alloc)
+		return;
+	addr = (void *)perm_alloc_address(layout->text.alloc);
+
+	/* Clean up the fake perm_allocation's in a special way */
+	kfree(layout->text.alloc);
+	kfree(layout->ro.alloc);
+	kfree(layout->ro_after_init.alloc);
+	kfree(layout->rw.alloc);
+	unset_layout_allocs(layout);
+
+	module_memfree(addr);
+}
+
 bool __weak module_exit_section(const char *name)
 {
 	return strstarts(name, ".exit");
@@ -3306,54 +3424,52 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
-	void *ptr;
 
-	/* Do the allocs. */
-	ptr = module_alloc(mod->core_layout.size);
 	/*
 	 * The pointer to this block is stored in the module structure
 	 * which is inside the block. Just mark it as not being a
 	 * leak.
 	 */
-	kmemleak_not_leak(ptr);
-	if (!ptr)
+	if (!module_perm_alloc(&mod->core_layout))
 		return -ENOMEM;
 
-	memset(ptr, 0, mod->core_layout.size);
-	mod->core_layout.base = ptr;
+	perm_memset(mod->core_layout.text.alloc, 0xcc);
+	perm_memset(mod->core_layout.ro.alloc, 0);
+	perm_memset(mod->core_layout.ro_after_init.alloc, 0);
+	perm_memset(mod->core_layout.rw.alloc, 0);
 
 	if (mod->init_layout.size) {
-		ptr = module_alloc(mod->init_layout.size);
 		/*
 		 * The pointer to this block is stored in the module structure
 		 * which is inside the block. This block doesn't need to be
 		 * scanned as it contains data and code that will be freed
 		 * after the module is initialized.
 		 */
-		kmemleak_ignore(ptr);
-		if (!ptr) {
-			module_memfree(mod->core_layout.base);
+		if (!module_perm_alloc(&mod->init_layout))
 			return -ENOMEM;
-		}
-		memset(ptr, 0, mod->init_layout.size);
-		mod->init_layout.base = ptr;
-	} else
-		mod->init_layout.base = NULL;
+		perm_memset(mod->init_layout.text.alloc, 0xcc);
+		perm_memset(mod->init_layout.ro.alloc, 0);
+		perm_memset(mod->init_layout.rw.alloc, 0);
+	} else {
+		unset_layout_allocs(&mod->init_layout);
+	}
 
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("final section addresses:\n");
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
+		struct perm_allocation *alloc;
+
 		Elf_Shdr *shdr = &info->sechdrs[i];
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
-			dest = mod->init_layout.base
-				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+			alloc = get_alloc_from_layout(&mod->init_layout, shdr->sh_entsize);
 		else
-			dest = mod->core_layout.base + shdr->sh_entsize;
+			alloc = get_alloc_from_layout(&mod->core_layout, shdr->sh_entsize);
+		dest = (void *)perm_alloc_address(alloc) + (shdr->sh_entsize & ~ALL_OFFSET_MASK);
 
 		if (shdr->sh_type != SHT_NOBITS)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
@@ -3414,12 +3530,13 @@ static void flush_module_icache(const struct module *mod)
 	 * Do it before processing of module parameters, so the module
 	 * can provide parameter accessor functions of its own.
 	 */
-	if (mod->init_layout.base)
-		flush_icache_range((unsigned long)mod->init_layout.base,
-				   (unsigned long)mod->init_layout.base
-				   + mod->init_layout.size);
-	flush_icache_range((unsigned long)mod->core_layout.base,
-			   (unsigned long)mod->core_layout.base + mod->core_layout.size);
+	if (mod->init_layout.text.alloc)
+		flush_icache_range((unsigned long)perm_alloc_address(mod->init_layout.text.alloc),
+				   (unsigned long)perm_alloc_address(mod->init_layout.text.alloc)
+				   + mod->init_layout.text.size);
+	flush_icache_range((unsigned long)perm_alloc_address(mod->core_layout.text.alloc),
+			   (unsigned long)perm_alloc_address(mod->init_layout.text.alloc) +
+			   mod->core_layout.text.size);
 }
 
 int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
@@ -3515,8 +3632,8 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
-	module_memfree(mod->init_layout.base);
-	module_memfree(mod->core_layout.base);
+	module_perm_free(&mod->init_layout);
+	module_perm_free(&mod->core_layout);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
@@ -3576,7 +3693,7 @@ static void do_mod_ctors(struct module *mod)
 /* For freeing module_init on success, in case kallsyms traversing */
 struct mod_initfree {
 	struct llist_node node;
-	void *module_init;
+	struct module_layout layout;
 };
 
 static void do_free_init(struct work_struct *w)
@@ -3590,7 +3707,7 @@ static void do_free_init(struct work_struct *w)
 
 	llist_for_each_safe(pos, n, list) {
 		initfree = container_of(pos, struct mod_initfree, node);
-		module_memfree(initfree->module_init);
+		module_perm_free(&initfree->layout);
 		kfree(initfree);
 	}
 }
@@ -3606,12 +3723,11 @@ static noinline int do_init_module(struct module *mod)
 	int ret = 0;
 	struct mod_initfree *freeinit;
 
-	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
+	freeinit = kmalloc(sizeof(*freeinit) * 4, GFP_KERNEL);
 	if (!freeinit) {
 		ret = -ENOMEM;
 		goto fail;
 	}
-	freeinit->module_init = mod->init_layout.base;
 
 	/*
 	 * We want to find out whether @mod uses async during init.  Clear
@@ -3659,8 +3775,9 @@ static noinline int do_init_module(struct module *mod)
 	if (!mod->async_probe_requested && (current->flags & PF_USED_ASYNC))
 		async_synchronize_full();
 
-	ftrace_free_mem(mod, mod->init_layout.base, mod->init_layout.base +
-			mod->init_layout.size);
+	ftrace_free_mem(mod, (void *)perm_alloc_address(mod->init_layout.text.alloc),
+			(void *)perm_alloc_address(mod->init_layout.text.alloc) +
+			perm_alloc_size(mod->init_layout.text.alloc));
 	mutex_lock(&module_mutex);
 	/* Drop initial reference. */
 	module_put(mod);
@@ -3669,14 +3786,10 @@ static noinline int do_init_module(struct module *mod)
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
-	module_enable_ro(mod, true);
+	module_map(mod, true);
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
-	mod->init_layout.base = NULL;
-	mod->init_layout.size = 0;
-	mod->init_layout.ro_size = 0;
-	mod->init_layout.ro_after_init_size = 0;
-	mod->init_layout.text_size = 0;
+
 	/*
 	 * We want to free module_init, but be aware that kallsyms may be
 	 * walking this with preempt disabled.  In all the failure paths, we
@@ -3690,6 +3803,9 @@ static noinline int do_init_module(struct module *mod)
 	 * be cleaned up needs to sync with the queued work - ie
 	 * rcu_barrier()
 	 */
+	freeinit->layout = mod->init_layout;
+	unset_layout_allocs(&mod->init_layout);
+	mod->init_layout.size = 0;
 	if (llist_add(&freeinit->node, &init_free_list))
 		schedule_work(&init_free_wq);
 
@@ -3775,9 +3891,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	/* This relies on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 
-	module_enable_ro(mod, false);
-	module_enable_nx(mod);
-	module_enable_x(mod);
+	module_map(mod, false);
 
 	/* Mark state as coming so strong_try_module_get() ignores us,
 	 * but kallsyms etc. can see us. */
@@ -4018,7 +4132,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range((void *)perm_alloc_address(mod->core_layout.rw.alloc),
+			       mod->core_layout.text.size);
 
 	module_deallocate(mod, info);
  free_copy:
@@ -4110,9 +4225,11 @@ static const char *find_kallsyms_symbol(struct module *mod,
 
 	/* At worse, next value is at end of module */
 	if (within_module_init(addr, mod))
-		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
+		nextval = perm_alloc_address(mod->init_layout.text.alloc) +
+					     mod->init_layout.text.size;
 	else
-		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
+		nextval = perm_alloc_address(mod->core_layout.text.alloc) +
+					     mod->core_layout.text.size;
 
 	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
 
@@ -4404,7 +4521,7 @@ static int m_show(struct seq_file *m, void *p)
 		   mod->state == MODULE_STATE_COMING ? "Loading" :
 		   "Live");
 	/* Used by oprofile and other similar tools. */
-	value = m->private ? NULL : mod->core_layout.base;
+	value = m->private ? NULL : (void *)perm_alloc_address(mod->core_layout.text.alloc);
 	seq_printf(m, " 0x%px", value);
 
 	/* Taints info */
@@ -4524,11 +4641,8 @@ struct module *__module_address(unsigned long addr)
 	module_assert_mutex_or_preempt();
 
 	mod = mod_find(addr);
-	if (mod) {
-		BUG_ON(!within_module(addr, mod));
-		if (mod->state == MODULE_STATE_UNFORMED)
-			mod = NULL;
-	}
+	BUG_ON(mod && !within_module(addr, mod));
+
 	return mod;
 }
 
@@ -4562,9 +4676,12 @@ struct module *__module_text_address(unsigned long addr)
 {
 	struct module *mod = __module_address(addr);
 	if (mod) {
+		void *init_text = (void *)perm_alloc_address(mod->init_layout.text.alloc);
+		void *core_text = (void *)perm_alloc_address(mod->init_layout.text.alloc);
+
 		/* Make sure it's within the text section. */
-		if (!within(addr, mod->init_layout.base, mod->init_layout.text_size)
-		    && !within(addr, mod->core_layout.base, mod->core_layout.text_size))
+		if (!within(addr, init_text, mod->init_layout.text.size) &&
+		    !within(addr, core_text, mod->core_layout.text.size))
 			mod = NULL;
 	}
 	return mod;
-- 
2.20.1

