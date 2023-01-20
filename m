Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA41D675EA0
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjATUJ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjATUJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:53 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB79DCAC
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:50 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDb3aX019632
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:50 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede80-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:48 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 728D525B4B119; Fri, 20 Jan 2023 12:09:46 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 15/25] libbpf: define s390x syscall regs spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:04 -0800
Message-ID: <20230120200914.3008030-16-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qlFnqwRoDvjMJQVmj-KeflqmskokK0Vd
X-Proofpoint-ORIG-GUID: qlFnqwRoDvjMJQVmj-KeflqmskokK0Vd
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

Define explicit table of registers used for syscall argument passing.
Note that we need custom overrides for PT_REGS_PARM1_[CORE_]SYSCALL
macros due to the need to use BPF CO-RE and custom local pt_regs
definitions to fetch orig_gpr2, storing 1st argument.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com> # s390x
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 4d04c63fda27..b63d538eb5f5 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -157,6 +157,10 @@
 
 #elif defined(bpf_target_s390)
 
+/*
+ * https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf
+ */
+
 struct pt_regs___s390 {
 	unsigned long orig_gpr2;
 };
@@ -168,13 +172,22 @@ struct pt_regs___s390 {
 #define __PT_PARM3_REG gprs[4]
 #define __PT_PARM4_REG gprs[5]
 #define __PT_PARM5_REG gprs[6]
+
+#define __PT_PARM1_SYSCALL_REG orig_gpr2
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#define __PT_PARM6_SYSCALL_REG gprs[7]
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) \
+	BPF_CORE_READ((const struct pt_regs___s390 *)(x), __PT_PARM1_SYSCALL_REG)
+
 #define __PT_RET_REG gprs[14]
 #define __PT_FP_REG gprs[11]	/* Works only with CONFIG_FRAME_POINTER */
 #define __PT_RC_REG gprs[2]
 #define __PT_SP_REG gprs[15]
 #define __PT_IP_REG psw.addr
-#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
-#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct pt_regs___s390 *)(x), orig_gpr2)
 
 #elif defined(bpf_target_arm)
 
-- 
2.30.2

