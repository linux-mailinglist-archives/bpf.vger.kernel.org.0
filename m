Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67F52DE6E
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiESUcZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 19 May 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiESUcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 16:32:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526E6B641
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:32:23 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24JKPmmn012733
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:32:23 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g5h5d4yjh-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 13:32:23 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 13:32:21 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 2D80D7D58F79; Thu, 19 May 2022 13:21:00 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 7/8] vmalloc: introduce huge_vmalloc_supported
Date:   Thu, 19 May 2022 13:20:36 -0700
Message-ID: <20220519202037.2401584-8-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519202037.2401584-1-song@kernel.org>
References: <20220519202037.2401584-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X10zIGV79ziPUPsmHK014lXb9UmKjHpc
X-Proofpoint-ORIG-GUID: X10zIGV79ziPUPsmHK014lXb9UmKjHpc
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

huge_vmalloc_supported() exposes vmap_allow_huge so that users of vmalloc
APIs could know whether vmalloc will return huge pages.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/vmalloc.h | 2 ++
 mm/vmalloc.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 5e0d0a60d9d5..3268e7e875ff 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -242,11 +242,13 @@ static inline void set_vm_flush_reset_perms(void *addr)
 	if (vm)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
+bool huge_vmalloc_supported(void);
 
 #else
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
+bool huge_vmalloc_supported(void) { return false; }
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

