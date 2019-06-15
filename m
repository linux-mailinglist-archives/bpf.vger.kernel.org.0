Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8584F471CD
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFOTMe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 15 Jun 2019 15:12:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfFOTMe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 15 Jun 2019 15:12:34 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5FJBUMd013121
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 12:12:33 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4vq414a5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 12:12:33 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 15 Jun 2019 12:12:31 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 3BEBB760AA7; Sat, 15 Jun 2019 12:12:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 2/9] selftests/bpf: fix tests due to const spill/fill
Date:   Sat, 15 Jun 2019 12:12:18 -0700
Message-ID: <20190615191225.2409862-3-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190615191225.2409862-1-ast@kernel.org>
References: <20190615191225.2409862-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=482 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906150181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

fix tests that incorrectly assumed that the verifier
cannot track constants through stack.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 .../bpf/verifier/direct_packet_access.c       |  3 +-
 .../bpf/verifier/helper_access_var_len.c      | 28 ++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
index d5c596fdc4b9..2c5fbe7bcd27 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -511,7 +511,8 @@
 		    offsetof(struct __sk_buff, data)),
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
 		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_IMM(BPF_REG_0, 0xffffffff),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+		    offsetof(struct __sk_buff, mark)),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 1f39d845c64f..67ab12410050 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -29,9 +29,9 @@
 {
 	"helper access to variable memory: stack, bitwise AND, zero included",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
@@ -46,9 +46,9 @@
 {
 	"helper access to variable memory: stack, bitwise AND + JMP, wrong max",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 65),
@@ -122,9 +122,9 @@
 {
 	"helper access to variable memory: stack, JMP, bounds + offset",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 5),
@@ -143,9 +143,9 @@
 {
 	"helper access to variable memory: stack, JMP, wrong max",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 65, 4),
@@ -163,9 +163,9 @@
 {
 	"helper access to variable memory: stack, JMP, no max check",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_MOV64_IMM(BPF_REG_4, 0),
@@ -183,9 +183,9 @@
 {
 	"helper access to variable memory: stack, JMP, no min check",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
@@ -201,9 +201,9 @@
 {
 	"helper access to variable memory: stack, JMP (signed), no min check",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_MOV64_IMM(BPF_REG_2, 16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, 64, 3),
@@ -244,6 +244,7 @@
 {
 	"helper access to variable memory: map, JMP, wrong max",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
@@ -251,7 +252,7 @@
 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) + 1, 4),
@@ -262,7 +263,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_48b = { 3 },
+	.fixup_map_hash_48b = { 4 },
 	.errstr = "invalid access to map value, value_size=48 off=0 size=49",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -296,6 +297,7 @@
 {
 	"helper access to variable memory: map adjusted, JMP, wrong max",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
@@ -304,7 +306,7 @@
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 20),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
 	BPF_JMP_IMM(BPF_JSGT, BPF_REG_2, sizeof(struct test_val) - 19, 4),
@@ -315,7 +317,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_48b = { 3 },
+	.fixup_map_hash_48b = { 4 },
 	.errstr = "R1 min value is outside of the array range",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
@@ -337,8 +339,8 @@
 {
 	"helper access to variable memory: size > 0 not allowed on NULL (ARG_PTR_TO_MEM_OR_NULL)",
 	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
@@ -562,6 +564,7 @@
 {
 	"helper access to variable memory: 8 bytes leak",
 	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -572,7 +575,6 @@
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
-- 
2.20.0

