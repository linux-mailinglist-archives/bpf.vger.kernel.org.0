Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E542527D16
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiEPFlY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 16 May 2022 01:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbiEPFlM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 01:41:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4AADF6F
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:11 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FLaUZF008181
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g29xxf5eb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:10 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 15 May 2022 22:41:09 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 595B17AEBC8C; Sun, 15 May 2022 22:41:01 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 3/5] bpf: introduce bpf_arch_text_invalidate for bpf_prog_pack
Date:   Sun, 15 May 2022 22:40:49 -0700
Message-ID: <20220516054051.114490-4-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516054051.114490-1-song@kernel.org>
References: <20220516054051.114490-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N-qY4FD60K72PxLuweWmo9a2UR2Wvd67
X-Proofpoint-ORIG-GUID: N-qY4FD60K72PxLuweWmo9a2UR2Wvd67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-15_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_arch_text_invalidate and use it to fill unused part of the
bpf_prog_pack with illegal instructions when a BPF program is freed.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++++
 include/linux/bpf.h         | 1 +
 kernel/bpf/core.c           | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a2b6d197c226..f298b18a9a3d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -228,6 +228,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 	memset(area, 0xcc, size);
 }
 
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	return IS_ERR_OR_NULL(text_poke_set(dst, 0xcc, len));
+}
+
 struct jit_context {
 	int cleanup_addr; /* Epilogue code offset */
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5061ccd8b2dc..0288a6464236 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2362,6 +2362,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
+int bpf_arch_text_invalidate(void *dst, size_t len);
 
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2d0c9d4696ad..cacd8684c3c4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -968,6 +968,9 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
 	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
 
+	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
+		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
+
 	bitmap_clear(pack->bitmap, pos, nbits);
 	if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
 				       bpf_prog_chunk_count(), 0) == 0) {
@@ -2740,6 +2743,11 @@ void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+int __weak bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	return -ENOTSUPP;
+}
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
-- 
2.30.2

