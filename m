Return-Path: <bpf+bounces-5403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E975A314
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDABB1C211EE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CD801;
	Thu, 20 Jul 2023 00:03:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AA7F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:03:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC219B2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:03:50 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMZx56031409
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lMRncoQZ/s/VGBSffPBLb5lVgDSrTdsVQsa5Wx1aEXE=;
 b=kcl3wNdX4j9F5sklA+CD0+JlVDO5qYGkCeMadT8zCEXyfx4T/20giugr2WMbJW+foZY3
 hHWj7/G1sN0RZXmIQbvryo4TQKEru/5PvH8etubNJZrtWBmp29CTXsLBPNQBPyKVM0U3
 JLLzoJYsgDfPahthBfy22cQmjvagGausOPI= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6q1kj-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:03:49 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:03:48 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 928872354E821; Wed, 19 Jul 2023 17:01:24 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 04/17] bpf: Support new unconditional bswap instruction
Date: Wed, 19 Jul 2023 17:01:24 -0700
Message-ID: <20230720000124.104276-1-yhs@fb.com>
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
X-Proofpoint-GUID: 70i8qdSVJ_TpalYHyJTJpdJ-cfRrlhuY
X-Proofpoint-ORIG-GUID: 70i8qdSVJ_TpalYHyJTJpdJ-cfRrlhuY
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

The existing 'be' and 'le' insns will do conditional bswap
depends on host endianness. This patch implements
unconditional bswap insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 +
 kernel/bpf/core.c           | 14 ++++++++++++++
 kernel/bpf/verifier.c       |  7 +++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 031ef3c4185d..4942a4c188b9 100644
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
index c37c454b09eb..ad58697cec4b 100644
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
@@ -1848,6 +1849,19 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
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
index b9be8706bf48..b305f88c2569 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3012,8 +3012,10 @@ static bool is_reg64(struct bpf_verifier_env *env,=
 struct bpf_insn *insn,
 		}
 	}
=20
+	if (class =3D=3D BPF_ALU64 && op =3D=3D BPF_END && (insn->imm =3D=3D 16=
 || insn->imm =3D=3D 32))
+		return false;
+
 	if (class =3D=3D BPF_ALU64 || class =3D=3D BPF_JMP ||
-	    /* BPF_END always use BPF_ALU class. */
 	    (class =3D=3D BPF_ALU && op =3D=3D BPF_END && insn->imm =3D=3D 64))
 		return true;
=20
@@ -13076,7 +13078,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 		} else {
 			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0 ||
 			    (insn->imm !=3D 16 && insn->imm !=3D 32 && insn->imm !=3D 64) ||
-			    BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
+			    (BPF_CLASS(insn->code) =3D=3D BPF_ALU64 &&
+			     BPF_SRC(insn->code) !=3D BPF_TO_LE)) {
 				verbose(env, "BPF_END uses reserved fields\n");
 				return -EINVAL;
 			}
--=20
2.34.1


