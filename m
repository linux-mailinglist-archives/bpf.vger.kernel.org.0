Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764D652F672
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbiEUAAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 May 2022 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiEUAAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:00:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB01A0AE2
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24KMsAm6021874
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:34 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g5wkrg2ru-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:00:34 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 17:00:32 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 0B1EE7E22204; Fri, 20 May 2022 16:58:21 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <mcgrof@kernel.org>, <torvalds@linux-foundation.org>,
        <rick.p.edgecombe@intel.com>, <kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 6/8] vmalloc: WARN for set_vm_flush_reset_perms() on huge pages
Date:   Fri, 20 May 2022 16:57:56 -0700
Message-ID: <20220520235758.1858153-7-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520235758.1858153-1-song@kernel.org>
References: <20220520235758.1858153-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7j70KGT89k7Bx7wKkwJiKVNG0N0bMf_g
X-Proofpoint-ORIG-GUID: 7j70KGT89k7Bx7wKkwJiKVNG0N0bMf_g
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

VM_FLUSH_RESET_PERMS is not yet ready for huge pages, add a WARN to
catch misuse soon.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/vmalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index b159c2789961..5e0d0a60d9d5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -238,6 +238,7 @@ static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
 
+	WARN_ON_ONCE(is_vm_area_hugepages(addr));
 	if (vm)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
-- 
2.30.2

