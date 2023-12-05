Return-Path: <bpf+bounces-16775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F602805DE1
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E720CB2105E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5070D274;
	Tue,  5 Dec 2023 18:43:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934701A5
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:43:45 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5IfZZt017839
	for <bpf@vger.kernel.org>; Tue, 5 Dec 2023 10:43:44 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3usxjfd271-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:43:44 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 5 Dec 2023 10:43:26 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2506A3CA17081; Tue,  5 Dec 2023 10:43:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 10/10] bpf: use common instruction history across all states
Date: Tue, 5 Dec 2023 10:42:48 -0800
Message-ID: <20231205184248.1502704-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205184248.1502704-1-andrii@kernel.org>
References: <20231205184248.1502704-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WgNIThjKEaTr8-LmC77Sz9LqF1RlsQvG
X-Proofpoint-ORIG-GUID: WgNIThjKEaTr8-LmC77Sz9LqF1RlsQvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02

Instead of allocating and copying instruction history each time we
enqueue child verifier state, switch to a model where we use one common
dynamically sized array of instruction history entries across all states.

The key observation for proving this is correct is that instruction
history is only relevant while state is active, which means it either is
a current state (and thus we are actively modifying instruction history
and no other state can interfere with us) or we are checkpointed state
with some children still active (either enqueued or being current).

In the latter case our portion of instruction history is finalized and
won't change or grow, so as long as we keep it immutable until the state
is finalized, we are good.

Now, when state is finalized and is put into state hash for potentially
future pruning lookups, instruction history is not used anymore. This is
because instruction history is only used by precision marking logic, and
we never modify precision markings for finalized states.

So, instead of each state having its own small instruction history, we
keep a global dynamically-sized instruction history, where each state in
current DFS path from root to active state remembers its portion of
instruction history.  Current state can append to this history, but
cannot modify any of its parent histories.

Because the insn_hist array can be grown through realloc, states don't
keep pointers, they instead maintain two indices, [start, end), into
global instruction history array. End is exclusive index, so
`start =3D=3D end` means there is no relevant instruction history.

This eliminates a lot of allocations and minimizes overall memory usage.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 19 +++++---
 kernel/bpf/verifier.c        | 95 ++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bada59812e00..13a1824aafa7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -327,7 +327,7 @@ struct bpf_func_state {
=20
 #define MAX_CALL_FRAMES 8
=20
-/* instruction history flags, used in bpf_jmp_history_entry.flags field =
*/
+/* instruction history flags, used in bpf_insn_hist_entry.flags field */
 enum {
 	/* instruction references stack slot through PTR_TO_STACK register;
 	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES =
is 8)
@@ -345,7 +345,7 @@ enum {
 static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
 static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
=20
-struct bpf_jmp_history_entry {
+struct bpf_insn_hist_entry {
 	u32 idx;
 	/* insn idx can't be bigger than 1 million */
 	u32 prev_idx : 22;
@@ -430,13 +430,14 @@ struct bpf_verifier_state {
 	 * See get_loop_entry() for more information.
 	 */
 	struct bpf_verifier_state *loop_entry;
-	/* jmp history recorded from first to last.
-	 * backtracking is using it to go from last to first.
-	 * For most states jmp_history_cnt is [0-3].
+	/* Sub-range of env->insn_hist[] corresponding to this state's
+	 * instruction history.
+	 * Backtracking is using it to go from last to first.
+	 * For most states instruction history is short, 0-3 instructions.
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_jmp_history_entry *jmp_history;
-	u32 jmp_history_cnt;
+	u32 insn_hist_start;
+	u32 insn_hist_end;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 };
@@ -678,7 +679,9 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
+	struct bpf_insn_hist_entry *insn_hist;
+	struct bpf_insn_hist_entry *cur_hist_ent;
+	u32 insn_hist_cap;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5ce530641ba..92a9aed7e112 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1327,13 +1327,6 @@ static void free_func_state(struct bpf_func_state =
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
@@ -1343,7 +1336,6 @@ static void free_verifier_state(struct bpf_verifier=
_state *state,
 		free_func_state(state->frame[i]);
 		state->frame[i] =3D NULL;
 	}
-	clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1369,13 +1361,6 @@ static int copy_verifier_state(struct bpf_verifier=
_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
=20
-	dst_state->jmp_history =3D copy_array(dst_state->jmp_history, src->jmp_=
history,
-					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_USER);
-	if (!dst_state->jmp_history)
-		return -ENOMEM;
-	dst_state->jmp_history_cnt =3D src->jmp_history_cnt;
-
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1392,6 +1377,8 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
 	dst_state->last_insn_idx =3D src->last_insn_idx;
+	dst_state->insn_hist_start =3D src->insn_hist_start;
+	dst_state->insn_hist_end =3D src->insn_hist_end;
 	dst_state->dfs_depth =3D src->dfs_depth;
 	dst_state->callback_unroll_depth =3D src->callback_unroll_depth;
 	dst_state->used_as_loop_entry =3D src->used_as_loop_entry;
@@ -3262,11 +3249,10 @@ static bool is_jmp_point(struct bpf_verifier_env =
*env, int insn_idx)
 }
=20
 /* for any branch, call, exit record the history of jmps in the given st=
ate */
-static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *cur,
-			    int insn_flags)
+static int push_insn_history(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *cur,
+			     int insn_flags)
 {
-	u32 cnt =3D cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
+	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
=20
 	/* combine instruction flags if we already recorded this instruction */
@@ -3282,28 +3268,31 @@ static int push_jmp_history(struct bpf_verifier_e=
nv *env, struct bpf_verifier_st
 		return 0;
 	}
=20
-	cnt++;
-	alloc_size =3D kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p =3D krealloc(cur->jmp_history, alloc_size, GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	cur->jmp_history =3D p;
+	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
+		alloc_size =3D size_mul(cur->insn_hist_end + 1, sizeof(*p));
+		alloc_size =3D kmalloc_size_roundup(alloc_size);
+		p =3D krealloc(env->insn_hist, alloc_size, GFP_USER);
+		if (!p)
+			return -ENOMEM;
+		env->insn_hist =3D p;
+		env->insn_hist_cap =3D alloc_size / sizeof(*p);
+	}
=20
-	p =3D &cur->jmp_history[cnt - 1];
+	p =3D &env->insn_hist[cur->insn_hist_end];
 	p->idx =3D env->insn_idx;
 	p->prev_idx =3D env->prev_insn_idx;
 	p->flags =3D insn_flags;
-	cur->jmp_history_cnt =3D cnt;
+	cur->insn_hist_end++;
 	env->cur_hist_ent =3D p;
=20
 	return 0;
 }
=20
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verif=
ier_state *st,
-						        u32 hist_end, int insn_idx)
+static struct bpf_insn_hist_entry *get_insn_hist_entry(struct bpf_verifi=
er_env *env,
+						       u32 hist_end, int insn_idx)
 {
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx =3D=3D insn_idx)
-		return &st->jmp_history[hist_end - 1];
+	if (hist_end > 0 && env->insn_hist[hist_end - 1].idx =3D=3D insn_idx)
+		return &env->insn_hist[hist_end - 1];
 	return NULL;
 }
=20
@@ -3320,25 +3309,26 @@ static struct bpf_jmp_history_entry *get_jmp_hist=
_entry(struct bpf_verifier_stat
  * history entry recording a jump from last instruction of parent state =
and
  * first instruction of given state.
  */
-static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
-			     u32 *history)
+static int get_prev_insn_idx(const struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *st,
+			     int insn_idx, u32 *hist_endp)
 {
-	u32 cnt =3D *history;
+	u32 hist_end =3D *hist_endp;
+	u32 cnt =3D hist_end - st->insn_hist_start;
=20
-	if (i =3D=3D st->first_insn_idx) {
+	if (insn_idx =3D=3D st->first_insn_idx) {
 		if (cnt =3D=3D 0)
 			return -ENOENT;
-		if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i)
+		if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].idx =3D=3D insn_idx)
 			return -ENOENT;
 	}
=20
-	if (cnt && st->jmp_history[cnt - 1].idx =3D=3D i) {
-		i =3D st->jmp_history[cnt - 1].prev_idx;
-		(*history)--;
+	if (cnt && env->insn_hist[hist_end - 1].idx =3D=3D insn_idx) {
+		(*hist_endp)--;
+		return env->insn_hist[hist_end - 1].prev_idx;
 	} else {
-		i--;
+		return insn_idx - 1;
 	}
-	return i;
 }
=20
 static const char *disasm_kfunc_name(void *data, const struct bpf_insn *=
insn)
@@ -3529,7 +3519,7 @@ static bool calls_callback(struct bpf_verifier_env =
*env, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int sub=
seq_idx,
-			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
+			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs =3D {
 		.cb_call	=3D disasm_kfunc_name,
@@ -4025,7 +4015,7 @@ static int mark_precise_scalar_ids(struct bpf_verif=
ier_env *env, struct bpf_veri
  * SCALARS, as well as any other registers and slots that contribute to
  * a tracked state of given registers/stack slots, depending on specific=
 BPF
  * assembly instructions (see backtrack_insns() for exact instruction ha=
ndling
- * logic). This backtracking relies on recorded jmp_history and is able =
to
+ * logic). This backtracking relies on recorded insn_hist and is able to
  * traverse entire chain of parent states. This process ends only when a=
ll the
  * necessary registers/slots and their transitive dependencies are marke=
d as
  * precise.
@@ -4142,8 +4132,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
=20
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 history =3D st->jmp_history_cnt;
-		struct bpf_jmp_history_entry *hist;
+		u32 hist_end =3D st->insn_hist_end;
+		struct bpf_insn_hist_entry *hist;
=20
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_=
idx %d \n",
@@ -4207,7 +4197,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				hist =3D get_jmp_hist_entry(st, history, i);
+				hist =3D get_insn_hist_entry(env, hist_end, i);
 				err =3D backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
@@ -4224,7 +4214,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				 */
 				return 0;
 			subseq_idx =3D i;
-			i =3D get_prev_insn_idx(st, i, &history);
+			i =3D get_prev_insn_idx(env, st, i, &hist_end);
 			if (i =3D=3D -ENOENT)
 				break;
 			if (i >=3D env->prog->len) {
@@ -4545,7 +4535,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	}
=20
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_insn_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -4845,7 +4835,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 		insn_flags =3D 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_insn_history(env, env->cur_state, insn_flags);
 	return 0;
 }
=20
@@ -16975,7 +16965,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err =3D err ? : push_jmp_history(env, cur, 0);
+				err =3D err ? : push_insn_history(env, cur, 0);
 			err =3D err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17074,8 +17064,8 @@ static int is_state_visited(struct bpf_verifier_e=
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
@@ -17242,7 +17232,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		if (is_jmp_point(env, env->insn_idx)) {
-			err =3D push_jmp_history(env, state, 0);
+			err =3D push_insn_history(env, state, 0);
 			if (err)
 				return err;
 		}
@@ -20804,6 +20794,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
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


