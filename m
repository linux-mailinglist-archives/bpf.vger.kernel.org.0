Return-Path: <bpf+bounces-13441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A57D9F9E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DFD1C21032
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2193C066;
	Fri, 27 Oct 2023 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FC8827
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C459AC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:41 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5hkh019728
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tyws7ggbx-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:40 -0700
Received: from twshared39705.02.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:37 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 212CA3A796688; Fri, 27 Oct 2023 11:14:18 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 12/23] bpf: generalize is_branch_taken() to work with two registers
Date: Fri, 27 Oct 2023 11:13:35 -0700
Message-ID: <20231027181346.4019398-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gY6bdCm5XjsZB_sQLzbJToelSScrScL7
X-Proofpoint-GUID: gY6bdCm5XjsZB_sQLzbJToelSScrScL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

While still assuming that second register is a constant, generalize
is_branch_taken-related code to accept two registers instead of register
plus explicit constant value. This also, as a side effect, allows to
simplify check_cond_jmp_op() by unifying BPF_K case with BPF_X case, for
which we use a fake register to represent BPF_K's imm constant as
a register.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa13f32751a1..fd328c579f10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14169,8 +14169,13 @@ static void find_good_pkt_pointers(struct bpf_ve=
rifier_state *vstate,
 	}));
 }
=20
-static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8 opc=
ode)
+/*
+ * <reg1> <op> <reg2>, currently assuming reg2 is a constant
+ */
+static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
 {
+	struct tnum subreg =3D tnum_subreg(reg1->var_off);
+	u32 val =3D (u32)tnum_subreg(reg2->var_off).value;
 	s32 sval =3D (s32)val;
=20
 	switch (opcode) {
@@ -14250,8 +14255,12 @@ static int is_branch32_taken(struct bpf_reg_stat=
e *reg1, u32 val, u8 opcode)
 }
=20
=20
-static int is_branch64_taken(struct bpf_reg_state *reg1, u64 val, u8 opc=
ode)
+/*
+ * <reg1> <op> <reg2>, currently assuming reg2 is a constant
+ */
+static int is_branch64_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2, u8 opcode)
 {
+	u64 val =3D reg2->var_off.value;
 	s64 sval =3D (s64)val;
=20
 	switch (opcode) {
@@ -14330,16 +14339,23 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg1, u64 val, u8 opcode)
 	return -1;
 }
=20
-/* compute branch direction of the expression "if (reg opcode val) goto =
target;"
+/* compute branch direction of the expression "if (<reg1> opcode <reg2>)=
 goto target;"
  * and return:
  *  1 - branch will be taken and "goto target" will be executed
  *  0 - branch will not be taken and fall-through to next insn
- * -1 - unknown. Example: "if (reg < 5)" is unknown when register value
+ * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register value
  *      range [0,10]
  */
-static int is_branch_taken(struct bpf_reg_state *reg1, u64 val, u8 opcod=
e,
-			   bool is_jmp32)
+static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
+			   u8 opcode, bool is_jmp32)
 {
+	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2-=
>var_off;
+	u64 val;
+
+	if (!tnum_is_const(reg2_tnum))
+		return -1;
+	val =3D reg2_tnum.value;
+
 	if (__is_pointer_value(false, reg1)) {
 		if (!reg_not_null(reg1))
 			return -1;
@@ -14361,8 +14377,8 @@ static int is_branch_taken(struct bpf_reg_state *=
reg1, u64 val, u8 opcode,
 	}
=20
 	if (is_jmp32)
-		return is_branch32_taken(reg1, val, opcode);
-	return is_branch64_taken(reg1, val, opcode);
+		return is_branch32_taken(reg1, reg2, opcode);
+	return is_branch64_taken(reg1, reg2, opcode);
 }
=20
 static int flip_opcode(u32 opcode)
@@ -14833,6 +14849,7 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 	struct bpf_reg_state *regs =3D this_branch->frame[this_branch->curframe=
]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg =3D NULL;
 	struct bpf_reg_state *eq_branch_regs;
+	struct bpf_reg_state fake_reg;
 	u8 opcode =3D BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred =3D -1;
@@ -14873,36 +14890,27 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
 			return -EINVAL;
 		}
+		src_reg =3D &fake_reg;
+		src_reg->type =3D SCALAR_VALUE;
+		__mark_reg_known(src_reg, insn->imm);
 	}
=20
 	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
=20
 	if (BPF_SRC(insn->code) =3D=3D BPF_K) {
-		pred =3D is_branch_taken(dst_reg, insn->imm, opcode, is_jmp32);
+		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
 		   is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
-		pred =3D is_branch_taken(dst_reg,
-				       tnum_subreg(src_reg->var_off).value,
-				       opcode,
-				       is_jmp32);
+		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
 		   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
-		pred =3D is_branch_taken(dst_reg,
-				       src_reg->var_off.value,
-				       opcode,
-				       is_jmp32);
+		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
 		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
-		pred =3D is_branch_taken(src_reg,
-				       tnum_subreg(dst_reg->var_off).value,
-				       flip_opcode(opcode),
-				       is_jmp32);
+		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_jmp=
32);
 	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
 		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
-		pred =3D is_branch_taken(src_reg,
-				       dst_reg->var_off.value,
-				       flip_opcode(opcode),
-				       is_jmp32);
+		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_jmp=
32);
 	} else if (reg_is_pkt_pointer_any(dst_reg) &&
 		   reg_is_pkt_pointer_any(src_reg) &&
 		   !is_jmp32) {
--=20
2.34.1


