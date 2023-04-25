Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73376EEB16
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjDYXtg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjDYXte (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41409B234
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEOsA012524
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:33 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q687r6ku5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:32 -0700
Received: from twshared6687.46.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 20F7F2F2D842F; Tue, 25 Apr 2023 16:49:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 07/10] bpf: fix mark_all_scalars_precise use in mark_chain_precision
Date:   Tue, 25 Apr 2023 16:49:08 -0700
Message-ID: <20230425234911.2113352-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2nni14xNUU2Lmc6Lp--X2cdQ2XCjb-A9
X-Proofpoint-GUID: 2nni14xNUU2Lmc6Lp--X2cdQ2XCjb-A9
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

When precision backtracking bails out due to some unsupported sequence
of instructions (e.g., stack access through register other than r10), we
need to mark all SCALAR registers as precise to be safe. Currently,
though, we mark SCALARs precise only starting from the state we detected
unsupported condition, which could be one of the parent states of the
actual current state. This will leave some registers potentially not
marked as precise, even though they should. So make sure we start
marking scalars as precise from current state (env->cur_state).

Further, we don't currently detect a situation when we end up with some
stack slots marked as needing precision, but we ran out of available
states to find the instructions that populate those stack slots. This is
akin the `i >= func->allocated_stack / BPF_REG_SIZE` check and should be
handled similarly by falling back to marking all SCALARs precise. Add
this check when we run out of states.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                          | 16 +++++++++++++---
 tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66d64ac10fb1..35f34c977819 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3781,7 +3781,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				err = backtrack_insn(env, i, bt);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, env->cur_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -3843,7 +3843,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 					 * fp-8 and it's "unallocated" stack space.
 					 * In such case fallback to conservative.
 					 */
-					mark_all_scalars_precise(env, st);
+					mark_all_scalars_precise(env, env->cur_state);
 					bt_reset(bt);
 					return 0;
 				}
@@ -3872,11 +3872,21 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		}
 
 		if (bt_bitcnt(bt) == 0)
-			break;
+			return 0;
 
 		last_idx = st->last_insn_idx;
 		first_idx = st->first_insn_idx;
 	}
+
+	/* if we still have requested precise regs or slots, we missed
+	 * something (e.g., stack access through non-r10 register), so
+	 * fallback to marking all precise
+	 */
+	if (bt_bitcnt(bt) != 0) {
+		mark_all_scalars_precise(env, env->cur_state);
+		bt_reset(bt);
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index ac9be4c576d6..f4f65cb9f9b1 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -159,8 +159,9 @@
 	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 3\
 	mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 2\
 	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs(0x1)=r0 stack(0x0)=:",
+	mark_precise: frame0: parent state regs(0x0)= stack(0x0)=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -187,10 +188,10 @@
 	mark_precise: frame0: falling back to forcing all scalars precise\
 	force_precise: frame0: forcing r0 to be precise\
 	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 6 first_idx 6\
-	mark_precise: frame0: parent state regs(0x1)=r0 stack(0x0)=:\
-	mark_precise: frame0: last_idx 5 first_idx 3\
-	mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 5",
+	mark_precise: frame0: parent state regs(0x0)= stack(0x0)=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
-- 
2.34.1

