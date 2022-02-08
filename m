Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF24AD0ED
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiBHFdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiBHFRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63900C0401EE
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:13 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182IG2M021390;
        Tue, 8 Feb 2022 05:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HR4g4dcgdAOIxXBvfmG4lQLe6l4SHdf1pDAgzAmfyqo=;
 b=KjpdEBt91RVCHvx2/EDbXNBCetMfz9lQVtpANt+q9dAbwKEy2plKIqhuP5Cl1eqtLFpD
 fEZaL9tW/pu4X0zNn6wrSYfCkFq2xhO4SOF1tYMJ6e0Cn2RGlr2qEOzIvf+prb1fBSrn
 Y9iY7h4LNhbuTmPIeNnKDPwddW44IHRyPNdxVuHtidEdUUaJYXZui0evw94fEUWIEw9S
 gRoYUND5aE4K6L+jMd7NhCyYNJbmtDFGoEbc/sDym903OKj0vKr4GlEnD6q6wm6QA118
 JBFBS4+Rdc4lS/iyi56gja++7HzvIB4QyNk+UZ5ofHN/RX1XDrAep3Jxn0XENwwoplw0 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4js4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:55 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2185GtuH021148;
        Tue, 8 Feb 2022 05:16:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4js40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:55 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185CCNI019236;
        Tue, 8 Feb 2022 05:16:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3e1gv99dk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GjD643581820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE6711C04A;
        Tue,  8 Feb 2022 05:16:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 500E111C052;
        Tue,  8 Feb 2022 05:16:44 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:44 +0000 (GMT)
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
Subject: [PATCH bpf-next v4 07/14] selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
Date:   Tue,  8 Feb 2022 06:16:28 +0100
Message-Id: <20220208051635.2160304-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vYdPpaRmaNJdZHYxS4rIzt-_FE4PCI0X
X-Proofpoint-GUID: bjMZQ5rEt0XQI7DspuIakKIdjmYSZ3TO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0
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

Ensure that PT_REGS_SYSCALL_REGS works correctly, and also remove some
duplication.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h              | 4 ----
 .../selftests/bpf/progs/bpf_syscall_macro_common.h        | 2 +-
 tools/testing/selftests/bpf/progs/test_probe_user.c       | 8 +-------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5bb11fe595a4..9f2937b5e819 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -3,16 +3,12 @@
 #define __BPF_MISC_H__
 
 #if defined(__TARGET_ARCH_x86)
-#define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
 #elif defined(__TARGET_ARCH_s390)
-#define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__s390x_"
 #elif defined(__TARGET_ARCH_arm64)
-#define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__arm64_"
 #else
-#define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
 #endif
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
index 8717605358d3..95c2f1904f81 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
@@ -31,7 +31,7 @@ int BPF_KPROBE(handle_sys_prctl)
 	if (pid != filter_pid)
 		return 0;
 
-	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	real_regs = PT_REGS_SYSCALL_REGS(ctx);
 
 	/* test for PT_REGS_PARM */
 
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index 702578a5e496..b2531f587c87 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -14,18 +14,12 @@ static struct sockaddr_in old;
 SEC("kprobe/" SYS_PREFIX "sys_connect")
 int BPF_KPROBE(handle_sys_connect)
 {
-#if SYSCALL_WRAPPER == 1
 	struct pt_regs *real_regs;
-#endif
 	struct sockaddr_in new;
 	void *ptr;
 
-#if SYSCALL_WRAPPER == 0
-	ptr = (void *)PT_REGS_PARM2(ctx);
-#else
-	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	real_regs = PT_REGS_SYSCALL_REGS(ctx);
 	bpf_probe_read_kernel(&ptr, sizeof(ptr), &PT_REGS_PARM2(real_regs));
-#endif
 
 	bpf_probe_read_user(&old, sizeof(old), ptr);
 	__builtin_memset(&new, 0xab, sizeof(new));
-- 
2.34.1

