Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366452E30A
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbiETDTB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 19 May 2022 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbiETDTA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 23:19:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059668F80
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:59 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24JKmcJn032487
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g5h5d6vry-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:58 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 20:18:56 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 19BBB7D8C309; Thu, 19 May 2022 20:16:10 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 8/8] bpf: simplify select_bpf_prog_pack_size
Date:   Thu, 19 May 2022 20:15:48 -0700
Message-ID: <20220520031548.338934-9-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520031548.338934-1-song@kernel.org>
References: <20220520031548.338934-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DStbXLmgz3PdCLCozD3JEjNuffvXUJ3L
X-Proofpoint-ORIG-GUID: DStbXLmgz3PdCLCozD3JEjNuffvXUJ3L
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

Use huge_vmalloc_supported to simplify select_bpf_prog_pack_size, so that
we don't allocate some huge pages and free them immediately.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b64d91fcb0ba..b5dcc8f182b3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -854,22 +854,15 @@ static LIST_HEAD(pack_list);
 static size_t select_bpf_prog_pack_size(void)
 {
 	size_t size;
-	void *ptr;
-
-	size = BPF_HPAGE_SIZE * num_online_nodes();
-	ptr = module_alloc_huge(size);
 
-	/* Test whether we can get huge pages. If not just use PAGE_SIZE
-	 * packs.
-	 */
-	if (!ptr || !is_vm_area_hugepages(ptr)) {
+	if (huge_vmalloc_supported()) {
+		size = BPF_HPAGE_SIZE * num_online_nodes();
+		bpf_prog_pack_mask = BPF_HPAGE_MASK;
+	} else {
 		size = PAGE_SIZE;
 		bpf_prog_pack_mask = PAGE_MASK;
-	} else {
-		bpf_prog_pack_mask = BPF_HPAGE_MASK;
 	}
 
-	vfree(ptr);
 	return size;
 }
 
-- 
2.30.2

