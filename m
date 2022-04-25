Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650650EAC1
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiDYUqW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiDYUqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 16:46:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F0762B5
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP4lT011178
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmejp58rk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 13:43:16 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 13:43:16 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 19BB8652E7A4; Mon, 25 Apr 2022 13:40:37 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <hch@infradead.org>, <peterz@infradead.org>,
        <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf 2/3] x86/alternative: introduce text_poke_set
Date:   Mon, 25 Apr 2022 13:39:46 -0700
Message-ID: <20220425203947.3311308-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425203947.3311308-1-song@kernel.org>
References: <20220425203947.3311308-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: P5dze0BTEMZjG9h1URNzi8uRpPn8TCo3
X-Proofpoint-ORIG-GUID: P5dze0BTEMZjG9h1URNzi8uRpPn8TCo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

