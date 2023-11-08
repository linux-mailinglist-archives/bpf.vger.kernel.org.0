Return-Path: <bpf+bounces-14532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD87E60DE
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024541C20BC2
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5337173;
	Wed,  8 Nov 2023 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395437150
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:12:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C142599
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:12:10 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8MSZmW024787
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 15:12:10 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u8k5eg8t8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:12:10 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 15:12:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2D9DD3B2E7DD3; Wed,  8 Nov 2023 15:11:56 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: handle ldimm64 properly in check_cfg()
Date: Wed, 8 Nov 2023 15:11:49 -0800
Message-ID: <20231108231152.3583545-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108231152.3583545-1-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0K692L5EmZxtfJok9AczTHJ-9yYqVOK7
X-Proofpoint-GUID: 0K692L5EmZxtfJok9AczTHJ-9yYqVOK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02

ldimm64 instructions are 16-byte long, and so have to be handled
appropriately in check_cfg(), just like the rest of BPF verifier does.

This has implications in three places:
  - when determining next instruction for non-jump instructions;
  - when determining next instruction for callback address ldimm64
    instructions (in visit_func_call_insn());
  - when checking for unreachable instructions, where second half of
    ldimm64 is expected to be unreachable;

We take this also as an opportunity to report jump into the middle of
ldimm64. And adjust few test_verifier tests accordingly.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  8 ++++--
 kernel/bpf/verifier.c                         | 27 ++++++++++++++-----
 .../testing/selftests/bpf/verifier/ld_imm64.c |  8 +++---
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb84caf133df..222275232453 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -909,10 +909,14 @@ bpf_ctx_record_field_size(struct bpf_insn_access_au=
x *aux, u32 size)
 	aux->ctx_field_size =3D size;
 }
=20
+static bool bpf_is_ldimm64(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
+}
+
 static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
 {
-	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
-	       insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
+	return bpf_is_ldimm64(insn) && insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
 }
=20
 struct bpf_prog_ops {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf94ba50c6ee..9d2af05e37a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15504,15 +15504,16 @@ static int visit_func_call_insn(int t, struct b=
pf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
 {
-	int ret;
+	int ret, insn_sz;
=20
-	ret =3D push_insn(t, t + 1, FALLTHROUGH, env, false);
+	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
+	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
 	if (ret)
 		return ret;
=20
-	mark_prune_point(env, t + 1);
+	mark_prune_point(env, t + insn_sz);
 	/* when we exit from subprog, we need to record non-linear history */
-	mark_jmp_point(env, t + 1);
+	mark_jmp_point(env, t + insn_sz);
=20
 	if (visit_callee) {
 		mark_prune_point(env, t);
@@ -15534,15 +15535,17 @@ static int visit_func_call_insn(int t, struct b=
pf_insn *insns,
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns =3D env->prog->insnsi, *insn =3D &insns[t];
-	int ret, off;
+	int ret, off, insn_sz;
=20
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
=20
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) !=3D BPF_JMP &&
-	    BPF_CLASS(insn->code) !=3D BPF_JMP32)
-		return push_insn(t, t + 1, FALLTHROUGH, env, false);
+	    BPF_CLASS(insn->code) !=3D BPF_JMP32) {
+		insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
+		return push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+	}
=20
 	switch (BPF_OP(insn->code)) {
 	case BPF_EXIT:
@@ -15672,11 +15675,21 @@ static int check_cfg(struct bpf_verifier_env *e=
nv)
 	}
=20
 	for (i =3D 0; i < insn_cnt; i++) {
+		struct bpf_insn *insn =3D &env->prog->insnsi[i];
+
 		if (insn_state[i] !=3D EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
 			ret =3D -EINVAL;
 			goto err_free;
 		}
+		if (bpf_is_ldimm64(insn)) {
+			if (insn_state[i + 1] !=3D 0) {
+				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				ret =3D -EINVAL;
+				goto err_free;
+			}
+			i++; /* skip second half of ldimm64 */
+		}
 	}
 	ret =3D 0; /* cfg looks good */
=20
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/test=
ing/selftests/bpf/verifier/ld_imm64.c
index f9297900cea6..78f19c255f20 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -9,8 +9,8 @@
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
-	.errstr =3D "invalid BPF_LD_IMM insn",
-	.errstr_unpriv =3D "R1 pointer comparison",
+	.errstr =3D "jump into the middle of ldimm64 insn 1",
+	.errstr_unpriv =3D "jump into the middle of ldimm64 insn 1",
 	.result =3D REJECT,
 },
 {
@@ -23,8 +23,8 @@
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
-	.errstr =3D "invalid BPF_LD_IMM insn",
-	.errstr_unpriv =3D "R1 pointer comparison",
+	.errstr =3D "jump into the middle of ldimm64 insn 1",
+	.errstr_unpriv =3D "jump into the middle of ldimm64 insn 1",
 	.result =3D REJECT,
 },
 {
--=20
2.34.1


