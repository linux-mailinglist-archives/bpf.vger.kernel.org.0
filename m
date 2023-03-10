Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB61F6B3659
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 07:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJGCV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 10 Mar 2023 01:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJGCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 01:02:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43924BC7A7
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 22:02:02 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32A5StkZ013655
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 22:02:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p7p0xb0cd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 22:02:01 -0800
Received: from twshared6687.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 22:01:59 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A9CB929CC9C6E; Thu,  9 Mar 2023 22:01:53 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] bpf: ensure state checkpointing at iter_next() call sites
Date:   Thu, 9 Mar 2023 22:01:49 -0800
Message-ID: <20230310060149.625887-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lTpzJR3oSG6nEuQusKeVo-EyBlvclEa0
X-Proofpoint-GUID: lTpzJR3oSG6nEuQusKeVo-EyBlvclEa0
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_02,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

State equivalence check and checkpointing performed in is_state_visited()
employs certain heuristics to try to save memory by avoiding state checkpoints
if not enough jumps and instructions happened since last checkpoint. This leads
to unpredictability of whether a particular instruction will be checkpointed
and how regularly. While normally this is not causing much problems (except
inconveniences for predictable verifier tests, which we overcome with
BPF_F_TEST_STATE_FREQ flag), turns out it's not the case for open-coded
iterators.

Checking and saving state checkpoints at iter_next() call is crucial for fast
convergence of open-coded iterator loop logic, so we need to force it. If we
don't do that, is_state_visited() might skip saving a checkpoint, causing
unnecessarily long sequence of not checkpointed instructions and jumps, leading
to exhaustion of jump history buffer, and potentially other undesired outcomes.
It is expected that with correct open-coded iterators convergence will happen
quickly, so we don't run a risk of exhausting memory.

This patch adds, in addition to prune and jump instruction marks, also a
"forced checkpoint" mark, and makes sure that any iter_next() call instruction
is marked as such.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/verifier.c        | 31 ++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0c052bc79940..81d525d057c7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -477,8 +477,12 @@ struct bpf_insn_aux_data {
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
-	bool prune_point;
 	bool jmp_point;
+	bool prune_point;
+	/* ensure we check state equivalence and save state checkpoint and
+	 * this instruction, regardless of any heuristics
+	 */
+	bool force_checkpoint;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45a082284464..13fd4c893f3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13865,6 +13865,17 @@ static bool is_prune_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].prune_point;
 }
 
+static void mark_force_checkpoint(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].force_checkpoint = true;
+}
+
+static bool is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].force_checkpoint;
+}
+
+
 enum {
 	DONE_EXPLORING = 0,
 	KEEP_EXPLORING = 1,
@@ -13984,8 +13995,21 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			struct bpf_kfunc_call_arg_meta meta;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
-			if (ret == 0 && is_iter_next_kfunc(&meta))
+			if (ret == 0 && is_iter_next_kfunc(&meta)) {
 				mark_prune_point(env, t);
+				/* Checking and saving state checkpoints at iter_next() call
+				 * is crucial for fast convergence of open-coded iterator loop
+				 * logic, so we need to force it. If we don't do that,
+				 * is_state_visited() might skip saving a checkpoint, causing
+				 * unnecessarily long sequence of not checkpointed
+				 * instructions and jumps, leading to exhaustion of jump
+				 * history buffer, and potentially other undesired outcomes.
+				 * It is expected that with correct open-coded iterators
+				 * convergence will happen quickly, so we don't run a risk of
+				 * exhausting memory.
+				 */
+				mark_force_checkpoint(env, t);
+			}
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
@@ -15172,7 +15196,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
 	int i, j, err, states_cnt = 0;
-	bool add_new_state = env->test_state_freq ? true : false;
+	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
+	bool add_new_state = force_new_state;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -15269,7 +15294,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * at the end of the loop are likely to be useful in pruning.
 			 */
 skip_inf_loop_check:
-			if (!env->test_state_freq &&
+			if (!force_new_state &&
 			    env->jmps_processed - env->prev_jmps_processed < 20 &&
 			    env->insn_processed - env->prev_insn_processed < 100)
 				add_new_state = false;
-- 
2.34.1

