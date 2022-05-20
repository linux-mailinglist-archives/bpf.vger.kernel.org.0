Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296FC52F671
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354157AbiEUAAg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 May 2022 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiEUAAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:00:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F21A0ADC
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KMrtvB023390
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g604bq6qh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:35 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 17:00:34 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id C84FB7E221EC; Fri, 20 May 2022 16:58:16 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 4/8] module: introduce module_alloc_huge
Date:   Fri, 20 May 2022 16:57:54 -0700
Message-ID: <20220520235758.1858153-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520235758.1858153-1-song@kernel.org>
References: <20220520235758.1858153-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N8ocT1TO60Ah0un658EOTo5MwyZoAaZi
X-Proofpoint-GUID: N8ocT1TO60Ah0un658EOTo5MwyZoAaZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce module_alloc_huge, which allocates huge page backed memory in
module memory space. The primary user of this memory is bpf_prog_pack
(multiple BPF programs sharing a huge page).

Signed-off-by: Song Liu <song@kernel.org>

---
Note: This conflicts with the module.c => module/ split in modules-next.
Current patch is for module.c in the bpf-next tree. After the split,
__weak module_alloc_huge() should be added to kernel/module/main.c.
---
 arch/x86/kernel/module.c     | 21 +++++++++++++++++++++
 include/linux/moduleloader.h |  5 +++++
 kernel/module.c              |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b98ffcf4d250..63f6a16c70dc 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -86,6 +86,27 @@ void *module_alloc(unsigned long size)
 	return p;
 }
 
+void *module_alloc_huge(unsigned long size)
+{
+	gfp_t gfp_mask = GFP_KERNEL;
+	void *p;
+
+	if (PAGE_ALIGN(size) > MODULES_LEN)
+		return NULL;
+
+	p = __vmalloc_node_range(size, MODULE_ALIGN,
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
+		vfree(p);
+		return NULL;
+	}
+
+	return p;
+}
+
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..d34743a88938 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -26,6 +26,11 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
    sections.  Returns NULL on failure. */
 void *module_alloc(unsigned long size);
 
+/* Allocator used for allocating memory in module memory space. If size is
+ * greater than PMD_SIZE, allow using huge pages. Returns NULL on failure.
+ */
+void *module_alloc_huge(unsigned long size);
+
 /* Free memory returned from module_alloc. */
 void module_memfree(void *module_region);
 
diff --git a/kernel/module.c b/kernel/module.c
index 6cea788fd965..2af20ac3209c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2839,6 +2839,14 @@ void * __weak module_alloc(unsigned long size)
 			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
+void * __weak module_alloc_huge(unsigned long size)
+{
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+				    GFP_KERNEL, PAGE_KERNEL_EXEC,
+				    VM_FLUSH_RESET_PERMS | VM_ALLOW_HUGE_VMAP,
+				    NUMA_NO_NODE, __builtin_return_address(0));
+}
+
 bool __weak module_init_section(const char *name)
 {
 	return strstarts(name, ".init");
-- 
2.30.2

