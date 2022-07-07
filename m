Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93056AE9F
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 00:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiGGWge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 7 Jul 2022 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiGGWgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 18:36:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C102AE8B
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 15:36:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KPxCC000753
        for <bpf@vger.kernel.org>; Thu, 7 Jul 2022 15:36:31 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h5kgpqxk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 15:36:31 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 7 Jul 2022 15:36:30 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 4AFEB9D349C5; Thu,  7 Jul 2022 15:36:10 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <daniel@iogearbox.net>, <kernel-team@fb.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <rick.p.edgecombe@intel.com>,
        <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next 5/5] bpf: simplify select_bpf_prog_pack_size
Date:   Thu, 7 Jul 2022 15:35:46 -0700
Message-ID: <20220707223546.4124919-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707223546.4124919-1-song@kernel.org>
References: <20220707223546.4124919-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e2DinLnuuuKmS9JxtjresLyXPCrI2FCf
X-Proofpoint-GUID: e2DinLnuuuKmS9JxtjresLyXPCrI2FCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_17,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index d1f32ac354d3..e1f8d36fb95c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -857,22 +857,15 @@ static LIST_HEAD(pack_list);
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

