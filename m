Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A119E62E5C3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiKQUXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Nov 2022 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKQUXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:23:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3B120B5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHH3WT011808
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kws7g1kst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:42 -0800
Received: from twshared29133.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:23:41 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 274A8FF1758F; Thu, 17 Nov 2022 12:23:31 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 3/6] selftests/vm: extend test_vmalloc to test execmem_* APIs
Date:   Thu, 17 Nov 2022 12:23:19 -0800
Message-ID: <20221117202322.944661-4-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117202322.944661-1-song@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0zQBAb7L_gB9w8k0SuPHH4YWwY3YFi4w
X-Proofpoint-ORIG-GUID: 0zQBAb7L_gB9w8k0SuPHH4YWwY3YFi4w
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

Add logic to test execmem_[alloc|fill|free] in test_vmalloc.c.
No need to change tools/testing/selftests/vm/test_vmalloc.sh.

Signed-off-by: Song Liu <song@kernel.org>
---
 lib/test_vmalloc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index cf7780572f5b..6591c4932c3c 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -50,6 +50,7 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 128,  name: pcpu_alloc_test\n"
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: execmem_alloc_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -352,6 +353,34 @@ kvfree_rcu_2_arg_vmalloc_test(void)
 	return 0;
 }
 
+static int
+execmem_alloc_test(void)
+{
+	void *p, *tmp;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		/* allocate variable size, up to 64kB */
+		size_t size = (i % 1024 + 1) * 64;
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
+	}
+
+	return 0;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -368,6 +397,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "pcpu_alloc_test", pcpu_alloc_test },
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "execmem_alloc_test", execmem_alloc_test },
 	/* Add a new test case here. */
 };
 
-- 
2.30.2

