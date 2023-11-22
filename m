Return-Path: <bpf+bounces-15706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500357F529A
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA130B20E55
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523E1CF94;
	Wed, 22 Nov 2023 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1342ED43
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 13:31:30 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMFrGqv009656
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 13:31:29 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uhmp5tkev-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 13:31:29 -0800
Received: from twshared15232.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 13:31:26 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 247093BF46073; Wed, 22 Nov 2023 13:31:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/3] bpf: validate global subprogs lazily
Date: Wed, 22 Nov 2023 13:31:11 -0800
Message-ID: <20231122213112.3596548-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122213112.3596548-1-andrii@kernel.org>
References: <20231122213112.3596548-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pjy3GHHpJn9DTxoQi--ADyOSDZ6sGRk-
X-Proofpoint-ORIG-GUID: Pjy3GHHpJn9DTxoQi--ADyOSDZ6sGRk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_16,2023-11-22_01,2023-05-22_02

Slightly change BPF verifier logic around eagerness and order of global
subprog validation. Instead of going over every global subprog eagerly
and validating it before main (entry) BPF program is verified, turn it
around. Validate main program first, mark subprogs that were called from
main program for later verification, but otherwise assume it is valid.
Afterwards, go over marked global subprogs and validate those,
potentially marking some more global functions as being called. Continue
this process until all (transitively) callable global subprogs are
validated. It's a BFS traversal at its heart and will always converge.

This is an important change because it allows to feature-gate some
subprograms that might not be verifiable on some older kernel, depending
on supported set of features.

E.g., at some point, global functions were allowed to accept a pointer
to memory, which size is identified by user-provided type.
Unfortunately, older kernels don't support this feature. With BPF CO-RE
approach, the natural way would be to still compile BPF object file once
and guard calls to this global subprog with some CO-RE check or using
.rodata variables. That's what people do to guard usage of new helpers
or kfuncs, and any other new BPF-side feature that might be missing on
old kernels.

That's currently impossible to do with global subprogs, unfortunately,
because they are eagerly and unconditionally validated. This patch set
aims to change this, so that in the future when global funcs gain new
features, those can be guarded using BPF CO-RE techniques in the same
fashion as any other new kernel feature.

Two selftests had to be adjusted in sync with these changes.

test_global_func12 relied on eager global subprog validation failing
before main program failure is detected (unknown return value). Fix by
making sure that main program is always valid.

verifier_subprog_precision's parent_stack_slot_precise subtest relied on
verifier checkpointing heuristic to do a checkpoint at instruction #5,
but that's no longer true because we don't have enough jumps validated
before reaching insn #5 due to global subprogs being validated later.

Other than that, no changes, as one would expect.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 +
 kernel/bpf/verifier.c                         | 49 ++++++++++++++++---
 .../selftests/bpf/progs/test_global_func12.c  |  4 +-
 .../bpf/progs/verifier_subprog_precision.c    |  4 +-
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 258ba232e302..eb447b0a9423 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1347,6 +1347,8 @@ static inline bool bpf_prog_has_trampoline(const st=
ruct bpf_prog *prog)
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
+	bool called : 1;
+	bool verified : 1;
 };
=20
 enum bpf_jit_poke_reason {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe2fd76d6ec4..e06e06d61fc7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -434,6 +434,11 @@ static const char *subprog_name(const struct bpf_ver=
ifier_env *env, int subprog)
 	return btf_type_name(env->prog->aux->btf, info->type_id);
 }
=20
+static struct bpf_func_info_aux *subprog_aux(const struct bpf_verifier_e=
nv *env, int subprog)
+{
+	return &env->prog->aux->func_info_aux[subprog];
+}
+
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
@@ -9149,6 +9154,9 @@ static int __check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 				subprog, sub_name);
=20
+			/* mark global subprog for verifying after main prog */
+			subprog_aux(env, subprog)->called =3D true;
+
 			clear_caller_saved_regs(env, caller->regs);
=20
 			/* All global functions return a 64-bit SCALAR_VALUE */
@@ -19741,8 +19749,11 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog, bool is_ex
 	return ret;
 }
=20
-/* Verify all global functions in a BPF program one by one based on thei=
r BTF.
- * All global functions must pass verification. Otherwise the whole prog=
ram is rejected.
+/* Lazily verify all global functions based on their BTF, if they are ca=
lled
+ * from main BPF program or any of subprograms transitively.
+ * BPF global subprogs called from dead code are not validated.
+ * All callable global functions must pass verification.
+ * Otherwise the whole program is rejected.
  * Consider:
  * int bar(int);
  * int foo(int f)
@@ -19761,14 +19772,26 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog, bool is_ex
 static int do_check_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux =3D env->prog->aux;
-	int i, ret;
+	struct bpf_func_info_aux *sub_aux;
+	int i, ret, new_cnt;
=20
 	if (!aux->func_info)
 		return 0;
=20
+	/* exception callback is presumed to be always called */
+	if (env->exception_callback_subprog)
+		subprog_aux(env, env->exception_callback_subprog)->called =3D true;
+
+again:
+	new_cnt =3D 0;
 	for (i =3D 1; i < env->subprog_cnt; i++) {
-		if (aux->func_info_aux[i].linkage !=3D BTF_FUNC_GLOBAL)
+		if (!subprog_is_global(env, i))
+			continue;
+
+		sub_aux =3D subprog_aux(env, i);
+		if (!sub_aux->called || sub_aux->verified)
 			continue;
+
 		env->insn_idx =3D env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx =3D=3D 0);
 		ret =3D do_check_common(env, i, env->exception_callback_subprog =3D=3D=
 i);
@@ -19778,7 +19801,21 @@ static int do_check_subprogs(struct bpf_verifier=
_env *env)
 			verbose(env, "Func#%d ('%s') is safe for any args that match its prot=
otype\n",
 				i, subprog_name(env, i));
 		}
+
+		/* We verified new global subprog, it might have called some
+		 * more global subprogs that we haven't verified yet, so we
+		 * need to do another pass over subprogs to verify those.
+		 */
+		sub_aux->verified =3D true;
+		new_cnt++;
 	}
+
+	/* We can't loop forever as we verify at least one global subprog on
+	 * each pass.
+	 */
+	if (new_cnt)
+		goto again;
+
 	return 0;
 }
=20
@@ -20424,8 +20461,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
=20
-	ret =3D do_check_subprogs(env);
-	ret =3D ret ?: do_check_main(env);
+	ret =3D do_check_main(env);
+	ret =3D ret ?: do_check_subprogs(env);
=20
 	if (ret =3D=3D 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret =3D bpf_prog_offload_finalize(env);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/too=
ls/testing/selftests/bpf/progs/test_global_func12.c
index 7f159d83c6f6..6e03d42519a6 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -19,5 +19,7 @@ int global_func12(struct __sk_buff *skb)
 {
 	const struct S s =3D {.x =3D skb->len };
=20
-	return foo(&s);
+	foo(&s);
+
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index db6b3143338b..23b8f2836a67 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -328,12 +328,10 @@ __naked int parent_stack_slot_precise(void)
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("9: (0f) r1 +=3D r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 6")
+__msg("mark_precise: frame0: last_idx 9 first_idx 0")
 __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 8: (bf) r1 =3D r7=
")
 __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 7: (27) r6 *=3D 4=
")
 __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 6: (79) r6 =3D *(=
u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:")
-__msg("mark_precise: frame0: last_idx 5 first_idx 0")
 __msg("mark_precise: frame0: regs=3D stack=3D-8 before 5: (85) call pc+6=
")
 __msg("mark_precise: frame0: regs=3D stack=3D-8 before 4: (b7) r1 =3D 0"=
)
 __msg("mark_precise: frame0: regs=3D stack=3D-8 before 3: (7b) *(u64 *)(=
r10 -8) =3D r6")
--=20
2.34.1


