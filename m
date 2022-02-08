Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880484AD0EA
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiBHFdE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiBHFRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615DC0401DC
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:12 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182NtgB004648;
        Tue, 8 Feb 2022 05:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tatvCcJMb5MAKykIB7N4AT8vsCZ5ASy49zIrBpgM7gE=;
 b=I/Jj7kSAOV00CNg0FXdCAjbIaiO539AocFsRCGzny+Flb2N9Yv764io2C2tpsYLtP+im
 H+k2iFDw19obn83zH9fPI3N9l3mjj1EgX6Ln4+007Cos4r5qpRB6c2tBQ3knLZJ5KZqU
 BOXVMStlZoiSQTUf1lfL3/zfsfv7RV2o2C68cdWQ5lcLh4eo4bBaFmIMjU9oCML6SsJW
 MDsOzMgjQlUVCEWta7cYAZRKESMMfo7mPpZWgl7sMLI3Ljv/N8qV+M27X+6LvkdLqPjC
 2vJzMafhKJOjdwyhgDtvlbCli4lQW6m8ajRjFcdw/dYW3YJbQJLtksjtibhig1kz+rUC qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22stg35r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:51 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2185FurH027220;
        Tue, 8 Feb 2022 05:16:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22stg34s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185CWgi002870;
        Tue, 8 Feb 2022 05:16:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv9ae6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GiTN41419070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F395711C04A;
        Tue,  8 Feb 2022 05:16:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CDF511C04C;
        Tue,  8 Feb 2022 05:16:43 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:43 +0000 (GMT)
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
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 06/14] libbpf: Add PT_REGS_SYSCALL_REGS macro
Date:   Tue,  8 Feb 2022 06:16:27 +0100
Message-Id: <20220208051635.2160304-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: at3DYpWTiPsqG8HhA1Y83T4MfdWzw_ti
X-Proofpoint-ORIG-GUID: 8-75i-M9NQNR_q9e3Lkp70m4TMthJFUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=989 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Depending on whether or not an arch has ARCH_HAS_SYSCALL_WRAPPER,
syscall arguments must be accessed through a different set of
registers. Provide PT_REGS_SYSCALL_REGS macro to abstract away
that difference.

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 82f1e935d549..7a015ee8fb11 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -64,6 +64,8 @@
 
 #if defined(bpf_target_x86)
 
+#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
+
 #if defined(__KERNEL__) || defined(__VMLINUX_H__)
 
 #define __PT_PARM1_REG di
@@ -114,6 +116,8 @@
 
 #elif defined(bpf_target_s390)
 
+#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
+
 /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
 #define __PT_PARM1_REG gprs[2]
@@ -142,6 +146,8 @@
 
 #elif defined(bpf_target_arm64)
 
+#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
+
 /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
 #define __PT_PARM1_REG regs[0]
@@ -344,6 +350,17 @@ struct pt_regs;
 
 #endif /* defined(bpf_target_defined) */
 
+/*
+ * When invoked from a syscall handler BPF_KPROBE, returns a pointer to a
+ * struct pt_regs containing syscall arguments, that is suitable for passing to
+ * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
+ */
+#ifdef __BPF_ARCH_HAS_SYSCALL_WRAPPER
+#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
+#else
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
+#endif
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
-- 
2.34.1

