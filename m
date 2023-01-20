Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B3675EA3
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjATUKG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjATUKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:10:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205459373F
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:05 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KIMnMJ018795
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7g70wh46-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:04 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8948325B4B16C; Fri, 20 Jan 2023 12:09:50 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 17/25] libbpf: define arm64 syscall regs spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:06 -0800
Message-ID: <20230120200914.3008030-18-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WYr1soH2LwsZL83Iphxr123h0jFfD7tW
X-Proofpoint-ORIG-GUID: WYr1soH2LwsZL83Iphxr123h0jFfD7tW
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
We need PT_REGS_PARM1_[CORE_]SYSCALL macros overrides, similarly to
s390x, due to orig_x0 not being present in UAPI's pt_regs, so we need to
utilize BPF CO-RE and custom pt_regs___arm64 definition.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index edd85a0ab612..f753346e9be6 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -233,13 +233,22 @@ struct pt_regs___arm64 {
 #define __PT_PARM6_REG regs[5]
 #define __PT_PARM7_REG regs[6]
 #define __PT_PARM8_REG regs[7]
+
+#define __PT_PARM1_SYSCALL_REG orig_x0
+#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
+#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
+#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
+#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) \
+	BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SYSCALL_REG)
+
 #define __PT_RET_REG regs[30]
 #define __PT_FP_REG regs[29]	/* Works only with CONFIG_FRAME_POINTER */
 #define __PT_RC_REG regs[0]
 #define __PT_SP_REG sp
 #define __PT_IP_REG pc
-#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
-#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct pt_regs___arm64 *)(x), orig_x0)
 
 #elif defined(bpf_target_mips)
 
-- 
2.30.2

