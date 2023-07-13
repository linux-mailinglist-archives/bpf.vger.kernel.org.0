Return-Path: <bpf+bounces-4928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898475188E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A982C1C21273
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732065695;
	Thu, 13 Jul 2023 06:07:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1975679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:07:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180D2117
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvWDk011852
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=C71uLUWFe4JTRJJVkbvF8sCPRLLUoWpdgp/RKCnCuUU=;
 b=T4SiS2drSgONY4CYoI0fToEQdiWWfKm+6pDv4+1zJGa+8u/D5Y7nMTbEtwNHju2k2jOg
 Fd/joGp9vxf9nrbTLx7PUkYi4N8BUuZS2FxD055RvCBh4MFJP2Hcjb8+0if/tayjY/Aa
 8wR9Vqxoqh2sG7W1Z45WxsRx1v5Tp6vasQM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg3h305p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:43 -0700
Received: from twshared8006.02.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:07:42 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 93C4C22EFA298; Wed, 12 Jul 2023 23:07:39 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 04/15] bpf: Support new unconditional bswap instruction
Date: Wed, 12 Jul 2023 23:07:39 -0700
Message-ID: <20230713060739.390659-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B2zo7-VngyQCfgteYT1gM9ag2MiflKKF
X-Proofpoint-ORIG-GUID: B2zo7-VngyQCfgteYT1gM9ag2MiflKKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing 'be' and 'le' insns will do conditional bswap
depends on host endianness. This patch implements
unconditional bswap insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 +
 kernel/bpf/core.c           | 14 ++++++++++++++
 kernel/bpf/verifier.c       |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a740a1a6e71d..adda5e7626b4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1322,6 +1322,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 			break;
=20
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 			switch (imm32) {
 			case 16:
 				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fe648a158c9e..86bb412fee39 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1524,6 +1524,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(ALU64, DIV,  X),			\
 	INSN_3(ALU64, MOD,  X),			\
 	INSN_2(ALU64, NEG),			\
+	INSN_3(ALU64, END, TO_LE),		\
 	/*   Immediate based. */		\
 	INSN_3(ALU64, ADD,  K),			\
 	INSN_3(ALU64, SUB,  K),			\
@@ -1845,6 +1846,19 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn)
 			break;
 		}
 		CONT;
+	ALU64_END_TO_LE:
+		switch (IMM) {
+		case 16:
+			DST =3D (__force u16) __swab16(DST);
+			break;
+		case 32:
+			DST =3D (__force u32) __swab32(DST);
+			break;
+		case 64:
+			DST =3D (__force u64) __swab64(DST);
+			break;
+		}
+		CONT;
=20
 	/* CALL */
 	JMP_CALL:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5fee9f24cb5e..22ba0744547b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13036,7 +13036,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 		} else {
 			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0 ||
 			    (insn->imm !=3D 16 && insn->imm !=3D 32 && insn->imm !=3D 64) ||
-			    BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
+			    (BPF_CLASS(insn->code) =3D=3D BPF_ALU64 && BPF_SRC(insn->code) !=3D=
 BPF_K)) {
 				verbose(env, "BPF_END uses reserved fields\n");
 				return -EINVAL;
 			}
--=20
2.34.1


