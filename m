Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9291163B1C9
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiK1TDG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 28 Nov 2022 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiK1TDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:03:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575D27FE9
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:04 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ASI0xNv021086
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:03 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m3f6ej248-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:03 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:03:01 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id E373F10980359; Mon, 28 Nov 2022 11:02:56 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v5 2/6] x86/alternative: support execmem_alloc() and execmem_free()
Date:   Mon, 28 Nov 2022 11:02:41 -0800
Message-ID: <20221128190245.2337461-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128190245.2337461-1-song@kernel.org>
References: <20221128190245.2337461-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uL49pttm3s3WmipDmfmQyGuXroIHWJ0B
X-Proofpoint-ORIG-GUID: uL49pttm3s3WmipDmfmQyGuXroIHWJ0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
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

