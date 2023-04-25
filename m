Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8456EEB19
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjDYXtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjDYXtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D7B230
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:41 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEJYe012383
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q687r6kun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:40 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 149BC2F2D83F3; Tue, 25 Apr 2023 16:49:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for inner frames
Date:   Tue, 25 Apr 2023 16:49:07 -0700
Message-ID: <20230425234911.2113352-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JfCW30_YEineFee5TuOdg5TAsQ1INFgc
X-Proofpoint-GUID: JfCW30_YEineFee5TuOdg5TAsQ1INFgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix propagate_precision() logic to perform propagation of all necessary
registers and stack slots across all active frames *in one batch step*.

Doing this for each register/slot in each individual frame is wasteful,
but the main problem is that backtracking of instruction in any frame
except the deepest one just doesn't work. This is due to backtracking
logic relying on jump history, and available jump history always starts
(or ends, depending how you view it) in current frame. So, if
prog A (frame #0) called subprog B (frame #1) and we need to propagate
precision of, say, register R6 (callee-saved) within frame #0, we
actually don't even know where jump history that corresponds to prog
A even starts. We'd need to skip subprog part of jump history first to
be able to do this.

Luckily, with struct backtrack_state and __mark_chain_precision()
handling bitmasks tracking/propagation across all active frames at the
same time (added in previous patch), propagate_precision() can be both
fixed and sped up by setting all the necessary bits across all frames
and then performing one __mark_chain_precision() pass. This makes it
unnecessary to skip subprog parts of jump history.

We also improve logging along the way, to clearly specify which
registers' and slots' precision markings are propagated within which
frame.

Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b19b3d9af65..66d64ac10fb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3885,14 +3885,12 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
 }
 
-static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
+static int mark_chain_precision_batch(struct bpf_verifier_env *env, int frame)
 {
-	return __mark_chain_precision(env, frame, regno, -1);
-}
-
-static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
-{
-	return __mark_chain_precision(env, frame, -1, spi);
+	/* we assume env->bt was set outside with desired reg and stack masks
+	 * for all frames
+	 */
+	return __mark_chain_precision(env, frame, -1, -1);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -15308,20 +15306,25 @@ static int propagate_precision(struct bpf_verifier_env *env,
 	struct bpf_reg_state *state_reg;
 	struct bpf_func_state *state;
 	int i, err = 0, fr;
+	bool first;
 
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
 		state_reg = state->regs;
+		first = true;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", fr, i);
-			err = mark_chain_precision_frame(env, fr, i);
-			if (err < 0)
-				return err;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating r%d", fr, i);
+				else
+					verbose(env, ",r%d", i);
+			}
+			bt_set_frame_reg(&env->bt, fr, i);
+			first = false;
 		}
 
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -15332,14 +15335,24 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating fp%d\n",
-					fr, (-i - 1) * BPF_REG_SIZE);
-			err = mark_chain_precision_stack_frame(env, fr, i);
-			if (err < 0)
-				return err;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating fp%d",
+						fr, (-i - 1) * BPF_REG_SIZE);
+				else
+					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
+			}
+			bt_set_frame_slot(&env->bt, fr, i);
+			first = false;
 		}
+		if (!first)
+			verbose(env, "\n");
 	}
+
+	err = mark_chain_precision_batch(env, old->curframe);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.34.1

