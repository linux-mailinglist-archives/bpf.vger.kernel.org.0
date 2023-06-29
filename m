Return-Path: <bpf+bounces-3709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50D74206F
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3791C203A9
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4833D74;
	Thu, 29 Jun 2023 06:37:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1715257
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:37:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328831727
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1ANkc012921
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mMiJ0FUYh6NiG0PvAZEUe8U3hhLwEmZ/xDfD68tp6cg=;
 b=D1KxQRZmIt06TBJPBQGLhUIE6erR423hea3hGyyvmFg4onXqZ6hu5TSmnP/duK1ydwfK
 rsZpt7BU2cxIBQycEHjdv7hCLKK57L+gSAfznsSP1lN/RJRhuLj00V/2dkCkGzePQzYv
 VTsXmTPD/FxagHeYvnlH+XY4/HhkkLjEeqs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgycyjax8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:31 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:28 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5213A221E7B00; Wed, 28 Jun 2023 23:37:21 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 01/13] bpf: Support new sign-extension load insns
Date: Wed, 28 Jun 2023 23:37:21 -0700
Message-ID: <20230629063721.1647917-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629063715.1646832-1-yhs@fb.com>
References: <20230629063715.1646832-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OXgmrk7aW3nGVyCxsdNOrLGy4HF9sr9F
X-Proofpoint-GUID: OXgmrk7aW3nGVyCxsdNOrLGy4HF9sr9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interpreter/jit support for new sign-extension load insns.
Also add basic verifier support so newer instruction can be
accepted by verifier.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    | 31 ++++++++++++++++++++++++++++++-
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/core.c              | 13 +++++++++++++
 kernel/bpf/verifier.c          |  8 ++++++--
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 438adb695daa..70d6a2c289ec 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -779,6 +779,29 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_r=
eg, u32 src_reg, int off)
 	*pprog =3D prog;
 }
=20
+/* LDX: dst_reg =3D *(s8*)(src_reg + off) */
+static void emit_lds(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int=
 off)
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
@@ -1370,6 +1393,9 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+		case BPF_LDX | BPF_MEMS | BPF_B:
+		case BPF_LDX | BPF_MEMS | BPF_H:
+		case BPF_LDX | BPF_MEMS | BPF_W:
 			insn_off =3D insn->off;
=20
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
@@ -1415,7 +1441,10 @@ st:			if (is_imm8(insn->off))
 				start_of_ldx =3D prog;
 				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
 			}
-			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			if (BPF_MODE(insn->code) =3D=3D BPF_MEMS)
+				emit_lds(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			else
+				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM) {
 				struct exception_table_entry *ex;
 				u8 *_insn =3D image + proglen + (start_of_ldx - temp);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..b28109bc5c54 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -19,6 +19,7 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
+#define BPF_MEMS	0x80	/* load with sign extension */
 #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
 #define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..acb7abd2eba0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1610,6 +1610,9 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(LDX, MEM, H),			\
 	INSN_3(LDX, MEM, W),			\
 	INSN_3(LDX, MEM, DW),			\
+	INSN_3(LDX, MEMS, B),			\
+	INSN_3(LDX, MEMS, H),			\
+	INSN_3(LDX, MEMS, W),			\
 	/*   Immediate based. */		\
 	INSN_3(LD, IMM, DW)
=20
@@ -1942,6 +1945,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn)
 	LDST(DW, u64)
 #undef LDST
=20
+#define LDS(SIZEOP, SIZE)						\
+	LDX_MEMS_##SIZEOP:						\
+		DST =3D *(SIZE *)(unsigned long) (SRC + insn->off);	\
+		CONT;
+
+	LDS(B,   s8)
+	LDS(H,  s16)
+	LDS(W,  s32)
+#undef LDS
+
 #define ATOMIC_ALU_OP(BOP, KOP)						\
 		case BOP:						\
 			if (BPF_SIZE(insn->code) =3D=3D BPF_W)		\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..212c367e2f46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16790,7 +16790,8 @@ static int resolve_pseudo_ldimm64(struct bpf_veri=
fier_env *env)
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
 		if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
-		    (BPF_MODE(insn->code) !=3D BPF_MEM || insn->imm !=3D 0)) {
+		    ((BPF_MODE(insn->code) !=3D BPF_MEM && BPF_MODE(insn->code) !=3D B=
PF_MEMS) ||
+		    insn->imm !=3D 0)) {
 			verbose(env, "BPF_LDX uses reserved fields\n");
 			return -EINVAL;
 		}
@@ -17488,7 +17489,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 		if (insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_H) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_W) ||
-		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_DW)) {
+		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMS | BPF_B) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMS | BPF_H) ||
+		    insn->code =3D=3D (BPF_LDX | BPF_MEMS | BPF_W)) {
 			type =3D BPF_READ;
 		} else if (insn->code =3D=3D (BPF_STX | BPF_MEM | BPF_B) ||
 			   insn->code =3D=3D (BPF_STX | BPF_MEM | BPF_H) ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 60a9d59beeab..b28109bc5c54 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -19,6 +19,7 @@
=20
 /* ld/ldx fields */
 #define BPF_DW		0x18	/* double word (64-bit) */
+#define BPF_MEMS	0x80	/* load with sign extension */
 #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
 #define BPF_XADD	0xc0	/* exclusive add - legacy name */
=20
--=20
2.34.1


