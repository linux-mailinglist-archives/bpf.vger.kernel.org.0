Return-Path: <bpf+bounces-29221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B88C14B4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277A01C21C93
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A807711B;
	Thu,  9 May 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="jHu6QDOq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A376C2ED;
	Thu,  9 May 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279179; cv=none; b=lgcV9/rayqVYASPq3ABT0NOQMQ0wh1O7xKve+3EjYA4Z6iEZfKaNm6lVRFzfKiluLl0jE6quM2CGvi9GjHJ4BQee/alQ5joweMmtYpcLvkWkBTPDl1SWgmV6x1AMeY0kvIYIghfDCoEQtOfSkgPTBKT+Vmc0ZEKyW+idWacFJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279179; c=relaxed/simple;
	bh=wAQcWYsJOFR+kundrOt659FzABVA4jQ/UPDOmK62pIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WrItscaIV1klwnzhq41QA5XxMWwV+/ZmoIad6+ShWp+Vm9/Bu45Uv8URT+VkFv0o7Sm8jeB5PCDlX8mFwatN1LoJhTIYy/Ef1/WcrpuYfITw7mFBltsNW3wJeDfyTqbjTjA61u07MlJ3LTSPU3PQDr4LFjQEyE83ay4frh64cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=jHu6QDOq; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449FFD4D005792;
	Thu, 9 May 2024 18:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:mime-version:content-type; s=
	DKIM202306; bh=QYFSwVT9FotsoowxBWBhbfTTKyNgUdIZZSjzdmDwwjY=; b=j
	Hu6QDOqw/LAmfnCya5SbatYj5JFafZLyKwzRFmOzZteElPPKdDXiij3uwSM7xhAI
	nvN5h6dGZgE5SHss330yY+BWPAVJxK4wcnjmkSBEtFFEUpsctqyD1cD9E39q1xGU
	hjN3Q8XVyCt0QRhfkEXsFf1yUXE73GDWF9RUVhdmRSQkva39JQKhRE8PL4ZBiB6E
	jaMkaGhRUa7RX+bCRDRqGml15yHmlM0UGHaJNBj/MJF9eYV7XhYxyTVO+7UY7JAA
	W4UXL2Hcjou7a7o9cr964hPkMyaVh+zAW+msH53uqKMouF2y54c+17h7zz1we4WP
	1h6Ene+EEhI8Ua0XSFHbA==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3y0q09jftx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 18:25:22 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4Vb0mx2qpszcCVx;
	Thu,  9 May 2024 18:25:21 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Vb0mw57fRz2VZ3B;
	Thu,  9 May 2024 18:25:20 +0000 (UTC)
Date: Thu, 9 May 2024 13:25:19 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH v5 1/2] mm: allow dynamic vmalloc range restrictions
Message-ID: <ozcyvkcdqhxhlg3sjz3s4odt7ejiwx2cctgb7sdx6jbardui37@al6uvt4yx5nt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: LKINdqq5dFBZb8tNq_0Ye_PQpCMqpRe_
X-Proofpoint-GUID: LKINdqq5dFBZb8tNq_0Ye_PQpCMqpRe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_10,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090128

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

Considering some alternatives, i.e. a large change to the vmalloc
infrastructure to provide true support for a module code dynamic
allocation region, this smaller vstart-based opt-in seems preferable.

These changes may need to wait/be rebased on Mike Rapoport's patches
at 20240505160628.2323363-11-rppt@kernel.org , but this version is
submitted to account for the justification for unrestricted BPF/kprobe
code allocations and squashes some bugs the last version created in the
bpf selftests.

Changes from v4:
20240423095843.446565600-1-mbland@motorola.com
- Fix the corruption because of backslash created by SMTP mailer
- Add config to permit the reduction of BPF memory to 128MB, i.e. fix
  issue with the arm64 side of this change implicitly breaking
  1636131046-5982-2-git-send-email-alan.maguire@oracle.com "128MB of
  JIT memory can be quickly exhausted"
- Expand modules_alloc region used on arm64 to support larger BPF
  allocations present in the selftests.

Changes from v3:
20240416122254.868007168-1-mbland@motorola.com
- Added callbacks into arch-specific code to dynamically partition
  red-black tree

(The freedom of architectures to determine vm area allocation was deemed
dangerous since there was no possibility of enforcing that areas were
correctly managed.)

Changes from v2:
20240220203256.31153-1-mbland@motorola.com
- No longer depends on reducing the size of the vmalloc region
- Attempted to implement change by allowing architectures to override
  most abstract public vmalloc interface

(Overrides on vmalloc methods were deemed undesirable.)

Changes from v1:
CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com
- Statically reduced the range of the vmalloc region to support
  parititoned code ranges

(The trade off between space reduction and security was deemed
unnecessary.)

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
Thanks again to the maintainers for their review, apologies for the
mailer and BPF selftest errors on the previous version. This version
will still be incompatible with BPF allocation limit stress tests, for
clear reasons. I plan to rebase this same exact code on top of Mike
Rapoport's recent patchset, but this version is compatible with the
current linus upstream.

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

base-commit: ee5b455b0adae9ecafb38b174c648c48f2a3c1a5
-- 
2.34.1


