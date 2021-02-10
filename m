Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED69315CE9
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhBJCJB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 21:09:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14484 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234023AbhBJCIS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 21:08:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A25V6A063800;
        Tue, 9 Feb 2021 21:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=e5SIusN3L8DMRsl7PVFS8tzzdKuuboSc7YrcEjtHPco=;
 b=Gp4iSmalY7ct9M5V3ULh1k+dy1pjCbBeaGIhnWvgpD/QBbXuPFX2cc9/DyxADI6AeG0r
 4mF57uh1NFjP0bMzl1jTc638QZ4Nf88YiIKvZo8G989j2bnmUMnPt0/nFKqa9N9mFD+i
 woAolzdkAZfkG5PTrrqbMdvh1dPo8/l5/guTF/VFXRBH/kWUlzdp91ONzrlyPu7Ao3Rz
 z3bmrIlyKv5746bzlv58kUq/VgF/7v/XCYmIZqLCYp8+a5XEp2YXufOucQ05EJzlPWEF
 5XOg1NzVGzCT/x/VaJc0q/7U7Mb2ZIyPhau46TuVKruHnqfN5nGD4vg0ytXaexxabweL 3g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36m5d9sd3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 21:07:20 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A27IAZ002504;
        Wed, 10 Feb 2021 02:07:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch25ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 02:07:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A27FD742139954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 02:07:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4582842049;
        Wed, 10 Feb 2021 02:07:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C2142045;
        Wed, 10 Feb 2021 02:07:15 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 02:07:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix endianness issues in atomic tests
Date:   Wed, 10 Feb 2021 03:07:13 +0100
Message-Id: <20210210020713.77911-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100013
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Atomic tests store a DW, but then load it back as a W from the same
address. This doesn't work on big-endian systems, and since the point
of those tests is not testing narrow loads, fix simply by loading a
DW.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Fixes: 98d666d05a1d ("bpf: Add tests for new BPF atomic operations")
---
 tools/testing/selftests/bpf/verifier/atomic_and.c | 2 +-
 tools/testing/selftests/bpf/verifier/atomic_or.c  | 2 +-
 tools/testing/selftests/bpf/verifier/atomic_xor.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/atomic_and.c b/tools/testing/selftests/bpf/verifier/atomic_and.c
index 600bc5e0f143..1bdc8e6684f7 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_and.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_and.c
@@ -7,7 +7,7 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_AND, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x010) exit(2); */
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x010, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
index ebe6e51455ba..70f982e1f9f0 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_or.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -7,7 +7,7 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_OR, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x111) exit(2); */
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x111, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xor.c b/tools/testing/selftests/bpf/verifier/atomic_xor.c
index eb791e547b47..74e8fb46694b 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_xor.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_xor.c
@@ -7,7 +7,7 @@
 		BPF_MOV64_IMM(BPF_REG_1, 0x011),
 		BPF_ATOMIC_OP(BPF_DW, BPF_XOR, BPF_REG_10, BPF_REG_1, -8),
 		/* if (val != 0x101) exit(2); */
-		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x101, 2),
 		BPF_MOV64_IMM(BPF_REG_0, 2),
 		BPF_EXIT_INSN(),
-- 
2.29.2

