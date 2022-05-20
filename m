Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7252E306
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 05:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiETDS4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 19 May 2022 23:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbiETDSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 23:18:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC0062BE3
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24JKmXCl032187
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:53 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g5h5d6vrr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:52 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 20:18:50 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 2C0A27D8C2F7; Thu, 19 May 2022 20:16:05 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for bpf_prog_pack
Date:   Thu, 19 May 2022 20:15:45 -0700
Message-ID: <20220520031548.338934-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520031548.338934-1-song@kernel.org>
References: <20220520031548.338934-1-song@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8yUOQx5CaYt6h08goPeYw1sHxUZOsjOk
X-Proofpoint-ORIG-GUID: 8yUOQx5CaYt6h08goPeYw1sHxUZOsjOk
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_01,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use module_alloc_huge for bpf_prog_pack so that BPF programs sit on
PMD_SIZE pages. This benefits system performance by reducing iTLB miss
rate. Benchmark of a real web service workload shows this change gives
another ~0.2% performance boost on top of PAGE_SIZE bpf_prog_pack
(which improve system throughput by ~0.5%).

Also, remove set_vm_flush_reset_perms() from alloc_new_pack() and use
set_memory_[nx|rw] in bpf_prog_pack_free(). This is because
VM_FLUSH_RESET_PERMS does not work with huge pages yet. [1]

[1] https://lore.kernel.org/bpf/aeeeaf0b7ec63fdba55d4834d2f524d8bf05b71b.camel@intel.com/
Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cacd8684c3c4..b64d91fcb0ba 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -857,7 +857,7 @@ static size_t select_bpf_prog_pack_size(void)
 	void *ptr;
 
 	size = BPF_HPAGE_SIZE * num_online_nodes();
-	ptr = module_alloc(size);
+	ptr = module_alloc_huge(size);
 
 	/* Test whether we can get huge pages. If not just use PAGE_SIZE
 	 * packs.
@@ -881,7 +881,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(bpf_prog_pack_size);
+	pack->ptr = module_alloc_huge(bpf_prog_pack_size);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
@@ -890,7 +890,6 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
-	set_vm_flush_reset_perms(pack->ptr);
 	set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
 	set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
 	return pack;
@@ -909,10 +908,9 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
 
 	if (size > bpf_prog_pack_size) {
 		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
+		ptr = module_alloc_huge(size);
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
-			set_vm_flush_reset_perms(ptr);
 			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
 			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
 		}
@@ -949,6 +947,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 
 	mutex_lock(&pack_mutex);
 	if (hdr->size > bpf_prog_pack_size) {
+		set_memory_nx((unsigned long)hdr, hdr->size / PAGE_SIZE);
+		set_memory_rw((unsigned long)hdr, hdr->size / PAGE_SIZE);
 		module_memfree(hdr);
 		goto out;
 	}
@@ -975,6 +975,8 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
 				       bpf_prog_chunk_count(), 0) == 0) {
 		list_del(&pack->list);
+		set_memory_nx((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
+		set_memory_rw((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
 		module_memfree(pack->ptr);
 		kfree(pack);
 	}
-- 
2.30.2

