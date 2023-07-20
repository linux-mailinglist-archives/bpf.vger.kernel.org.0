Return-Path: <bpf+bounces-5396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E992A75A30A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A341E281BBD
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC03D92;
	Thu, 20 Jul 2023 00:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58204196
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05F19B2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMZwWA031335
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8G9Tx2+YNrA1G3VZhuXwyEYE1o1BnAiOBi9V/sqvrE8=;
 b=jsMtqFtS6DskCJIRmwt4kw3uJRT41IyN0tQYlTZP+QxLMfFgnt2e6/1ukfBunVggXA7X
 Aa7D0UCo9bHkCDkVuHGhBfhTW/sUFZt3VjFHvvDm8R0VfkKxSZlF4vCy9JTUTH60pv1I
 3Zkj9zCJz52/p+9x4NZBfWAkywhglxOEQ/I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6q1c5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:30 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:52 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 093CB2354E8CC; Wed, 19 Jul 2023 17:01:47 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 08/17] bpf: Add kernel/bpftool asm support for new instructions
Date: Wed, 19 Jul 2023 17:01:47 -0700
Message-ID: <20230720000147.105988-1-yhs@fb.com>
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
X-Proofpoint-GUID: UZTTMkZ_wlbKkUeI1nCsx1mGMElaAvsB
X-Proofpoint-ORIG-GUID: UZTTMkZ_wlbKkUeI1nCsx1mGMElaAvsB
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

Add asm support for new instructions so kernel verifier and bpftool
xlated insn dumps can have proper asm syntax for new instructions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/disasm.c | 57 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 7b4afb7d96db..d7bff608f299 100644
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
+const char *const bpf_movsx_string[4] =3D {
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
+static const char *const bpf_ldsx_string[] =3D {
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
+static bool is_sdiv_smod(const struct bpf_insn *insn)
+{
+	return (BPF_OP(insn->code)  =3D=3D BPF_DIV || BPF_OP(insn->code) =3D=3D=
 BPF_MOD) &&
+	       insn->off =3D=3D 1;
+}
+
+static bool is_movsx(const struct bpf_insn *insn)
+{
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
+				is_movsx(insn) ? bpf_movsx_string[(insn->off >> 3) - 1] : "",
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
_MEMSX) {
 			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
 			return;
 		}
 		verbose(cbs->private_data, "(%02x) r%d =3D *(%s *)(r%d %+d)\n",
 			insn->code, insn->dst_reg,
-			bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+			BPF_MODE(insn->code) =3D=3D BPF_MEM ?
+				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
+				 bpf_ldsx_string[BPF_SIZE(insn->code) >> 3],
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


