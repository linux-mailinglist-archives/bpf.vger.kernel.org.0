Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BD6140A2
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 23:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJaW0G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 31 Oct 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJaW0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:26:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B093140A7
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:03 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPADi021770
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:03 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjk60t971-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:02 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:26:01 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 7C938F0CC5C9; Mon, 31 Oct 2022 15:25:55 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <dave.hansen@intel.com>, <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v1 RESEND 4/5] vmalloc: introduce register_text_tail_vm()
Date:   Mon, 31 Oct 2022 15:25:40 -0700
Message-ID: <20221031222541.1773452-5-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
References: <20221031222541.1773452-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pxsIhQ6rNLkKzOA8jGBx_yI98cOmBIGL
X-Proofpoint-ORIG-GUID: pxsIhQ6rNLkKzOA8jGBx_yI98cOmBIGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow arch code to register some memory to be used by vmalloc_exec().
One possible use case is to allocate PMD pages for kernl text up to
PMD_ALIGN(_etext), and use (_etext, PMD_ALIGN(_etext)) for
vmalloc_exec. Currently, only one such region is supported.

Signed-off-by: Song Liu <song@kernel.org>
---
 mm/vmalloc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6f4c73e67191..46f2b7e56670 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -75,6 +75,9 @@ static const bool vmap_allow_huge = false;
 #define PMD_ALIGN(addr) ALIGN(addr, PMD_SIZE)
 #define PMD_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PMD_SIZE)
 
+static struct vm_struct text_tail_vm;
+static struct vmap_area text_tail_va;
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
@@ -653,6 +656,8 @@ int is_vmalloc_or_module_addr(const void *x)
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
 	if (addr >= MODULES_VADDR && addr < MODULES_END)
 		return 1;
+	if (addr >= text_tail_va.va_start && addr < text_tail_va.va_end)
+		return 1;
 #endif
 	return is_vmalloc_addr(x);
 }
@@ -2437,6 +2442,34 @@ static void vmap_init_free_space(void)
 	}
 }
 
+/*
+ * register_text_tail_vm() allows arch code to register memory regions
+ * for vmalloc_exec. Unlike regular memory regions used by vmalloc_exec,
+ * this region is never freed by vfree_exec.
+ *
+ * One possible use case is to allocate PMD pages for kernl text up to
+ * PMD_ALIGN(_etext), and use (_etext, PMD_ALIGN(_etext)) for vmalloc_exec.
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

