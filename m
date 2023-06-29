Return-Path: <bpf+bounces-3711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE107742074
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11A3280D7F
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D053A1;
	Thu, 29 Jun 2023 06:37:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77715D2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:37:49 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21281727
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHwevI006893
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DXkSX1nG42pjM2Tk4il2oW2FOHe9gt+69ygdkeY07L0=;
 b=htDtV4tZHLAzCXkgbn2EksA5sJg7XeioK0qUhq+NY3fzK56E8qoJA7O6wVKwPPnuCgAN
 Htrk4BHC3DtGt+InhWjA2BU7UF10CgEBRaobZeLhmCy0f3bg3/CWUlQy7vOUcfRVfaeF
 SQCYW4cmCQK3IgwIFcE08ZVVrl1ZvLoFEvg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rghjv9437-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:46 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:45 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A52CD221E7C15; Wed, 28 Jun 2023 23:37:33 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 03/13] bpf: Support new sign-extension mov insns
Date: Wed, 28 Jun 2023 23:37:33 -0700
Message-ID: <20230629063733.1650134-1-yhs@fb.com>
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
X-Proofpoint-ORIG-GUID: gLQOeL_OD_YaJLKD78wrTjkCqeedzThY
X-Proofpoint-GUID: gLQOeL_OD_YaJLKD78wrTjkCqeedzThY
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

Add interpreter/jit support for new sign-extension mov insns.
The verifier support is basic and the better register range
calculation will be done in the future revision.

NOTE: currently new insns support:
  ALU:
      dst =3D (s8)src
      dst =3D (s16)src
  ALU64:
      dst =3D (s8)src
      dst =3D (s16)src
      dst =3D (s32)src
while unsigned mov insns support:
  ALU:
      dst =3D (u32)src
  ALU64:
      dst =3D src
Should we support more unsigned-extension mov insns like below?
  ALU:
      dst =3D (u8)src
      dst =3D (u16)src
  ALU64:
      dst =3D (u8)src
      dst =3D (u16)src
      dst =3D (u32)src

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 43 ++++++++++++++++++++++++++++++++++---
 kernel/bpf/core.c           | 28 ++++++++++++++++++++++--
 kernel/bpf/verifier.c       | 14 +++++++++++-
 3 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 70d6a2c289ec..7c85d1b01931 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -701,6 +701,38 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 =
dst_reg, u32 src_reg)
 	*pprog =3D prog;
 }
=20
+static void emit_movs_reg(u8 **pprog, int num_bits, bool is64, u32 dst_r=
eg,
+			  u32 src_reg)
+{
+	u8 *prog =3D *pprog;
+
+	if (is64) {
+		/* movs[b,w,l]q dst, src */
+		if (num_bits =3D=3D 8)
+			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbe,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		else if (num_bits =3D=3D 16)
+			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbf,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		else if (num_bits =3D=3D 32)
+			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x63,
+			      add_2reg(0xC0, src_reg, dst_reg));
+	} else {
+		/* movs[b,w]l dst, src */
+		if (num_bits =3D=3D 8) {
+			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		} else if (num_bits =3D=3D 16) {
+			if (is_ereg(dst_reg) || is_ereg(src_reg))
+				EMIT1(add_2mod(0x40, src_reg, dst_reg));
+			EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0xbf,
+			      add_2reg(0xC0, src_reg, dst_reg));
+		}
+	}
+
+	*pprog =3D prog;
+}
+
 /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_=
reg */
 static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int o=
ff)
 {
@@ -1051,9 +1083,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
=20
 		case BPF_ALU64 | BPF_MOV | BPF_X:
 		case BPF_ALU | BPF_MOV | BPF_X:
-			emit_mov_reg(&prog,
-				     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
-				     dst_reg, src_reg);
+			if (insn->off =3D=3D 0)
+				emit_mov_reg(&prog,
+					     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
+					     dst_reg, src_reg);
+			else
+				emit_movs_reg(&prog, insn->off,
+					      BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
+					      dst_reg, src_reg);
 			break;
=20
 			/* neg dst */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index acb7abd2eba0..72ee246ac3af 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -61,6 +61,7 @@
 #define AX	regs[BPF_REG_AX]
 #define ARG1	regs[BPF_REG_ARG1]
 #define CTX	regs[BPF_REG_CTX]
+#define OFF	insn->off
 #define IMM	insn->imm
=20
 struct bpf_mem_alloc bpf_global_ma;
@@ -1736,13 +1737,36 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
 		DST =3D -DST;
 		CONT;
 	ALU_MOV_X:
-		DST =3D (u32) SRC;
+		switch (OFF) {
+		case 0:
+			DST =3D (u32) SRC;
+			break;
+		case 8:
+			DST =3D (s8) SRC;
+			break;
+		case 16:
+			DST =3D (s16) SRC;
+			break;
+		}
 		CONT;
 	ALU_MOV_K:
 		DST =3D (u32) IMM;
 		CONT;
 	ALU64_MOV_X:
-		DST =3D SRC;
+		switch (OFF) {
+		case 0:
+			DST =3D SRC;
+			break;
+		case 8:
+			DST =3D (s8) SRC;
+			break;
+		case 16:
+			DST =3D (s16) SRC;
+			break;
+		case 32:
+			DST =3D (s32) SRC;
+			break;
+		}
 		CONT;
 	ALU64_MOV_K:
 		DST =3D IMM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6845504d42a5..5c5b37b6b39a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12926,11 +12926,23 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
 	} else if (opcode =3D=3D BPF_MOV) {
=20
 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			if (insn->imm !=3D 0 || insn->off !=3D 0) {
+			if (insn->imm !=3D 0) {
 				verbose(env, "BPF_MOV uses reserved fields\n");
 				return -EINVAL;
 			}
=20
+			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
+				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16) {
+					verbose(env, "BPF_MOV uses reserved fields\n");
+					return -EINVAL;
+				}
+			} else {
+				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16 && ins=
n->off !=3D 32) {
+					verbose(env, "BPF_MOV uses reserved fields\n");
+					return -EINVAL;
+				}
+			}
+
 			/* check src operand */
 			err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
--=20
2.34.1


