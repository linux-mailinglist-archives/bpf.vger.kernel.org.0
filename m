Return-Path: <bpf+bounces-90-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88B6F7BEE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4F71C21624
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC921C3C;
	Fri,  5 May 2023 04:33:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455BA1FD7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:33:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C511DAB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:33:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344JrwWh001073
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 21:33:39 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qck8rjn59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:33:39 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 21:33:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8634B3006D795; Thu,  4 May 2023 21:33:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 04/10] bpf: improve precision backtrack logging
Date: Thu, 4 May 2023 21:33:11 -0700
Message-ID: <20230505043317.3629845-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505043317.3629845-1-andrii@kernel.org>
References: <20230505043317.3629845-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tRO78qx2YgdaHqweMSpfrOJlLraOAlFn
X-Proofpoint-ORIG-GUID: tRO78qx2YgdaHqweMSpfrOJlLraOAlFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add helper to format register and stack masks in more human-readable
format. Adjust logging a bit during backtrack propagation and especially
during forcing precision fallback logic to make it clearer what's going
on (with log_level=3D2, of course), and also start reporting affected
frame depth. This is in preparation for having more than one active
frame later when precision propagation between subprog calls is added.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                  |  13 ++-
 kernel/bpf/verifier.c                         |  72 ++++++++++--
 .../testing/selftests/bpf/verifier/precise.c  | 106 +++++++++---------
 3 files changed, 128 insertions(+), 63 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 33f541366f4e..5b11a3b0fec0 100644
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
=20
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they recor=
d that
@@ -620,8 +623,10 @@ struct bpf_verifier_env {
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
=20
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b2e571250e1..5412c8c8511d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -605,9 +605,9 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 		 type & PTR_TRUSTED ? "trusted_" : ""
 	);
=20
-	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
+	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
-	return env->type_str_buf;
+	return env->tmp_str_buf;
 }
=20
 static char slot_type_char[] =3D {
@@ -3308,6 +3308,45 @@ static inline bool bt_is_slot_set(struct backtrack=
_state *bt, u32 slot)
 	return bt->stack_masks[bt->frame] & (1ull << slot);
 }
=20
+/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
+static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first =3D true;
+	int i, n;
+
+	buf[0] =3D '\0';
+
+	bitmap_from_u64(mask, reg_mask);
+	for_each_set_bit(i, mask, 32) {
+		n =3D snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i);
+		first =3D false;
+		buf +=3D n;
+		buf_sz -=3D n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
+static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first =3D true;
+	int i, n;
+
+	buf[0] =3D '\0';
+
+	bitmap_from_u64(mask, stack_mask);
+	for_each_set_bit(i, mask, 64) {
+		n =3D snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
+		first =3D false;
+		buf +=3D n;
+		buf_sz -=3D n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+
 /* For given verifier state backtrack_insn() is called from the last ins=
n to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -3331,7 +3370,11 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx,
 	if (insn->code =3D=3D 0)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "regs=3D%x stack=3D%llx before ", bt_reg_mask(bt), bt_sta=
ck_mask(bt));
+		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
+		verbose(env, "mark_precise: frame%d: regs=3D%s ",
+			bt->frame, env->tmp_str_buf);
+		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+		verbose(env, "stack=3D%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
@@ -3531,6 +3574,11 @@ static void mark_all_scalars_precise(struct bpf_ve=
rifier_env *env,
 	struct bpf_reg_state *reg;
 	int i, j;
=20
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "mark_precise: frame%d: falling back to forcing all scala=
rs precise\n",
+			st->curframe);
+	}
+
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
 	 * We also skip current state and go straight to first parent state,
@@ -3542,17 +3590,25 @@ static void mark_all_scalars_precise(struct bpf_v=
erifier_env *env,
 			func =3D st->frame[i];
 			for (j =3D 0; j < BPF_REG_FP; j++) {
 				reg =3D &func->regs[j];
-				if (reg->type !=3D SCALAR_VALUE)
+				if (reg->type !=3D SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise =3D true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing r%d to be precise\n",
+						i, j);
+				}
 			}
 			for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
 					continue;
 				reg =3D &func->stack[j].spilled_ptr;
-				if (reg->type !=3D SCALAR_VALUE)
+				if (reg->type !=3D SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise =3D true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing fp%d to be precise\n"=
,
+						i, -(j + 1) * 8);
+				}
 			}
 		}
 	}
@@ -3716,8 +3772,10 @@ static int __mark_chain_precision(struct bpf_verif=
ier_env *env, int frame, int r
 		DECLARE_BITMAP(mask, 64);
 		u32 history =3D st->jmp_history_cnt;
=20
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+		if (env->log.level & BPF_LOG_LEVEL2) {
+			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d\n",
+				bt->frame, last_idx, first_idx);
+		}
=20
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
index 8f0340eed696..a22fabd404ed 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -38,25 +38,24 @@
 	.fixup_map_array_48b =3D { 1 },
 	.result =3D VERBOSE_ACCEPT,
 	.errstr =3D
-	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 20\
-	regs=3D4 stack=3D0 before 25\
-	regs=3D4 stack=3D0 before 24\
-	regs=3D4 stack=3D0 before 23\
-	regs=3D4 stack=3D0 before 22\
-	regs=3D4 stack=3D0 before 20\
-	parent didn't have regs=3D4 stack=3D0 marks\
-	last_idx 19 first_idx 10\
-	regs=3D4 stack=3D0 before 19\
-	regs=3D200 stack=3D0 before 18\
-	regs=3D300 stack=3D0 before 17\
-	regs=3D201 stack=3D0 before 15\
-	regs=3D201 stack=3D0 before 14\
-	regs=3D200 stack=3D0 before 13\
-	regs=3D200 stack=3D0 before 12\
-	regs=3D200 stack=3D0 before 11\
-	regs=3D200 stack=3D0 before 10\
-	parent already had regs=3D0 stack=3D0 marks",
+	"mark_precise: frame0: last_idx 26 first_idx 20\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 25\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 24\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 23\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 22\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 20\
+	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 10\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 19\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 18\
+	mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
+	mark_precise: frame0: regs=3Dr0,r9 stack=3D before 15\
+	mark_precise: frame0: regs=3Dr0,r9 stack=3D before 14\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 13\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 12\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 11\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 10\
+	parent already had regs=3D0 stack=3D0 marks:",
 },
 {
 	"precise: test 2",
@@ -100,20 +99,20 @@
 	.flags =3D BPF_F_TEST_STATE_FREQ,
 	.errstr =3D
 	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 22\
-	regs=3D4 stack=3D0 before 25\
-	regs=3D4 stack=3D0 before 24\
-	regs=3D4 stack=3D0 before 23\
-	regs=3D4 stack=3D0 before 22\
-	parent didn't have regs=3D4 stack=3D0 marks\
-	last_idx 20 first_idx 20\
-	regs=3D4 stack=3D0 before 20\
-	parent didn't have regs=3D4 stack=3D0 marks\
-	last_idx 19 first_idx 17\
-	regs=3D4 stack=3D0 before 19\
-	regs=3D200 stack=3D0 before 18\
-	regs=3D300 stack=3D0 before 17\
-	parent already had regs=3D0 stack=3D0 marks",
+	mark_precise: frame0: last_idx 26 first_idx 22\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 25\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 24\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 23\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 22\
+	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 20 first_idx 20\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 20\
+	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 17\
+	mark_precise: frame0: regs=3Dr2 stack=3D before 19\
+	mark_precise: frame0: regs=3Dr9 stack=3D before 18\
+	mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
+	parent already had regs=3D0 stack=3D0 marks:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,15 +152,15 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D BPF_F_TEST_STATE_FREQ,
-	.errstr =3D "5: (2d) if r4 > r0 goto pc+0\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=3D10 stack=3D0 marks\
-	last_idx 4 first_idx 2\
-	regs=3D10 stack=3D0 before 4\
-	regs=3D10 stack=3D0 before 3\
-	regs=3D0 stack=3D1 before 2\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=3D1 stack=3D0 marks",
+	.errstr =3D "mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=3D10 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 4 first_idx 2\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 3\
+	mark_precise: frame0: regs=3D stack=3D-8 before 2\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=3D1 stack=3D0 marks:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
@@ -179,16 +178,19 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D BPF_F_TEST_STATE_FREQ,
-	.errstr =3D "last_idx 6 first_idx 6\
-	parent didn't have regs=3D10 stack=3D0 marks\
-	last_idx 5 first_idx 3\
-	regs=3D10 stack=3D0 before 5\
-	regs=3D10 stack=3D0 before 4\
-	regs=3D0 stack=3D1 before 3\
-	last_idx 6 first_idx 6\
-	parent didn't have regs=3D1 stack=3D0 marks\
-	last_idx 5 first_idx 3\
-	regs=3D1 stack=3D0 before 5",
+	.errstr =3D "mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=3D10 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 5\
+	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
+	mark_precise: frame0: regs=3D stack=3D-8 before 3\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=3D1 stack=3D0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs=3Dr0 stack=3D before 5",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
--=20
2.34.1


