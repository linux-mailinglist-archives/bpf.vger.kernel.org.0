Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5B4AD0DC
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbiBHFc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiBHFRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F60C0401DC
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:21 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2183qQYv011129;
        Tue, 8 Feb 2022 05:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lJqfHEfM8MX5+Yw3Kw2gURq7wH1XqjIsrdpgbIZGrlE=;
 b=cYA1Ycklvx09V4hsausD40hlWcV5g3GvoAFSOGuprOWTMEKCMYRtULpoMO7LPzELDowH
 RwedU/07AUCjnxpQkLWpZ1Dw56cqMb5DaVBtQDkW+wliFRIbS5NH4/iDSgcrnaaU532I
 6knZ79PszTCbsAkzphHwwIUf4UOjcsXEMU3j+GmBPR/vIr3Frfyl+l5fHfgC7Ynsn068
 4GI5hnSxaALcCP9jjO45wWwgCwVCpc/yMMBldIFgml0Gkkfw0BsoypY5ly8/cHbdkTK2
 yervdQVMoQPPUCe3ctA2YQQzcrSyA3UPb8AL3rpzLPtUgLOgV1ywmivL9QqdTFNtX1I/ Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22nkqh40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:58 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21852hOl025243;
        Tue, 8 Feb 2022 05:16:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22nkqh2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185Cc2I002911;
        Tue, 8 Feb 2022 05:16:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv9ae6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GmiK38600994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A82BF11C04A;
        Tue,  8 Feb 2022 05:16:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D9F11C04C;
        Tue,  8 Feb 2022 05:16:48 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:47 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 11/14] libbpf: Fix accessing the first syscall argument on s390
Date:   Tue,  8 Feb 2022 06:16:32 +0100
Message-Id: <20220208051635.2160304-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oLFjtIm_eVraQyewtjXc7EyRcWWnnyuB
X-Proofpoint-ORIG-GUID: 2zMH8xtgr2TbetzB-djjM5ou3dMoMUIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On s390, the first syscall argument should be accessed via orig_gpr2
(see arch/s390/include/asm/syscall.h). Currently gpr[2] is used
instead, leading to bpf_syscall_macro test failure.

Note that this is unfixable for CO-RE when vmlinux.h is not included.
Simply fail the build in this case.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 88ed5ba9510c..5911b177728f 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -2,6 +2,8 @@
 #ifndef __BPF_TRACING_H__
 #define __BPF_TRACING_H__
 
+#include <bpf/bpf_common_helpers.h>
+
 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
 	#define bpf_target_x86
@@ -118,9 +120,20 @@
 
 #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
 
-#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
+#if defined(__KERNEL__) || defined(__VMLINUX_H__)
+#define __PT_PARM1_REG_SYSCALL orig_gpr2
+#else
 /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
+/*
+ * struct pt_regs.orig_gpr2 is not exposed through user_pt_regs, and the ABI
+ * prohibits extending user_pt_regs. In non-CO-RE case, make use of the fact
+ * that orig_gpr2 comes right after gprs in struct pt_regs. CO-RE does not
+ * allow such hacks, so there is no way to access orig_gpr2.
+ */
+#define PT_REGS_PARM1_SYSCALL(x) \
+	(*(unsigned long *)(((char *)(x) + offsetofend(user_pt_regs, gprs))))
+#define __PT_PARM1_REG_SYSCALL __unsupported__
 #endif
 
 #define __PT_PARM1_REG gprs[2]
-- 
2.34.1

