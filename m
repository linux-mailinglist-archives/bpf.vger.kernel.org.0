Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7671471A6
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 20:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAWTSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 14:18:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbgAWTSY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 14:18:24 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NJH7oV030233
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=L9ZosEOYE0BzGPkMR0wmjKaYYifeozGziPjpKrEOeLY=;
 b=MuLlOPzc3Qhd5t1PC5X+da+HlSQlCtdReUsbzcAm+19H0Eros3boAokazLs1mSfuNoq+
 FoA7nC2uRFzRAVFeUb1jng3H6lTsbTKwiUXp8Ur4K/K1g9OFvyFOWSjpnyC+anKBl9+u
 tJyEPXnlAUlf/LhT19rRsttqOtKzQ33uoYg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xqgc5rcm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:22 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 11:18:21 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E4AE237029A3; Thu, 23 Jan 2020 11:18:16 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] selftests/bpf: add selftests for verifier handling 32bit signed compares
Date:   Thu, 23 Jan 2020 11:18:16 -0800
Message-ID: <20200123191816.1364546-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123191815.1364298-1-yhs@fb.com>
References: <20200123191815.1364298-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_11:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 mlxlogscore=676 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a few verifier tests for 32bit signed compares.
  $ ./test_verifier
  ...
  #557/p jsle32, jsge32, mov : combining range OK
  #558/p jslt32, jsgt32, add : combining range OK
  #559/p jslt32, jsgt32 : negative lower bound OK
  ...

Also reverted the workaround in test_sysctl_loop1.c since
the kernel verifier is able to handle the case now.
  $ ./test_progs
  ...
  #4/18 test_sysctl_loop1.o:OK
  ...
For non-alu32 mode where llvm optimization (https://reviews.llvm.org/D72787)
also kicked in, existing verifier can handle it well:
  $ ./test_progs-no-alu32
  ...
  #4/18 test_sysctl_loop1.o:OK
  ...

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  5 +-
 tools/testing/selftests/bpf/verifier/jmp32.c  | 76 +++++++++++++++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 458b0d69133e..ede7ce8e8a5c 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -44,10 +44,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	unsigned long tcp_mem[TCP_MEM_LOOPS] = {};
 	char value[MAX_VALUE_STR_LEN];
 	unsigned char i, off = 0;
-	/* a workaround to prevent compiler from generating
-	 * codes verifier cannot handle yet.
-	 */
-	volatile int ret;
+	int ret;
 
 	if (ctx->write)
 		return 0;
diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index bf0322eb5346..589fcc8c37fd 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -827,3 +827,79 @@
 	.result = ACCEPT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"jsle32, jsge32, mov : combining range",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_JMP32_IMM(BPF_JSLE, BPF_REG_0, 0, 4),
+	BPF_JMP32_IMM(BPF_JSGE, BPF_REG_0, 8, 3),
+	BPF_ALU32_REG(BPF_MOV, BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_1),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_8b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"jslt32, jsgt32, add : combining range",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_0, 1, 4),
+	BPF_JMP32_IMM(BPF_JSGT, BPF_REG_0, 4, 3),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_0),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"jslt32, jsgt32 : negative lower bound",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_0, -2, 4),
+	BPF_JMP32_IMM(BPF_JSGT, BPF_REG_0, 4, 3),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_0),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = REJECT,
+	.errstr = "R8 unbounded memory access, make sure to bounds check any array access into a map",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
-- 
2.17.1

