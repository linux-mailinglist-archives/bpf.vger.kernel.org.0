Return-Path: <bpf+bounces-13662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04BB7DC59B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139851C20B75
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD7CA7B;
	Tue, 31 Oct 2023 05:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FD6FC6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:03:46 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A80DF
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:44 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UIuAPe027658
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2j6vtumr-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:40 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:03:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6760B3AA9B6BF; Mon, 30 Oct 2023 22:03:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history across all states
Date: Mon, 30 Oct 2023 22:03:18 -0700
Message-ID: <20231031050324.1107444-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031050324.1107444-1-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fF0LckinAEKc01_rz6KS9SQch_YFYIp-
X-Proofpoint-GUID: fF0LckinAEKc01_rz6KS9SQch_YFYIp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02

Instead of allocating and copying jump history each time we enqueue
child verifier state, switch to a model where we use one common
dynamically sized array of instruction jumps across all states.

The key observation for proving this is correct is that jmp_history is
only relevant while state is active, which means it either is a current
state (and thus we are actively modifying jump history and no other
state can interfere with us) or we are checkpointed state with some
children still active (either enqueued or being current).

In the latter case our portion of jump history is finalized and won't
change or grow, so as long as we keep it immutable until the state is
finalized, we are good.

Now, when state is finalized and is put into state hash for potentially
future pruning lookups, jump history is not used anymore. This is
because jump history is only used by precision marking logic, and we
never modify precision markings for finalized states.

So, instead of each state having its own small jump history, we keep
a global dynamically-sized jump history, where each state in current DFS
path from root to active state remembers its portion of jump history.
Current state can append to this history, but cannot modify any of its
parent histories.

Because the jmp_history array can be grown through realloc, states don't
keep pointers, they instead maintain two indexes [start, end) into
global jump history array. End is exclusive index, so start =3D=3D end me=
ans
there is no relevant jump history.

This should eliminate a lot of allocations and minimize overall memory
usage (but I haven't benchmarked on real hardware, and QEMU benchmarking
is too noisy).

Also, in the next patch we'll extend jump history to maintain additional
markings for some instructions even if there was no jump, so in
preparation for that call this thing a more generic "instruction history"=
.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  8 +++--
 kernel/bpf/verifier.c        | 68 ++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 24213a99cc79..b57696145111 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -309,7 +309,7 @@ struct bpf_func_state {
 	struct bpf_stack_state *stack;
 };
=20
-struct bpf_idx_pair {
+struct bpf_insn_hist_entry {
 	u32 prev_idx;
 	u32 idx;
 };
@@ -397,8 +397,8 @@ struct bpf_verifier_state {
 	 * For most states jmp_history_cnt is [0-3].
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_idx_pair *jmp_history;
-	u32 jmp_history_cnt;
+	u32 insn_hist_start;
+	u32 insn_hist_end;
 	u32 dfs_depth;
 };
=20
@@ -666,6 +666,8 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	struct bpf_insn_hist_entry *insn_hist;
+	u32 insn_hist_cap;
 };
=20
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..2905ce2e8b34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1737,13 +1737,6 @@ static void free_func_state(struct bpf_func_state =
*state)
 	kfree(state);
 }
=20
-static void clear_jmp_history(struct bpf_verifier_state *state)
-{
-	kfree(state->jmp_history);
-	state->jmp_history =3D NULL;
-	state->jmp_history_cnt =3D 0;
-}
-
 static void free_verifier_state(struct bpf_verifier_state *state,
 				bool free_self)
 {
@@ -1753,7 +1746,6 @@ static void free_verifier_state(struct bpf_verifier=
_state *state,
 		free_func_state(state->frame[i]);
 		state->frame[i] =3D NULL;
 	}
-	clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1779,13 +1771,6 @@ static int copy_verifier_state(struct bpf_verifier=
_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
=20
-	dst_state->jmp_history =3D copy_array(dst_state->jmp_history, src->jmp_=
history,
-					    src->jmp_history_cnt, sizeof(struct bpf_idx_pair),
-					    GFP_USER);
-	if (!dst_state->jmp_history)
-		return -ENOMEM;
-	dst_state->jmp_history_cnt =3D src->jmp_history_cnt;
-
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1802,6 +1787,8 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
 	dst_state->last_insn_idx =3D src->last_insn_idx;
+	dst_state->insn_hist_start =3D src->insn_hist_start;
+	dst_state->insn_hist_end =3D src->insn_hist_end;
 	dst_state->dfs_depth =3D src->dfs_depth;
 	dst_state->used_as_loop_entry =3D src->used_as_loop_entry;
 	for (i =3D 0; i <=3D src->curframe; i++) {
@@ -3495,40 +3482,44 @@ static bool is_jmp_point(struct bpf_verifier_env =
*env, int insn_idx)
 static int push_jmp_history(struct bpf_verifier_env *env,
 			    struct bpf_verifier_state *cur)
 {
-	u32 cnt =3D cur->jmp_history_cnt;
-	struct bpf_idx_pair *p;
+	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
=20
 	if (!is_jmp_point(env, env->insn_idx))
 		return 0;
=20
-	cnt++;
-	alloc_size =3D kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p =3D krealloc(cur->jmp_history, alloc_size, GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	p[cnt - 1].idx =3D env->insn_idx;
-	p[cnt - 1].prev_idx =3D env->prev_insn_idx;
-	cur->jmp_history =3D p;
-	cur->jmp_history_cnt =3D cnt;
+	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
+		alloc_size =3D size_mul(cur->insn_hist_end + 1, sizeof(*p));
+		alloc_size =3D kmalloc_size_roundup(alloc_size);
+		p =3D krealloc(env->insn_hist, alloc_size, GFP_USER);
+		if (!p)
+			return -ENOMEM;
+		env->insn_hist =3D p;
+		env->insn_hist_cap =3D alloc_size / sizeof(*p);
+	}
+
+	p =3D &env->insn_hist[cur->insn_hist_end];
+	p->idx =3D env->insn_idx;
+	p->prev_idx =3D env->prev_insn_idx;
+	cur->insn_hist_end++;
 	return 0;
 }
=20
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  */
-static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
-			     u32 *history)
+static int get_prev_insn_idx(const struct bpf_verifier_env *env, int ins=
n_idx,
+			     u32 hist_start, u32 *hist_endp)
 {
-	u32 cnt =3D *history;
+	u32 hist_end =3D *hist_endp;
=20
-	if (cnt && st->jmp_history[cnt - 1].idx =3D=3D i) {
-		i =3D st->jmp_history[cnt - 1].prev_idx;
-		(*history)--;
+	if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx =3D=3D in=
sn_idx) {
+		insn_idx =3D env->insn_hist[hist_end - 1].prev_idx;
+		(*hist_endp)--;
 	} else {
-		i--;
+		insn_idx--;
 	}
-	return i;
+	return insn_idx;
 }
=20
 static const char *disasm_kfunc_name(void *data, const struct bpf_insn *=
insn)
@@ -4200,7 +4191,7 @@ static int mark_precise_scalar_ids(struct bpf_verif=
ier_env *env, struct bpf_veri
  * SCALARS, as well as any other registers and slots that contribute to
  * a tracked state of given registers/stack slots, depending on specific=
 BPF
  * assembly instructions (see backtrack_insns() for exact instruction ha=
ndling
- * logic). This backtracking relies on recorded jmp_history and is able =
to
+ * logic). This backtracking relies on recorded insn_history and is able=
 to
  * traverse entire chain of parent states. This process ends only when a=
ll the
  * necessary registers/slots and their transitive dependencies are marke=
d as
  * precise.
@@ -4317,7 +4308,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
=20
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 history =3D st->jmp_history_cnt;
+		u32 hist_end =3D st->insn_hist_end;
=20
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_=
idx %d \n",
@@ -4399,7 +4390,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 			if (i =3D=3D first_idx)
 				break;
 			subseq_idx =3D i;
-			i =3D get_prev_insn_idx(st, i, &history);
+			i =3D get_prev_insn_idx(env, i, st->insn_hist_start, &hist_end);
 			if (i >=3D env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
@@ -17109,8 +17100,8 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
=20
 	cur->parent =3D new;
 	cur->first_insn_idx =3D insn_idx;
+	cur->insn_hist_start =3D cur->insn_hist_end;
 	cur->dfs_depth =3D new->dfs_depth + 1;
-	clear_jmp_history(cur);
 	new_sl->next =3D *explored_state(env, insn_idx);
 	*explored_state(env, insn_idx) =3D new_sl;
 	/* connect new state to parentage chain. Current frame needs all
@@ -20807,6 +20798,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
+	kvfree(env->insn_hist);
 err_free_env:
 	kfree(env);
 	return ret;
--=20
2.34.1


