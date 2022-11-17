Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9D62E5C4
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKQUXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Nov 2022 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiKQUXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:23:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC49F1F9DF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGgkjT013222
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kwqbnamy2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:23:41 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id D6423FF175D8; Thu, 17 Nov 2022 12:23:32 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 4/6] bpf: use execmem_alloc for bpf program and bpf dispatcher
Date:   Thu, 17 Nov 2022 12:23:20 -0800
Message-ID: <20221117202322.944661-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117202322.944661-1-song@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0tb4pBe5PnZ0dXmkZhbPCtGHX_EqlTZ0
X-Proofpoint-ORIG-GUID: 0tb4pBe5PnZ0dXmkZhbPCtGHX_EqlTZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use execmem_alloc, execmem_free, and execmem_fill instead of
bpf_prog_pack_alloc, bpf_prog_pack_free, and bpf_arch_text_copy.

execmem_free doesn't require extra size information. Therefore, the free
and error handling path can be simplified.

There are some tests that show the benefit of execmem_alloc.

Run 100 instances of the following benchmark from bpf selftests:
  tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
which loads 7 BPF programs, and triggers one of them.

Then use perf to monitor TLB related counters:
   perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
           itlb_misses.walk_completed_2m_4m -a

The following results are from a qemu VM with 32 cores.

Before bpf_prog_pack:
  iTLB-load-misses: 350k/s
  itlb_misses.walk_completed_4k: 90k/s
  itlb_misses.walk_completed_2m_4m: 0.1/s

With bpf_prog_pack (current upstream):
  iTLB-load-misses: 220k/s
  itlb_misses.walk_completed_4k: 68k/s
  itlb_misses.walk_completed_2m_4m: 0.2/s

With execmem_alloc (with this set):
  iTLB-load-misses: 185k/s
  itlb_misses.walk_completed_4k: 58k/s
  itlb_misses.walk_completed_2m_4m: 1/s

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c |  23 +----
 include/linux/bpf.h         |   3 -
 include/linux/filter.h      |   5 -
 kernel/bpf/core.c           | 180 +++---------------------------------
 kernel/bpf/dispatcher.c     |  11 +--
 5 files changed, 21 insertions(+), 201 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cec5195602bc..43b93570d8f9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -229,11 +229,6 @@ static void jit_fill_hole(void *area, unsigned int size)
 	memset(area, 0xcc, size);
 }
 
-int bpf_arch_text_invalidate(void *dst, size_t len)
-{
-	return IS_ERR_OR_NULL(text_poke_set(dst, 0xcc, len));
-}
-
 struct jit_context {
 	int cleanup_addr; /* Epilogue code offset */
 
@@ -2509,11 +2504,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
-			if (header) {
-				bpf_arch_text_copy(&header->size, &rw_header->size,
-						   sizeof(rw_header->size));
+			if (header)
 				bpf_jit_binary_pack_free(header, rw_header);
-			}
+
 			/* Fall back to interpreter mode */
 			prog = orig_prog;
 			if (extra_pass) {
@@ -2563,8 +2556,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		if (!prog->is_func || extra_pass) {
 			/*
 			 * bpf_jit_binary_pack_finalize fails in two scenarios:
-			 *   1) header is not pointing to proper module memory;
-			 *   2) the arch doesn't support bpf_arch_text_copy().
+			 *   1) header is not pointing to memory allocated by
+			 *      execmem_alloc;
+			 *   2) the arch doesn't support execmem_free().
 			 *
 			 * Both cases are serious bugs and justify WARN_ON.
 			 */
@@ -2610,13 +2604,6 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
-void *bpf_arch_text_copy(void *dst, void *src, size_t len)
-{
-	if (text_poke_copy(dst, src, len) == NULL)
-		return ERR_PTR(-EINVAL);
-	return dst;
-}
-
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54462dd28824..9018f4149310 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2733,9 +2733,6 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
-void *bpf_arch_text_copy(void *dst, void *src, size_t len);
-int bpf_arch_text_invalidate(void *dst, size_t len);
-
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index bf701976056e..4373ff388759 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1023,8 +1023,6 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
-void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
-
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -1037,9 +1035,6 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
-void bpf_prog_pack_free(struct bpf_binary_header *hdr);
-
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 {
 	return list_empty(&fp->aux->ksym.lnode) ||
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9c16338bcbe8..86b4f640e3c0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -806,149 +806,6 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 	return slot;
 }
 
-/*
- * BPF program pack allocator.
- *
- * Most BPF programs are pretty small. Allocating a hole page for each
- * program is sometime a waste. Many small bpf program also adds pressure
- * to instruction TLB. To solve this issue, we introduce a BPF program pack
- * allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
- * to host BPF programs.
- */
-#define BPF_PROG_CHUNK_SHIFT	6
-#define BPF_PROG_CHUNK_SIZE	(1 << BPF_PROG_CHUNK_SHIFT)
-#define BPF_PROG_CHUNK_MASK	(~(BPF_PROG_CHUNK_SIZE - 1))
-
-struct bpf_prog_pack {
-	struct list_head list;
-	void *ptr;
-	unsigned long bitmap[];
-};
-
-void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
-{
-	memset(area, 0, size);
-}
-
-#define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
-
-static DEFINE_MUTEX(pack_mutex);
-static LIST_HEAD(pack_list);
-
-/* PMD_SIZE is not available in some special config, e.g. ARCH=arm with
- * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
- */
-#ifdef PMD_SIZE
-#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
-#else
-#define BPF_PROG_PACK_SIZE PAGE_SIZE
-#endif
-
-#define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
-
-static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
-{
-	struct bpf_prog_pack *pack;
-
-	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
-		       GFP_KERNEL);
-	if (!pack)
-		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
-	if (!pack->ptr) {
-		kfree(pack);
-		return NULL;
-	}
-	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
-	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
-	list_add_tail(&pack->list, &pack_list);
-
-	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	return pack;
-}
-
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
-{
-	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
-	void *ptr = NULL;
-
-	mutex_lock(&pack_mutex);
-	if (size > BPF_PROG_PACK_SIZE) {
-		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
-		if (ptr) {
-			bpf_fill_ill_insns(ptr, size);
-			set_vm_flush_reset_perms(ptr);
-			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
-			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
-		}
-		goto out;
-	}
-	list_for_each_entry(pack, &pack_list, list) {
-		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
-						 nbits, 0);
-		if (pos < BPF_PROG_CHUNK_COUNT)
-			goto found_free_area;
-	}
-
-	pack = alloc_new_pack(bpf_fill_ill_insns);
-	if (!pack)
-		goto out;
-
-	pos = 0;
-
-found_free_area:
-	bitmap_set(pack->bitmap, pos, nbits);
-	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
-
-out:
-	mutex_unlock(&pack_mutex);
-	return ptr;
-}
-
-void bpf_prog_pack_free(struct bpf_binary_header *hdr)
-{
-	struct bpf_prog_pack *pack = NULL, *tmp;
-	unsigned int nbits;
-	unsigned long pos;
-
-	mutex_lock(&pack_mutex);
-	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		module_memfree(hdr);
-		goto out;
-	}
-
-	list_for_each_entry(tmp, &pack_list, list) {
-		if ((void *)hdr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (void *)hdr) {
-			pack = tmp;
-			break;
-		}
-	}
-
-	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
-		goto out;
-
-	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
-	pos = ((unsigned long)hdr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
-
-	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
-		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
-
-	bitmap_clear(pack->bitmap, pos, nbits);
-	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
-				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
-		list_del(&pack->list);
-		module_memfree(pack->ptr);
-		kfree(pack);
-	}
-out:
-	mutex_unlock(&pack_mutex);
-}
-
 static atomic_long_t bpf_jit_current;
 
 /* Can be overridden by an arch's JIT compiler if it has a custom,
@@ -1048,6 +905,9 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 	bpf_jit_uncharge_modmem(size);
 }
 
+#define BPF_PROG_EXEC_ALIGN	64
+#define BPF_PROG_EXEC_MASK	(~(BPF_PROG_EXEC_ALIGN - 1))
+
 /* Allocate jit binary from bpf_prog_pack allocator.
  * Since the allocated memory is RO+X, the JIT engine cannot write directly
  * to the memory. To solve this problem, a RW buffer is also allocated at
@@ -1070,11 +930,11 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 		     alignment > BPF_IMAGE_ALIGNMENT);
 
 	/* add 16 bytes for a random section of illegal instructions */
-	size = round_up(proglen + sizeof(*ro_header) + 16, BPF_PROG_CHUNK_SIZE);
+	size = round_up(proglen + sizeof(*ro_header) + 16, BPF_PROG_EXEC_ALIGN);
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	ro_header = execmem_alloc(size, BPF_PROG_EXEC_ALIGN);
 	if (!ro_header) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
@@ -1082,8 +942,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	*rw_header = kvmalloc(size, GFP_KERNEL);
 	if (!*rw_header) {
-		bpf_arch_text_copy(&ro_header->size, &size, sizeof(size));
-		bpf_prog_pack_free(ro_header);
+		execmem_free(ro_header);
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
 	}
@@ -1093,7 +952,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 	(*rw_header)->size = size;
 
 	hole = min_t(unsigned int, size - (proglen + sizeof(*ro_header)),
-		     BPF_PROG_CHUNK_SIZE - sizeof(*ro_header));
+		     BPF_PROG_EXEC_ALIGN - sizeof(*ro_header));
 	start = prandom_u32_max(hole) & ~(alignment - 1);
 
 	*image_ptr = &ro_header->image[start];
@@ -1109,12 +968,12 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
 {
 	void *ptr;
 
-	ptr = bpf_arch_text_copy(ro_header, rw_header, rw_header->size);
+	ptr = execmem_fill(ro_header, rw_header, rw_header->size);
 
 	kvfree(rw_header);
 
 	if (IS_ERR(ptr)) {
-		bpf_prog_pack_free(ro_header);
+		execmem_free(ro_header);
 		return PTR_ERR(ptr);
 	}
 	return 0;
@@ -1124,18 +983,13 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
  *   1) when the program is freed after;
  *   2) when the JIT engine fails (before bpf_jit_binary_pack_finalize).
  * For case 2), we need to free both the RO memory and the RW buffer.
- *
- * bpf_jit_binary_pack_free requires proper ro_header->size. However,
- * bpf_jit_binary_pack_alloc does not set it. Therefore, ro_header->size
- * must be set with either bpf_jit_binary_pack_finalize (normal path) or
- * bpf_arch_text_copy (when jit fails).
  */
 void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 			      struct bpf_binary_header *rw_header)
 {
-	u32 size = ro_header->size;
+	u32 size = rw_header ? rw_header->size : ro_header->size;
 
-	bpf_prog_pack_free(ro_header);
+	execmem_free(ro_header);
 	kvfree(rw_header);
 	bpf_jit_uncharge_modmem(size);
 }
@@ -1146,7 +1000,7 @@ bpf_jit_binary_pack_hdr(const struct bpf_prog *fp)
 	unsigned long real_start = (unsigned long)fp->bpf_func;
 	unsigned long addr;
 
-	addr = real_start & BPF_PROG_CHUNK_MASK;
+	addr = real_start & BPF_PROG_EXEC_MASK;
 	return (void *)addr;
 }
 
@@ -2736,16 +2590,6 @@ int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return -ENOTSUPP;
 }
 
-void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
-{
-	return ERR_PTR(-ENOTSUPP);
-}
-
-int __weak bpf_arch_text_invalidate(void *dst, size_t len)
-{
-	return -ENOTSUPP;
-}
-
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 04f0a045dcaa..c41dff3379db 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -126,11 +126,11 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 	tmp = d->num_progs ? d->rw_image + noff : NULL;
 	if (new) {
 		/* Prepare the dispatcher in d->rw_image. Then use
-		 * bpf_arch_text_copy to update d->image, which is RO+X.
+		 * execmem_fill to update d->image, which is RO+X.
 		 */
 		if (bpf_dispatcher_prepare(d, new, tmp))
 			return;
-		if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)))
+		if (IS_ERR(execmem_fill(new, tmp, PAGE_SIZE / 2)))
 			return;
 	}
 
@@ -152,15 +152,12 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 
 	mutex_lock(&d->mutex);
 	if (!d->image) {
-		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero);
+		d->image = execmem_alloc(PAGE_SIZE, PAGE_SIZE /* align */);
 		if (!d->image)
 			goto out;
 		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
 		if (!d->rw_image) {
-			u32 size = PAGE_SIZE;
-
-			bpf_arch_text_copy(d->image, &size, sizeof(size));
-			bpf_prog_pack_free((struct bpf_binary_header *)d->image);
+			execmem_free((struct bpf_binary_header *)d->image);
 			d->image = NULL;
 			goto out;
 		}
-- 
2.30.2

