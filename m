Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF03675E95
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjATUJf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjATUJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCE2E0D9
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:33 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KINMwS014119
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:33 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7ycmgwa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:33 -0800
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:31 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F142125B4B0AA; Fri, 20 Jan 2023 12:09:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 05/25] libbpf: complete powerpc spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:54 -0800
Message-ID: <20230120200914.3008030-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vuBa208asA_FnGbo3HgnlViNEhNuyKAL
X-Proofpoint-ORIG-GUID: vuBa208asA_FnGbo3HgnlViNEhNuyKAL
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

Add definitions of PARM6 through PARM8 for powerpc architecture. Add
also a link to a functiona call sequence documentation for future reference.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f356955b059a..1b9447f847b0 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -222,11 +222,19 @@ struct pt_regs___arm64 {
 
 #elif defined(bpf_target_powerpc)
 
+/*
+ * http://refspecs.linux-foundation.org/elf/elfspec_ppc.pdf (page 3-14,
+ * section "Function Calling Sequence")
+ */
+
 #define __PT_PARM1_REG gpr[3]
 #define __PT_PARM2_REG gpr[4]
 #define __PT_PARM3_REG gpr[5]
 #define __PT_PARM4_REG gpr[6]
 #define __PT_PARM5_REG gpr[7]
+#define __PT_PARM6_REG gpr[8]
+#define __PT_PARM7_REG gpr[9]
+#define __PT_PARM8_REG gpr[10]
 #define __PT_RET_REG regs[31]
 #define __PT_FP_REG __unsupported__
 #define __PT_RC_REG gpr[3]
-- 
2.30.2

