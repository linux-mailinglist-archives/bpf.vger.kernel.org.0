Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0901C1EC151
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFBRpK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 13:45:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgFBRpJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jun 2020 13:45:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052HWwP5072968;
        Tue, 2 Jun 2020 13:44:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dr8gx3qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 13:44:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052HeDnd027310;
        Tue, 2 Jun 2020 17:44:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 31bf47xg24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 17:44:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052Hhau163046026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 17:43:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E6A5204F;
        Tue,  2 Jun 2020 17:44:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.174.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9CFDA5204E;
        Tue,  2 Jun 2020 17:44:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] bpf, selftests: Use bpf_probe_read_kernel
Date:   Tue,  2 Jun 2020 19:44:48 +0200
Message-Id: <20200602174448.2501214-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020127
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
archs where they work") 44 verifier tests fail on s390 due to not having
bpf_probe_read anymore. Fix by using bpf_probe_read_kernel.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../testing/selftests/bpf/verifier/const_or.c |  8 ++--
 .../bpf/verifier/helper_access_var_len.c      | 44 +++++++++----------
 .../bpf/verifier/helper_value_access.c        | 36 +++++++--------
 .../testing/selftests/bpf/verifier/precise.c  |  8 ++--
 4 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/const_or.c b/tools/testing/selftests/bpf/verifier/const_or.c
index 84446dfc7c1d..6c214c58e8d4 100644
--- a/tools/testing/selftests/bpf/verifier/const_or.c
+++ b/tools/testing/selftests/bpf/verifier/const_or.c
@@ -6,7 +6,7 @@
 	BPF_MOV64_IMM(BPF_REG_2, 34),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_2, 13),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -20,7 +20,7 @@
 	BPF_MOV64_IMM(BPF_REG_2, 34),
 	BPF_ALU64_IMM(BPF_OR, BPF_REG_2, 24),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "invalid stack type R1 off=-48 access_size=58",
@@ -36,7 +36,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 13),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -51,7 +51,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 24),
 	BPF_ALU64_REG(BPF_OR, BPF_REG_2, BPF_REG_4),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "invalid stack type R1 off=-48 access_size=58",
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 67ab12410050..4da14770eba6 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -19,7 +19,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -36,7 +36,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "invalid indirect read from stack off -64+0 size 64",
@@ -55,7 +55,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -84,7 +84,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -112,7 +112,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -132,7 +132,7 @@
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 3),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -152,7 +152,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -171,7 +171,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -190,7 +190,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -208,7 +208,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 3),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -233,7 +233,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -259,7 +259,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -286,7 +286,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -313,7 +313,7 @@
 	BPF_MOV64_IMM(BPF_REG_4, 0),
 	BPF_JMP_REG(BPF_JSGE, BPF_REG_4, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -468,7 +468,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "R1 type=inv expected=fp",
@@ -481,7 +481,7 @@
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "R1 type=inv expected=fp",
@@ -495,7 +495,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.result = ACCEPT,
@@ -513,7 +513,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -534,7 +534,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -554,7 +554,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 8, 2),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
@@ -580,7 +580,7 @@
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_EXIT_INSN(),
 	},
@@ -607,7 +607,7 @@
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 32),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 32),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/helper_value_access.c b/tools/testing/selftests/bpf/verifier/helper_value_access.c
index 7572e403ddb9..4bf0df7258a5 100644
--- a/tools/testing/selftests/bpf/verifier/helper_value_access.c
+++ b/tools/testing/selftests/bpf/verifier/helper_value_access.c
@@ -10,7 +10,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -29,7 +29,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -67,7 +67,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val) + 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -87,7 +87,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -109,7 +109,7 @@
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) -	offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -129,7 +129,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -170,7 +170,7 @@
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) - offsetof(struct test_val, foo) + 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -191,7 +191,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -212,7 +212,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -235,7 +235,7 @@
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) - offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -256,7 +256,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -300,7 +300,7 @@
 		      sizeof(struct test_val) -
 		      offsetof(struct test_val, foo) + 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -322,7 +322,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -344,7 +344,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -368,7 +368,7 @@
 	BPF_MOV64_IMM(BPF_REG_2,
 		      sizeof(struct test_val) - offsetof(struct test_val, foo)),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -390,7 +390,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -433,7 +433,7 @@
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
@@ -458,7 +458,7 @@
 		      sizeof(struct test_val) -
 		      offsetof(struct test_val, foo) + 1),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 3 },
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 02151f8c940f..6dc8003ffc70 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -31,14 +31,14 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_array_48b = { 1 },
 	.result = VERBOSE_ACCEPT,
 	.errstr =
-	"26: (85) call bpf_probe_read#4\
+	"26: (85) call bpf_probe_read_kernel#113\
 	last_idx 26 first_idx 20\
 	regs=4 stack=0 before 25\
 	regs=4 stack=0 before 24\
@@ -91,7 +91,7 @@
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read),
+	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -99,7 +99,7 @@
 	.result = VERBOSE_ACCEPT,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr =
-	"26: (85) call bpf_probe_read#4\
+	"26: (85) call bpf_probe_read_kernel#113\
 	last_idx 26 first_idx 22\
 	regs=4 stack=0 before 25\
 	regs=4 stack=0 before 24\
-- 
2.25.4

