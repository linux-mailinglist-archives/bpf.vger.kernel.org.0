Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF610675E9B
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjATUJr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjATUJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:47 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5ED12875
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:45 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KI71jp011140
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:44 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:44 -0800
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2228B25B4B0CB; Fri, 20 Jan 2023 12:09:32 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 08/25] libbpf: fix and complete ARC spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:57 -0800
Message-ID: <20230120200914.3008030-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WGkipF8Fwy94MGd8wsCfcRDvM6uCn4CM
X-Proofpoint-ORIG-GUID: WGkipF8Fwy94MGd8wsCfcRDvM6uCn4CM
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

Add PARM6 through PARM8 definitions. Also fix frame pointer (FP)
register definition. Also leave a link to where to find ABI spec.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 579e2f830532..815c50ccedf4 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -291,6 +291,11 @@ struct pt_regs___arm64 {
 
 #elif defined(bpf_target_arc)
 
+/*
+ * Section "Function Calling Sequence" (page 24):
+ * https://raw.githubusercontent.com/wiki/foss-for-synopsys-dwc-arc-processors/toolchain/files/ARCv2_ABI.pdf
+ */
+
 /* arc provides struct user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
 #define __PT_PARM1_REG scratch.r0
@@ -298,8 +303,11 @@ struct pt_regs___arm64 {
 #define __PT_PARM3_REG scratch.r2
 #define __PT_PARM4_REG scratch.r3
 #define __PT_PARM5_REG scratch.r4
+#define __PT_PARM6_REG scratch.r5
+#define __PT_PARM7_REG scratch.r6
+#define __PT_PARM8_REG scratch.r7
 #define __PT_RET_REG scratch.blink
-#define __PT_FP_REG __unsupported__
+#define __PT_FP_REG scratch.fp
 #define __PT_RC_REG scratch.r0
 #define __PT_SP_REG scratch.sp
 #define __PT_IP_REG scratch.ret
-- 
2.30.2

