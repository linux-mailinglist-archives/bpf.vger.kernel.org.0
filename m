Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777763B1D8
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiK1TF0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 28 Nov 2022 14:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiK1TFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:05:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E752DD
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:05:24 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI15KX012610
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:05:24 -0800
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3fqts8bs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:05:24 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:05:21 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id D530210980373; Mon, 28 Nov 2022 11:02:58 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v5 3/6] selftests/vm: extend test_vmalloc to test execmem_* APIs
Date:   Mon, 28 Nov 2022 11:02:42 -0800
Message-ID: <20221128190245.2337461-4-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128190245.2337461-1-song@kernel.org>
References: <20221128190245.2337461-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ELez660CEigpEXOb1etaBEPpQVHvCh8i
X-Proofpoint-GUID: ELez660CEigpEXOb1etaBEPpQVHvCh8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add logic to test execmem_[alloc|fill|free] in test_vmalloc.c.
No need to change tools/testing/selftests/vm/test_vmalloc.sh.

Gate the export of execmem_* with DEBUG_TEST_VMALLOC_EXEMEM_ALLOC so
they are only exported when the developers are running tests.

Signed-off-by: Song Liu <song@kernel.org>
---
 lib/test_vmalloc.c | 35 +++++++++++++++++++++++++++++++++++
 mm/vmalloc.c       | 12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index cf7780572f5b..9c78f0693f59 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -50,6 +50,7 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 128,  name: pcpu_alloc_test\n"
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: execmem_alloc_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -352,6 +353,39 @@ kvfree_rcu_2_arg_vmalloc_test(void)
 	return 0;
 }
 
+/* This should match the define in vmalloc.c */
+#define DEBUG_TEST_VMALLOC_EXEMEM_ALLOC 0
+
+static int
+execmem_alloc_test(void)
+{
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
+		/* allocate variable size, up to 64kB */
+		size_t size = (i % 1024 + 1) * 64;
+		void *p, *tmp;
+
+		p = execmem_alloc(size, 64);
+		if (!p)
+			return -1;
+
+		tmp = execmem_fill(p, "a", 1);
+		if (tmp != p)
+			return -1;
+
+		tmp = execmem_fill(p + size - 1, "b", 1);
+		if (tmp != p + size - 1)
+			return -1;
+
+		execmem_free(p);
+#endif
+	}
+
+	return 0;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -368,6 +402,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "pcpu_alloc_test", pcpu_alloc_test },
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "execmem_alloc_test", execmem_alloc_test },
 	/* Add a new test case here. */
 };
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1f7f2134f9bd..95ee8282b66c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3387,6 +3387,9 @@ static void move_vmap_to_free_text_tree(void *addr)
 	spin_unlock(&free_text_area_lock);
 }
 
+/* This should match the define in test_vmalloc.c */
+#define DEBUG_TEST_VMALLOC_EXEMEM_ALLOC 0
+
 /**
  * execmem_alloc - allocate virtually contiguous RO+X memory
  * @size:    allocation size
@@ -3459,6 +3462,9 @@ void *execmem_alloc(unsigned long size, unsigned long align)
 	kmem_cache_free(vmap_area_cachep, va);
 	return NULL;
 }
+#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
+EXPORT_SYMBOL_GPL(execmem_alloc);
+#endif
 
 void __weak *arch_fill_execmem(void *dst, void *src, size_t len)
 {
@@ -3510,6 +3516,9 @@ void *execmem_fill(void *dst, void *src, size_t len)
 	spin_unlock(&vmap_area_lock);
 	return ERR_PTR(-EINVAL);
 }
+#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
+EXPORT_SYMBOL_GPL(execmem_fill);
+#endif
 
 static struct vm_struct *find_and_unlink_text_vm(unsigned long start, unsigned long end)
 {
@@ -3633,6 +3642,9 @@ void execmem_free(void *addr)
 out:
 	spin_unlock(&free_text_area_lock);
 }
+#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
+EXPORT_SYMBOL_GPL(execmem_free);
+#endif
 
 /**
  * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
-- 
2.30.2

