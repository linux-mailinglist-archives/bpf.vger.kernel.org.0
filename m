Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE46D675EA5
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjATUKL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjATUKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:10:10 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A59DCAC
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:07 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDeFx5025990
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdedec4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:06 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:10:04 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9FEDA25B4B17D; Fri, 20 Jan 2023 12:09:54 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 19/25] libbpf: define powerpc syscall regs spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:08 -0800
Message-ID: <20230120200914.3008030-20-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HFjXs_iEcTXf2IgFj_90BxG4TdKIA2_j
X-Proofpoint-ORIG-GUID: HFjXs_iEcTXf2IgFj_90BxG4TdKIA2_j
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

Define explicit table of registers used for syscall argument passing.
Note that 7th arg is supported on 32-bit powerpc architecture, by not on
powerpc64.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a3da63b74b0b..b3647c4a6c0c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -294,13 +294,24 @@ struct pt_regs___arm64 {
 #define __PT_PARM6_REG gpr[8]
 #define __PT_PARM7_REG gpr[9]
 #define __PT_PARM8_REG gpr[10]
+
+/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER. */
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
+#define __PT_PARM1_SYSCALL_REG orig_gpr3
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+#if !defined(__arch64__)
+#define __PT_PARM7_SYSCALL_REG __PT_PARM7_REG /* only powerpc (not powerpc64) */
+#endif
+
 #define __PT_RET_REG regs[31]
 #define __PT_FP_REG __unsupported__
 #define __PT_RC_REG gpr[3]
 #define __PT_SP_REG sp
 #define __PT_IP_REG nip
-/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER. */
-#define PT_REGS_SYSCALL_REGS(ctx) ctx
 
 #elif defined(bpf_target_sparc)
 
-- 
2.30.2

