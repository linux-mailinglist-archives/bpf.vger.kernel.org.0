Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9D104826
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 02:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUBka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Nov 2019 20:40:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfKUBka (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Nov 2019 20:40:30 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL1eSpS014567
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 17:40:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Q1SQV7Q22T8fXHsyR/sEXmDiJSseUHY0zEI1NnIMlJo=;
 b=ccErjOPoyl6shb5Evl/4q7w+tidl4XqSAHA7BPjU1No9XBEE5vwUjxnnCfYsadZP4WPw
 Bb+LWGmyjT1kgWpjPcavlHIDwb/EpC7SF7ULhvRQ55tWB1SaAyYPvBbe7xawyTLZIjCP
 gv0x2vqx4GUVK35GanE4wqSHW3a3oGo7Gpc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wd91hjrhf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 17:40:29 -0800
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 20 Nov 2019 17:40:26 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E8BD43703208; Wed, 20 Nov 2019 17:40:25 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] tools/bpf: add verifier tests for better jmp32 register bounds
Date:   Wed, 20 Nov 2019 17:40:25 -0800
Message-ID: <20191121014025.1700871-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121014024.1700638-1-yhs@fb.com>
References: <20191121014024.1700638-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 suspectscore=13 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=509 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210013
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three test cases are added.
Test 1: jmp32 'reg op imm'.
Test 2: jmp32 'reg op reg' where dst 'reg' has unknown constant
        and src 'reg' has known constant
Test 3: jmp32 'reg op reg' where dst 'reg' has known constant
        and src 'reg' has unknown constant

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/verifier/jmp32.c | 83 ++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index f0961c58581e..2db41dd85786 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -744,3 +744,86 @@
 	.result = ACCEPT,
 	.retval = 2,
 },
+{
+	"jgt32: range bound deduction, reg op imm",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_JMP32_IMM(BPF_JGT, BPF_REG_0, 1, 5),
+	BPF_MOV32_REG(BPF_REG_6, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_6),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+        BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"jgt32: range bound deduction, reg1 op reg2, reg1 unknown",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_MOV32_IMM(BPF_REG_2, 1),
+	BPF_JMP32_REG(BPF_JGT, BPF_REG_0, BPF_REG_2, 5),
+	BPF_MOV32_REG(BPF_REG_6, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_6),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+        BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"jle32: range bound deduction, reg1 op reg2, reg2 unknown",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_MOV32_IMM(BPF_REG_2, 1),
+	BPF_JMP32_REG(BPF_JLE, BPF_REG_2, BPF_REG_0, 5),
+	BPF_MOV32_REG(BPF_REG_6, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_6),
+	BPF_ST_MEM(BPF_B, BPF_REG_8, 0, 0),
+        BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
-- 
2.17.1

