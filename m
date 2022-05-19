Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0552DE61
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiESU0c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 19 May 2022 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiESU03 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 16:26:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1ED2D1F4
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:26:29 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JKPGh6029522
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:26:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d82ah2d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:26:28 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 13:26:22 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 78BE17D58F7C; Thu, 19 May 2022 13:21:02 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 8/8] bpf: simplify select_bpf_prog_pack_size
Date:   Thu, 19 May 2022 13:20:37 -0700
Message-ID: <20220519202037.2401584-9-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519202037.2401584-1-song@kernel.org>
References: <20220519202037.2401584-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gBnVVyMwyRT0WTu6pRA80UGgxLoXeV_L
X-Proofpoint-ORIG-GUID: gBnVVyMwyRT0WTu6pRA80UGgxLoXeV_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_06,2022-05-19_03,2022-02-23_01
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
 kernel/bpf/core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b64d91fcb0ba..62c8632a59a2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -856,20 +856,14 @@ static size_t select_bpf_prog_pack_size(void)
 	size_t size;
 	void *ptr;
 
-	size = BPF_HPAGE_SIZE * num_online_nodes();
-	ptr = module_alloc_huge(size);
-
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

