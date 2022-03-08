Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAD4D2209
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350102AbiCHTyP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 8 Mar 2022 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350101AbiCHTyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 14:54:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FAD37BE6
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 11:53:13 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228Ioqv3027337
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 11:53:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3emr97s9ue-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 11:53:13 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 11:53:10 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 9C70D1D8EF47; Tue,  8 Mar 2022 11:53:04 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <edumazet@google.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next] bpf: select proper size for bpf_prog_pack
Date:   Tue, 8 Mar 2022 11:53:03 -0800
Message-ID: <20220308195303.556765-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NmtTZtf7G86JTQsry9q3PmG9krmuIK-r
X-Proofpoint-GUID: NmtTZtf7G86JTQsry9q3PmG9krmuIK-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using HPAGE_PMD_SIZE as the size for bpf_prog_pack is not ideal in some
cases. Specifically, for NUMA systems, __vmalloc_node_range requires
PMD_SIZE * num_online_nodes() to allocate huge pages. Also, if the system
does not support huge pages (i.e., with cmdline option nohugevmalloc), it
is better to use PAGE_SIZE packs.

Add logic to select proper size for bpf_prog_pack. This solution is not
ideal, as it makes assumption about the behavior of module_alloc and
__vmalloc_node_range. However, it appears to be the easiest solution as
it doesn't require changes in module_alloc and vmalloc code.

Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")
Signed-off-by: Song Liu <song@kernel.org>

---
Changes v1 => v2:
1. Fix case with first program > PAGE_SIZE. (Daniel)
2. Add Fixes tag.
3. Remove a inline to avoid netdev/source_inline error.
---
 kernel/bpf/core.c | 75 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ab630f773ec1..f039c1f7e5dd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -33,6 +33,7 @@
 #include <linux/extable.h>
 #include <linux/log2.h>
 #include <linux/bpf_verifier.h>
+#include <linux/nodemask.h>
 
 #include <asm/barrier.h>
 #include <asm/unaligned.h>
@@ -814,15 +815,9 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
  * allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
  * to host BPF programs.
  */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define BPF_PROG_PACK_SIZE	HPAGE_PMD_SIZE
-#else
-#define BPF_PROG_PACK_SIZE	PAGE_SIZE
-#endif
 #define BPF_PROG_CHUNK_SHIFT	6
 #define BPF_PROG_CHUNK_SIZE	(1 << BPF_PROG_CHUNK_SHIFT)
 #define BPF_PROG_CHUNK_MASK	(~(BPF_PROG_CHUNK_SIZE - 1))
-#define BPF_PROG_CHUNK_COUNT	(BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
 
 struct bpf_prog_pack {
 	struct list_head list;
@@ -830,30 +825,59 @@ struct bpf_prog_pack {
 	unsigned long bitmap[];
 };
 
-#define BPF_PROG_MAX_PACK_PROG_SIZE	BPF_PROG_PACK_SIZE
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
+static size_t bpf_prog_pack_size = -1;
+
+static int bpf_prog_chunk_count(void)
+{
+	WARN_ON_ONCE(bpf_prog_pack_size == -1);
+	return bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE;
+}
+
 static DEFINE_MUTEX(pack_mutex);
 static LIST_HEAD(pack_list);
 
+static size_t select_bpf_prog_pack_size(void)
+{
+	size_t size;
+	void *ptr;
+
+	size = PMD_SIZE * num_online_nodes() - 1;
+	ptr = module_alloc(size);
+
+	/* Test whether we can get huge pages. If not just use PAGE_SIZE
+	 * packs.
+	 */
+	if (!ptr || !is_vm_area_hugepages(ptr))
+		size = PAGE_SIZE;
+
+	vfree(ptr);
+	return size;
+}
+
 static struct bpf_prog_pack *alloc_new_pack(void)
 {
 	struct bpf_prog_pack *pack;
+	void *ptr;
 
-	pack = kzalloc(sizeof(*pack) + BITS_TO_BYTES(BPF_PROG_CHUNK_COUNT), GFP_KERNEL);
-	if (!pack)
+	ptr = module_alloc(bpf_prog_pack_size);
+	if (!ptr)
 		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
-	if (!pack->ptr) {
-		kfree(pack);
+
+	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(bpf_prog_chunk_count())),
+		       GFP_KERNEL);
+	if (!pack) {
+		vfree(ptr);
 		return NULL;
 	}
-	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
+	pack->ptr = ptr;
+	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
+	set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
 	return pack;
 }
 
@@ -864,7 +888,11 @@ static void *bpf_prog_pack_alloc(u32 size)
 	unsigned long pos;
 	void *ptr = NULL;
 
-	if (size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+	mutex_lock(&pack_mutex);
+	if (bpf_prog_pack_size == -1)
+		bpf_prog_pack_size = select_bpf_prog_pack_size();
+
+	if (size > bpf_prog_pack_size) {
 		size = round_up(size, PAGE_SIZE);
 		ptr = module_alloc(size);
 		if (ptr) {
@@ -872,13 +900,12 @@ static void *bpf_prog_pack_alloc(u32 size)
 			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
 			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
 		}
-		return ptr;
+		goto out;
 	}
-	mutex_lock(&pack_mutex);
 	list_for_each_entry(pack, &pack_list, list) {
-		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+		pos = bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
 						 nbits, 0);
-		if (pos < BPF_PROG_CHUNK_COUNT)
+		if (pos < bpf_prog_chunk_count())
 			goto found_free_area;
 	}
 
@@ -904,12 +931,12 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	unsigned long pos;
 	void *pack_ptr;
 
-	if (hdr->size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+	if (hdr->size > bpf_prog_pack_size) {
 		module_memfree(hdr);
 		return;
 	}
 
-	pack_ptr = (void *)((unsigned long)hdr & ~(BPF_PROG_PACK_SIZE - 1));
+	pack_ptr = (void *)((unsigned long)hdr & ~(bpf_prog_pack_size - 1));
 	mutex_lock(&pack_mutex);
 
 	list_for_each_entry(tmp, &pack_list, list) {
@@ -926,8 +953,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
 
 	bitmap_clear(pack->bitmap, pos, nbits);
-	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
-				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
+	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
+				       bpf_prog_chunk_count(), 0) == 0) {
 		list_del(&pack->list);
 		module_memfree(pack->ptr);
 		kfree(pack);
-- 
2.30.2

