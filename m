Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03312644FA8
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLFXeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 6 Dec 2022 18:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFXeG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:34:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DE303FB
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:34:05 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6NLpV7028484
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:34:04 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m9s5q0fn9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:34:04 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 15:34:02 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D8F802304B9B8; Tue,  6 Dec 2022 15:33:52 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/3] bpf: remove unnecessary prune and jump points
Date:   Tue, 6 Dec 2022 15:33:45 -0800
Message-ID: <20221206233345.438540-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206233345.438540-1-andrii@kernel.org>
References: <20221206233345.438540-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z8o6IFYm9ly6WgqrXo5S8eRBU2bZBnxP
X-Proofpoint-ORIG-GUID: Z8o6IFYm9ly6WgqrXo5S8eRBU2bZBnxP
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

Don't mark some instructions as jump points when there are actually no
jumps and instructions are just processed sequentially. Such case is
handled naturally by precision backtracking logic without the need to
update jump history. See get_prev_insn_idx(). It goes back linearly by
one instruction, unless current top of jmp_history is pointing to
current instruction. In such case we use `st->jmp_history[cnt - 1].prev_idx`
to find instruction from which we jumped to the current instruction
non-linearly.

Also remove both jump and prune point marking for instruction right
after unconditional jumps, as program flow can get to the instruction
right after unconditional jump instruction only if there is a jump to
that instruction from somewhere else in the program. In such case we'll
mark such instruction as prune/jump point because it's a destination of
a jump.

This change has no changes in terms of number of instructions or states
processes across Cilium and selftests programs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1feb8d3c42e..4f163a28ab59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12228,13 +12228,12 @@ static int visit_func_call_insn(int t, int insn_cnt,
 	if (ret)
 		return ret;
 
-	if (t + 1 < insn_cnt) {
-		mark_prune_point(env, t + 1);
-		mark_jmp_point(env, t + 1);
-	}
+	mark_prune_point(env, t + 1);
+	/* when we exit from subprog, we need to record non-linear history */
+	mark_jmp_point(env, t + 1);
+
 	if (visit_callee) {
 		mark_prune_point(env, t);
-		mark_jmp_point(env, t);
 		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env,
 				/* It's ok to allow recursion from CFG point of
 				 * view. __check_func_call() will do the actual
@@ -12268,15 +12267,13 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insns[t].imm == BPF_FUNC_timer_set_callback) {
-			/* Mark this call insn to trigger is_state_visited() check
-			 * before call itself is processed by __check_func_call().
-			 * Otherwise new async state will be pushed for further
-			 * exploration.
+		if (insns[t].imm == BPF_FUNC_timer_set_callback)
+			/* Mark this call insn as a prune point to trigger
+			 * is_state_visited() check before call itself is
+			 * processed by __check_func_call(). Otherwise new
+			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
-			mark_jmp_point(env, t);
-		}
 		return visit_func_call_insn(t, insn_cnt, insns, env,
 					    insns[t].src_reg == BPF_PSEUDO_CALL);
 
@@ -12290,26 +12287,15 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 		if (ret)
 			return ret;
 
-		/* unconditional jmp is not a good pruning point,
-		 * but it's marked, since backtracking needs
-		 * to record jmp history in is_state_visited().
-		 */
 		mark_prune_point(env, t + insns[t].off + 1);
 		mark_jmp_point(env, t + insns[t].off + 1);
-		/* tell verifier to check for equivalent states
-		 * after every call and jump
-		 */
-		if (t + 1 < insn_cnt) {
-			mark_prune_point(env, t + 1);
-			mark_jmp_point(env, t + 1);
-		}
 
 		return ret;
 
 	default:
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
-		mark_jmp_point(env, t);
+
 		ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
 		if (ret)
 			return ret;
-- 
2.30.2

