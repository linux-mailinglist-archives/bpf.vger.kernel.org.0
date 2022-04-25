Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1A50EAC4
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbiDYUq0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiDYUqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 16:46:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65BECCEC
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PIVi2F009635
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fp10e910a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 13:43:15 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 56C29652E7A1; Mon, 25 Apr 2022 13:40:35 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <hch@infradead.org>, <peterz@infradead.org>,
        <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf 1/3] bpf: fill new bpf_prog_pack with illegal instructions
Date:   Mon, 25 Apr 2022 13:39:45 -0700
Message-ID: <20220425203947.3311308-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425203947.3311308-1-song@kernel.org>
References: <20220425203947.3311308-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MNLorSazeK9Ou72qR_BHSDuX1mCNhyxQ
X-Proofpoint-ORIG-GUID: MNLorSazeK9Ou72qR_BHSDuX1mCNhyxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_pack enables sharing huge pages among multiple BPF programs.
These pages are marked as executable before the JIT engine fill it with
BPF programs. To make these pages safe, fill the hole bpf_prog_pack with
illegal instructions before making it executable.

Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")
Fixes: 33c9805860e5 ("bpf: Introduce bpf_jit_binary_pack_[alloc|finalize|free]")
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 13e9dbeeedf3..132dfba389be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -873,7 +873,7 @@ static size_t select_bpf_prog_pack_size(void)
 	return size;
 }
 
-static struct bpf_prog_pack *alloc_new_pack(void)
+static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
 
@@ -886,6 +886,7 @@ static struct bpf_prog_pack *alloc_new_pack(void)
 		kfree(pack);
 		return NULL;
 	}
+	bpf_fill_ill_insns(pack->ptr, bpf_prog_pack_size);
 	bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
@@ -895,7 +896,7 @@ static struct bpf_prog_pack *alloc_new_pack(void)
 	return pack;
 }
 
-static void *bpf_prog_pack_alloc(u32 size)
+static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	struct bpf_prog_pack *pack;
@@ -910,6 +911,7 @@ static void *bpf_prog_pack_alloc(u32 size)
 		size = round_up(size, PAGE_SIZE);
 		ptr = module_alloc(size);
 		if (ptr) {
+			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
 			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
 			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
@@ -923,7 +925,7 @@ static void *bpf_prog_pack_alloc(u32 size)
 			goto found_free_area;
 	}
 
-	pack = alloc_new_pack();
+	pack = alloc_new_pack(bpf_fill_ill_insns);
 	if (!pack)
 		goto out;
 
@@ -1102,7 +1104,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	ro_header = bpf_prog_pack_alloc(size);
+	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
 	if (!ro_header) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
-- 
2.30.2

