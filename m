Return-Path: <bpf+bounces-3712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833D742075
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B188B280DA2
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39134C90;
	Thu, 29 Jun 2023 06:38:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945615D2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:38:01 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079B30C7
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0VVxe016619
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/FL35U8pzWnvhiK5wofSPb/SIX4mBqWGN/xJK9GspZU=;
 b=hqe6EbF3hyoiP4F2Y+8J/e1t1+K4BP/WmBAEmejYRKNppIjactRyxjo8Q4BU8QwZ8eDZ
 MLye4UCVUEIh74LNTUfMSEuJ5FQaM1Zbb6ls7fcqnbq2hwEJpnP7gqKOHYIDS51eBU1p
 lTqW+UgwGnIpOuA7FynjZarTYjfPybyC5CY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyg3j98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:59 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 49355221E7C5D; Wed, 28 Jun 2023 23:37:46 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 05/13] bpf: Support new signed div/mod instructions.
Date: Wed, 28 Jun 2023 23:37:46 -0700
Message-ID: <20230629063746.1650701-1-yhs@fb.com>
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
X-Proofpoint-GUID: tLAJ5CWRy-5iHkZCbozBw1EiccnQ2zbF
X-Proofpoint-ORIG-GUID: tLAJ5CWRy-5iHkZCbozBw1EiccnQ2zbF
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

Add interpreter/jit support for new signed div/mod instructions.
Also add basic verifier support to ensure new insns get
accepted.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 27 +++++++----
 kernel/bpf/core.c           | 96 ++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c       |  6 ++-
 3 files changed, 103 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6385a8d740b0..0c8d881f3ada 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 				/* mov rax, dst_reg */
 				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
=20
-			/*
-			 * xor edx, edx
-			 * equivalent to 'xor rdx, rdx', but one byte less
-			 */
-			EMIT2(0x31, 0xd2);
+			if (insn->off =3D=3D 0) {
+				/*
+				 * xor edx, edx
+				 * equivalent to 'xor rdx, rdx', but one byte less
+				 */
+				EMIT2(0x31, 0xd2);
=20
-			/* div src_reg */
-			maybe_emit_1mod(&prog, src_reg, is64);
-			EMIT2(0xF7, add_1reg(0xF0, src_reg));
+				/* div src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF0, src_reg));
+			} else {
+				if (BPF_CLASS(insn->code) =3D=3D BPF_ALU)
+					EMIT1(0x99); /* cltd */
+				else
+					EMIT2(0x48, 0x99); /* cqto */
+
+				/* idiv src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF8, src_reg));
+			}
=20
 			if (BPF_OP(insn->code) =3D=3D BPF_MOD &&
 			    dst_reg !=3D BPF_REG_3)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b59b41a3d07c..279d095ca1d1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1789,36 +1789,100 @@ static u64 ___bpf_prog_run(u64 *regs, const stru=
ct bpf_insn *insn)
 		(*(s64 *) &DST) >>=3D IMM;
 		CONT;
 	ALU64_MOD_X:
-		div64_u64_rem(DST, SRC, &AX);
-		DST =3D AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, SRC, &AX);
+			DST =3D AX;
+			break;
+		case 1:
+			AX =3D div64_s64(DST, SRC);
+			DST =3D DST - AX * SRC;
+			break;
+		}
 		CONT;
 	ALU_MOD_X:
-		AX =3D (u32) DST;
-		DST =3D do_div(AX, (u32) SRC);
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			DST =3D do_div(AX, (u32) SRC);
+			break;
+		case 1:
+			AX =3D (s32) DST;
+			DST =3D do_div(AX, (s32) SRC);
+			break;
+		}
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &AX);
-		DST =3D AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, IMM, &AX);
+			DST =3D AX;
+			break;
+		case 1:
+			AX =3D div64_s64(DST, IMM);
+			DST =3D DST - AX * IMM;
+			break;
+		}
 		CONT;
 	ALU_MOD_K:
-		AX =3D (u32) DST;
-		DST =3D do_div(AX, (u32) IMM);
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			DST =3D do_div(AX, (u32) IMM);
+			break;
+		case 1:
+			AX =3D (s32) DST;
+			DST =3D do_div(AX, (s32) IMM);
+			break;
+		}
 		CONT;
 	ALU64_DIV_X:
-		DST =3D div64_u64(DST, SRC);
+		switch (OFF) {
+		case 0:
+			DST =3D div64_u64(DST, SRC);
+			break;
+		case 1:
+			DST =3D div64_s64(DST, SRC);
+			break;
+		}
 		CONT;
 	ALU_DIV_X:
-		AX =3D (u32) DST;
-		do_div(AX, (u32) SRC);
-		DST =3D (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			do_div(AX, (u32) SRC);
+			DST =3D (u32) AX;
+			break;
+		case 1:
+			AX =3D (s32) DST;
+			do_div(AX, (s32) SRC);
+			DST =3D (s32) AX;
+			break;
+		}
 		CONT;
 	ALU64_DIV_K:
-		DST =3D div64_u64(DST, IMM);
+		switch (OFF) {
+		case 0:
+			DST =3D div64_u64(DST, IMM);
+			break;
+		case 1:
+			DST =3D div64_s64(DST, IMM);
+			break;
+		}
 		CONT;
 	ALU_DIV_K:
-		AX =3D (u32) DST;
-		do_div(AX, (u32) IMM);
-		DST =3D (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX =3D (u32) DST;
+			do_div(AX, (u32) IMM);
+			DST =3D (u32) AX;
+			break;
+		case 1:
+			AX =3D (s32) DST;
+			do_div(AX, (s32) IMM);
+			DST =3D (s32) AX;
+			break;
+		}
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d515bfee1a8f..cc14d2ac3c5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13029,7 +13029,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
=20
 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			if (insn->imm !=3D 0 || insn->off !=3D 0) {
+			if (insn->imm !=3D 0 || insn->off > 1 ||
+			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
@@ -13038,7 +13039,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0) {
+			if (insn->src_reg !=3D BPF_REG_0 || insn->off > 1 ||
+			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
--=20
2.34.1


