Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398C52E30B
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbiETDTA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 19 May 2022 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbiETDS6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 23:18:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE014A25E
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:57 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JKmWte017172
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:57 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g5pj4w87v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 20:18:57 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 20:18:56 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 363FC7D8C302; Thu, 19 May 2022 20:16:08 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 7/8] vmalloc: introduce huge_vmalloc_supported
Date:   Thu, 19 May 2022 20:15:47 -0700
Message-ID: <20220520031548.338934-8-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520031548.338934-1-song@kernel.org>
References: <20220520031548.338934-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IROkRLn5KQCyONhPZ9J8DCUw0Zx-k2bC
X-Proofpoint-ORIG-GUID: IROkRLn5KQCyONhPZ9J8DCUw0Zx-k2bC
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

huge_vmalloc_supported() exposes vmap_allow_huge so that users of vmalloc
APIs could know whether vmalloc will return huge pages.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/vmalloc.h | 6 ++++++
 mm/vmalloc.c            | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 5e0d0a60d9d5..22e81c1813bd 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -242,11 +242,17 @@ static inline void set_vm_flush_reset_perms(void *addr)
 	if (vm)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
+bool huge_vmalloc_supported(void);
 
 #else
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
+
+static inline bool huge_vmalloc_supported(void)
+{
+	return false;
+}
 #endif
 
 /* for /proc/kcore */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 07da85ae825b..d3b11317b025 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -72,6 +72,11 @@ early_param("nohugevmalloc", set_nohugevmalloc);
 static const bool vmap_allow_huge = false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
 
+bool huge_vmalloc_supported(void)
+{
+	return vmap_allow_huge;
+}
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
-- 
2.30.2

