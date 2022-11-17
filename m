Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4AB62E5C5
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKQUXw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Nov 2022 15:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKQUXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:23:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6A11800
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:44 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIfVOG024752
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:44 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kwtf58tdd-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:23:41 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 4DF2FFF175EF; Thu, 17 Nov 2022 12:23:34 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 5/6] vmalloc: introduce register_text_tail_vm()
Date:   Thu, 17 Nov 2022 12:23:21 -0800
Message-ID: <20221117202322.944661-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117202322.944661-1-song@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: k-Nsh64kBTA-VEKOj_ZDoYBMKPEEjvmh
X-Proofpoint-ORIG-GUID: k-Nsh64kBTA-VEKOj_ZDoYBMKPEEjvmh
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

Allow arch code to register some memory to be used by execmem_alloc().
One possible use case is to allocate PMD pages for kernl text up to
PMD_ALIGN(_etext), and use (_etext, PMD_ALIGN(_etext)) for
execmem_alloc. Currently, only one such region is supported.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/vmalloc.h |  4 ++++
 mm/vmalloc.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 30aa8c187d40..2babbe3031a5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -132,11 +132,15 @@ extern void vm_unmap_aliases(void);
 #ifdef CONFIG_MMU
 extern void __init vmalloc_init(void);
 extern unsigned long vmalloc_nr_pages(void);
+void register_text_tail_vm(unsigned long start, unsigned long end);
 #else
 static inline void vmalloc_init(void)
 {
 }
 static inline unsigned long vmalloc_nr_pages(void) { return 0; }
+void register_text_tail_vm(unsigned long start, unsigned long end)
+{
+}
 #endif
 
 extern void *vmalloc(unsigned long size) __alloc_size(1);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 75ec8ab24929..31d04ae81cd9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -77,6 +77,9 @@ static const bool vmap_allow_huge = false;
 #endif
 #define PMD_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PMD_SIZE)
 
+static struct vm_struct text_tail_vm;
+static struct vmap_area text_tail_va;
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
@@ -655,6 +658,8 @@ int is_vmalloc_or_module_addr(const void *x)
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
 	if (addr >= MODULES_VADDR && addr < MODULES_END)
 		return 1;
+	if (addr >= text_tail_va.va_start && addr < text_tail_va.va_end)
+		return 1;
 #endif
 	return is_vmalloc_addr(x);
 }
@@ -2439,6 +2444,35 @@ static void vmap_init_free_space(void)
 	}
 }
 
+/*
+ * register_text_tail_vm() allows arch code to register memory regions
+ * for execmem_alloc. Unlike regular memory regions used by execmem_alloc,
+ * this region is never freed by vfree_exec.
+ *
+ * One possible use case is to allocate PMD pages for kernl text up to
+ * PMD_ALIGN(_etext), and use (_etext, PMD_ALIGN(_etext)) for
+ * execmem_alloc.
+ */
+void register_text_tail_vm(unsigned long start, unsigned long end)
+{
+	struct vmap_area *va;
+
+	/* only support one region */
+	if (WARN_ON_ONCE(text_tail_vm.addr))
+		return;
+
+	va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+	if (WARN_ON_ONCE(!va))
+		return;
+	text_tail_vm.addr = (void *)start;
+	text_tail_vm.size = end - start;
+	text_tail_va.va_start = start;
+	text_tail_va.va_end = end;
+	text_tail_va.vm = &text_tail_vm;
+	memcpy(va, &text_tail_va, sizeof(*va));
+	insert_vmap_area_augment(va, NULL, &free_text_area_root, &free_text_area_list);
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
-- 
2.30.2

