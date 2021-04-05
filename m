Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417CF3547A9
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 22:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhDEUlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 16:41:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:54260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237132AbhDEUlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 16:41:40 -0400
IronPort-SDR: 7ymwcVff4gIP8YdAjYE7fYjRjrFrDsAcpodaONhQZ4r6O/cLBsyIVHw+eH1ua2g9xpgNiECoKL
 SNf5t7BdpHXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180051524"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="180051524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:33 -0700
IronPort-SDR: v928vZ1l56ThdOyMI6sluCapDrYJ1qbjHifAmQ0OUi0fiHw1bGMDS6S+wPykc938SJfGMzuG01
 Q7gNdbAlUFPw==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="418078034"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.230.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 13:41:32 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, hch@infradead.org, x86@kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC 2/3] vmalloc: Support grouped page allocations
Date:   Mon,  5 Apr 2021 13:37:10 -0700
Message-Id: <20210405203711.1095940-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For x86, setting memory permissions on vmalloc allocations results in
fracturing large pages on the direct map. Direct map fracturing can be
reduced by locating pages that will have their permissions set close
together.

Create a simple page cache in vmalloc that allocates pages from huge
page size blocks. Define a new flag, VM_GROUP_PAGES, that vmalloc
callers can use to ask vmalloc to try to use pages from this new cache.
Don't guarantee that a page will come from a huge page grouping,
instead fallback to non-grouped pages to fulfill the allocation if
needed. Also, register a shrinker such that the system can ask for the
pages back if needed.

Since this is only needed for cases where there are direct map
permissions and there might be large pages on the direct map, compile
it out for non-x86 and highmem using a new arch CONFIG.

Free pages in the cache are kept track of in per-node list inside a
list_lru. NUMA_NO_NODE requests are serviced by checking each per-node
list in a round robin fashion. If pages are requested for a certain node
but the cache is empty for that node, a whole additional huge page size
page is allocated.

When replenishing the cache, use a specific GFP flag that matches the
intended user of this vm_flag (module_alloc()). In the case of the vm
and GFP flags mismatching, fail the page allocation. In the case of a
huge page size page not being available, fallback to the normal page
allocator logic and use non-grouped pages.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/Kconfig        |   1 +
 include/linux/vmalloc.h |   1 +
 mm/Kconfig              |   9 ++
 mm/vmalloc.c            | 215 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 215 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..c0dafa7e6e73 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -80,6 +80,7 @@ config X86
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_HPAGE_DIRECT_MAP_PERMS  if !HIGHMEM
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index cedcda6593f6..6a27af32f3a1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -26,6 +26,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
+#define VM_GROUP_PAGES		0x00000400	/* try to group the pages on the direct map */
 
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
diff --git a/mm/Kconfig b/mm/Kconfig
index f730605b8dcf..ecb04d9b6227 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -869,6 +869,15 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+#
+# Select if arch tries to preserve large pages on the direct map while also
+# setting permissions on the direct map. When set, generic mm code will make
+# an effort to centralize the breakage of the direct map that results from
+# setting kernel memory permissions.
+#
+config ARCH_HAS_HPAGE_DIRECT_MAP_PERMS
+	bool
+
 config MAPPING_DIRTY_HELPERS
         bool
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e6f352bf0498..d478dccda3a7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2194,6 +2194,203 @@ struct vm_struct *remove_vm_area(const void *addr)
 	return NULL;
 }
 
+static struct page *__vm_alloc_page_order(int node, gfp_t gfp_mask, int order)
+{
+	if (node == NUMA_NO_NODE)
+		return alloc_pages(gfp_mask, order);
+
+	return alloc_pages_node(node, gfp_mask, order);
+}
+
+#ifdef CONFIG_ARCH_HAS_HPAGE_DIRECT_MAP_PERMS
+#define GFP_GROUPED (__GFP_NOWARN | __GFP_HIGHMEM | GFP_KERNEL)
+
+/*
+ * The list_lru contains per-node lists of the cache of grouped pages. Huge
+ * page size blocks of pages are added whenever a request cannot be fulfilled
+ * by pages in the cache. For NUMA_NO_NODE, nid_round_robin is used as the
+ * start of a search through each node looking for a page. The shrinker will
+ * lock the per-node list.
+ */
+static struct list_lru grouped_pages_lru;
+static bool grouped_page_en;
+static atomic_t nid_round_robin;
+
+static unsigned long grouped_shrink_count(struct shrinker *shrinker,
+					  struct shrink_control *sc)
+{
+	unsigned long page_cnt = list_lru_shrink_count(&grouped_pages_lru, sc);
+
+	return page_cnt ? page_cnt : SHRINK_EMPTY;
+}
+
+static enum lru_status grouped_isolate(struct list_head *item,
+				       struct list_lru_one *list,
+				       spinlock_t *lock, void *cb_arg)
+{
+	struct list_head *dispose = cb_arg;
+
+	list_lru_isolate_move(list, item, dispose);
+
+	return LRU_REMOVED;
+}
+
+static void __dispose_pages(struct list_head *head)
+{
+	struct list_head *cur, *next;
+
+	list_for_each_safe(cur, next, head) {
+		list_del(cur);
+
+		/* The list head is stored at the start of the page */
+		free_page((unsigned long)cur);
+	}
+}
+
+static unsigned long grouped_shrink_scan(struct shrinker *shrinker,
+					 struct shrink_control *sc)
+{
+	unsigned long isolated;
+	LIST_HEAD(freeable);
+
+	if (!(sc->gfp_mask & GFP_GROUPED))
+		return SHRINK_STOP;
+
+	isolated = list_lru_shrink_walk(&grouped_pages_lru, sc, grouped_isolate,
+					&freeable);
+	__dispose_pages(&freeable);
+
+	/* Every item walked gets isolated */
+	sc->nr_scanned += isolated;
+
+	return isolated;
+}
+
+static struct shrinker grouped_page_shrinker = {
+	.count_objects = grouped_shrink_count,
+	.scan_objects = grouped_shrink_scan,
+	.seeks = DEFAULT_SEEKS,
+	.flags = SHRINKER_NUMA_AWARE
+};
+
+static int __init grouped_page_init(void)
+{
+	if (list_lru_init(&grouped_pages_lru))
+		goto out;
+
+	grouped_page_en = !register_shrinker(&grouped_page_shrinker);
+	if (!grouped_page_en)
+		list_lru_destroy(&grouped_pages_lru);
+
+out:
+	return !grouped_page_en;
+}
+
+device_initcall(grouped_page_init);
+
+static struct page *__remove_first_page(int node)
+{
+	unsigned int start_nid, i;
+	struct list_head *head;
+
+	if (node != NUMA_NO_NODE) {
+		head = list_lru_get_mru(&grouped_pages_lru, node);
+		if (head)
+			return virt_to_page(head);
+		return NULL;
+	}
+
+	/* If NUMA_NO_NODE, search the nodes in round robin for a page */
+	start_nid = (unsigned int)atomic_fetch_inc(&nid_round_robin) % nr_node_ids;
+	for (i = 0; i < nr_node_ids; i++) {
+		int cur_nid = (start_nid + i) % nr_node_ids;
+
+		head = list_lru_get_mru(&grouped_pages_lru, cur_nid);
+		if (head)
+			return virt_to_page(head);
+	}
+
+	return NULL;
+}
+
+static inline bool vmalloc_grouped_page_enabled(unsigned long vm_flags)
+{
+	return grouped_page_en && vm_flags & VM_GROUP_PAGES;
+}
+
+/* Return a page to the cache used by VM_GROUP_PAGES */
+static void __free_grouped_page(struct page *page)
+{
+	struct list_head *item;
+
+	item = (struct list_head *)page_address(page);
+	INIT_LIST_HEAD(item);
+	list_lru_add(&grouped_pages_lru, item);
+}
+
+/* Get and add some new pages to the cache to be used by VM_GROUP_PAGES */
+static struct page *__replenish_grouped_pages(int node)
+{
+	const unsigned int hpage_cnt = HPAGE_SIZE >> PAGE_SHIFT;
+	struct page *page;
+	int i;
+
+	page = __vm_alloc_page_order(node, GFP_GROUPED, HUGETLB_PAGE_ORDER);
+	if (!page)
+		return __vm_alloc_page_order(node, GFP_GROUPED, 0);
+
+	split_page(page, HUGETLB_PAGE_ORDER);
+
+	for (i = 1; i < hpage_cnt; i++)
+		__free_grouped_page(&page[i]);
+
+	return &page[0];
+}
+
+/* Get a page from the cache for VM_GROUP_PAGES */
+static struct page *__get_grouped_page(int node, gfp_t gfp_mask)
+{
+	struct page *page;
+
+	if (gfp_mask != GFP_GROUPED) {
+		WARN(1, "Unsupported GFP flags for VM_GROUP_PAGES\n");
+		return NULL;
+	}
+
+	page = __remove_first_page(node);
+
+	if (page)
+		return page;
+
+	return __replenish_grouped_pages(node);
+}
+#else /* CONFIG_ARCH_HAS_HPAGE_DIRECT_MAP_PERMS */
+static inline bool vmalloc_grouped_page_enabled(unsigned long vm_flags)
+{
+	return false;
+}
+
+extern void __free_grouped_page(struct page *page);
+extern struct page *__get_grouped_page(int node, gfp_t gfp_mask);
+#endif /* CONFIG_ARCH_HAS_HPAGE_DIRECT_MAP_PERMS */
+
+static struct page *vm_alloc_page(int node, unsigned long vm_flags,
+				  gfp_t gfp_mask)
+{
+	if (vmalloc_grouped_page_enabled(vm_flags))
+		return __get_grouped_page(node, gfp_mask);
+
+	return __vm_alloc_page_order(node, gfp_mask, 0);
+}
+
+static void vm_free_page(struct page *page, unsigned long vm_flags)
+{
+	if (vmalloc_grouped_page_enabled(vm_flags))
+		__free_grouped_page(page);
+	else
+		__free_pages(page, 0);
+}
+
 static inline void set_area_direct_map(const struct vm_struct *area,
 				       int (*set_direct_map)(struct page *page))
 {
@@ -2283,7 +2480,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			__free_pages(page, 0);
+			vm_free_page(page, area->flags);
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2474,7 +2671,7 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node)
+				 pgprot_t prot, int node, unsigned long vm_flags)
 {
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
 	unsigned int nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
@@ -2504,12 +2701,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	area->nr_pages = nr_pages;
 
 	for (i = 0; i < area->nr_pages; i++) {
-		struct page *page;
-
-		if (node == NUMA_NO_NODE)
-			page = alloc_page(gfp_mask);
-		else
-			page = alloc_pages_node(node, gfp_mask, 0);
+		struct page *page = vm_alloc_page(node, vm_flags, gfp_mask);
 
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vfree() */
@@ -2560,6 +2752,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller)
 {
+	unsigned long flags = VM_ALLOC | VM_UNINITIALIZED | vm_flags;
 	struct vm_struct *area;
 	void *addr;
 	unsigned long real_size = size;
@@ -2568,12 +2761,12 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
 
-	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
-				vm_flags, start, end, node, gfp_mask, caller);
+	area = __get_vm_area_node(real_size, align, flags, start, end, node,
+				  gfp_mask, caller);
 	if (!area)
 		goto fail;
 
-	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
+	addr = __vmalloc_area_node(area, gfp_mask, prot, node, flags);
 	if (!addr)
 		return NULL;
 
-- 
2.29.2

