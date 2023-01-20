Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786E675E9D
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjATUJv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjATUJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B229DCA9
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KINPga014209
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:48 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7ycmgwaj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:48 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 59E2F25B4B0F4; Fri, 20 Jan 2023 12:09:42 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 13/25] libbpf: define x86-64 syscall regs spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:02 -0800
Message-ID: <20230120200914.3008030-14-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DZ5bPnswVgUt-_S71UooMog_-r29AqBb
X-Proofpoint-ORIG-GUID: DZ5bPnswVgUt-_S71UooMog_-r29AqBb
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
Remove now unnecessary overrides of PT_REGS_PARM5_[CORE_]SYSCALL macros.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index e3bf510e1e55..5fd498821c29 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -90,14 +90,22 @@
 #define __PT_PARM4_REG cx
 #define __PT_PARM5_REG r8
 #define __PT_PARM6_REG r9
+/*
+ * Syscall uses r10 for PARM4. See arch/x86/entry/entry_64.S:entry_SYSCALL_64
+ * comments in Linux sources. And refer to syscall(2) manpage.
+ */
+#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#define __PT_PARM4_SYSCALL_REG r10
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+
 #define __PT_RET_REG sp
 #define __PT_FP_REG bp
 #define __PT_RC_REG ax
 #define __PT_SP_REG sp
 #define __PT_IP_REG ip
-/* syscall uses r10 for PARM4 */
-#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10)
-#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(x, r10)
 
 #else
 
@@ -121,14 +129,19 @@
 #define __PT_PARM4_REG rcx
 #define __PT_PARM5_REG r8
 #define __PT_PARM6_REG r9
+
+#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#define __PT_PARM4_SYSCALL_REG r10
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+
 #define __PT_RET_REG rsp
 #define __PT_FP_REG rbp
 #define __PT_RC_REG rax
 #define __PT_SP_REG rsp
 #define __PT_IP_REG rip
-/* syscall uses r10 for PARM4 */
-#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10)
-#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(x, r10)
 
 #endif /* __i386__ */
 
-- 
2.30.2

