Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418B4A68AA
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 00:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiBAXmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 18:42:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242928AbiBAXmY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 18:42:24 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211LOM0A007767;
        Tue, 1 Feb 2022 23:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+LjoE0NZmu4eTgC5xdsneOk1/jfO4/mdoy6UnZQR+Ic=;
 b=i2iinbqDSV9s+eDr5kspTD9+5px76XvvH53LFgaEQeoWrMaxag2umbhrqcwEuaGRwi4X
 +uq+7SKDPBA8Am8x8vhXlGaaNDf9hy1tOX/01kOjgPpCKQrNSpeBSpxv+8CiDouwSX9j
 kj8c7XvLx6nsqvcCdqo9gyQgwBXVcZqKjLWapLCVY009aFCQmGbY1XCdVrj3ebWN/lb2
 ZRFNTNguHYsDbV3kxwJbYJTe98nCBq16VpOS3bqT29xFStN4rKl5vTbf7yuNgTgCSLYk
 bvATwYyz1GtTbVT6Ftgp9+nWIyiOPQYpJjuQqJlnIaT7RvAza4fV68I5hV2IYwit45ad cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dycrgsynu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211NcZeO021950;
        Tue, 1 Feb 2022 23:42:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dycrgsyn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211NdJ1c021094;
        Tue, 1 Feb 2022 23:42:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3dvvuj7gxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Ng4fj25887034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 23:42:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7445811C054;
        Tue,  1 Feb 2022 23:42:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07B3611C04A;
        Tue,  1 Feb 2022 23:42:04 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 23:42:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
Date:   Wed,  2 Feb 2022 00:41:59 +0100
Message-Id: <20220201234200.1836443-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201234200.1836443-1-iii@linux.ibm.com>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0GTTlWxycBvFuHs2AbwCoM4b1iX43l_J
X-Proofpoint-GUID: LHDFMotm4tDhT9Ehs8EpQAs_Wl4zQ1tQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010130
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

