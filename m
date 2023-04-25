Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F86EEB1F
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjDYXw3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjDYXw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:52:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CEC15F
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:52:26 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLESC1028401
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:52:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6ek7mr4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:52:25 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:52:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F00D32F2D8358; Tue, 25 Apr 2023 16:49:22 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 04/10] bpf: improve precision backtrack logging
Date:   Tue, 25 Apr 2023 16:49:05 -0700
Message-ID: <20230425234911.2113352-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: itrzFXlpRtgrEyXw_dHpvfwlENqPzP5H
X-Proofpoint-GUID: itrzFXlpRtgrEyXw_dHpvfwlENqPzP5H
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

Add helper to format register and stack masks in more human-readable
format. Adjust logging a bit during backtrack propagation and especially
during forcing precision fallback logic to make it clearer what's going
on (with log_level=2, of course), and also start reporting affected
frame depth. This is in preparation for having more than one active
frame later when precision propagation between subprog calls is added.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                  |  13 ++-
 kernel/bpf/verifier.c                         |  72 ++++++++++--
 .../testing/selftests/bpf/verifier/precise.c  | 106 +++++++++---------
 3 files changed, 128 insertions(+), 63 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 185bfaf0ec6b..0ca367e13dd8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -18,8 +18,11 @@
  * that converting umax_value to int cannot overflow.
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
-/* size of type_str_buf in bpf_verifier. */
-#define TYPE_STR_BUF_LEN 128
+/* size of tmp_str_buf in bpf_verifier.
+ * we need at least 306 bytes to fit full stack mask representation
+ * (in the "-8,-16,...,-512" form)
+ */
+#define TMP_STR_BUF_LEN 320
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
@@ -621,8 +624,10 @@ struct bpf_verifier_env {
 	/* Same as scratched_regs but for stack slots */
 	u64 scratched_stack_slots;
 	u64 prev_log_pos, prev_insn_print_pos;
-	/* buffer used in reg_type_str() to generate reg_type string */
-	char type_str_buf[TYPE_STR_BUF_LEN];
+	/* buffer used to generate temporary string representations,
+	 * e.g., in reg_type_str() to generate reg_type string
+	 */
+	char tmp_str_buf[TMP_STR_BUF_LEN];
 };
 
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cb89fe00507..8faf9170acf0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -604,9 +604,9 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		 type & PTR_TRUSTED ? "trusted_" : ""
 	);
 
-	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
+	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
-	return env->type_str_buf;
+	return env->tmp_str_buf;
 }
 
 static char slot_type_char[] = {
@@ -3275,6 +3275,45 @@ static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
 	return bt->stack_masks[bt->frame] & (1ull << slot);
 }
 
+/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
+static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first = true;
+	int i, n;
+
+	buf[0] = '\0';
+
+	bitmap_from_u64(mask, reg_mask);
+	for_each_set_bit(i, mask, 32) {
+		n = snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i);
+		first = false;
+		buf += n;
+		buf_sz -= n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
+static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first = true;
+	int i, n;
+
+	buf[0] = '\0';
+
+	bitmap_from_u64(mask, stack_mask);
+	for_each_set_bit(i, mask, 64) {
+		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
+		first = false;
+		buf += n;
+		buf_sz -= n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -3298,7 +3337,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 	if (insn->code == 0)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "regs=%x stack=%llx before ", bt_reg_mask(bt), bt_stack_mask(bt));
+		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
+		verbose(env, "mark_precise: frame%d: regs(0x%x)=%s ",
+			bt->frame, bt_reg_mask(bt), env->tmp_str_buf);
+		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+		verbose(env, "stack(0x%llx)=%s before ", bt_stack_mask(bt), env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
@@ -3498,6 +3541,11 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	int i, j;
 
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "mark_precise: frame%d: falling back to forcing all scalars precise\n",
+			st->curframe);
+	}
+
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
 	 * We also skip current state and go straight to first parent state,
@@ -3509,17 +3557,25 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
 				reg = &func->regs[j];
-				if (reg->type != SCALAR_VALUE)
+				if (reg->type != SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing r%d to be precise\n",
+						i, j);
+				}
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
 					continue;
 				reg = &func->stack[j].spilled_ptr;
-				if (reg->type != SCALAR_VALUE)
+				if (reg->type != SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing fp%d to be precise\n",
+						i, -(j + 1) * 8);
+				}
 			}
 		}
 	}
@@ -3683,8 +3739,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+		if (env->log.level & BPF_LOG_LEVEL2) {
+			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d\n",
+				bt->frame, last_idx, first_idx);
+		}
 
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 6c03a7d805f9..fce831667b06 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -38,25 +38,24 @@
 	.fixup_map_array_48b = { 1 },
 	.result = VERBOSE_ACCEPT,
 	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 20\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 10\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	regs=201 stack=0 before 15\
-	regs=201 stack=0 before 14\
-	regs=200 stack=0 before 13\
-	regs=200 stack=0 before 12\
-	regs=200 stack=0 before 11\
-	regs=200 stack=0 before 10\
-	parent already had regs=0 stack=0 marks",
+	"mark_precise: frame0: last_idx 26 first_idx 20\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 25\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 24\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 10\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
+	mark_precise: frame0: regs(0x300)=r8,r9 stack(0x0)= before 17\
+	mark_precise: frame0: regs(0x201)=r0,r9 stack(0x0)= before 15\
+	mark_precise: frame0: regs(0x201)=r0,r9 stack(0x0)= before 14\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 13\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 12\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 11\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 10\
+	parent already had regs=0 stack=0 marks:",
 },
 {
 	"precise: test 2",
@@ -100,20 +99,20 @@
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr =
 	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 22\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 20 first_idx 20\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 17\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	parent already had regs=0 stack=0 marks",
+	mark_precise: frame0: last_idx 26 first_idx 22\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 25\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 24\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 20 first_idx 20\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 17\
+	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
+	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
+	mark_precise: frame0: regs(0x300)=r8,r9 stack(0x0)= before 17\
+	parent already had regs=0 stack=0 marks:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,15 +152,15 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "5: (2d) if r4 > r0 goto pc+0\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 4 first_idx 2\
-	regs=10 stack=0 before 4\
-	regs=10 stack=0 before 3\
-	regs=0 stack=1 before 2\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=1 stack=0 marks",
+	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: last_idx 4 first_idx 2\
+	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 4\
+	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 3\
+	mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 2\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=1 stack=0 marks:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -179,16 +178,19 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "last_idx 6 first_idx 6\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=10 stack=0 before 5\
-	regs=10 stack=0 before 4\
-	regs=0 stack=1 before 3\
-	last_idx 6 first_idx 6\
-	parent didn't have regs=1 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=1 stack=0 before 5",
+	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 5\
+	mark_precise: frame0: regs(0x10)=r4 stack(0x0)= before 4\
+	mark_precise: frame0: regs(0x0)= stack(0x1)=-8 before 3\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=1 stack=0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs(0x1)=r0 stack(0x0)= before 5",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
-- 
2.34.1

