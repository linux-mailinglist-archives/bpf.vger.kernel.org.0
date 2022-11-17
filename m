Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8962E5C2
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKQUXo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Nov 2022 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKQUXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:23:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883C1901C
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:42 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHHFHW012051
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:42 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kws7g1kss-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:23:42 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:23:41 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id B5B91FF17571; Thu, 17 Nov 2022 12:23:29 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 2/6] x86/alternative: support execmem_alloc() and execmem_free()
Date:   Thu, 17 Nov 2022 12:23:18 -0800
Message-ID: <20221117202322.944661-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117202322.944661-1-song@kernel.org>
References: <20221117202322.944661-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BtPu0WvGN9UBzhA2maASmPmqFk7a0Z1-
X-Proofpoint-ORIG-GUID: BtPu0WvGN9UBzhA2maASmPmqFk7a0Z1-
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

Implement arch_fill_execmem() and arch_invalidate_execmem() to support
execmem_alloc.

arch_fill_execmem() copies dynamic kernel text (such as BPF programs) to
RO+X memory region allocated by execmem_alloc().

arch_invalidate_execmem() fills memory with 0xcc after it is released by
execmem_free().

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/kernel/alternative.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..e38829f19a81 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1270,6 +1270,18 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 	return addr;
 }
 
+void *arch_fill_execmem(void *dst, void *src, size_t len)
+{
+	if (text_poke_copy(dst, src, len) == NULL)
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
+
+int arch_invalidate_execmem(void *ptr, size_t len)
+{
+	return IS_ERR_OR_NULL(text_poke_set(ptr, 0xcc, len));
+}
+
 /**
  * text_poke_set - memset into (an unused part of) RX memory
  * @addr: address to modify
-- 
2.30.2

