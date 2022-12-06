Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C40644FA6
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLFXd6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 6 Dec 2022 18:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLFXd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:33:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14F303FB
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:33:55 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6NLlKT023418
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:33:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3m9g8cdjsd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:33:54 -0800
Received: from twshared4568.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:33:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C47712304B9AD; Tue,  6 Dec 2022 15:33:50 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 2/3] bpf: mostly decouple jump history management from is_state_visited()
Date:   Tue, 6 Dec 2022 15:33:44 -0800
Message-ID: <20221206233345.438540-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206233345.438540-1-andrii@kernel.org>
References: <20221206233345.438540-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kGXqH-zdvc_5C9zewBX-9p_2lo5H8DLv
X-Proofpoint-ORIG-GUID: kGXqH-zdvc_5C9zewBX-9p_2lo5H8DLv
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jump history updating and state equivalence checks are conceptually
independent, so move push_jmp_history() out of is_state_visited(). Also
make a decision whether to perform state equivalence checks or not one
layer higher in do_check(), keeping is_state_visited() unconditionally
performing state checks.

push_jmp_history() should be performed after state checks. There is just
one small non-uniformity. When is_state_visited() finds already
validated equivalent state, it propagates precision marks to current
state's parent chain. For this to work correctly, jump history has to be
updated, so is_state_visited() is doing that internally.

But if no equivalent verified state is found, jump history has to be
updated in a newly cloned child state, so is_jmp_point()
+ push_jmp_history() is performed after is_state_visited() exited with
zero result, which means "proceed with validation".

This change has no functional changes. It's not strictly necessary, but
feels right to decouple these two processes.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 49 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb72536fbf5d..b1feb8d3c42e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13343,13 +13343,6 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	int i, j, err, states_cnt = 0;
 	bool add_new_state = env->test_state_freq ? true : false;
 
-	cur->last_insn_idx = env->prev_insn_idx;
-	if (!is_prune_point(env, insn_idx))
-		/* this 'insn_idx' instruction wasn't marked, so we will not
-		 * be doing state search here
-		 */
-		return push_jmp_history(env, cur);
-
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
 	 * Do not add new state for future pruning if the verifier hasn't seen
@@ -13484,10 +13477,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		env->max_states_per_insn = states_cnt;
 
 	if (!env->bpf_capable && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
-		return push_jmp_history(env, cur);
+		return 0;
 
 	if (!add_new_state)
-		return push_jmp_history(env, cur);
+		return 0;
 
 	/* There were no equivalent states, remember the current one.
 	 * Technically the current state is not proven to be safe yet,
@@ -13627,21 +13620,31 @@ static int do_check(struct bpf_verifier_env *env)
 			return -E2BIG;
 		}
 
-		err = is_state_visited(env, env->insn_idx);
-		if (err < 0)
-			return err;
-		if (err == 1) {
-			/* found equivalent state, can prune the search */
-			if (env->log.level & BPF_LOG_LEVEL) {
-				if (do_print_state)
-					verbose(env, "\nfrom %d to %d%s: safe\n",
-						env->prev_insn_idx, env->insn_idx,
-						env->cur_state->speculative ?
-						" (speculative execution)" : "");
-				else
-					verbose(env, "%d: safe\n", env->insn_idx);
+		state->last_insn_idx = env->prev_insn_idx;
+
+		if (is_prune_point(env, env->insn_idx)) {
+			err = is_state_visited(env, env->insn_idx);
+			if (err < 0)
+				return err;
+			if (err == 1) {
+				/* found equivalent state, can prune the search */
+				if (env->log.level & BPF_LOG_LEVEL) {
+					if (do_print_state)
+						verbose(env, "\nfrom %d to %d%s: safe\n",
+							env->prev_insn_idx, env->insn_idx,
+							env->cur_state->speculative ?
+							" (speculative execution)" : "");
+					else
+						verbose(env, "%d: safe\n", env->insn_idx);
+				}
+				goto process_bpf_exit;
 			}
-			goto process_bpf_exit;
+		}
+
+		if (is_jmp_point(env, env->insn_idx)) {
+			err = push_jmp_history(env, state);
+			if (err)
+				return err;
 		}
 
 		if (signal_pending(current))
-- 
2.30.2

