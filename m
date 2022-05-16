Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B5527D18
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiEPFlZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 16 May 2022 01:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiEPFlP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 01:41:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A3DF48
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:13 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FBxMHI027826
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g27rnqmbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 22:41:13 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 15 May 2022 22:41:12 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id DF9B77AEBC5A; Sun, 15 May 2022 22:40:59 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Date:   Sun, 15 May 2022 22:40:48 -0700
Message-ID: <20220516054051.114490-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516054051.114490-1-song@kernel.org>
References: <20220516054051.114490-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BvaePzEhzZ6hB-9x6LP_x6w-oCbD1Jn7
X-Proofpoint-GUID: BvaePzEhzZ6hB-9x6LP_x6w-oCbD1Jn7
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

Introduce a memset like API for text_poke. This will be used to fill the
unused RX memory with illegal instructions.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 70 ++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index d20ab0921480..1cc15528ce29 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3cf024..732814065389 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -994,7 +994,21 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static void *__text_poke(void *addr, const void *opcode, size_t len)
+static void text_poke_memcpy(void *dst, const void *src, size_t len)
+{
+	memcpy(dst, src, len);
+}
+
+static void text_poke_memset(void *dst, const void *src, size_t len)
+{
+	int c = *(int *)src;
+
+	memset(dst, c, len);
+}
+
+typedef void text_poke_f(void *dst, const void *src, size_t len);
+
+static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
@@ -1059,7 +1073,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	prev = use_temporary_mm(poking_mm);
 
 	kasan_disable_current();
-	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
+	func((u8 *)poking_addr + offset_in_page(addr), src, len);
 	kasan_enable_current();
 
 	/*
@@ -1087,11 +1101,13 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
 			   PAGE_SHIFT, false);
 
-	/*
-	 * If the text does not match what we just wrote then something is
-	 * fundamentally screwy; there's nothing we can really do about that.
-	 */
-	BUG_ON(memcmp(addr, opcode, len));
+	if (func == text_poke_memcpy) {
+		/*
+		 * If the text does not match what we just wrote then something is
+		 * fundamentally screwy; there's nothing we can really do about that.
+		 */
+		BUG_ON(memcmp(addr, src, len));
+	}
 
 	local_irq_restore(flags);
 	pte_unmap_unlock(ptep, ptl);
@@ -1118,7 +1134,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	lockdep_assert_held(&text_mutex);
 
-	return __text_poke(addr, opcode, len);
+	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
 /**
@@ -1137,7 +1153,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
  */
 void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
 {
-	return __text_poke(addr, opcode, len);
+	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
 /**
@@ -1167,7 +1183,41 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 
 		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
 
-		__text_poke((void *)ptr, opcode + patched, s);
+		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
+		patched += s;
+	}
+	mutex_unlock(&text_mutex);
+	return addr;
+}
+
+/**
+ * text_poke_set - memset into (an unused part of) RX memory
+ * @addr: address to modify
+ * @c: the byte to fill the area with
+ * @len: length to copy, could be more than 2x PAGE_SIZE
+ *
+ * Not safe against concurrent execution; useful for JITs to dump
+ * new code blocks into unused regions of RX memory. Can be used in
+ * conjunction with synchronize_rcu_tasks() to wait for existing
+ * execution to quiesce after having made sure no existing functions
+ * pointers are live.
+ */
+void *text_poke_set(void *addr, int c, size_t len)
+{
+	unsigned long start = (unsigned long)addr;
+	size_t patched = 0;
+
+	if (WARN_ON_ONCE(core_kernel_text(start)))
+		return NULL;
+
+	mutex_lock(&text_mutex);
+	while (patched < len) {
+		unsigned long ptr = start + patched;
+		size_t s;
+
+		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
+
+		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
 		patched += s;
 	}
 	mutex_unlock(&text_mutex);
-- 
2.30.2

