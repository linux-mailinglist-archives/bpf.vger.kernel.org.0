Return-Path: <bpf+bounces-6126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB076610A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6804282563
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B817CB;
	Fri, 28 Jul 2023 01:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BD15D1
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:12:40 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCF30DE
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:12:39 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B994323C7496D; Thu, 27 Jul 2023 18:12:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 06/17] bpf: Fix jit blinding with new sdiv/smov insns
Date: Thu, 27 Jul 2023 18:12:25 -0700
Message-Id: <20230728011225.3715812-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728011143.3710005-1-yonghong.song@linux.dev>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Handle new insns properly in bpf_jit_blind_insn() function.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
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


