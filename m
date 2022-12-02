Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6767A63FFBD
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLBFLL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 2 Dec 2022 00:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiLBFLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 00:11:10 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CBD78FA
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 21:11:02 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B21wZn2027855
        for <bpf@vger.kernel.org>; Thu, 1 Dec 2022 21:11:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6qnhsjg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 21:11:01 -0800
Received: from twshared1533.39.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 21:11:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C515622C31AB6; Thu,  1 Dec 2022 21:10:50 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] bpf: remove unnecessary prune and jump points
Date:   Thu, 1 Dec 2022 21:10:30 -0800
Message-ID: <20221202051030.3100390-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202051030.3100390-1-andrii@kernel.org>
References: <20221202051030.3100390-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iK0r-WruSVddlTarKEK33mYCI57ovIi9
X-Proofpoint-ORIG-GUID: iK0r-WruSVddlTarKEK33mYCI57ovIi9
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

Don't mark some instructions as jump points when there are actually no
jumps and instructions are just processed sequentially. Such case is
handled naturally by precision backtracking logic without the need to
update jump history.

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
 kernel/bpf/verifier.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 75a56ded5aca..03c2cc116292 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12209,13 +12209,10 @@ static int visit_func_call_insn(int t, int insn_cnt,
 	if (ret)
 		return ret;
 
-	if (t + 1 < insn_cnt) {
-		mark_prune_point(env, t + 1);
-		mark_jmp_point(env, t + 1);
-	}
+	mark_prune_point(env, t + 1);
+
 	if (visit_callee) {
 		mark_prune_point(env, t);
-		mark_jmp_point(env, t);
 		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env,
 				/* It's ok to allow recursion from CFG point of
 				 * view. __check_func_call() will do the actual
@@ -12249,15 +12246,13 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insns[t].imm == BPF_FUNC_timer_set_callback) {
+		if (insns[t].imm == BPF_FUNC_timer_set_callback)
 			/* Mark this call insn to trigger is_state_visited() check
 			 * before call itself is processed by __check_func_call().
 			 * Otherwise new async state will be pushed for further
 			 * exploration.
 			 */
 			mark_prune_point(env, t);
-			mark_jmp_point(env, t);
-		}
 		return visit_func_call_insn(t, insn_cnt, insns, env,
 					    insns[t].src_reg == BPF_PSEUDO_CALL);
 
@@ -12271,26 +12266,15 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
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

