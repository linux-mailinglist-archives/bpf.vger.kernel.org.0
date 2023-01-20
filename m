Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4056675E9A
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjATUJr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjATUJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3B9373F
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:44 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30KDgFXH002534
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3n7qeyujwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:43 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2C81325B4B0D4; Fri, 20 Jan 2023 12:09:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 09/25] libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:58 -0800
Message-ID: <20230120200914.3008030-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e9j0onwg1gaEFvnGrljTSY2VTF2tHPD0
X-Proofpoint-GUID: e9j0onwg1gaEFvnGrljTSY2VTF2tHPD0
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add PARM6 through PARM8 definitions. Add kernel docs link describing ABI
for LoongArch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 815c50ccedf4..510df96ff19d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -316,13 +316,19 @@ struct pt_regs___arm64 {
 
 #elif defined(bpf_target_loongarch)
 
-/* https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html */
+/*
+ * https://docs.kernel.org/loongarch/introduction.html
+ * https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
+ */
 
 #define __PT_PARM1_REG regs[4]
 #define __PT_PARM2_REG regs[5]
 #define __PT_PARM3_REG regs[6]
 #define __PT_PARM4_REG regs[7]
 #define __PT_PARM5_REG regs[8]
+#define __PT_PARM6_REG regs[9]
+#define __PT_PARM7_REG regs[10]
+#define __PT_PARM8_REG regs[11]
 #define __PT_RET_REG regs[1]
 #define __PT_FP_REG regs[22]
 #define __PT_RC_REG regs[4]
-- 
2.30.2

