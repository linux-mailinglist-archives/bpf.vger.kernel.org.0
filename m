Return-Path: <bpf+bounces-14534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138447E60DF
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1392C1C20C0A
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E3374DF;
	Wed,  8 Nov 2023 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55237158
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:12:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2532593
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:12:11 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A8KNPGU019096
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 15:12:10 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u7w2atcmy-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:12:10 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 15:12:06 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 527B03B2E7DE2; Wed,  8 Nov 2023 15:12:00 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in privileged mode
Date: Wed, 8 Nov 2023 15:11:51 -0800
Message-ID: <20231108231152.3583545-4-andrii@kernel.org>
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
X-Proofpoint-GUID: RuWkyP_vkjMSjFGXhuu9YaDJTuSCuqh5
X-Proofpoint-ORIG-GUID: RuWkyP_vkjMSjFGXhuu9YaDJTuSCuqh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02

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

So, this patch fixes this limitation by tracking not just immediate
conditional jump, but also all subsequent instructions that happened in
such conditional branch. For that we store a new flag, CONDITIONAL,
along with current DISCOVERED, EXPLORED, BRANCH, and FALLTHROUGH.
Conditional jump instructions forces CONDITIONAL flag, and in all other
situations we "inherit" this flag based on whether we arrived at given
instruction with CONDITIONAL flag during discovery step.

Note, this approach doesn't detect some obvious infinite loops during
check_cfg() if they happen inside conditional code path. This can be
fixed with more sophisticated DFS state implementation, where we'd
remember some sort of "conditional epoch", and so if a sequence of jumps
or sequential instructions lead to back-edge within the same epoch, that
a loop within the same branch.

But I didn't add that for two reasons. First, subsequent BPF verifier
logic will detect this and prevent anyways, and it's easy to do the same
with just conditional jumps, so there isn't much of a difference in
supporting this.

But also, second, this conditional jump branch might never be taken and
thus will be a dead code. And it seems desirable to be able to express
"this shall not be executed, otherwise we'll while(true){}" logic as
a kind of unreachable guard.

So keeping things simple and allowing this dead code elimination
approach to work.

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

Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 45 +++++++++----------
 .../selftests/bpf/progs/verifier_cfg.c        |  4 +-
 .../selftests/bpf/progs/verifier_loops1.c     |  9 ++--
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edca7f1ad335..35065cae98b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15433,8 +15433,9 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno)
 enum {
 	DISCOVERED =3D 0x10,
 	EXPLORED =3D 0x20,
-	FALLTHROUGH =3D 1,
-	BRANCH =3D 2,
+	CONDITIONAL =3D 0x01,
+	FALLTHROUGH =3D 0x02,
+	BRANCH =3D 0x04,
 };
=20
 static void mark_prune_point(struct bpf_verifier_env *env, int idx)
@@ -15468,16 +15469,15 @@ enum {
  * w - next instruction
  * e - edge
  */
-static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
-		     bool loop_ok)
+static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 {
 	int *insn_stack =3D env->cfg.insn_stack;
 	int *insn_state =3D env->cfg.insn_state;
=20
-	if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALLTHROUG=
H))
+	if ((e & FALLTHROUGH) && insn_state[t] >=3D (DISCOVERED | FALLTHROUGH))
 		return DONE_EXPLORING;
=20
-	if (e =3D=3D BRANCH && insn_state[t] >=3D (DISCOVERED | BRANCH))
+	if ((e & BRANCH) && insn_state[t] >=3D (DISCOVERED | BRANCH))
 		return DONE_EXPLORING;
=20
 	if (w < 0 || w >=3D env->prog->len) {
@@ -15486,7 +15486,7 @@ static int push_insn(int t, int w, int e, struct =
bpf_verifier_env *env,
 		return -EINVAL;
 	}
=20
-	if (e =3D=3D BRANCH) {
+	if (e & BRANCH) {
 		/* mark branch target for state pruning */
 		mark_prune_point(env, w);
 		mark_jmp_point(env, w);
@@ -15495,13 +15495,13 @@ static int push_insn(int t, int w, int e, struc=
t bpf_verifier_env *env,
 	if (insn_state[w] =3D=3D 0) {
 		/* tree-edge */
 		insn_state[t] =3D DISCOVERED | e;
-		insn_state[w] =3D DISCOVERED;
+		insn_state[w] =3D DISCOVERED | (e & CONDITIONAL);
 		if (env->cfg.cur_stack >=3D env->prog->len)
 			return -E2BIG;
 		insn_stack[env->cfg.cur_stack++] =3D w;
 		return KEEP_EXPLORING;
-	} else if ((insn_state[w] & 0xF0) =3D=3D DISCOVERED) {
-		if (loop_ok && env->bpf_capable)
+	} else if (insn_state[w] & DISCOVERED) {
+		if ((e & CONDITIONAL) && env->bpf_capable)
 			return DONE_EXPLORING;
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
@@ -15521,10 +15521,11 @@ static int visit_func_call_insn(int t, struct b=
pf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
 {
-	int ret, insn_sz;
+	int ret, insn_sz, cond;
=20
+	cond =3D env->cfg.insn_state[t] & CONDITIONAL;
 	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
-	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH | cond, env);
 	if (ret)
 		return ret;
=20
@@ -15534,12 +15535,7 @@ static int visit_func_call_insn(int t, struct bp=
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
+		ret =3D push_insn(t, t + insns[t].imm + 1, BRANCH | cond, env);
 	}
 	return ret;
 }
@@ -15552,16 +15548,18 @@ static int visit_func_call_insn(int t, struct b=
pf_insn *insns,
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns =3D env->prog->insnsi, *insn =3D &insns[t];
-	int ret, off, insn_sz;
+	int ret, off, insn_sz, cond;
=20
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
=20
+	cond =3D env->cfg.insn_state[t] & CONDITIONAL;
+
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) !=3D BPF_JMP &&
 	    BPF_CLASS(insn->code) !=3D BPF_JMP32) {
 		insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
-		return push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+		return push_insn(t, t + insn_sz, FALLTHROUGH | cond, env);
 	}
=20
 	switch (BPF_OP(insn->code)) {
@@ -15608,8 +15606,7 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
 			off =3D insn->imm;
=20
 		/* unconditional jump with single edge */
-		ret =3D push_insn(t, t + off + 1, FALLTHROUGH, env,
-				true);
+		ret =3D push_insn(t, t + off + 1, FALLTHROUGH | cond, env);
 		if (ret)
 			return ret;
=20
@@ -15622,11 +15619,11 @@ static int visit_insn(int t, struct bpf_verifie=
r_env *env)
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
=20
-		ret =3D push_insn(t, t + 1, FALLTHROUGH, env, true);
+		ret =3D push_insn(t, t + 1, FALLTHROUGH | CONDITIONAL, env);
 		if (ret)
 			return ret;
=20
-		return push_insn(t, t + insn->off + 1, BRANCH, env, true);
+		return push_insn(t, t + insn->off + 1, BRANCH | CONDITIONAL, env);
 	}
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/tes=
ting/selftests/bpf/progs/verifier_cfg.c
index df7697b94007..65d205474f33 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -57,7 +57,7 @@ __naked void out_of_range_jump2(void)
=20
 SEC("socket")
 __description("loop (back-edge)")
-__failure __msg("unreachable insn 1")
+__failure __msg("back-edge")
 __msg_unpriv("back-edge")
 __naked void loop_back_edge(void)
 {
@@ -69,7 +69,7 @@ l0_%=3D:	goto l0_%=3D;					\
=20
 SEC("socket")
 __description("loop2 (back-edge)")
-__failure __msg("unreachable insn 4")
+__failure __msg("back-edge")
 __msg_unpriv("back-edge")
 __naked void loop2_back_edge(void)
 {
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
--=20
2.34.1


