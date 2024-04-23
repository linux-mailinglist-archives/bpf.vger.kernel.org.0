Return-Path: <bpf+bounces-27558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD58AEA05
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72536282441
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64C13B7AB;
	Tue, 23 Apr 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="HcNhI9ti"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37037144;
	Tue, 23 Apr 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884488; cv=none; b=RkRHtXkeMRFUYxBAUOA4o90VMrN64Wq/ECmRcF0rEx9yVWVsyOg4eJor9aEc+Yz1/Dyds4rcfOcgcc2I24RuZtAtVY5zBhwSQOfF5YZa6iKPcXXM1+oGA/uYYOWJ2eC5WsqdAE9ZyUgRlrG0ULRCm+Rz4k+2gVPY+JQJb9w8C0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884488; c=relaxed/simple;
	bh=iL6oPpd1OAOThM11i+/97Cg1bIY9o/LEyO7E8TON+Ds=;
	h=Message-Id:To:Cc:Date:From; b=dVUKSipZcc75kqE1gCGTBzuktKQzT9ch/OPG8ljXxJZIbMbEd0FuacxRVXGci0/BtrEWn76KHT9WKWgQtx+tbk6D32uh/+dIvRAYLlC9/yM4ydsU5frJJusm2erWzlqBikv13uzfBC/obCXKDgUh1m9Xo5CXw+MMQj2eKYdlvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=fail (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=HcNhI9ti reason="signature verification failed"; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N9JGBf017992;
	Tue, 23 Apr 2024 15:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:to:cc:date:from; s=DKIM202306; bh=9qq1nXJw/h3GRRXj78u
	DbU6YdBzkk0R7hHun/H4SGtc=; b=HcNhI9ti7yiu2m3WlOh7CTjmdH47vT5MF73
	lbIPllq028P9M+HjSOxMPySEG8X9UJntgxtwp1I1N1NNxe/1rg/Md8RE0TLqOKWa
	Ha9/eKCJ/O+erbvMuJXuY5l3xsr5vcUL3f1/taENW89F2MgyzsP1bHyUJHRfwAOd
	fh+9GSLM/PWNhyt/yqLFmiES/m9p15Bk08r6962QKDSKVdOe9DliDGSGDZxo0qNF
	f8SbDB6r9UNGytHn0p501YiGH8r9eOrw4NA2VnBOO8r/2M/pwICeowUjhyA5xVq8
	iBcdDgnADfABhj/a0Kh/Q1ssA7/e3i4RJbJ2bKsFq6s3VKmFKmQ==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xnu55a6m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 15:00:18 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4VP4zh5KzTzfBb2;
	Tue, 23 Apr 2024 15:00:16 +0000 (UTC)
Received: from ilclasset02.mot.com (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VP4zh55dTz3p6jp;
	Tue, 23 Apr 2024 15:00:16 +0000 (UTC)
Message-Id: <20240423095843.446565600-1-mbland@motorola.com>
To: linux-mm@kvack.org
Cc: "Maxwell Bland <mbland@motorola.com>
	Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Maxwell Bland <mbland@motorola.com>,
        Russell King <linux@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>,
        Ryo Takakura <takakura@valinux.co.jp>,
        James Morse <james.morse@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Date: Tue, 23 Apr 2024 15:00:16 +0000 (UTC)
From: mbland@motorola.com
X-Proofpoint-ORIG-GUID: JfbiOwgw0di6fOZEf4T-CjXDvCoa9N8_
X-Proofpoint-GUID: JfbiOwgw0di6fOZEf4T-CjXDvCoa9N8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230036
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From aef33d1682400c55a1634de8ab44b7a77a776900 Mon Sep 17 00:00:00 2001
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 23 Apr 2024 09:58:43 -0500
Subject: [PATCH v4 1/2] mm: allow dynamic vmalloc range restrictions

Add an API to the vmalloc infrastructure, create_vmalloc_range_check,
which allows for the creation of restricted sub-ranges of vmalloc memory
during the init process, which can only be allocated from via vmalloc
requests with vaddr start addresses explicitly matching the range's
start addresses. Calls to this API can split up to two nodes in the
red-black tree.

create_vmalloc_range_check restricts vmalloc requests not matching the
range's start address to all other locations in the standard vmalloc
range, i.e. users of the interface are responsible for requesting only
correct and appropriate reservations. The primary intention of this API
is supporting ASLR module region allocation regions while not
undermining existing security mechanisms by necessitating interleaved
code and data pages.

To perform range allocation at the appropriate, earliest time, provide a
callback arch_init_checked_vmap_ranges rather than maintaining a linked
list outside of the vmalloc infrastructure, ensuring all vmap management
is still owned by vmalloc.c.

v3: 20240416122254.868007168-1-mbland@motorola.com
- Added callbacks into arch-specific code to dynamically partition
  red-black tree

(The freedom of architectures to determine vm area allocation was deemed
dangerous since there was no possibility of enforcing that areas were
correctly managed.)

v2: 20240220203256.31153-1-mbland@motorola.com
- No longer depends on reducing the size of the vmalloc region
- Attempted to implement change by allowing architectures to override
  most abstract public vmalloc interface

(Overrides on vmalloc methods were deemed undesirable.)

v1: CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com
- Statically reduced the range of the vmalloc region to support
  parititoned code ranges

(The trade off between space reduction and security was deemed
unnecessary.)

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
Hello,

Thank you again to all the maintainers for prior and current reviews of
this patch. The below approach is more pristine and fixes the additional
issues Uladzislau raised last Tuesday.

I have decided to break down the prior patchset into 3-5 parts since the
affected maintainers list is large and the affected portions of the code
are large and discrete.

Regards,
Maxwell Bland

P.S. Clarifying a few technical details from prior reviews:

- Dynamic restricted ranges are adopted in favor over strict (linear)
partitioning, as just restricting vmalloc ranges creates unfavorable and
unnecessary trade-offs between vmalloc region size and security, for
example, ASLR randomization entropy. Restricted ranges are also adopted
in favor over interleaving code and data pages, which prevents an entire
field of work and kernel improvements based on the enforcment of
PMD-level-and-coarser sized code protections or optimizations (e.g.
arm64's PXNTable) dynamically.
- Preventing code and data page interleaving simplifies code focused on
preventing malicious page table updates since we do not need to track
all updates of PTE level descriptors. Many present exploits which
generate write gadgets to kernel data via use-after-free (UAF) and
heap-spray attacks target PTE descriptors to modify the permissions on
critical memory regions. If PTEs are non-interleaved, executable regions
can be marked immutable when outside of specialized code allocation
systems, e.g. BPF's JIT, and data regions can be entirely restricted
from privileged executability at the PMD level.

 include/linux/vmalloc.h |  14 ++++++
 mm/vmalloc.c            | 102 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 98ea90e90439..ece8879ab060 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -81,6 +81,12 @@ struct vmap_area {
 	unsigned long flags; /* mark type of vm_map_ram area */
 };
 
+struct checked_vmap_range {
+	unsigned long va_start;
+	unsigned long va_end;
+	struct list_head list;
+};
+
 /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
 #ifndef arch_vmap_p4d_supported
 static inline bool arch_vmap_p4d_supported(pgprot_t prot)
@@ -125,6 +131,12 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
 }
 #endif
 
+#ifndef arch_init_checked_vmap_ranges
+inline void __init arch_init_checked_vmap_ranges(void)
+{
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
@@ -211,6 +223,8 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
 					const void *caller);
+int __init create_vmalloc_range_check(unsigned long start_vaddr,
+					unsigned long end_vaddr);
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68fa001648cc..8f382b6c31de 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -817,6 +817,16 @@ static struct kmem_cache *vmap_area_cachep;
  */
 static LIST_HEAD(free_vmap_area_list);
 
+static struct kmem_cache *vmap_checked_range_cachep;
+
+/*
+ * This linked list is used to record ranges of the vmalloc
+ * region which are checked at allocation time to ensure they
+ * are only allocated within when an explicit allocation
+ * request to that range is made.
+ */
+static LIST_HEAD(checked_range_list);
+
 /*
  * This augment red-black tree represents the free vmap space.
  * All vmap_area objects in this tree are sorted by va->va_start
@@ -1454,6 +1464,23 @@ merge_or_add_vmap_area_augment(struct vmap_area *va,
 	return va;
 }
 
+static __always_inline bool
+va_is_range_restricted(struct vmap_area *va, unsigned long vstart)
+{
+	struct checked_vmap_range *range, *tmp;
+
+	if (list_empty(&checked_range_list))
+		return false;
+
+	list_for_each_entry_safe(range, tmp, &checked_range_list, list)
+		if (va->va_start >= range->va_start &&
+		    va->va_end <= range->va_end &&
+		    vstart != range->va_start)
+			return true;
+
+	return false;
+}
+
 static __always_inline bool
 is_within_this_va(struct vmap_area *va, unsigned long size,
 	unsigned long align, unsigned long vstart)
@@ -1501,7 +1528,8 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
 				vstart < va->va_start) {
 			node = node->rb_left;
 		} else {
-			if (is_within_this_va(va, size, align, vstart))
+			if (!va_is_range_restricted(va, vstart) &&
+			    is_within_this_va(va, size, align, vstart))
 				return va;
 
 			/*
@@ -1522,7 +1550,8 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
 			 */
 			while ((node = rb_parent(node))) {
 				va = rb_entry(node, struct vmap_area, rb_node);
-				if (is_within_this_va(va, size, align, vstart))
+				if (!va_is_range_restricted(va, vstart) &&
+				    is_within_this_va(va, size, align, vstart))
 					return va;
 
 				if (get_subtree_max_size(node->rb_right) >= length &&
@@ -1554,7 +1583,8 @@ find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
 	struct vmap_area *va;
 
 	list_for_each_entry(va, head, list) {
-		if (!is_within_this_va(va, size, align, vstart))
+		if (va_is_range_restricted(va, vstart) ||
+		    !is_within_this_va(va, size, align, vstart))
 			continue;
 
 		return va;
@@ -1717,6 +1747,36 @@ va_clip(struct rb_root *root, struct list_head *head,
 	return 0;
 }
 
+static inline int
+split_and_alloc_va(struct rb_root *root, struct list_head *head, unsigned long addr)
+{
+	struct vmap_area *va;
+	int ret;
+	struct vmap_area *lva = NULL;
+
+	va = __find_vmap_area(addr, root);
+	if (!va) {
+		pr_err("%s: could not find vmap\n", __func__);
+		return -1;
+	}
+
+	lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
+	if (!lva) {
+		pr_err("%s: unable to allocate va for range\n", __func__);
+		return -1;
+	}
+	lva->va_start = addr;
+	lva->va_end = va->va_end;
+	ret = va_clip(root, head, va, addr, va->va_end - addr);
+	if (WARN_ON_ONCE(ret)) {
+		pr_err("%s: unable to clip code base region\n", __func__);
+		kmem_cache_free(vmap_area_cachep, lva);
+		return -1;
+	}
+	insert_vmap_area_augment(lva, NULL, root, head);
+	return 0;
+}
+
 static unsigned long
 va_alloc(struct vmap_area *va,
 		struct rb_root *root, struct list_head *head,
@@ -4424,6 +4484,35 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
+/**
+ * create_vmalloc_range_check - create a checked range of vmalloc memory
+ * @start_vaddr:	The starting vaddr of the code range
+ * @end_vaddr:		The ending vaddr of the code range
+ *
+ * Returns:	0 for success, -1 on failure
+ *
+ * This function marks regions within or overlapping the vmalloc region for
+ * requested range checking during allocation. When requesting virtual memory,
+ * if the requested starting vaddr does not explicitly match the starting vaddr
+ * of this range, this range will not be allocated from.
+ */
+int __init create_vmalloc_range_check(unsigned long start_vaddr,
+					unsigned long end_vaddr)
+{
+	struct checked_vmap_range *range;
+
+	range = kmem_cache_alloc(vmap_checked_range_cachep, GFP_NOWAIT);
+	if (split_and_alloc_va(&free_vmap_area_root, &free_vmap_area_list, start_vaddr) ||
+	    split_and_alloc_va(&free_vmap_area_root, &free_vmap_area_list, end_vaddr))
+		return -1;
+
+	range->va_start = start_vaddr;
+	range->va_end = end_vaddr;
+
+	list_add(&range->list, &checked_range_list);
+	return 0;
+}
+
 void free_vm_area(struct vm_struct *area)
 {
 	struct vm_struct *ret;
@@ -5082,6 +5171,11 @@ void __init vmalloc_init(void)
 	 */
 	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
 
+	/*
+	 * Create the cache for checked vmap ranges.
+	 */
+	vmap_checked_range_cachep = KMEM_CACHE(checked_vmap_range, SLAB_PANIC);
+
 	for_each_possible_cpu(i) {
 		struct vmap_block_queue *vbq;
 		struct vfree_deferred *p;
@@ -5129,4 +5223,6 @@ void __init vmalloc_init(void)
 	vmap_node_shrinker->count_objects = vmap_node_shrink_count;
 	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
 	shrinker_register(vmap_node_shrinker);
+
+	arch_init_checked_vmap_ranges();
 }

base-commit: 71b1543c83d65af8215d7558d70fc2ecbee77dcf
-- 
2.34.1


