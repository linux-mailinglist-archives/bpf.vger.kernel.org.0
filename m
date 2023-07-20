Return-Path: <bpf+bounces-5390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBA75A301
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06677281B12
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC9263CF;
	Thu, 20 Jul 2023 00:01:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37863182AD
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:01:43 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4914E69
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JNaKYv013031
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NBf8X9stnqC+Numu4HfMDrEUVR0Q7ECOM1EbBS7Nm6k=;
 b=FJSP0ozKneMPlPmofGfzyWbr99gew0KFXqZFony8a2KO3jkmGDB+SvHJd4qYKLnQN6rz
 yyof9H/CH4x65J3VK9Rxl4OcXcYyR/5ukZSdz8++r5xrD659Qiet71BW6XEhX1wZH7I+
 SrZGMYqcVDekd9pWxfoEDmpN6rVEX9eaVko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbxnpm1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:41 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:41 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B75132354E892; Wed, 19 Jul 2023 17:01:34 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 06/17] bpf: Fix jit blinding with new sdiv/smov insns
Date: Wed, 19 Jul 2023 17:01:34 -0700
Message-ID: <20230720000134.105248-1-yhs@fb.com>
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
X-Proofpoint-ORIG-GUID: WwlG4Efm4dvBHQ83rlx62cXc1MDgQNit
X-Proofpoint-GUID: WwlG4Efm4dvBHQ83rlx62cXc1MDgQNit
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

Handle new insns properly in bpf_jit_blind_insn() function.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/filter.h | 14 ++++++++++----
 kernel/bpf/core.c      |  4 ++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a93242b5516b..f5eabe3fa5e8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -93,22 +93,28 @@ struct ctl_table_header;
=20
 /* ALU ops on registers, bpf_add|sub|...: dst_reg +=3D src_reg */
=20
-#define BPF_ALU64_REG(OP, DST, SRC)				\
+#define BPF_ALU64_REG_OFF(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
 		.code  =3D BPF_ALU64 | BPF_OP(OP) | BPF_X,	\
 		.dst_reg =3D DST,					\
 		.src_reg =3D SRC,					\
-		.off   =3D 0,					\
+		.off   =3D OFF,					\
 		.imm   =3D 0 })
=20
-#define BPF_ALU32_REG(OP, DST, SRC)				\
+#define BPF_ALU64_REG(OP, DST, SRC)				\
+	BPF_ALU64_REG_OFF(OP, DST, SRC, 0)
+
+#define BPF_ALU32_REG_OFF(OP, DST, SRC, OFF)			\
 	((struct bpf_insn) {					\
 		.code  =3D BPF_ALU | BPF_OP(OP) | BPF_X,		\
 		.dst_reg =3D DST,					\
 		.src_reg =3D SRC,					\
-		.off   =3D 0,					\
+		.off   =3D OFF,					\
 		.imm   =3D 0 })
=20
+#define BPF_ALU32_REG(OP, DST, SRC)				\
+	BPF_ALU32_REG_OFF(OP, DST, SRC, 0)
+
 /* ALU ops on immediates, bpf_add|sub|...: dst_reg +=3D imm32 */
=20
 #define BPF_ALU64_IMM(OP, DST, IMM)				\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3fe895199f6e..646d2fe537be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1272,7 +1272,7 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 	case BPF_ALU | BPF_MOD | BPF_K:
 		*to++ =3D BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ =3D BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ =3D BPF_ALU32_REG(from->code, from->dst_reg, BPF_REG_AX);
+		*to++ =3D BPF_ALU32_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, fro=
m->off);
 		break;
=20
 	case BPF_ALU64 | BPF_ADD | BPF_K:
@@ -1286,7 +1286,7 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ =3D BPF_ALU64_REG(from->code, from->dst_reg, BPF_REG_AX);
+		*to++ =3D BPF_ALU64_REG_OFF(from->code, from->dst_reg, BPF_REG_AX, fro=
m->off);
 		break;
=20
 	case BPF_JMP | BPF_JEQ  | BPF_K:
--=20
2.34.1


