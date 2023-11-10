Return-Path: <bpf+bounces-14722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5F7E790A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573991C20D1B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD26118;
	Fri, 10 Nov 2023 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652266105
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:14:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2F525E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:14:28 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYK2c006253
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 22:14:28 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u8k5eurbx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:14:28 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 22:14:26 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 354BD3B43D515; Thu,  9 Nov 2023 22:14:13 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf 1/2] bpf: fix control-flow graph checking in privileged mode
Date: Thu, 9 Nov 2023 22:14:10 -0800
Message-ID: <20231110061412.2995786-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rqrcX9nmHskdxYowJob5ExWTbXPISnhL
X-Proofpoint-GUID: rqrcX9nmHskdxYowJob5ExWTbXPISnhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_03,2023-11-09_01,2023-05-22_02

When BPF program is verified in privileged mode, BPF verifier allows
bounded loops. This means that from CFG point of view there are
definitely some back-edges. Original commit adjusted check_cfg() logic
to not detect back-edges in control flow graph if they are resulting
from conditional jumps, which the idea that subsequent full BPF
verification process will determine whether such loops are bounded or
not, and either accept or reject the BPF program. At least that's my
reading of the intent.

Unfortunately, the implementation of this idea doesn't work correctly in
all possible situations. Conditional jump might not result in immediate
back-edge, but just a few unconditional instructions later we can arrive
at back-edge. In such situations check_cfg() would reject BPF program
even in privileged mode, despite it might be bounded loop. Next patch
adds one simple program demonstrating such scenario.

To keep things simple, instead of trying to detect back edges in
privileged mode, just assume every back edge is valid and let subsequent
BPF verification prove or reject bounded loops.

Note a few test changes. For unknown reason, we have a few tests that
are specified to detect a back-edge in a privileged mode, but looking at
their code it seems like the right outcome is passing check_cfg() and
letting subsequent verification to make a decision about bounded or not
bounded looping.

Bounded recursion case is also interesting. The example should pass, as
recursion is limited to just a few levels and so we never reach maximum
number of nested frames and never exhaust maximum stack depth. But the
way that max stack depth logic works today it falsely detects this as
exceeding max nested frame count. This patch series doesn't attempt to
fix this orthogonal problem, so we just adjust expected verifier failure.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 23 +++++++------------
 .../selftests/bpf/progs/verifier_loops1.c     |  9 +++++---
 tools/testing/selftests/bpf/verifier/calls.c  |  6 ++---
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 484c742f733e..a2267d5ed14e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15403,8 +15403,7 @@ enum {
  * w - next instruction
  * e - edge
  */
-static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
-		     bool loop_ok)
+static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 {
 	int *insn_stack =3D env->cfg.insn_stack;
 	int *insn_state =3D env->cfg.insn_state;
@@ -15436,7 +15435,7 @@ static int push_insn(int t, int w, int e, struct =
bpf_verifier_env *env,
 		insn_stack[env->cfg.cur_stack++] =3D w;
 		return KEEP_EXPLORING;
 	} else if ((insn_state[w] & 0xF0) =3D=3D DISCOVERED) {
-		if (loop_ok && env->bpf_capable)
+		if (env->bpf_capable)
 			return DONE_EXPLORING;
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
@@ -15459,7 +15458,7 @@ static int visit_func_call_insn(int t, struct bpf=
_insn *insns,
 	int ret, insn_sz;
=20
 	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
-	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	if (ret)
 		return ret;
=20
@@ -15469,12 +15468,7 @@ static int visit_func_call_insn(int t, struct bp=
f_insn *insns,
=20
 	if (visit_callee) {
 		mark_prune_point(env, t);
-		ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH, env,
-				/* It's ok to allow recursion from CFG point of
-				 * view. __check_func_call() will do the actual
-				 * check.
-				 */
-				bpf_pseudo_func(insns + t));
+		ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH, env);
 	}
 	return ret;
 }
@@ -15496,7 +15490,7 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
 	if (BPF_CLASS(insn->code) !=3D BPF_JMP &&
 	    BPF_CLASS(insn->code) !=3D BPF_JMP32) {
 		insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
-		return push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+		return push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	}
=20
 	switch (BPF_OP(insn->code)) {
@@ -15543,8 +15537,7 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
 			off =3D insn->imm;
=20
 		/* unconditional jump with single edge */
-		ret =3D push_insn(t, t + off + 1, FALLTHROUGH, env,
-				true);
+		ret =3D push_insn(t, t + off + 1, FALLTHROUGH, env);
 		if (ret)
 			return ret;
=20
@@ -15557,11 +15550,11 @@ static int visit_insn(int t, struct bpf_verifie=
r_env *env)
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
=20
-		ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true);
+		ret =3D push_insn(t, t + 1, FALLTHROUGH, env);
 		if (ret)
 			return ret;
=20
-		return push_insn(t, t + insn->off + 1, BRANCH, env, true);
+		return push_insn(t, t + insn->off + 1, BRANCH, env);
 	}
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/=
testing/selftests/bpf/progs/verifier_loops1.c
index 5bc86af80a9a..71735dbf33d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -75,9 +75,10 @@ l0_%=3D:	r0 +=3D 1;					\
 "	::: __clobber_all);
 }
=20
-SEC("tracepoint")
+SEC("socket")
 __description("bounded loop, start in the middle")
-__failure __msg("back-edge")
+__success
+__failure_unpriv __msg_unpriv("back-edge")
 __naked void loop_start_in_the_middle(void)
 {
 	asm volatile ("					\
@@ -136,7 +137,9 @@ l0_%=3D:	exit;						\
=20
 SEC("tracepoint")
 __description("bounded recursion")
-__failure __msg("back-edge")
+__failure
+/* verifier limitation in detecting max stack depth */
+__msg("the call stack of 8 frames is too deep !")
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing=
/selftests/bpf/verifier/calls.c
index 1bdf2b43e49e..3d5cd51071f0 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -442,7 +442,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
-	.errstr =3D "back-edge from insn 0 to 0",
+	.errstr =3D "the call stack of 9 frames is too deep",
 	.result =3D REJECT,
 },
 {
@@ -799,7 +799,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
-	.errstr =3D "back-edge",
+	.errstr =3D "the call stack of 9 frames is too deep",
 	.result =3D REJECT,
 },
 {
@@ -811,7 +811,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
-	.errstr =3D "back-edge",
+	.errstr =3D "the call stack of 9 frames is too deep",
 	.result =3D REJECT,
 },
 {
--=20
2.34.1


