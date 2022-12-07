Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5B6461E6
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGTzt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 7 Dec 2022 14:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGTzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:55:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8E5E3CD
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:55:46 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7JSmSj027187
        for <bpf@vger.kernel.org>; Wed, 7 Dec 2022 11:55:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mb118g7y6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:55:46 -0800
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 7 Dec 2022 11:55:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6CF1D23106E7C; Wed,  7 Dec 2022 11:55:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: remove unused insn_cnt argument from visit_[func_call_]insn()
Date:   Wed, 7 Dec 2022 11:55:34 -0800
Message-ID: <20221207195534.2866030-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5Qi7qpdwiUMmRhNUeHANftOs3dwlJcRK
X-Proofpoint-ORIG-GUID: 5Qi7qpdwiUMmRhNUeHANftOs3dwlJcRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Number of total instructions in BPF program (including subprogs) can and
is accessed from env->prog->len. visit_func_call_insn() doesn't do any
checks against insn_cnt anymore, relying on push_insn() to do this check
internally. So remove unnecessary insn_cnt input argument from
visit_func_call_insn() and visit_insn() functions.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c5f0adbbde3..9ecfdc06b5d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12222,8 +12222,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
 	return DONE_EXPLORING;
 }
 
-static int visit_func_call_insn(int t, int insn_cnt,
-				struct bpf_insn *insns,
+static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
 {
@@ -12254,13 +12253,13 @@ static int visit_func_call_insn(int t, int insn_cnt,
  *  DONE_EXPLORING - the instruction was fully explored
  *  KEEP_EXPLORING - there is still work to be done before it is fully explored
  */
-static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
+static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi;
 	int ret;
 
 	if (bpf_pseudo_func(insns + t))
-		return visit_func_call_insn(t, insn_cnt, insns, env, true);
+		return visit_func_call_insn(t, insns, env, true);
 
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insns[t].code) != BPF_JMP &&
@@ -12279,7 +12278,7 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
-		return visit_func_call_insn(t, insn_cnt, insns, env,
+		return visit_func_call_insn(t, insns, env,
 					    insns[t].src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
@@ -12336,7 +12335,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 	while (env->cfg.cur_stack > 0) {
 		int t = insn_stack[env->cfg.cur_stack - 1];
 
-		ret = visit_insn(t, insn_cnt, env);
+		ret = visit_insn(t, env);
 		switch (ret) {
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
-- 
2.30.2

