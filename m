Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE66A8D45
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBXuk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBXuh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89811E5C6
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:36 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KUbWl013627
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:36 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2tfhd0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:35 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B3467291B7EDB; Thu,  2 Mar 2023 15:50:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 06/17] bpf: clean up visit_insn()'s instruction processing
Date:   Thu, 2 Mar 2023 15:50:04 -0800
Message-ID: <20230302235015.2044271-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kDcMCqoJaIc1fwJyE6K_VmFiK2SJLgdR
X-Proofpoint-ORIG-GUID: kDcMCqoJaIc1fwJyE6K_VmFiK2SJLgdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of referencing processed instruction repeatedly as insns[t]
throughout entire visit_insn() function, take a local insn pointer and
work with it in a cleaner way.

It makes enhancing this function further a bit easier as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 154f5d251ecb..f8055f3d9b47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13389,44 +13389,43 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
  */
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
-	struct bpf_insn *insns = env->prog->insnsi;
+	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
 	int ret;
 
-	if (bpf_pseudo_func(insns + t))
+	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
 
 	/* All non-branch instructions have a single fall-through edge. */
-	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
-	    BPF_CLASS(insns[t].code) != BPF_JMP32)
+	if (BPF_CLASS(insn->code) != BPF_JMP &&
+	    BPF_CLASS(insn->code) != BPF_JMP32)
 		return push_insn(t, t + 1, FALLTHROUGH, env, false);
 
-	switch (BPF_OP(insns[t].code)) {
+	switch (BPF_OP(insn->code)) {
 	case BPF_EXIT:
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (insns[t].imm == BPF_FUNC_timer_set_callback)
+		if (insn->imm == BPF_FUNC_timer_set_callback)
 			/* Mark this call insn as a prune point to trigger
 			 * is_state_visited() check before call itself is
 			 * processed by __check_func_call(). Otherwise new
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
-		return visit_func_call_insn(t, insns, env,
-					    insns[t].src_reg == BPF_PSEUDO_CALL);
+		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
-		if (BPF_SRC(insns[t].code) != BPF_K)
+		if (BPF_SRC(insn->code) != BPF_K)
 			return -EINVAL;
 
 		/* unconditional jump with single edge */
-		ret = push_insn(t, t + insns[t].off + 1, FALLTHROUGH, env,
+		ret = push_insn(t, t + insn->off + 1, FALLTHROUGH, env,
 				true);
 		if (ret)
 			return ret;
 
-		mark_prune_point(env, t + insns[t].off + 1);
-		mark_jmp_point(env, t + insns[t].off + 1);
+		mark_prune_point(env, t + insn->off + 1);
+		mark_jmp_point(env, t + insn->off + 1);
 
 		return ret;
 
@@ -13438,7 +13437,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		if (ret)
 			return ret;
 
-		return push_insn(t, t + insns[t].off + 1, BRANCH, env, true);
+		return push_insn(t, t + insn->off + 1, BRANCH, env, true);
 	}
 }
 
-- 
2.30.2

