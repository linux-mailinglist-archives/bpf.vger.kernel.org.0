Return-Path: <bpf+bounces-5388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D817D75A2FF
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51218281B7D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365A263C1;
	Thu, 20 Jul 2023 00:01:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4F182AD
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:01:37 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262C1BF2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMLrRH024047
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GILcAIgJVUz1bSAxlmpDPQV7hE6vhsuPVVRF+zl4ofA=;
 b=RkRf2kHAjntgegDw17ef/SBTCN/Nisujv0OJ8Jd7Kqh4BCFHBcfOToyq5ys7ffgjLAo+
 ftwQSxxOI6M+j7Q+feoRntmwufqR8Vi3NkqjsC8N3M7CE0bDNvnD+VueUZIhP9Tp48gI
 yMbAMSC29g3Tnh2Zo50uHlK5EbFMzT129EY= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx7na8k6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:24 -0700
Received: from twshared8006.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:23 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 20FC42354E794; Wed, 19 Jul 2023 17:01:09 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 01/17] bpf: Support new sign-extension load insns
Date: Wed, 19 Jul 2023 17:01:09 -0700
Message-ID: <20230720000109.101613-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _CSTfDOi_4K8xXWtwbM4987xuDNLQCOB
X-Proofpoint-GUID: _CSTfDOi_4K8xXWtwbM4987xuDNLQCOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interpreter/jit support for new sign-extension load insns
which adds a new mode (BPF_MEMSX).
Also add verifier support to recognize these insns and to
do proper verification with new insns. In verifier, besides
to deduce proper bounds for the dst_reg, probed memory access
is also properly handled.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    |  42 ++++++++-
 include/linux/filter.h         |   3 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/core.c              |  21 +++++
 kernel/bpf/verifier.c          | 150 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |   1 +
 6 files changed, 191 insertions(+), 27 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 83c4b45dc65f..54478a9c93e1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -779,6 +779,29 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_r=
eg, u32 src_reg, int off)
 	*pprog =3D prog;
 }
=20
+/* LDSX: dst_reg =3D *(s8*)(src_reg + off) */
+static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, in=
t off)
+{
+	u8 *prog =3D *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* Emit 'movsx rax, byte ptr [rax + off]' */
+		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBE);
+		break;
+	case BPF_H:
+		/* Emit 'movsx rax, word ptr [rax + off]' */
+		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBF);
+		break;
+	case BPF_W:
+		/* Emit 'movsx rax, dword ptr [rax+0x14]' */
+		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x63);
+		break;
+	}
+	emit_insn_suffix(&prog, src_reg, dst_reg, off);
+	*pprog =3D prog;
+}
+
 /* STX: *(u8*)(dst_reg + off) =3D src_reg */
 static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int=
 off)
 {
@@ -1370,9 +1393,17 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+			/* LDXS: dst_reg =3D *(s8*)(src_reg + off) */
+		case BPF_LDX | BPF_MEMSX | BPF_B:
+		case BPF_LDX | BPF_MEMSX | BPF_H:
+		case BPF_LDX | BPF_MEMSX | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off =3D insn->off;
=20
-			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
+			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
+			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
 				/* Conservatively check that src_reg + insn->off is a kernel address=
:
 				 *   src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE
 				 * src_reg is used as scratch for src_reg +=3D insn->off and restore=
d
@@ -1415,8 +1446,13 @@ st:			if (is_imm8(insn->off))
 				start_of_ldx =3D prog;
 				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
 			}
-			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
-			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
+			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX ||
+			    BPF_MODE(insn->code) =3D=3D BPF_MEMSX)
+				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			else
+				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
+			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) {
 				struct exception_table_entry *ex;
 				u8 *_insn =3D image + proglen + (start_of_ldx - temp);
 				s64 delta;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f69114083ec7..a93242b5516b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -69,6 +69,9 @@ struct ctl_table_header;
 /* unused opcode to mark special load instruction. Same as BPF_ABS */
 #define BPF_PROBE_MEM	0x20
=20
+/* unused opcode to mark special ldsx instruction. Same as BPF_IND */
+#define BPF_PROBE_MEMSX	0x40
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 739c15906a65..651a34511780 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -19,6 +19,7 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
+#define BPF_MEMSX	0x80	/* load with sign extension */
 #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
 #define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..01b72fc001f6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1610,6 +1610,9 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(LDX, MEM, H),			\
 	INSN_3(LDX, MEM, W),			\
 	INSN_3(LDX, MEM, DW),			\
+	INSN_3(LDX, MEMSX, B),			\
+	INSN_3(LDX, MEMSX, H),			\
+	INSN_3(LDX, MEMSX, W),			\
 	/*   Immediate based. */		\
 	INSN_3(LD, IMM, DW)
=20
@@ -1666,6 +1669,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
 		[BPF_LDX | BPF_PROBE_MEM | BPF_H] =3D &&LDX_PROBE_MEM_H,
 		[BPF_LDX | BPF_PROBE_MEM | BPF_W] =3D &&LDX_PROBE_MEM_W,
 		[BPF_LDX | BPF_PROBE_MEM | BPF_DW] =3D &&LDX_PROBE_MEM_DW,
+		[BPF_LDX | BPF_PROBE_MEMSX | BPF_B] =3D &&LDX_PROBE_MEMSX_B,
+		[BPF_LDX | BPF_PROBE_MEMSX | BPF_H] =3D &&LDX_PROBE_MEMSX_H,
+		[BPF_LDX | BPF_PROBE_MEMSX | BPF_W] =3D &&LDX_PROBE_MEMSX_W,
 	};
 #undef BPF_INSN_3_LBL
 #undef BPF_INSN_2_LBL
@@ -1942,6 +1948,21 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn)
 	LDST(DW, u64)
 #undef LDST
=20
+#define LDSX(SIZEOP, SIZE)						\
+	LDX_MEMSX_##SIZEOP:						\
+		DST =3D *(SIZE *)(unsigned long) (SRC + insn->off);	\
+		CONT;							\
+	LDX_PROBE_MEMSX_##SIZEOP:					\
+		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
+				      (const void *)(long) (SRC + insn->off));	\
+		DST =3D *((SIZE *)&DST);					\
+		CONT;
+
+	LDSX(B,   s8)
+	LDSX(H,  s16)
+	LDSX(W,  s32)
+#undef LDSX
+
 #define ATOMIC_ALU_OP(BOP, KOP)						\
 		case BOP:						\
 			if (BPF_SIZE(insn->code) =3D=3D BPF_W)		\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 803b91135ca0..79c0cd50ec59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5809,6 +5809,94 @@ static void coerce_reg_to_size(struct bpf_reg_stat=
e *reg, int size)
 	__reg_combine_64_into_32(reg);
 }
=20
+static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
+{
+	if (size =3D=3D 1) {
+		reg->smin_value =3D reg->s32_min_value =3D S8_MIN;
+		reg->smax_value =3D reg->s32_max_value =3D S8_MAX;
+	} else if (size =3D=3D 2) {
+		reg->smin_value =3D reg->s32_min_value =3D S16_MIN;
+		reg->smax_value =3D reg->s32_max_value =3D S16_MAX;
+	} else {
+		/* size =3D=3D 4 */
+		reg->smin_value =3D reg->s32_min_value =3D S32_MIN;
+		reg->smax_value =3D reg->s32_max_value =3D S32_MAX;
+	}
+	reg->umin_value =3D reg->u32_min_value =3D 0;
+	reg->umax_value =3D U64_MAX;
+	reg->u32_max_value =3D U32_MAX;
+	reg->var_off =3D tnum_unknown;
+}
+
+static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
+{
+	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
+	u64 top_smax_value, top_smin_value;
+	u64 num_bits =3D size * 8;
+
+	if (tnum_is_const(reg->var_off)) {
+		u64_cval =3D reg->var_off.value;
+		if (size =3D=3D 1)
+			reg->var_off =3D tnum_const((s8)u64_cval);
+		else if (size =3D=3D 2)
+			reg->var_off =3D tnum_const((s16)u64_cval);
+		else
+			/* size =3D=3D 4 */
+			reg->var_off =3D tnum_const((s32)u64_cval);
+
+		u64_cval =3D reg->var_off.value;
+		reg->smax_value =3D reg->smin_value =3D u64_cval;
+		reg->umax_value =3D reg->umin_value =3D u64_cval;
+		reg->s32_max_value =3D reg->s32_min_value =3D u64_cval;
+		reg->u32_max_value =3D reg->u32_min_value =3D u64_cval;
+		return;
+	}
+
+	top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bits;
+	top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bits;
+
+	if (top_smax_value !=3D top_smin_value)
+		goto out;
+
+	/* find the s64_min and s64_min after sign extension */
+	if (size =3D=3D 1) {
+		init_s64_max =3D (s8)reg->smax_value;
+		init_s64_min =3D (s8)reg->smin_value;
+	} else if (size =3D=3D 2) {
+		init_s64_max =3D (s16)reg->smax_value;
+		init_s64_min =3D (s16)reg->smin_value;
+	} else {
+		init_s64_max =3D (s32)reg->smax_value;
+		init_s64_min =3D (s32)reg->smin_value;
+	}
+
+	s64_max =3D max(init_s64_max, init_s64_min);
+	s64_min =3D min(init_s64_max, init_s64_min);
+
+	if (s64_max >=3D 0 && s64_min >=3D 0) {
+		reg->smin_value =3D reg->s32_min_value =3D s64_min;
+		reg->smax_value =3D reg->s32_max_value =3D s64_max;
+		reg->umin_value =3D reg->u32_min_value =3D s64_min;
+		reg->umax_value =3D reg->u32_max_value =3D s64_max;
+		reg->var_off =3D tnum_range(s64_min, s64_max);
+		return;
+	}
+
+	if (s64_min < 0 && s64_max < 0) {
+		reg->smin_value =3D reg->s32_min_value =3D s64_min;
+		reg->smax_value =3D reg->s32_max_value =3D s64_max;
+		reg->umin_value =3D (u64)s64_min;
+		reg->umax_value =3D (u64)s64_max;
+		reg->u32_min_value =3D (u32)s64_min;
+		reg->u32_max_value =3D (u32)s64_max;
+		reg->var_off =3D tnum_range((u64)s64_min, (u64)s64_max);
+		return;
+	}
+
+out:
+	set_sext64_default_val(reg, size);
+}
+
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
 {
 	/* A map is considered read-only if the following condition are true:
@@ -5829,7 +5917,8 @@ static bool bpf_map_is_rdonly(const struct bpf_map =
*map)
 	       !bpf_map_write_active(map);
 }
=20
-static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u=
64 *val)
+static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u=
64 *val,
+			       bool is_ldsx)
 {
 	void *ptr;
 	u64 addr;
@@ -5842,13 +5931,13 @@ static int bpf_map_direct_read(struct bpf_map *ma=
p, int off, int size, u64 *val)
=20
 	switch (size) {
 	case sizeof(u8):
-		*val =3D (u64)*(u8 *)ptr;
+		*val =3D is_ldsx ? (s64)*(s8 *)ptr : (u64)*(u8 *)ptr;
 		break;
 	case sizeof(u16):
-		*val =3D (u64)*(u16 *)ptr;
+		*val =3D is_ldsx ? (s64)*(s16 *)ptr : (u64)*(u16 *)ptr;
 		break;
 	case sizeof(u32):
-		*val =3D (u64)*(u32 *)ptr;
+		*val =3D is_ldsx ? (s64)*(s32 *)ptr : (u64)*(u32 *)ptr;
 		break;
 	case sizeof(u64):
 		*val =3D *(u64 *)ptr;
@@ -6267,7 +6356,7 @@ static int check_stack_access_within_bounds(
  */
 static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
u32 regno,
 			    int off, int bpf_size, enum bpf_access_type t,
-			    int value_regno, bool strict_alignment_once)
+			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	struct bpf_reg_state *reg =3D regs + regno;
@@ -6328,7 +6417,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 				u64 val =3D 0;
=20
 				err =3D bpf_map_direct_read(map, map_off, size,
-							  &val);
+							  &val, is_ldsx);
 				if (err)
 					return err;
=20
@@ -6498,8 +6587,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
=20
 	if (!err && size < BPF_REG_SIZE && value_regno >=3D 0 && t =3D=3D BPF_R=
EAD &&
 	    regs[value_regno].type =3D=3D SCALAR_VALUE) {
-		/* b/h/w load zero-extends, mark upper bits as known 0 */
-		coerce_reg_to_size(&regs[value_regno], size);
+		if (!is_ldsx)
+			/* b/h/w load zero-extends, mark upper bits as known 0 */
+			coerce_reg_to_size(&regs[value_regno], size);
+		else
+			coerce_reg_to_size_sx(&regs[value_regno], size);
 	}
 	return err;
 }
@@ -6591,17 +6683,17 @@ static int check_atomic(struct bpf_verifier_env *=
env, int insn_idx, struct bpf_i
 	 * case to simulate the register fill.
 	 */
 	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1, true);
+			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >=3D 0)
 		err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true);
+				       true, false);
 	if (err)
 		return err;
=20
 	/* Check whether we can write into the same memory. */
 	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
=20
@@ -6847,7 +6939,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
=20
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false);
+						atype, -1, false, false);
 		}
=20
 		fallthrough;
@@ -7219,7 +7311,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
 			err =3D check_mem_access(env, insn_idx, regno,
-					       i, BPF_DW, BPF_WRITE, -1, false);
+					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
 		}
@@ -7312,7 +7404,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
=20
 		for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_SIZE) {
 			err =3D check_mem_access(env, insn_idx, regno,
-					       i, BPF_DW, BPF_WRITE, -1, false);
+					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
 		}
@@ -9456,7 +9548,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	 */
 	for (i =3D 0; i < meta.access_size; i++) {
 		err =3D check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
-				       BPF_WRITE, -1, false);
+				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
 	}
@@ -16184,7 +16276,7 @@ static int save_aux_ptr_type(struct bpf_verifier_=
env *env, enum bpf_reg_type typ
 			 * Have to support a use case when one path through
 			 * the program yields TRUSTED pointer while another
 			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
-			 * BPF_PROBE_MEM.
+			 * BPF_PROBE_MEM/BPF_PROBE_MEMSX.
 			 */
 			*prev_type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
 		} else {
@@ -16325,7 +16417,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 */
 			err =3D check_mem_access(env, env->insn_idx, insn->src_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false);
+					       BPF_READ, insn->dst_reg, false,
+					       BPF_MODE(insn->code) =3D=3D BPF_MEMSX);
 			if (err)
 				return err;
=20
@@ -16362,7 +16455,7 @@ static int do_check(struct bpf_verifier_env *env)
 			/* check that memory (dst_reg + off) is writeable */
 			err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, insn->src_reg, false);
+					       BPF_WRITE, insn->src_reg, false, false);
 			if (err)
 				return err;
=20
@@ -16387,7 +16480,7 @@ static int do_check(struct bpf_verifier_env *env)
 			/* check that memory (dst_reg + off) is writeable */
 			err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, -1, false);
+					       BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
=20
@@ -16815,7 +16908,8 @@ static int resolve_pseudo_ldimm64(struct bpf_veri=
fier_env *env)
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
 		if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
-		    (BPF_MODE(insn->code) !=3D BPF_MEM || insn->imm !=3D 0)) {
+		    ((BPF_MODE(insn->code) !=3D BPF_MEM && BPF_MODE(insn->code) !=3D B=
PF_MEMSX) ||
+		    insn->imm !=3D 0)) {
 			verbose(env, "BPF_LDX uses reserved fields\n");
 			return -EINVAL;
 		}
@@ -17513,7 +17607,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 		if (insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_H) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_W) ||
-		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_DW)) {
+		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMSX | BPF_B) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMSX | BPF_H) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMSX | BPF_W)) {
 			type =3D BPF_READ;
 		} else if (insn->code =3D=3D (BPF_STX | BPF_MEM | BPF_B) ||
 			   insn->code =3D=3D (BPF_STX | BPF_MEM | BPF_H) ||
@@ -17572,8 +17669,12 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
 			if (type =3D=3D BPF_READ) {
-				insn->code =3D BPF_LDX | BPF_PROBE_MEM |
-					BPF_SIZE((insn)->code);
+				if (BPF_MODE(insn->code) =3D=3D BPF_MEM)
+					insn->code =3D BPF_LDX | BPF_PROBE_MEM |
+						     BPF_SIZE((insn)->code);
+				else
+					insn->code =3D BPF_LDX | BPF_PROBE_MEMSX |
+						     BPF_SIZE((insn)->code);
 				env->prog->aux->num_exentries++;
 			}
 			continue;
@@ -17761,7 +17862,8 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 		insn =3D func[i]->insnsi;
 		for (j =3D 0; j < func[i]->len; j++, insn++) {
 			if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
-			    BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM)
+			    (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX))
 				num_exentries++;
 		}
 		func[i]->aux->num_exentries =3D num_exentries;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 739c15906a65..651a34511780 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -19,6 +19,7 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
+#define BPF_MEMSX	0x80	/* load with sign extension */
 #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
 #define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
--=20
2.34.1


