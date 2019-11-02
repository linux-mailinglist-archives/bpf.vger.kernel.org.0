Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136FAED0C0
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2019 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKBWBN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 2 Nov 2019 18:01:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727300AbfKBWBM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 2 Nov 2019 18:01:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA2LxW5P018128
        for <bpf@vger.kernel.org>; Sat, 2 Nov 2019 15:01:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w17hpt2tn-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2019 15:01:11 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 15:00:31 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id ECCCA760F5C; Sat,  2 Nov 2019 15:00:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <peterz@infradead.org>,
        <rostedt@goodmis.org>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/7] bpf: refactor x86 JIT into helpers
Date:   Sat, 2 Nov 2019 15:00:20 -0700
Message-ID: <20191102220025.2475981-3-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102220025.2475981-1-ast@kernel.org>
References: <20191102220025.2475981-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-02_13:2019-11-01,2019-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=595
 spamscore=0 suspectscore=1 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911020218
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor x86 JITing of LDX, STX, CALL instructions into separate helper
functions.  No functional changes in LDX and STX helpers.  There is a minor
change in CALL helper. It will populate target address correctly on the first
pass of JIT instead of second pass. That won't reduce total number of JIT
passes though.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 151 +++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 54 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8cd23d8309bf..e73fc8a6d665 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -390,6 +390,100 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
 	*pprog = prog;
 }
 
+/* LDX: dst_reg = *(u8*)(src_reg + off) */
+static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	switch (size) {
+	case BPF_B:
+		/* Emit 'movzx rax, byte ptr [rax + off]' */
+		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB6);
+		break;
+	case BPF_H:
+		/* Emit 'movzx rax, word ptr [rax + off]' */
+		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB7);
+		break;
+	case BPF_W:
+		/* Emit 'mov eax, dword ptr [rax+0x14]' */
+		if (is_ereg(dst_reg) || is_ereg(src_reg))
+			EMIT2(add_2mod(0x40, src_reg, dst_reg), 0x8B);
+		else
+			EMIT1(0x8B);
+		break;
+	case BPF_DW:
+		/* Emit 'mov rax, qword ptr [rax+0x14]' */
+		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
+		break;
+	}
+	/*
+	 * If insn->off == 0 we can save one extra byte, but
+	 * special case of x86 R13 which always needs an offset
+	 * is not worth the hassle
+	 */
+	if (is_imm8(off))
+		EMIT2(add_2reg(0x40, src_reg, dst_reg), off);
+	else
+		EMIT1_off32(add_2reg(0x80, src_reg, dst_reg), off);
+	*pprog = prog;
+}
+
+/* STX: *(u8*)(dst_reg + off) = src_reg */
+static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	switch (size) {
+	case BPF_B:
+		/* Emit 'mov byte ptr [rax + off], al' */
+		if (is_ereg(dst_reg) || is_ereg(src_reg) ||
+		    /* We have to add extra byte for x86 SIL, DIL regs */
+		    src_reg == BPF_REG_1 || src_reg == BPF_REG_2)
+			EMIT2(add_2mod(0x40, dst_reg, src_reg), 0x88);
+		else
+			EMIT1(0x88);
+		break;
+	case BPF_H:
+		if (is_ereg(dst_reg) || is_ereg(src_reg))
+			EMIT3(0x66, add_2mod(0x40, dst_reg, src_reg), 0x89);
+		else
+			EMIT2(0x66, 0x89);
+		break;
+	case BPF_W:
+		if (is_ereg(dst_reg) || is_ereg(src_reg))
+			EMIT2(add_2mod(0x40, dst_reg, src_reg), 0x89);
+		else
+			EMIT1(0x89);
+		break;
+	case BPF_DW:
+		EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
+		break;
+	}
+	if (is_imm8(off))
+		EMIT2(add_2reg(0x40, dst_reg, src_reg), off);
+	else
+		EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
+			    off);
+	*pprog = prog;
+}
+
+static int emit_call(u8 **pprog, void *func, void *ip)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	s64 offset;
+
+	offset = func - (ip + 5);
+	if (!is_simm32(offset)) {
+		pr_err("Target call %p is out of range\n", func);
+		return -EINVAL;
+	}
+	EMIT1_off32(0xE8, offset);
+	*pprog = prog;
+	return 0;
+}
 
 static bool ex_handler_bpf(const struct exception_table_entry *x,
 			   struct pt_regs *regs, int trapnr,
@@ -773,68 +867,22 @@ st:			if (is_imm8(insn->off))
 
 			/* STX: *(u8*)(dst_reg + off) = src_reg */
 		case BPF_STX | BPF_MEM | BPF_B:
-			/* Emit 'mov byte ptr [rax + off], al' */
-			if (is_ereg(dst_reg) || is_ereg(src_reg) ||
-			    /* We have to add extra byte for x86 SIL, DIL regs */
-			    src_reg == BPF_REG_1 || src_reg == BPF_REG_2)
-				EMIT2(add_2mod(0x40, dst_reg, src_reg), 0x88);
-			else
-				EMIT1(0x88);
-			goto stx;
 		case BPF_STX | BPF_MEM | BPF_H:
-			if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT3(0x66, add_2mod(0x40, dst_reg, src_reg), 0x89);
-			else
-				EMIT2(0x66, 0x89);
-			goto stx;
 		case BPF_STX | BPF_MEM | BPF_W:
-			if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT2(add_2mod(0x40, dst_reg, src_reg), 0x89);
-			else
-				EMIT1(0x89);
-			goto stx;
 		case BPF_STX | BPF_MEM | BPF_DW:
-			EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
-stx:			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
-					    insn->off);
+			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			break;
 
 			/* LDX: dst_reg = *(u8*)(src_reg + off) */
 		case BPF_LDX | BPF_MEM | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
-			/* Emit 'movzx rax, byte ptr [rax + off]' */
-			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB6);
-			goto ldx;
 		case BPF_LDX | BPF_MEM | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_H:
-			/* Emit 'movzx rax, word ptr [rax + off]' */
-			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB7);
-			goto ldx;
 		case BPF_LDX | BPF_MEM | BPF_W:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
-			/* Emit 'mov eax, dword ptr [rax+0x14]' */
-			if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT2(add_2mod(0x40, src_reg, dst_reg), 0x8B);
-			else
-				EMIT1(0x8B);
-			goto ldx;
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
-			/* Emit 'mov rax, qword ptr [rax+0x14]' */
-			EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
-ldx:			/*
-			 * If insn->off == 0 we can save one extra byte, but
-			 * special case of x86 R13 which always needs an offset
-			 * is not worth the hassle
-			 */
-			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, src_reg, dst_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, src_reg, dst_reg),
-					    insn->off);
+			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
 				struct exception_table_entry *ex;
 				u8 *_insn = image + proglen;
@@ -899,13 +947,8 @@ xadd:			if (is_imm8(insn->off))
 			/* call */
 		case BPF_JMP | BPF_CALL:
 			func = (u8 *) __bpf_call_base + imm32;
-			jmp_offset = func - (image + addrs[i]);
-			if (!imm32 || !is_simm32(jmp_offset)) {
-				pr_err("unsupported BPF func %d addr %p image %p\n",
-				       imm32, func, image);
+			if (!imm32 || emit_call(&prog, func, image + addrs[i - 1]))
 				return -EINVAL;
-			}
-			EMIT1_off32(0xE8, jmp_offset);
 			break;
 
 		case BPF_JMP | BPF_TAIL_CALL:
-- 
2.23.0

