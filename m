Return-Path: <bpf+bounces-88-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFE6F7BEC
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26F2280EEE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B791FC5;
	Fri,  5 May 2023 04:33:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37D1C3C
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:33:41 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AC1163F
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:33:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344KBMm2024234
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 21:33:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qckh42hmm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:33:37 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 21:33:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9EB3A3006D7DE; Thu,  4 May 2023 21:33:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 05/10] bpf: maintain bitmasks across all active frames in __mark_chain_precision
Date: Thu, 4 May 2023 21:33:12 -0700
Message-ID: <20230505043317.3629845-6-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: tE4chmi0GOMFIQQv7UKusExEx4JOJNti
X-Proofpoint-GUID: tE4chmi0GOMFIQQv7UKusExEx4JOJNti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/bpf/verifier.c                         | 100 ++++++++++--------
 .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
 2 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5412c8c8511d..5a7997bc96f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3736,7 +3736,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int frame, int r
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
 	bool skip_first =3D true;
-	int i, err;
+	int i, fr, err;
=20
 	if (!env->bpf_capable)
 		return 0;
@@ -3845,56 +3845,62 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 		if (!st)
 			break;
=20
-		func =3D st->frame[frame];
-		bitmap_from_u64(mask, bt_reg_mask(bt));
-		for_each_set_bit(i, mask, 32) {
-			reg =3D &func->regs[i];
-			if (reg->type !=3D SCALAR_VALUE) {
-				bt_clear_reg(bt, i);
-				continue;
+		for (fr =3D bt->frame; fr >=3D 0; fr--) {
+			func =3D st->frame[fr];
+			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+			for_each_set_bit(i, mask, 32) {
+				reg =3D &func->regs[i];
+				if (reg->type !=3D SCALAR_VALUE) {
+					bt_clear_frame_reg(bt, fr, i);
+					continue;
+				}
+				if (reg->precise)
+					bt_clear_frame_reg(bt, fr, i);
+				else
+					reg->precise =3D true;
 			}
-			if (reg->precise)
-				bt_clear_reg(bt, i);
-			else
-				reg->precise =3D true;
-		}
=20
-		bitmap_from_u64(mask, bt_stack_mask(bt));
-		for_each_set_bit(i, mask, 64) {
-			if (i >=3D func->allocated_stack / BPF_REG_SIZE) {
-				/* the sequence of instructions:
-				 * 2: (bf) r3 =3D r10
-				 * 3: (7b) *(u64 *)(r3 -8) =3D r0
-				 * 4: (79) r4 =3D *(u64 *)(r10 -8)
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
+				if (i >=3D func->allocated_stack / BPF_REG_SIZE) {
+					/* the sequence of instructions:
+					 * 2: (bf) r3 =3D r10
+					 * 3: (7b) *(u64 *)(r3 -8) =3D r0
+					 * 4: (79) r4 =3D *(u64 *)(r10 -8)
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
=20
-			if (!is_spilled_scalar_reg(&func->stack[i])) {
-				bt_clear_slot(bt, i);
-				continue;
+				if (!is_spilled_scalar_reg(&func->stack[i])) {
+					bt_clear_frame_slot(bt, fr, i);
+					continue;
+				}
+				reg =3D &func->stack[i].spilled_ptr;
+				if (reg->precise)
+					bt_clear_frame_slot(bt, fr, i);
+				else
+					reg->precise =3D true;
+			}
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					     bt_frame_reg_mask(bt, fr));
+				verbose(env, "mark_precise: frame%d: parent state regs=3D%s ",
+					fr, env->tmp_str_buf);
+				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					       bt_frame_stack_mask(bt, fr));
+				verbose(env, "stack=3D%s: ", env->tmp_str_buf);
+				print_verifier_state(env, func, true);
 			}
-			reg =3D &func->stack[i].spilled_ptr;
-			if (reg->precise)
-				bt_clear_slot(bt, i);
-			else
-				reg->precise =3D true;
-		}
-		if (env->log.level & BPF_LOG_LEVEL2) {
-			verbose(env, "parent %s regs=3D%x stack=3D%llx marks:",
-				!bt_empty(bt) ? "didn't have" : "already had",
-				bt_reg_mask(bt), bt_stack_mask(bt));
-			print_verifier_state(env, func, true);
 		}
=20
 		if (bt_empty(bt))
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
index a22fabd404ed..77ea018582c5 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -44,7 +44,7 @@
 	mark_precise: frame0: regs=3Dr2 stack=3D before 23\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 22\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 20\
-	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 19\
 	mark_precise: frame0: regs=3Dr9 stack=3D before 18\
@@ -55,7 +55,7 @@
 	mark_precise: frame0: regs=3Dr9 stack=3D before 12\
 	mark_precise: frame0: regs=3Dr9 stack=3D before 11\
 	mark_precise: frame0: regs=3Dr9 stack=3D before 10\
-	parent already had regs=3D0 stack=3D0 marks:",
+	mark_precise: frame0: parent state regs=3D stack=3D:",
 },
 {
 	"precise: test 2",
@@ -104,15 +104,15 @@
 	mark_precise: frame0: regs=3Dr2 stack=3D before 24\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 23\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 22\
-	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 20\
-	parent didn't have regs=3D4 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs=3Dr2 stack=3D before 19\
 	mark_precise: frame0: regs=3Dr9 stack=3D before 18\
 	mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
-	parent already had regs=3D0 stack=3D0 marks:",
+	mark_precise: frame0: parent state regs=3D stack=3D:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,14 +153,14 @@
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D BPF_F_TEST_STATE_FREQ,
 	.errstr =3D "mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=3D10 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 3\
 	mark_precise: frame0: regs=3D stack=3D-8 before 2\
 	mark_precise: frame0: falling back to forcing all scalars precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=3D1 stack=3D0 marks:",
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
@@ -179,7 +179,7 @@
 	.prog_type =3D BPF_PROG_TYPE_XDP,
 	.flags =3D BPF_F_TEST_STATE_FREQ,
 	.errstr =3D "mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=3D10 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 5\
 	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
@@ -188,7 +188,7 @@
 	force_precise: frame0: forcing r0 to be precise\
 	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=3D1 stack=3D0 marks:\
+	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs=3Dr0 stack=3D before 5",
 	.result =3D VERBOSE_ACCEPT,
--=20
2.34.1


