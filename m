Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE54A9301
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiBDEUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356924AbiBDEUh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21404DVw029386;
        Fri, 4 Feb 2022 04:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+LjoE0NZmu4eTgC5xdsneOk1/jfO4/mdoy6UnZQR+Ic=;
 b=dtfkSRKbIXj2eEi97b9H9GiRf187rIqnHlWEjd7qjAJTxNSWkFLTglM/OmwA48xAo7Ck
 hIUAxxwQku/A8ddLklgMqFddd2ZgOWbmEQgLw/aWrubi9a9NcbaPMSrd2YhVknIbrInZ
 46lm81++deiTHQXfVGHorDN+sERP3qx7ohr/LldBvD6ewwCGYVh0o3Xij6u2/Q9boRCM
 MbCpIMaWXsEyg/isckJVWlpqa3qRfOJykbPdJfDkqgiQ30KLdYde1Wzrbs5KoBGXbmPA
 Llh2vcgS8L8uSiB7WBkW12d7BaS2Hd8vkU/ykm8eBh66DpywY5GWF/h5vnOWTJavGpmv eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx2vq4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:07 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2143lK6o029165;
        Fri, 4 Feb 2022 04:20:07 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx2vq3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:07 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144DTQW021513;
        Fri, 4 Feb 2022 04:20:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3e0r0y92pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144K1Dl39322096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:20:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D066A4055;
        Fri,  4 Feb 2022 04:20:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B284A4051;
        Fri,  4 Feb 2022 04:20:00 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:20:00 +0000 (GMT)
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
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 03/10] selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
Date:   Fri,  4 Feb 2022 05:19:48 +0100
Message-Id: <20220204041955.1958263-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M3JAOWDWGGsQpneh5-eneqqDUfib5hCz
X-Proofpoint-GUID: ORp3c9-ZIZS3RfgP9WuS4UJ_YUDPyvMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_syscall_macro reads a long argument into an int variable, which
produces a wrong value on big-endian systems. Fix by reading the
argument into an intermediate long variable first.

Fixes: 77fc0330dfe5 ("selftests/bpf: Add a test to confirm PT_REGS_PARM4_SYSCALL")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index c8e60220cda8..f5c6ef2ff6d1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -28,6 +28,7 @@ int BPF_KPROBE(handle_sys_prctl)
 {
 	struct pt_regs *real_regs;
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	unsigned long tmp;
 
 	if (pid != filter_pid)
 		return 0;
@@ -35,7 +36,9 @@ int BPF_KPROBE(handle_sys_prctl)
 	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
 
 	/* test for PT_REGS_PARM */
-	bpf_probe_read_kernel(&arg1, sizeof(arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
+
+	bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(real_regs));
+	arg1 = tmp;
 	bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
 	bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
 	bpf_probe_read_kernel(&arg4_cx, sizeof(arg4_cx), &PT_REGS_PARM4(real_regs));
-- 
2.34.1

