Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E044AB04F
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbiBFPk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 10:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbiBFPkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 10:40:21 -0500
X-Greylist: delayed 2753 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 07:40:20 PST
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F195C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 07:40:20 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216E5rZ8009779;
        Sun, 6 Feb 2022 14:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1qv3fNnWzE6B3dGpU4fMclN37R45mMlEFSevTh2YBXg=;
 b=hisemLqbtnSPwmGof/89wiSU489TvEpxXf/hG4BOhiLBLq4LBlnJTpFWJ2V7wFeNKwZi
 WbbswExal0m/R+DLJW2l+U/udTgeUDvMWYdqGoyDsipCSVvbgqJMRgcOA74PxSRWkUMe
 spJmJyghkSndVJsFGe7OMTF+YSugiL3EpuL3NzwLQsxYsyvToATqqM4RB06vbEpeVteG
 ErA5nfddo37twuZHL9VpHimVtAgCCJM6n78JtGgChrcuAM0eOtRY9HLUbI6/+lBHzk73
 J8/eTHWHL3JA/Lk43DVqWghbYnIe9srsqC5QWRj6tPamoqzDXKF/tX1UiaYQ6rgPwKrK LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22q098ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 216EjKwJ008114;
        Sun, 6 Feb 2022 14:54:08 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22q098u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216ElfXS006946;
        Sun, 6 Feb 2022 14:54:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggje33f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216Ei1uq45744412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 14:44:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34D3811C04C;
        Sun,  6 Feb 2022 14:54:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0B6B11C04A;
        Sun,  6 Feb 2022 14:54:01 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 14:54:01 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] arm64/bpf: Introduce struct user_pt_regs_v2
Date:   Sun,  6 Feb 2022 15:53:50 +0100
Message-Id: <20220206145350.2069779-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220206145350.2069779-1-iii@linux.ibm.com>
References: <20220206145350.2069779-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rkAT_ewP3t8mLPhc7AMTvX0ZNa_wuiX9
X-Proofpoint-ORIG-GUID: _Hc9QUoR-bkox_mp7zBypUGq5pKbkZeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202060108
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extending struct user_pt_regs breaks struct bpf_perf_event_data ABI, so
instead of exposing orig_x0 through it, create its copy with orig_x0 at
the end and use it in libbpf.

The existing members are copy-pasted, so now there are 3 copies in
total. It might be tempting to add a user_pt_regs member to
user_pt_regs_v2 instead, however, there is no guarantee that then
user_pt_regs_v2.orig_x0 would be at the same offset as
pt_regs.orig_gpr2.

Fixes: d473f4062165 ("arm64/bpf: Add orig_x0 to user_pt_regs")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h      | 1 +
 arch/arm64/include/uapi/asm/ptrace.h | 7 +++++++
 tools/lib/bpf/bpf_tracing.h          | 6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 1be22f7870f8..c5e098af5b70 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -178,6 +178,7 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
 struct pt_regs {
 	union {
 		struct user_pt_regs user_regs;
+		struct user_pt_regs_v2 user_regs_v2;
 		struct {
 			u64 regs[31];
 			u64 sp;
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 3c118c5b0893..ab7a2f0cdca8 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -90,6 +90,13 @@ struct user_pt_regs {
 	__u64		sp;
 	__u64		pc;
 	__u64		pstate;
+};
+
+struct user_pt_regs_v2 {
+	__u64		regs[31];
+	__u64		sp;
+	__u64		pc;
+	__u64		pstate;
 	__u64		orig_x0;
 };
 
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 76abbc5ff2e8..284cc4d6954e 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -143,8 +143,10 @@
 
 #elif defined(bpf_target_arm64)
 
-/* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
-#define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
+/*
+ * arm64 provides struct user_pt_regs_v2 instead of struct pt_regs to userspace
+ */
+#define __PT_REGS_CAST(x) ((const struct user_pt_regs_v2 *)(x))
 #define __PT_PARM1_REG regs[0]
 #define __PT_PARM1_REG_SYSCALL orig_x0
 #define __PT_PARM2_REG regs[1]
-- 
2.34.1

