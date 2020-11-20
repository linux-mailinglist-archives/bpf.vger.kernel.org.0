Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B82BB6E3
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgKTUaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:10351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731055AbgKTUaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:06 -0500
IronPort-SDR: q6kFQBIEGpqbjxf9qJYOoSEc48nAbKSb34lUe/iXfgxJjk6pfcX4MmGQBEw2ewZkA/R2EISLsY
 v2TFIYdVqFug==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683321"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:05 -0800
IronPort-SDR: 97QE0b6Gshe6vW0gPefTAnuBtLy3iVJfb8FOcK/CZUxunD/qo1MFjTsqzK/RnCx9nBCbiMK71W
 gUVhzP7+yCVQ==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163333"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:05 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 10/10] vmalloc: Add perm_alloc x86 implementation
Date:   Fri, 20 Nov 2020 12:24:26 -0800
Message-Id: <20201120202426.18009-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create a custom perm_alloc() implementation for x86. Allocate a new buffer
to be returned by perm_writable_addr(), and text_poke() it into the final
allocation in perm_writable_finish(). Map the allocation at it's final
permissions so that it does not need to be shot down as it transitions
from writable to read-only.

Since x86 direct map permissions are set via set_memory_() calls whose
alias mappings can be scattered across the direct map, instead draw from
blocks of 2MB unmapped pages. Previously the direct map was marked RO
for a RO vmalloc alias, however unmapping the direct map instead will
allow us to remap them later without a shootdown.

Register a shrinker callback to allow for this pool of pages to be
freed. This should reduce breaking large pages on the direct map
over the existing set_memory_() based solutions. Since the pages are left
as 4k NP pages, we can remap them in the shrinker callback without any
split or flush.

An algorithm for how many unmapped pages to keep in the cache is still a
todo. Currently it will grow until the shrinker triggers.

By grabbing whole 2MB pages this may reduce the availability of high page
order blocks in some cases. However, it could just as easily improve the
availability of high order pages for cases where the vmalloc allocations
could be long lived, such as modules, by grouping these long lived
allocations together. By caching pages, this would however reduce pages
available to other parts of the kernel for use in other caches.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/set_memory.h |   2 +
 arch/x86/mm/Makefile              |   1 +
 arch/x86/mm/pat/set_memory.c      |  13 +
 arch/x86/mm/vmalloc.c             | 438 ++++++++++++++++++++++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 arch/x86/mm/vmalloc.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..aa3c19fa23f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -78,6 +78,7 @@ config X86
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_PERM_ALLOC_IMPLEMENTATION	if X86_64
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 5948218f35c5..0d3efed009bb 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,6 +49,8 @@ int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
+int set_memory_noalias_noflush(unsigned long addr, int numpages,
+			       pgprot_t mask_set, pgprot_t mask_clr);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..fb7a566bfedc 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PTDUMP_CORE)	+= dump_pagetables.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= debug_pagetables.o
 
 obj-$(CONFIG_HIGHMEM)		+= highmem_32.o
+obj-$(CONFIG_ARCH_HAS_PERM_ALLOC_IMPLEMENTATION)	+= vmalloc.o
 
 KASAN_SANITIZE_kasan_init_$(BITS).o := n
 obj-$(CONFIG_KASAN)		+= kasan_init_$(BITS).o
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 40baa90e74f4..59f42de1e6ab 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1954,6 +1954,19 @@ int set_memory_np_noalias(unsigned long addr, int numpages)
 					cpa_flags, NULL);
 }
 
+int set_memory_noalias_noflush(unsigned long addr, int numpages,
+			       pgprot_t mask_set, pgprot_t mask_clr)
+{
+	struct cpa_data cpa = { .vaddr = &addr,
+				.pgd = NULL,
+				.numpages = numpages,
+				.mask_set = mask_set,
+				.mask_clr = mask_clr,
+				.flags = CPA_NO_CHECK_ALIAS};
+
+	return __change_page_attr_set_clr(&cpa, 0);
+}
+
 int set_memory_4k(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
diff --git a/arch/x86/mm/vmalloc.c b/arch/x86/mm/vmalloc.c
new file mode 100644
index 000000000000..2bc6381cbd2d
--- /dev/null
+++ b/arch/x86/mm/vmalloc.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/shrinker.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <asm/set_memory.h>
+#include <asm/tlbflush.h>
+#include <asm/text-patching.h>
+#include <linux/memory.h>
+
+#define DIRECTMAP_PROTECTED	0
+#define DIRECTMAP_UNPROTECTED	1
+
+static LIST_HEAD(pages);
+static int page_cnt;
+static DEFINE_SPINLOCK(pages_lock);
+
+#define DEFINE_RANGE_CALC(x) struct range_calc x = {.min = ULONG_MAX, .max = 0}
+
+struct range_calc {
+	unsigned long min;
+	unsigned long max;
+};
+
+static inline void grow_range(struct range_calc *grower, unsigned long addr, unsigned long size)
+{
+	if (addr < grower->min)
+		grower->min = addr;
+	if (addr + size > grower->max)
+		grower->max = addr;
+}
+
+static inline void grow_range_page(struct range_calc *grower, struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (!addr)
+		return;
+
+	grow_range(grower, addr, PAGE_SIZE);
+}
+
+static inline bool has_range(struct range_calc *grower)
+{
+	return grower->min != ULONG_MAX && grower->max != 0;
+}
+
+static unsigned long perm_shrink_count(struct shrinker *shrinker, struct shrink_control *sc)
+{
+	unsigned long ret;
+
+	spin_lock(&pages_lock);
+	ret = page_cnt;
+	spin_unlock(&pages_lock);
+
+	return ret;
+}
+
+static struct page *__get_perm_page(void)
+{
+	struct page *page;
+
+	spin_lock(&pages_lock);
+	page = list_first_entry(&pages, struct page, lru);
+	list_del(&page->lru);
+	spin_unlock(&pages_lock);
+
+	return page;
+}
+
+static unsigned long perm_shrink_scan(struct shrinker *shrinker, struct shrink_control *sc)
+{
+	DEFINE_RANGE_CALC(range);
+	static LIST_HEAD(to_free_list);
+	struct page *page, *tmp;
+	unsigned int i, cnt = 0;
+
+	for (i = 0; i < sc->nr_to_scan; i++) {
+		page = __get_perm_page();
+		if (!page)
+			continue;
+
+		grow_range_page(&range, page);
+		set_direct_map_default_noflush(page);
+		list_add(&page->lru, &to_free_list);
+		cnt++;
+	}
+
+	if (has_range(&range))
+		flush_tlb_kernel_range(range.min, range.max);
+
+	list_for_each_entry_safe(page, tmp, &to_free_list, lru)
+		__free_pages(page, 0);
+
+	return cnt;
+}
+
+static struct shrinker perm_shrinker = {
+	.count_objects = perm_shrink_count,
+	.scan_objects = perm_shrink_scan,
+	.seeks = DEFAULT_SEEKS
+};
+
+static bool replenish_pages_one(void)
+{
+	struct page *page = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!page)
+		return false;
+
+	spin_lock(&pages_lock);
+	list_add(&page->lru, &pages);
+	page->private = DIRECTMAP_UNPROTECTED;
+	page_cnt++;
+	spin_unlock(&pages_lock);
+
+	return true;
+}
+
+static bool replenish_pages(void)
+{
+	struct page *page = alloc_pages(GFP_KERNEL | __GFP_ZERO, 9); /* 2MB */
+	DEFINE_RANGE_CALC(range);
+	int convert_ret = 0;
+	int i;
+
+	if (!page)
+		return replenish_pages_one();
+
+	for (i = 0; i < 512; i++)
+		convert_ret |= set_direct_map_invalid_noflush(&page[i]);
+
+	if (convert_ret)
+		goto convert_fail;
+
+	spin_lock(&pages_lock);
+	for (i = 0; i < 512; i++) {
+		list_add(&page[i].lru, &pages);
+		page[i].private = DIRECTMAP_PROTECTED;
+		grow_range_page(&range, page);
+	}
+	page_cnt += 512;
+	spin_unlock(&pages_lock);
+
+	flush_tlb_kernel_range(range.min, range.max);
+
+	vm_unmap_aliases();
+
+	return true;
+
+convert_fail:
+	for (i = 0; i < 512; i++) {
+		set_direct_map_default_noflush(&page[i]);
+		__free_pages(&page[i], 0);
+	}
+
+	return false;
+}
+
+static struct page *get_perm_page(void)
+{
+	struct page *page;
+
+	spin_lock(&pages_lock);
+	if (!page_cnt) {
+		spin_unlock(&pages_lock);
+		if (!replenish_pages())
+			return NULL;
+		spin_lock(&pages_lock);
+	}
+
+	page = list_first_entry(&pages, struct page, lru);
+	page_cnt--;
+	list_del(&page->lru);
+	spin_unlock(&pages_lock);
+
+	return page;
+}
+
+static void __perm_free_page(struct page *page)
+{
+	spin_lock(&pages_lock);
+	list_add(&page->lru, &pages);
+	page_cnt++;
+	spin_unlock(&pages_lock);
+}
+
+static void __perm_free_pages(struct page **page, int count)
+{
+	int i;
+
+	spin_lock(&pages_lock);
+	for (i = 0; i < count; i++)
+		list_add(&page[i]->lru, &pages);
+	page_cnt += count;
+	spin_unlock(&pages_lock);
+}
+
+static inline pgprot_t perms_to_prot(virtual_perm perms)
+{
+	switch (perms) {
+	case PERM_RX:
+		return PAGE_KERNEL_ROX;
+	case PERM_RWX:
+		return PAGE_KERNEL_EXEC;
+	case PERM_RW:
+		return PAGE_KERNEL;
+	case PERM_R:
+		return PAGE_KERNEL_RO;
+	default:
+		return __pgprot(0);
+	}
+}
+
+static bool map_alloc(struct perm_allocation *alloc)
+{
+	return !map_kernel_range(perm_alloc_address(alloc), get_vm_area_size(alloc->area),
+				 perms_to_prot(alloc->cur_perm), alloc->pages);
+}
+
+struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
+				   virtual_perm perms)
+{
+	struct perm_allocation *alloc;
+	DEFINE_RANGE_CALC(range);
+	int i, j;
+
+	if (!page_cnt)
+		return NULL;
+
+	alloc = kmalloc(sizeof(*alloc), GFP_KERNEL | __GFP_ZERO);
+
+	if (!alloc)
+		return NULL;
+
+	alloc->area = __get_vm_area_caller(page_cnt << PAGE_SHIFT, VM_MAP, vstart, vend,
+					   __builtin_return_address(0));
+
+	if (!alloc->area)
+		goto free_alloc;
+
+	alloc->pages = kvmalloc(page_cnt * sizeof(struct page *), GFP_KERNEL);
+	if (!alloc->pages)
+		goto free_area;
+
+	alloc->size = (unsigned long)get_vm_area_size(alloc->area);
+	alloc->offset = 0;
+	alloc->writable = NULL;
+	alloc->cur_perm = perms;
+
+	/* TODO if this will be RW, we don't need unmapped pages, better to conserve those */
+	for (i = 0; i < page_cnt; i++) {
+		alloc->pages[i] = get_perm_page();
+		if (alloc->pages[i]->private == DIRECTMAP_PROTECTED)
+			continue;
+
+		grow_range_page(&range, alloc->pages[i]);
+		if (set_direct_map_invalid_noflush(alloc->pages[i]))
+			goto convert_fail;
+		alloc->pages[i]->private = DIRECTMAP_PROTECTED;
+	}
+
+	/*
+	 * Flush any pages that were removed in the loop above. In the event of no pages in the
+	 * cache, these may be scattered about single pages, so flush here to only have a single
+	 * flush instead of one for each replenish_pages_one() call.
+	 */
+	if (has_range(&range)) {
+		flush_tlb_kernel_range(range.min, range.max);
+		vm_unmap_aliases();
+	}
+
+	if (i != page_cnt)
+		goto free_pages;
+
+	/* TODO: Need to zero these pages */
+	if (!map_alloc(alloc))
+		goto free_pages;
+
+	return alloc;
+
+free_pages:
+	__perm_free_pages(alloc->pages, i);
+	kvfree(alloc->pages);
+free_area:
+	remove_vm_area(alloc->area->addr);
+free_alloc:
+	kfree(alloc);
+
+	return NULL;
+
+convert_fail:
+	for (j = 0; j < i - 1; j++)
+		__perm_free_page(alloc->pages[j]);
+
+	return NULL;
+}
+
+unsigned long perm_writable_addr(struct perm_allocation *alloc, unsigned long addr)
+{
+	/* If this is already mapped and writable, just write to the actual kva */
+	if (alloc->cur_perm & PERM_W)
+		return addr;
+
+	/* TODO lock or callers need to synchronize? */
+	/* TODO could fail, set primary alias writable in this case or alloc up front */
+	if (!alloc->writable)
+		alloc->writable = vmalloc(alloc->size);
+
+	return (unsigned long)alloc->writable + (addr - perm_alloc_address(alloc));
+}
+
+bool perm_writable_finish(struct perm_allocation *alloc)
+{
+	unsigned long addr;
+	void *writable;
+	int i;
+
+	if (!alloc)
+		return false;
+	if (!alloc->writable)
+		return true;
+
+	addr = perm_alloc_address(alloc);
+
+	writable = (void *)perm_writable_base(alloc);
+
+	mutex_lock(&text_mutex);
+	for (i = 0; i < perm_alloc_size(alloc); i += PAGE_SIZE)
+		text_poke((void *)(addr + i), writable + i, PAGE_SIZE);
+	mutex_unlock(&text_mutex);
+
+	vfree(alloc->writable);
+
+	alloc->writable = 0;
+
+	return true;
+}
+
+static inline pgprot_t get_set(virtual_perm perms)
+{
+	pteval_t ret = 0;
+
+	if (perms)
+		ret = _PAGE_PRESENT;
+
+	if (perms & PERM_W)
+		ret |= _PAGE_RW;
+
+	if (~perms & PERM_X)
+		ret |= _PAGE_NX;
+
+	return __pgprot(ret);
+}
+
+static inline pgprot_t get_unset(virtual_perm perms)
+{
+	pteval_t ret = 0;
+
+	if (!perms)
+		ret = _PAGE_PRESENT;
+
+	if (~perms & PERM_W)
+		ret |= _PAGE_RW;
+
+	if (perms & PERM_X)
+		ret |= _PAGE_NX;
+
+	return __pgprot(ret);
+}
+
+bool perm_change(struct perm_allocation *alloc, virtual_perm perms)
+{
+	pgprot_t set = get_set(perms);
+	pgprot_t clr = get_unset(perms);
+	unsigned long start;
+
+	if (!alloc)
+		return false;
+
+	if (!(alloc->cur_perm ^ perms))
+		return true;
+
+	start = perm_alloc_address(alloc);
+
+	set_memory_noalias_noflush(start, perm_alloc_size(alloc) >> PAGE_SHIFT, set, clr);
+
+	flush_tlb_kernel_range(start, start + perm_alloc_size(alloc));
+
+	return true;
+}
+
+static inline bool perms_need_flush(struct perm_allocation *alloc)
+{
+	return alloc->cur_perm & PERM_X;
+}
+
+void perm_free(struct perm_allocation *alloc)
+{
+	unsigned long size, addr;
+	int page_cnt;
+
+	if (!alloc)
+		return;
+
+	if (alloc->writable)
+		vfree(alloc->writable);
+
+	size = get_vm_area_size(alloc->area);
+	addr = perm_alloc_address(alloc);
+	page_cnt = size >> PAGE_SHIFT;
+
+	vunmap((void *)addr);
+
+	if (perms_need_flush(alloc))
+		flush_tlb_kernel_range(addr, addr + size);
+
+	__perm_free_pages(alloc->pages, page_cnt);
+
+	kvfree(alloc->pages);
+	kfree(alloc);
+}
+
+void perm_memset(struct perm_allocation *alloc, char val)
+{
+	if (!alloc)
+		return;
+
+	memset((void *)perm_writable_base(alloc), val, perm_alloc_size(alloc));
+}
+
+static int __init perm_alloc_init(void)
+{
+	return register_shrinker(&perm_shrinker);
+}
+device_initcall(perm_alloc_init);
-- 
2.20.1

