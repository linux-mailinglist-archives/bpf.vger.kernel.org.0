Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEF6EEB18
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjDYXtl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbjDYXtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F213C3B
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:37 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33PLEAP0029783
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3q6mgthrqq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:37 -0700
Received: from twshared6687.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 084982F2D83B2; Tue, 25 Apr 2023 16:49:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 05/10] bpf: maintain bitmasks across all active frames in __mark_chain_precision
Date:   Tue, 25 Apr 2023 16:49:06 -0700
Message-ID: <20230425234911.2113352-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bbKAVPc_kgwNGxyg8WiMmR6WQI4NFF_k
X-Proofpoint-ORIG-GUID: bbKAVPc_kgwNGxyg8WiMmR6WQI4NFF_k
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

Teach __mark_chain_precision logic to maintain register/stack masks
across all active frames when going from child state to parent state.
Currently this should be mostly no-op, as precision backtracking usually
bails out when encountering subprog entry/exit.

It's not very apparent from the diff due to increased indentation, but
the logic remains the same, except everything is done on specific `fr`
frame index. Calls to bt_clear_reg() and bt_clear_slot() are replaced
with frame-specific bt_clear_frame_reg() and bt_clear_frame_slot(),
where frame index is passed explicitly, instead of using current frame
number.

We also adjust logging to emit affected frame number. And we also add
better logging of human-readable register and stack slot masks, similar
to previous patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 101 ++++++++++--------
 .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
 2 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8faf9170acf0..0b19b3d9af65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3703,7 +3703,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
 	bool skip_first = true;
-	int i, err;
+	int i, fr, err;
 
 	if (!env->bpf_capable)
 		return 0;
@@ -3812,56 +3812,63 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		if (!st)
 			break;
 
-		func = st->frame[frame];
-		bitmap_from_u64(mask, bt_reg_mask(bt));
-		for_each_set_bit(i, mask, 32) {
-			reg = &func->regs[i];
-			if (reg->type != SCALAR_VALUE) {
-				bt_clear_reg(bt, i);
-				continue;
+		for (fr = bt->frame; fr >= 0; fr--) {
+			func = st->frame[fr];
+			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+			for_each_set_bit(i, mask, 32) {
+				reg = &func->regs[i];
+				if (reg->type != SCALAR_VALUE) {
+					bt_clear_frame_reg(bt, fr, i);
+					continue;
+				}
+				if (reg->precise)
+					bt_clear_frame_reg(bt, fr, i);
+				else
+					reg->precise = true;
 			}
-			if (reg->precise)
-				bt_clear_reg(bt, i);
-			else
-				reg->precise = true;
-		}
 
-		bitmap_from_u64(mask, bt_stack_mask(bt));
-		for_each_set_bit(i, mask, 64) {
-			if (i >= func->allocated_stack / BPF_REG_SIZE) {
-				/* the sequence of instructions:
-				 * 2: (bf) r3 = r10
-				 * 3: (7b) *(u64 *)(r3 -8) = r0
-				 * 4: (79) r4 = *(u64 *)(r10 -8)
-				 * doesn't contain jmps. It's backtracked
-				 * as a single block.
-				 * During backtracking insn 3 is not recognized as
-				 * stack access, so at the end of backtracking
-				 * stack slot fp-8 is still marked in stack_mask.
-				 * However the parent state may not have accessed
-				 * fp-8 and it's "unallocated" stack space.
-				 * In such case fallback to conservative.
-				 */
-				mark_all_scalars_precise(env, st);
-				bt_reset(bt);
-				return 0;
-			}
+			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
+			for_each_set_bit(i, mask, 64) {
+				if (i >= func->allocated_stack / BPF_REG_SIZE) {
+					/* the sequence of instructions:
+					 * 2: (bf) r3 = r10
+					 * 3: (7b) *(u64 *)(r3 -8) = r0
+					 * 4: (79) r4 = *(u64 *)(r10 -8)
+					 * doesn't contain jmps. It's backtracked
+					 * as a single block.
+					 * During backtracking insn 3 is not recognized as
+					 * stack access, so at the end of backtracking
+					 * stack slot fp-8 is still marked in stack_mask.
+					 * However the parent state may not have accessed
+					 * fp-8 and it's "unallocated" stack space.
+					 * In such case fallback to conservative.
+					 */
+					mark_all_scalars_precise(env, st);
+					bt_reset(bt);
+					return 0;
+				}
 
-			if (!is_spilled_scalar_reg(&func->stack[i])) {
-				bt_clear_slot(bt, i);
-				continue;
+				if (!is_spilled_scalar_reg(&func->stack[i])) {
+					bt_clear_frame_slot(bt, fr, i);
+					continue;
+				}
+				reg = &func->stack[i].spilled_ptr;
+				if (reg->precise)
+					bt_clear_frame_slot(bt, fr, i);
+				else
+					reg->precise = true;
+			}
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					     bt_frame_reg_mask(bt, fr));
+				verbose(env, "mark_precise: frame%d: parent state regs(0x%x)=%s ",
+					fr, bt_frame_reg_mask(bt, fr), env->tmp_str_buf);
+				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					       bt_frame_stack_mask(bt, fr));
+				verbose(env, "stack(0x%llx)=%s: ",
+					bt_frame_stack_mask(bt, fr), env->tmp_str_buf);
+				print_verifier_state(env, func, true);
 			}
-			reg = &func->stack[i].spilled_ptr;
-			if (reg->precise)
-				bt_clear_slot(bt, i);
-			else
-				reg->precise = true;
-		}
-		if (env->log.level & BPF_LOG_LEVEL2) {
-			verbose(env, "parent %s regs=%x stack=%llx marks:",
-				bt_bitcnt(bt) ? "didn't have" : "already had",
-				bt_reg_mask(bt), bt_stack_mask(bt));
-			print_verifier_state(env, func, true);
 		}
 
 		if (bt_bitcnt(bt) == 0)
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index fce831667b06..ac9be4c576d6 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -44,7 +44,7 @@
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x4)=r2 stack(0x0)=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
 	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
@@ -55,7 +55,7 @@
 	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 12\
 	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 11\
 	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 10\
-	parent already had regs=0 stack=0 marks:",
+	mark_precise: frame0: parent state regs(0x0)= stack(0x0)=:",
 },
 {
 	"precise: test 2",
@@ -104,15 +104,15 @@
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 24\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x4)=r2 stack(0x0)=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x4)=r2 stack(0x0)=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
 	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
 	mark_precise: frame0: regs(0x300)=r8,r9 stack(0x0)= before 17\
-	parent already had regs=0 stack=0 marks:",
+	mark_precise: frame0: parent state regs(0x0)= stack(0x0)=:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,14 +153,14 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x10)=r4 stack(0x0)=:\
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 4\
 	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 3\
 	mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 2\
 	mark_precise: frame0: falling back to forcing all scalars precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=1 stack=0 marks:",
+	mark_precise: frame0: parent state regs(0x1)=r0 stack(0x0)=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -179,7 +179,7 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x10)=r4 stack(0x0)=:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 5\
 	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 4\
@@ -188,7 +188,7 @@
 	force_precise: frame0: forcing r0 to be precise\
 	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=1 stack=0 marks:\
+	mark_precise: frame0: parent state regs(0x1)=r0 stack(0x0)=:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 5",
 	.result = VERBOSE_ACCEPT,
-- 
2.34.1

