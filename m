Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC04A9879
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 12:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358436AbiBDLgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 06:36:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358414AbiBDLgS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 06:36:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214AEK3I017304;
        Fri, 4 Feb 2022 11:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9Q4lsFLNw8guNUfEkFdBVG/wBt5/Ki22kHIv1luHzdw=;
 b=jRMmHmeTv32Exr3dBLVS3yzqFwVchCacQ/aKb+16ntyL9x7D6LavhQsJ8mnHbpbANqrh
 rfiY+TTx+LnqC9v1W1t1Hf9TFySh4BIChaFKOVVKelC8QGxskEGaISE2V25s7WQ7S7lu
 K5IBrPeOOxofqfb+Xfr5FkODDZIih3H4SUwsrC60Nz1iKDCuDSGF4cT8/Zoj2SaCdMSU
 1HeA1NLFvvYGezEDLvpG840mX4M66qmFLj1iQL28kXaeifqZUc8e562d/pTJVvJB97/i
 5WuVbFW3MejLrqu2g1I3qDLz8GyMP/05Gn2efd1sL15VeT0jNDO9m52QY5w4Rx+E5HfD rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx93ka1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214BW6Pd008669;
        Fri, 4 Feb 2022 11:36:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx93k9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214BXFNc001057;
        Fri, 4 Feb 2022 11:36:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3e0r0v3wvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:36:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214BZsNQ41091340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 11:35:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 661CF11C04A;
        Fri,  4 Feb 2022 11:35:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FA611C050;
        Fri,  4 Feb 2022 11:35:52 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.69.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 11:35:51 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Use correct pt_regs on architectures without syscall wrapper
Date:   Fri,  4 Feb 2022 17:05:18 +0530
Message-Id: <17d8062517c4cfc4ee224fb0d49a4b84200557ca.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VXJuDXbYRKEJEXDoB_CC6lo5KA0730UZ
X-Proofpoint-ORIG-GUID: AscjJ4pC5jYiHMwKyV5nhSC-XIunf9zS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040063
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On architectures that are not using a syscall wrapper, syscall
parameters can be accessed directly from the bpf prog ctx. Fix
bpf_syscall_macro prog accordingly.

Fixes: 77fc0330dfe5ab ("selftests/bpf: Add a test to confirm PT_REGS_PARM4_SYSCALL")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index c8e60220cda855..12ec4b71f14aeb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -32,7 +32,11 @@ int BPF_KPROBE(handle_sys_prctl)
 	if (pid != filter_pid)
 		return 0;
 
+#if SYSCALL_WRAPPER == 1
 	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+#else
+	real_regs = (struct pt_regs *)ctx;
+#endif
 
 	/* test for PT_REGS_PARM */
 	bpf_probe_read_kernel(&arg1, sizeof(arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
-- 
2.34.1

