Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D724619D67
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKDQhG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Nov 2022 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKDQhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:37:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B90627148
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:37:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FNs0M015464
        for <bpf@vger.kernel.org>; Fri, 4 Nov 2022 09:37:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpgcf91p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 09:37:00 -0700
Received: from twshared18648.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 09:36:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 856B92117FE8B; Fri,  4 Nov 2022 09:36:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/6] bpf: propagate precision across all frames, not just the last one
Date:   Fri, 4 Nov 2022 09:36:45 -0700
Message-ID: <20221104163649.121784-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221104163649.121784-1-andrii@kernel.org>
References: <20221104163649.121784-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: e4pTLIH_86mYSpk74jE14qKJ78Lg5xmD
X-Proofpoint-ORIG-GUID: e4pTLIH_86mYSpk74jE14qKJ78Lg5xmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When equivalent completed state is found and it has additional precision
restrictions, BPF verifier propagates precision to
currently-being-verified state chain (i.e., including parent states) so
that if some of the states in the chain are not yet completed, necessary
precision restrictions are enforced.

Unfortunately, right now this happens only for the last frame (deepest
active subprogram's frame), not all the frames. This can lead to
incorrect matching of states due to missing precision marker. Currently
this doesn't seem possible as BPF verifier forces everything to precise
when validated BPF program has any subprograms. But with the next patch
lifting this restriction, this becomes problematic.

In fact, without this fix, we'll start getting failure in one of the
existing test_verifier test cases:

  #906/p precise: cross frame pruning FAIL
  Unexpected success to load!
  verification time 48 usec
  stack depth 0+0
  processed 26 insns (limit 1000000) max_states_per_insn 3 total_states 17 peak_states 17 mark_read 8

This patch adds precision propagation across all frames.

Fixes: a3ce685dd01a ("bpf: fix precision tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddfb4b0ab35f..5c708eb30664 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2756,7 +2756,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 		}
 }
 
-static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
+static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
 {
 	struct bpf_verifier_state *st = env->cur_state;
@@ -2773,7 +2773,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 	if (!env->bpf_capable)
 		return 0;
 
-	func = st->frame[st->curframe];
+	func = st->frame[frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
 		if (reg->type != SCALAR_VALUE) {
@@ -2854,7 +2854,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 			break;
 
 		new_marks = false;
-		func = st->frame[st->curframe];
+		func = st->frame[frame];
 		bitmap_from_u64(mask, reg_mask);
 		for_each_set_bit(i, mask, 32) {
 			reg = &func->regs[i];
@@ -2920,12 +2920,17 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, regno, -1);
+	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
 }
 
-static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
+static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
 {
-	return __mark_chain_precision(env, -1, spi);
+	return __mark_chain_precision(env, frame, regno, -1);
+}
+
+static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
+{
+	return __mark_chain_precision(env, frame, -1, spi);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -11794,34 +11799,36 @@ static int propagate_precision(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *state_reg;
 	struct bpf_func_state *state;
-	int i, err = 0;
+	int i, err = 0, fr;
 
-	state = old->frame[old->curframe];
-	state_reg = state->regs;
-	for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
-		if (state_reg->type != SCALAR_VALUE ||
-		    !state_reg->precise)
-			continue;
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating r%d\n", i);
-		err = mark_chain_precision(env, i);
-		if (err < 0)
-			return err;
-	}
+	for (fr = old->curframe; fr >= 0; fr--) {
+		state = old->frame[fr];
+		state_reg = state->regs;
+		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "frame %d: propagating r%d\n", i, fr);
+			err = mark_chain_precision_frame(env, fr, i);
+			if (err < 0)
+				return err;
+		}
 
-	for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (!is_spilled_reg(&state->stack[i]))
-			continue;
-		state_reg = &state->stack[i].spilled_ptr;
-		if (state_reg->type != SCALAR_VALUE ||
-		    !state_reg->precise)
-			continue;
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "propagating fp%d\n",
-				(-i - 1) * BPF_REG_SIZE);
-		err = mark_chain_precision_stack(env, i);
-		if (err < 0)
-			return err;
+		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (!is_spilled_reg(&state->stack[i]))
+				continue;
+			state_reg = &state->stack[i].spilled_ptr;
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "frame %d: propagating fp%d\n",
+					(-i - 1) * BPF_REG_SIZE, fr);
+			err = mark_chain_precision_stack_frame(env, fr, i);
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }
-- 
2.30.2

