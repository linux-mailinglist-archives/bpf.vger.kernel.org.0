Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87D1471A5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAWTSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 14:18:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbgAWTSV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 14:18:21 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NJGKW1003088
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9aLlaKbRfPJLC3YRcIrli8QHH/Ccs+D2aDX9HDd6fFI=;
 b=qCPSK3S/bvEQhjPnLbs7SptJc+3oRSPebejJkngcfFl3nIOR8+0b0H22Uq0rqBW2WD/y
 Ve4zOn7iofIlg3WFHmKAY+pFDmAoKAsqFZdzDhrTCpipTuRZryCo0SA3c6ZW19GgnXEY
 Yz7D0Sef0uFo/mxLfH/5wYkB7Cppv8OO68s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xpyheve19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 11:18:20 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 11:18:19 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AAF453702B1D; Thu, 23 Jan 2020 11:18:15 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] bpf: improve verifier handling for 32bit signed compare operations
Date:   Thu, 23 Jan 2020 11:18:15 -0800
Message-ID: <20200123191815.1364372-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123191815.1364298-1-yhs@fb.com>
References: <20200123191815.1364298-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_11:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001230144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b7a0d65d80a0 ("bpf, testing: Workaround a verifier failure
for test_progs") worked around a verifier failure where the
register is copied to another later refined register, but the
original register is used after refinement. Another similar example is
  https://lore.kernel.org/netdev/871019a0-71f8-c26d-0ae8-c7fd8c8867fc@fb.com/

LLVM commit https://reviews.llvm.org/D72787 added a phase
to adjust optimization such that the original register is
directly refined and used later. Another issue exposed by
the llvm is verifier cannot handle the following code:
  call bpf_strtoul
  if w0 s< 1 then ...
  if w0 s> 7 then ...
  ... use w0 ...

Unfortunately, the verifier is not able to handle the above
code well and will reject it.
  call bpf_strtoul
    R0_w=inv(id=0) R8=invP0
  if w0 s< 0x1 goto pc-22
    R0_w=inv(id=0) R8=invP0
  if w0 s> 0x7 goto pc-23
    R0=inv(id=0) R8=invP0
  w0 += w8
    R0_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R8=invP0

After "w0 += w8", we got a very conservative R0 value, which
later on caused verifier rejection.

This patch added two register states, s32_min_value and s32_max_value,
to bpf_reg_state. These two states capture the signed 32bit
min/max values refined due to 32bit signed sle/slt/sge/sgt comparisons.
  1. whenever refined s32_min_value, s32_max_value is captured, reg->var_off
     will be refined if possible.
  2. For any ALU32 operation where the dst_reg will have upper 32bit cleared,
     if s32_min_value >= 0 and s32_max_value has been narrowed due to previous
     signed compare operation, the dst_reg as an input can ignore upper 32bit values,
     this may produce better output dst_reg value range.
  3. s32_min_value and s32_max_value is reset if the corresponding register
     is redefined.

The following shows the new register states for the above example.
  call bpf_strtoul
    R0_w=inv(id=0) R8=invP0
  if w0 s< 0x1 goto pc-22
    R0_w=inv(id=0,smax_value=9223372034707292159,umax_value=18446744071562067967,
             s32_min_value=1,var_off=(0x0; 0xffffffff7fffffff))
    R8=invP0
  if w0 s> 0x7 goto pc-23
    R0=inv(id=0,smax_value=9223372032559808519,umax_value=18446744069414584327,
           s32_min_value=1,s32_max_value=7,var_off=(0x0; 0xffffffff00000007))
    R8=invP0
  w0 += w8
    R0_w=inv(id=0,umax_value=7,var_off=(0x0; 0x7)) R8=invP0

With the above LLVM patch and this commit, the original
workaround in Commit b7a0d65d80a0 is not needed any more.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 73 +++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5406e6e96585..d5694308466d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -123,6 +123,8 @@ struct bpf_reg_state {
 	s64 smax_value; /* maximum possible (s64)value */
 	u64 umin_value; /* minimum possible (u64)value */
 	u64 umax_value; /* maximum possible (u64)value */
+	s32 s32_min_value; /* minimum possible (s32)value */
+	s32 s32_max_value; /* maximum possible (s32)value */
 	/* parentage chain for liveness checking */
 	struct bpf_reg_state *parent;
 	/* Inside the callee two registers can be both PTR_TO_STACK like
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..c5d6835c38db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -543,6 +543,14 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 				if (reg->umax_value != U64_MAX)
 					verbose(env, ",umax_value=%llu",
 						(unsigned long long)reg->umax_value);
+				if (reg->s32_min_value != reg->umin_value &&
+				    reg->s32_min_value != S32_MIN)
+					verbose(env, ",s32_min_value=%d",
+						(int)reg->s32_min_value);
+				if (reg->s32_max_value != reg->umax_value &&
+				    reg->s32_max_value != S32_MAX)
+					verbose(env, ",s32_max_value=%d",
+						(int)reg->s32_max_value);
 				if (!tnum_is_unknown(reg->var_off)) {
 					char tn_buf[48];
 
@@ -923,6 +931,10 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	reg->smax_value = (s64)imm;
 	reg->umin_value = imm;
 	reg->umax_value = imm;
+
+	/* no need to be precise, just reset s32_{min,max}_value */
+	reg->s32_min_value = S32_MIN;
+	reg->s32_max_value = S32_MAX;
 }
 
 /* Mark the 'variable offset' part of a register as zero.  This should be
@@ -1043,6 +1055,12 @@ static void __reg_bound_offset32(struct bpf_reg_state *reg)
 	struct tnum hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);
 
 	reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
+
+	/* further refine based on s32 min/max values */
+	range = tnum_range(reg->s32_min_value, reg->s32_max_value);
+	lo32 = tnum_cast(reg->var_off, 4);
+	hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);
+	reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
 }
 
 /* Reset the min/max bounds of a register */
@@ -1052,6 +1070,8 @@ static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 	reg->smax_value = S64_MAX;
 	reg->umin_value = 0;
 	reg->umax_value = U64_MAX;
+	reg->s32_min_value = S32_MIN;
+	reg->s32_max_value = S32_MAX;
 }
 
 /* Mark a register as having a completely unknown (scalar) value. */
@@ -2788,7 +2808,8 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 /* truncate register to smaller size (in bytes)
  * must be called with size < BPF_REG_SIZE
  */
-static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
+static void coerce_reg_to_size(struct bpf_reg_state *reg, int size,
+			       bool ignore_upper_value)
 {
 	u64 mask;
 
@@ -2797,7 +2818,8 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 
 	/* fix arithmetic bounds */
 	mask = ((u64)1 << (size * 8)) - 1;
-	if ((reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
+	if (ignore_upper_value ||
+	    (reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
 		reg->umin_value &= mask;
 		reg->umax_value &= mask;
 	} else {
@@ -3066,7 +3088,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	if (!err && size < BPF_REG_SIZE && value_regno >= 0 && t == BPF_READ &&
 	    regs[value_regno].type == SCALAR_VALUE) {
 		/* b/h/w load zero-extends, mark upper bits as known 0 */
-		coerce_reg_to_size(&regs[value_regno], size);
+		coerce_reg_to_size(&regs[value_regno], size, false);
 	}
 	return err;
 }
@@ -4859,10 +4881,20 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		 * LSB, so it isn't sufficient to only truncate the output to
 		 * 32 bits.
 		 */
-		coerce_reg_to_size(dst_reg, 4);
-		coerce_reg_to_size(&src_reg, 4);
+		/* The upper 32bit value can be ignored in coerce_reg_to_size()
+		 * for dst_reg if we had a narrower range for 32bit subregister
+		 * based on previous tests.
+		 */
+		bool ignore_upper_value = dst_reg->s32_min_value >= 0 &&
+					  dst_reg->s32_max_value < S32_MAX;
+		coerce_reg_to_size(dst_reg, 4, ignore_upper_value);
+		coerce_reg_to_size(&src_reg, 4, false);
 	}
 
+	/* reset dst_reg s32_{min,max}_value */
+	dst_reg->s32_min_value = S32_MIN;
+	dst_reg->s32_max_value = S32_MAX;
+
 	smin_val = src_reg.smin_value;
 	smax_val = src_reg.smax_value;
 	umin_val = src_reg.umin_value;
@@ -5114,7 +5146,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 
 	if (BPF_CLASS(insn->code) != BPF_ALU64) {
 		/* 32-bit ALU ops are (32,32)->32 */
-		coerce_reg_to_size(dst_reg, 4);
+		coerce_reg_to_size(dst_reg, 4, false);
 	}
 
 	__reg_deduce_bounds(dst_reg);
@@ -5267,6 +5299,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		if (BPF_SRC(insn->code) == BPF_X) {
 			struct bpf_reg_state *src_reg = regs + insn->src_reg;
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
+			bool ignore_upper_value;
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				/* case: R1 = R2
@@ -5290,8 +5323,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
 				}
-				coerce_reg_to_size(dst_reg, 4);
+
+				ignore_upper_value = dst_reg->s32_min_value >= 0 &&
+						     dst_reg->s32_max_value < S32_MAX;
+				coerce_reg_to_size(dst_reg, 4, ignore_upper_value);
 			}
+
+			dst_reg->s32_min_value = S32_MIN;
+			dst_reg->s32_max_value = S32_MAX;
 		} else {
 			/* case: R = imm
 			 * remember the value we stored into this reg
@@ -5482,7 +5521,7 @@ static int is_branch_taken(struct bpf_reg_state *reg, u64 val, u8 opcode,
 		 * could truncate high bits and update umin/umax according to
 		 * information of low bits.
 		 */
-		coerce_reg_to_size(reg, 4);
+		coerce_reg_to_size(reg, 4, false);
 		/* smin/smax need special handling. For example, after coerce,
 		 * if smin_value is 0x00000000ffffffffLL, the value is -1 when
 		 * used as operand to JMP32. It is a negative number from s32's
@@ -5673,6 +5712,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		s64 false_smax = opcode == BPF_JSGT ? sval    : sval - 1;
 		s64 true_smin = opcode == BPF_JSGT ? sval + 1 : sval;
 
+		if (is_jmp32 && false_smax > S32_MIN && true_smin < S32_MAX) {
+			false_reg->s32_max_value =
+				min(false_reg->s32_max_value, (s32)false_smax);
+			true_reg->s32_min_value =
+				max(true_reg->s32_min_value, (s32)true_smin);
+		}
+
 		/* If the full s64 was not sign-extended from s32 then don't
 		 * deduct further info.
 		 */
@@ -5702,6 +5748,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		s64 false_smin = opcode == BPF_JSLT ? sval    : sval + 1;
 		s64 true_smax = opcode == BPF_JSLT ? sval - 1 : sval;
 
+		if (is_jmp32 && false_smin < S32_MAX && true_smax > S32_MIN) {
+			false_reg->s32_min_value =
+				max(false_reg->s32_min_value, (s32)false_smin);
+			true_reg->s32_max_value =
+				min(true_reg->s32_max_value, (s32)true_smax);
+		}
+
 		if (is_jmp32 && !cmp_val_with_extended_s64(sval, false_reg))
 			break;
 		false_reg->smin_value = max(false_reg->smin_value, false_smin);
@@ -6174,8 +6227,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		dst_lo = &lo_reg0;
 		src_lo = &lo_reg1;
-		coerce_reg_to_size(dst_lo, 4);
-		coerce_reg_to_size(src_lo, 4);
+		coerce_reg_to_size(dst_lo, 4, false);
+		coerce_reg_to_size(src_lo, 4, false);
 
 		if (dst_reg->type == SCALAR_VALUE &&
 		    src_reg->type == SCALAR_VALUE) {
-- 
2.17.1

