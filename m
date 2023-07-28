Return-Path: <bpf+bounces-6136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D950A766117
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B628259F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312415C3;
	Fri, 28 Jul 2023 01:15:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FF7C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:15:29 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3030EB
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:15:28 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4909F23C748B2; Thu, 27 Jul 2023 18:12:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 03/17] bpf: Handle sign-extenstin ctx member accesses
Date: Thu, 27 Jul 2023 18:12:07 -0700
Message-Id: <20230728011207.3712528-1-yonghong.song@linux.dev>
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

Currently, if user accesses a ctx member with signed types,
the compiler will generate an unsigned load followed by
necessary left and right shifts.

With the introduction of sign-extension load, compiler may
just emit a ldsx insn instead. Let us do a final movsx sign
extension to the final unsigned ctx load result to
satisfy original sign extension requirement.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f3eebcd962f..7a6945be07e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17716,6 +17716,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		u8 mode;
=20
 		if (insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_H) ||
@@ -17797,6 +17798,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
=20
 		ctx_field_size =3D env->insn_aux_data[i + delta].ctx_field_size;
 		size =3D BPF_LDST_BYTES(insn);
+		mode =3D BPF_MODE(insn->code);
=20
 		/* If the read access is a narrower load of the field,
 		 * convert to a 4/8-byte load, to minimum program type specific
@@ -17856,6 +17858,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 								(1ULL << size * 8) - 1);
 			}
 		}
+		if (mode =3D=3D BPF_MEMSX)
+			insn_buf[cnt++] =3D BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
+						       insn->dst_reg, insn->dst_reg,
+						       size * 8, 0);
=20
 		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
--=20
2.34.1


