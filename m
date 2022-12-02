Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FA63FFBE
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLBFLM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 2 Dec 2022 00:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiLBFLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 00:11:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6ACD7579
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 21:10:55 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B24QeWs017402
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 21:10:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m7ab2068m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 21:10:55 -0800
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 21:10:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AE67A22C31A7B; Thu,  1 Dec 2022 21:10:46 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: decouple prune and jump points
Date:   Thu, 1 Dec 2022 21:10:28 -0800
Message-ID: <20221202051030.3100390-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202051030.3100390-1-andrii@kernel.org>
References: <20221202051030.3100390-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LfHXjP20CD9JhG4xubZAl4xn4_L9E5BO
X-Proofpoint-GUID: LfHXjP20CD9JhG4xubZAl4xn4_L9E5BO
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_02,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF verifier marks some instructions as prune points. Currently these
prune points serve two purposes.

It's a point where verifier tries to find previously verified state and
check current state's equivalence to short circuit verification for
current code path.

But also currently it's a point where jump history, used for precision
backtracking, is updated. This is done so that non-linear flow of
execution could be properly backtracked.

Such coupling is coincidental and unnecessary. Some prune points are not
part of some non-linear jump path, so don't need update of jump history.
On the other hand, not all instructions which have to be recorded in
jump history necessarily are good prune points.

This patch splits prune and jump points into independent flags.
Currently all prune points are marked as jump points to minimize amount
of changes in this patch, but next patch will perform some optimization
of prune vs jmp point placement.

No functional changes are intended.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 57 +++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b5090e89cb3f..9870d1d0df01 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -452,6 +452,7 @@ struct bpf_insn_aux_data {
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
 	bool prune_point;
+	bool jmp_point;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0ecc0b18b20..2dec4ca47bb5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2525,6 +2525,16 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].jmp_point = true;
+}
+
+static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].jmp_point;
+}
+
 /* for any branch, call, exit record the history of jmps in the given state */
 static int push_jmp_history(struct bpf_verifier_env *env,
 			    struct bpf_verifier_state *cur)
@@ -2533,6 +2543,9 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 	struct bpf_idx_pair *p;
 	size_t alloc_size;
 
+	if (!is_jmp_point(env, env->insn_idx))
+		return 0;
+
 	cnt++;
 	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
 	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
@@ -12116,11 +12129,16 @@ static struct bpf_verifier_state_list **explored_state(
 	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
 }
 
-static void init_explored_state(struct bpf_verifier_env *env, int idx)
+static void mark_prune_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].prune_point = true;
 }
 
+static bool is_prune_point(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].prune_point;
+}
+
 enum {
 	DONE_EXPLORING = 0,
 	KEEP_EXPLORING = 1,
@@ -12149,9 +12167,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (e == BRANCH)
+	if (e == BRANCH) {
 		/* mark branch target for state pruning */
-		init_explored_state(env, w);
+		mark_prune_point(env, w);
+		mark_jmp_point(env, w);
+	}
 
 	if (insn_state[w] == 0) {
 		/* tree-edge */
@@ -12189,10 +12209,13 @@ static int visit_func_call_insn(int t, int insn_cnt,
 	if (ret)
 		return ret;
 
-	if (t + 1 < insn_cnt)
-		init_explored_state(env, t + 1);
+	if (t + 1 < insn_cnt) {
+		mark_prune_point(env, t + 1);
+		mark_jmp_point(env, t + 1);
+	}
 	if (visit_callee) {
-		init_explored_state(env, t);
+		mark_prune_point(env, t);
+		mark_jmp_point(env, t);
 		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env,
 				/* It's ok to allow recursion from CFG point of
 				 * view. __check_func_call() will do the actual
@@ -12226,13 +12249,15 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insns[t].imm == BPF_FUNC_timer_set_callback)
+		if (insns[t].imm == BPF_FUNC_timer_set_callback) {
 			/* Mark this call insn to trigger is_state_visited() check
 			 * before call itself is processed by __check_func_call().
 			 * Otherwise new async state will be pushed for further
 			 * exploration.
 			 */
-			init_explored_state(env, t);
+			mark_prune_point(env, t);
+			mark_jmp_point(env, t);
+		}
 		return visit_func_call_insn(t, insn_cnt, insns, env,
 					    insns[t].src_reg == BPF_PSEUDO_CALL);
 
@@ -12250,18 +12275,22 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 		 * but it's marked, since backtracking needs
 		 * to record jmp history in is_state_visited().
 		 */
-		init_explored_state(env, t + insns[t].off + 1);
+		mark_prune_point(env, t + insns[t].off + 1);
+		mark_jmp_point(env, t + insns[t].off + 1);
 		/* tell verifier to check for equivalent states
 		 * after every call and jump
 		 */
-		if (t + 1 < insn_cnt)
-			init_explored_state(env, t + 1);
+		if (t + 1 < insn_cnt) {
+			mark_prune_point(env, t + 1);
+			mark_jmp_point(env, t + 1);
+		}
 
 		return ret;
 
 	default:
 		/* conditional jump with two edges */
-		init_explored_state(env, t);
+		mark_prune_point(env, t);
+		mark_jmp_point(env, t);
 		ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
 		if (ret)
 			return ret;
@@ -13296,11 +13325,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	bool add_new_state = env->test_state_freq ? true : false;
 
 	cur->last_insn_idx = env->prev_insn_idx;
-	if (!env->insn_aux_data[insn_idx].prune_point)
+	if (!is_prune_point(env, insn_idx))
 		/* this 'insn_idx' instruction wasn't marked, so we will not
 		 * be doing state search here
 		 */
-		return 0;
+		return push_jmp_history(env, cur);
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
-- 
2.30.2

