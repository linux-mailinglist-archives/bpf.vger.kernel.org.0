Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F564462C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFMQtr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 13 Jun 2019 12:49:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59184 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbfFMEUW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jun 2019 00:20:22 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D4FBc9019783
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 21:20:20 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t38w7151c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 21:20:20 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 21:20:19 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 986F6760CD6; Wed, 12 Jun 2019 21:20:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <ecree@solarflare.com>, <john.fastabend@gmail.com>,
        <andriin@fb.com>, <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 7/9] selftests/bpf: add basic verifier tests for loops
Date:   Wed, 12 Jun 2019 21:20:01 -0700
Message-ID: <20190613042003.3791852-8-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190613042003.3791852-1-ast@kernel.org>
References: <20190613042003.3791852-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130033
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set of tests is a rewrite of Edward's earlier tests:
https://patchwork.ozlabs.org/patch/877221/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/verifier/loops1.c | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/loops1.c

diff --git a/tools/testing/selftests/bpf/verifier/loops1.c b/tools/testing/selftests/bpf/verifier/loops1.c
new file mode 100644
index 000000000000..5e980a5ab69d
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/loops1.c
@@ -0,0 +1,161 @@
+{
+	"bounded loop, count to 4",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.retval = 4,
+},
+{
+	"bounded loop, count to 20",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 3),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 20, -2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"bounded loop, count from positive unknown to 4",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.retval = 4,
+},
+{
+	"bounded loop, count from totally unknown to 4",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"bounded loop, count to 4 with equality",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, -2),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"bounded loop, start in the middle",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_A(1),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "back-edge",
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.retval = 4,
+},
+{
+	"bounded loop containing a forward jump",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.retval = 4,
+},
+{
+	"bounded loop that jumps out rather than in",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_6, 10000, 2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_JMP_A(-4),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"infinite loop after a conditional jump",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 5),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, 2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_A(-2),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "program is too large",
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"bounded recursion",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 4, 1),
+	BPF_EXIT_INSN(),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, -5),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "back-edge",
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"infinite loop in two jumps",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_JMP_A(0),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 4, -2),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "loop detected",
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
+{
+	"infinite loop: three-jump trick",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+	BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 2, -11),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "loop detected",
+	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+},
-- 
2.20.0

