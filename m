Return-Path: <bpf+bounces-3713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E098A742076
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C74B1C20949
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DA566A;
	Thu, 29 Jun 2023 06:38:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF0538D
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:38:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE930D3
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0VVxf016619
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IV5W/RJGC89sfJHFdYcp9KOj6lmKEnJA9urUK2HaYzo=;
 b=PlrrwKFb9PF/cujEbKhllC9mq63Oy8nEpVdpiYKKYBXu3tQllOu1tpXo5hkjh2KnbozA
 +WEYI/C2jooYwRBSr53V0W51HvCDcce/OCzOPy2dRVWn8xlItLikw4xZVfbwS+saDdfN
 ppEPvvySryXUG/8j57KLTBmZs5wsWNJcs4M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyg3j98g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:59 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 413F2221E7CC3; Wed, 28 Jun 2023 23:37:56 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 07/13] bpf: Add kernel/bpftool asm support for new instructions
Date: Wed, 28 Jun 2023 23:37:56 -0700
Message-ID: <20230629063756.1652245-1-yhs@fb.com>
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
X-Proofpoint-GUID: G6wUOf5VTdUAbv4UfmCtfl2q9LX7u75d
X-Proofpoint-ORIG-GUID: G6wUOf5VTdUAbv4UfmCtfl2q9LX7u75d
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

Add asm support for new instructions so kernel verifier and bpftool
xlated insn dumps can have proper asm syntax for new instructions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/disasm.c | 57 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 7b4afb7d96db..cc46e708df5e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -87,6 +87,17 @@ const char *const bpf_alu_string[16] =3D {
 	[BPF_END >> 4]  =3D "endian",
 };
=20
+const char *const bpf_alu_sign_string[16] =3D {
+	[BPF_DIV >> 4]  =3D "s/=3D",
+	[BPF_MOD >> 4]  =3D "s%=3D",
+};
+
+const char *const bpf_movs_string[4] =3D {
+	[0] =3D "(s8)",
+	[1] =3D "(s16)",
+	[3] =3D "(s32)",
+};
+
 static const char *const bpf_atomic_alu_string[16] =3D {
 	[BPF_ADD >> 4]  =3D "add",
 	[BPF_AND >> 4]  =3D "and",
@@ -101,6 +112,12 @@ static const char *const bpf_ldst_string[] =3D {
 	[BPF_DW >> 3] =3D "u64",
 };
=20
+static const char *const bpf_lds_string[] =3D {
+	[BPF_W >> 3]  =3D "s32",
+	[BPF_H >> 3]  =3D "s16",
+	[BPF_B >> 3]  =3D "s8",
+};
+
 static const char *const bpf_jmp_string[16] =3D {
 	[BPF_JA >> 4]   =3D "jmp",
 	[BPF_JEQ >> 4]  =3D "=3D=3D",
@@ -128,6 +145,26 @@ static void print_bpf_end_insn(bpf_insn_print_t verb=
ose,
 		insn->imm, insn->dst_reg);
 }
=20
+static void print_bpf_bswap_insn(bpf_insn_print_t verbose,
+			       void *private_data,
+			       const struct bpf_insn *insn)
+{
+	verbose(private_data, "(%02x) r%d =3D bswap%d r%d\n",
+		insn->code, insn->dst_reg,
+		insn->imm, insn->dst_reg);
+}
+
+static bool is_sdiv_smod(const struct bpf_insn *insn) {
+	u8 op =3D BPF_OP(insn->code);
+	u16 off =3D insn->off;
+
+	return (op =3D=3D BPF_DIV || op =3D=3D BPF_MOD) && off =3D=3D 1;
+}
+
+static bool is_movs(const struct bpf_insn *insn) {
+	return BPF_OP(insn->code) =3D=3D BPF_MOV && insn->off !=3D 0;
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -138,7 +175,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 	if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
 		if (BPF_OP(insn->code) =3D=3D BPF_END) {
 			if (class =3D=3D BPF_ALU64)
-				verbose(cbs->private_data, "BUG_alu64_%02x\n", insn->code);
+				print_bpf_bswap_insn(verbose, cbs->private_data, insn);
 			else
 				print_bpf_end_insn(verbose, cbs->private_data, insn);
 		} else if (BPF_OP(insn->code) =3D=3D BPF_NEG) {
@@ -147,17 +184,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg, class =3D=3D BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
-			verbose(cbs->private_data, "(%02x) %c%d %s %c%d\n",
+			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
 				insn->code, class =3D=3D BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
-				bpf_alu_string[BPF_OP(insn->code) >> 4],
+				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
+						   : bpf_alu_string[BPF_OP(insn->code) >> 4],
+				is_movs(insn) ? bpf_movs_string[(insn->off >> 3) - 1] : "",
 				class =3D=3D BPF_ALU ? 'w' : 'r',
 				insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "(%02x) %c%d %s %d\n",
 				insn->code, class =3D=3D BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
-				bpf_alu_string[BPF_OP(insn->code) >> 4],
+				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
+						   : bpf_alu_string[BPF_OP(insn->code) >> 4],
 				insn->imm);
 		}
 	} else if (class =3D=3D BPF_STX) {
@@ -218,13 +258,15 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
 		}
 	} else if (class =3D=3D BPF_LDX) {
-		if (BPF_MODE(insn->code) !=3D BPF_MEM) {
+		if (BPF_MODE(insn->code) !=3D BPF_MEM && BPF_MODE(insn->code) !=3D BPF=
_MEMS) {
 			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
 			return;
 		}
 		verbose(cbs->private_data, "(%02x) r%d =3D *(%s *)(r%d %+d)\n",
 			insn->code, insn->dst_reg,
-			bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+			BPF_MODE(insn->code) =3D=3D BPF_MEM ?
+				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
+				 bpf_lds_string[BPF_SIZE(insn->code) >> 3],
 			insn->src_reg, insn->off);
 	} else if (class =3D=3D BPF_LD) {
 		if (BPF_MODE(insn->code) =3D=3D BPF_ABS) {
@@ -279,6 +321,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code =3D=3D (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code =3D=3D (BPF_JMP32 | BPF_JA)) {
+			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
+				insn->code, insn->imm);
 		} else if (insn->code =3D=3D (BPF_JMP | BPF_EXIT)) {
 			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
 		} else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
--=20
2.34.1


