Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB14AE685
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiBICjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbiBICSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD02C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:13 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21912QZu005940;
        Wed, 9 Feb 2022 02:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5xixiBaVyFGmWQnrYLx4jiAcVVYeuIvAsYc0oD99bWA=;
 b=XaD9VefVPdqcbQV3PYK9kPOb7QHJff9uXUEkCGfhz8/BoFxo7SFdnkHWm8ciQTHnwJUC
 n/MHvCPvcktIhQ4gB1cfNMBHoV0EO6NiQUMjgqksyd1t/D6F1fVblpZUE60NHUhpm2Sn
 FFSTGNj9elloPY3w2LbfWqoAu5NdnwL23MEsjot4aeq/7cHrepD7qmBnpA50VIC8F+2e
 qv79PGAx77k4X+qin6rDFYozDBKuc09hPrHdn2mGJ1SWkQnJ5TRIQcCIoFwUZM7Oltwu
 bg22e8ejcbTF5UZCBsWEIPB5y+CM2uxNBVS/+x2GQt1jqxc+6Dr58hzQlEbW1JjMzcCe CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst7a13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:01 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21927ovc019352;
        Wed, 9 Feb 2022 02:18:00 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst7a0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:00 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192CuTZ028207;
        Wed, 9 Feb 2022 02:17:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3e2ygq84ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2192HtXY45547804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:17:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 445B3A4054;
        Wed,  9 Feb 2022 02:17:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE77A405C;
        Wed,  9 Feb 2022 02:17:54 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:54 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 07/10] selftests/bpf: Skip test_bpf_syscall_macro:syscall_arg1 on arm64 and s390
Date:   Wed,  9 Feb 2022 03:17:42 +0100
Message-Id: <20220209021745.2215452-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
References: <20220209021745.2215452-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LHm_EZ0tErxWU3v5wUJpURDzUJGVs1r2
X-Proofpoint-GUID: mMgEEqSNaoS8UzGX2xG7OQUsKMGE06_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These architectures can provide access to the first syscall argument
only through PT_REGS_PARM1_CORE_SYSCALL().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c | 4 ++++
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c         | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index f5f4c8adf539..8bc58bda500d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -33,7 +33,11 @@ void test_bpf_syscall_macro(void)
 
 	/* check whether args of syscall are copied correctly */
 	prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
+#if defined(__aarch64__) || defined(__s390__)
+	ASSERT_NEQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
+#else
 	ASSERT_EQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
+#endif
 	ASSERT_EQ(skel->bss->arg2, exp_arg2, "syscall_arg2");
 	ASSERT_EQ(skel->bss->arg3, exp_arg3, "syscall_arg3");
 	/* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index e7c622cb6a39..496e54d0ac22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -28,7 +28,7 @@ int BPF_KPROBE(handle_sys_prctl)
 {
 	struct pt_regs *real_regs;
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
-	unsigned long tmp;
+	unsigned long tmp = 0;
 
 	if (pid != filter_pid)
 		return 0;
@@ -37,7 +37,9 @@ int BPF_KPROBE(handle_sys_prctl)
 
 	/* test for PT_REGS_PARM */
 
+#if !defined(bpf_target_arm64) && !defined(bpf_target_s390)
 	bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(real_regs));
+#endif
 	arg1 = tmp;
 	bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
 	bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
-- 
2.34.1

