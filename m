Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46458573E26
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiGMUuC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 13 Jul 2022 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiGMUuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:50:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761E2B61C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:50:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DICj4v017663
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:50:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5hptp0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:49:59 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 13:49:58 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id BDE92A19EBB5; Wed, 13 Jul 2022 13:49:56 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <kernel-team@fb.com>, <ast@kernel.org>,
        <andrii@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: simplify bpf_prog_pack_[size|mask]
Date:   Wed, 13 Jul 2022 13:49:50 -0700
Message-ID: <20220713204950.3015201-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B7CYj9BCuKROs0My_bAM8PHZ-HBXvLJE
X-Proofpoint-GUID: B7CYj9BCuKROs0My_bAM8PHZ-HBXvLJE
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_11,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify the logic that selects bpf_prog_pack_size, and always use
(PMD_SIZE * num_possible_nodes()). This is a good tradeoff, as most of the
performance benefit observed is from less direct map fragmentation [1].

Also, module_alloc(4MB) may not allocate 4MB aligned memory. Therefore, we
cannot use (ptr & bpf_prog_pack_mask) to find the correct address of
bpf_prog_pack. Fix this by checking the header address falls in the range
of pack->ptr and (pack->ptr + bpf_prog_pack_size).

[1] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 71 ++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cfb8a50a9f12..72d0721318e1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -825,15 +825,6 @@ struct bpf_prog_pack {
 
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
-static size_t bpf_prog_pack_size = -1;
-static size_t bpf_prog_pack_mask = -1;
-
-static int bpf_prog_chunk_count(void)
-{
-	WARN_ON_ONCE(bpf_prog_pack_size == -1);
-	return bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE;
-}
-
 static DEFINE_MUTEX(pack_mutex);
 static LIST_HEAD(pack_list);
 
@@ -841,55 +832,33 @@ static LIST_HEAD(pack_list);
  * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
  */
 #ifdef PMD_SIZE
-#define BPF_HPAGE_SIZE PMD_SIZE
-#define BPF_HPAGE_MASK PMD_MASK
+#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
 #else
-#define BPF_HPAGE_SIZE PAGE_SIZE
-#define BPF_HPAGE_MASK PAGE_MASK
+#define BPF_PROG_PACK_SIZE PAGE_SIZE
 #endif
 
-static size_t select_bpf_prog_pack_size(void)
-{
-	size_t size;
-	void *ptr;
-
-	size = BPF_HPAGE_SIZE * num_online_nodes();
-	ptr = module_alloc(size);
-
-	/* Test whether we can get huge pages. If not just use PAGE_SIZE
-	 * packs.
-	 */
-	if (!ptr || !is_vm_area_hugepages(ptr)) {
-		size = PAGE_SIZE;
-		bpf_prog_pack_mask = PAGE_MASK;
-	} else {
-		bpf_prog_pack_mask = BPF_HPAGE_MASK;
-	}
-
-	vfree(ptr);
-	return size;
-}
+#define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
 
 static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
 
-	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(bpf_prog_chunk_count())),
+	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(bpf_prog_pack_size);
+	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
 	}
-	bpf_fill_ill_insns(pack->ptr, bpf_prog_pack_size);
-	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
+	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
+	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
-	set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
+	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	return pack;
 }
 
@@ -901,10 +870,7 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
-	if (bpf_prog_pack_size == -1)
-		bpf_prog_pack_size = select_bpf_prog_pack_size();
-
-	if (size > bpf_prog_pack_size) {
+	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
 		ptr = module_alloc(size);
 		if (ptr) {
@@ -916,9 +882,9 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
 		goto out;
 	}
 	list_for_each_entry(pack, &pack_list, list) {
-		pos = bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
+		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 						 nbits, 0);
-		if (pos < bpf_prog_chunk_count())
+		if (pos < BPF_PROG_CHUNK_COUNT)
 			goto found_free_area;
 	}
 
@@ -942,18 +908,15 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	struct bpf_prog_pack *pack = NULL, *tmp;
 	unsigned int nbits;
 	unsigned long pos;
-	void *pack_ptr;
 
 	mutex_lock(&pack_mutex);
-	if (hdr->size > bpf_prog_pack_size) {
+	if (hdr->size > BPF_PROG_PACK_SIZE) {
 		module_memfree(hdr);
 		goto out;
 	}
 
-	pack_ptr = (void *)((unsigned long)hdr & bpf_prog_pack_mask);
-
 	list_for_each_entry(tmp, &pack_list, list) {
-		if (tmp->ptr == pack_ptr) {
+		if ((void *)hdr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (void *)hdr) {
 			pack = tmp;
 			break;
 		}
@@ -963,14 +926,14 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 		goto out;
 
 	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
-	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
+	pos = ((unsigned long)hdr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
 
 	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
 
 	bitmap_clear(pack->bitmap, pos, nbits);
-	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
-				       bpf_prog_chunk_count(), 0) == 0) {
+	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);
 		module_memfree(pack->ptr);
 		kfree(pack);
-- 
2.30.2

