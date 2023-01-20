Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5641675E93
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjATUJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjATUJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:29 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65216743AD
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:28 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KI76wK011218
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:27 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede2h-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:27 -0800
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D888D25B4B07E; Fri, 20 Jan 2023 12:09:21 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 03/25] libbpf: fix arm and arm64 specs in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:08:52 -0800
Message-ID: <20230120200914.3008030-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4otZ_pi99YaLXYJqPIWoN1rUCe3AdMjk
X-Proofpoint-ORIG-GUID: 4otZ_pi99YaLXYJqPIWoN1rUCe3AdMjk
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

Remove invalid support for PARM5 on 32-bit arm, as per ABI. Add three
more argument registers for arm64. Also leave links to ABI specs for
future reference.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a47504c2f3cb..a263f600e309 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -157,11 +157,14 @@ struct pt_regs___s390 {
 
 #elif defined(bpf_target_arm)
 
+/*
+ * https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.rst#machine-registers
+ */
+
 #define __PT_PARM1_REG uregs[0]
 #define __PT_PARM2_REG uregs[1]
 #define __PT_PARM3_REG uregs[2]
 #define __PT_PARM4_REG uregs[3]
-#define __PT_PARM5_REG uregs[4]
 #define __PT_RET_REG uregs[14]
 #define __PT_FP_REG uregs[11]	/* Works only with CONFIG_FRAME_POINTER */
 #define __PT_RC_REG uregs[0]
@@ -170,6 +173,10 @@ struct pt_regs___s390 {
 
 #elif defined(bpf_target_arm64)
 
+/*
+ * https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#machine-registers
+ */
+
 struct pt_regs___arm64 {
 	unsigned long orig_x0;
 };
@@ -181,6 +188,9 @@ struct pt_regs___arm64 {
 #define __PT_PARM3_REG regs[2]
 #define __PT_PARM4_REG regs[3]
 #define __PT_PARM5_REG regs[4]
+#define __PT_PARM6_REG regs[5]
+#define __PT_PARM7_REG regs[6]
+#define __PT_PARM8_REG regs[7]
 #define __PT_RET_REG regs[30]
 #define __PT_FP_REG regs[29]	/* Works only with CONFIG_FRAME_POINTER */
 #define __PT_RC_REG regs[0]
-- 
2.30.2

