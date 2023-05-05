Return-Path: <bpf+bounces-67-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8E6F79FE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557CA280F9F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E91110D;
	Fri,  5 May 2023 00:10:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29CEA1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:10:20 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C112E90
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:10:19 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344JrwJ4001073
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:10:18 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qck8rhe7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:10:18 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A9BBB3002FB28; Thu,  4 May 2023 17:09:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 06/10] bpf: fix propagate_precision() logic for inner frames
Date: Thu, 4 May 2023 17:09:04 -0700
Message-ID: <20230505000908.1265044-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SjfiqJhezLCzbSKi-OpGpTm0eBKgRddd
X-Proofpoint-ORIG-GUID: SjfiqJhezLCzbSKi-OpGpTm0eBKgRddd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
frame. Each frame will have dedicated line and all registers and stack
slots from that frame will be reported in format similar to precision
backtrack regs/stack logging. E.g.:

frame 1: propagating r1,r2,r3,fp-8,fp-16
frame 0: propagating r3,r9,fp-120

Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not jus=
t the last one")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 65 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d373f472406b..474966d339b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3742,8 +3742,7 @@ static void mark_all_scalars_imprecise(struct bpf_v=
erifier_env *env, struct bpf_
  * mark_all_scalars_imprecise() to hopefully get more permissive and gen=
eric
  * finalized states which help in short circuiting more future states.
  */
-static int __mark_chain_precision(struct bpf_verifier_env *env, int fram=
e, int regno,
-				  int spi)
+static int __mark_chain_precision(struct bpf_verifier_env *env, int regn=
o)
 {
 	struct backtrack_state *bt =3D &env->bt;
 	struct bpf_verifier_state *st =3D env->cur_state;
@@ -3758,13 +3757,13 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
 		return 0;
=20
 	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, frame);
+	bt_init(bt, env->cur_state->curframe);
=20
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
 	 */
-	func =3D st->frame[frame];
+	func =3D st->frame[bt->frame];
 	if (regno >=3D 0) {
 		reg =3D &func->regs[regno];
 		if (reg->type !=3D SCALAR_VALUE) {
@@ -3774,13 +3773,6 @@ static int __mark_chain_precision(struct bpf_verif=
ier_env *env, int frame, int r
 		bt_set_reg(bt, regno);
 	}
=20
-	while (spi >=3D 0) {
-		if (!is_spilled_scalar_reg(&func->stack[spi]))
-			break;
-		bt_set_slot(bt, spi);
-		break;
-	}
-
 	if (bt_empty(bt))
 		return 0;
=20
@@ -3930,17 +3922,15 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int frame, int r
=20
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1)=
;
-}
-
-static int mark_chain_precision_frame(struct bpf_verifier_env *env, int =
frame, int regno)
-{
-	return __mark_chain_precision(env, frame, regno, -1);
+	return __mark_chain_precision(env, regno);
 }
=20
-static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env=
, int frame, int spi)
+/* mark_chain_precision_batch() assumes that env->bt is set in the calle=
r to
+ * desired reg and stack masks across all relevant frames
+ */
+static int mark_chain_precision_batch(struct bpf_verifier_env *env)
 {
-	return __mark_chain_precision(env, frame, -1, spi);
+	return __mark_chain_precision(env, -1);
 }
=20
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -15377,20 +15367,25 @@ static int propagate_precision(struct bpf_verif=
ier_env *env,
 	struct bpf_reg_state *state_reg;
 	struct bpf_func_state *state;
 	int i, err =3D 0, fr;
+	bool first;
=20
 	for (fr =3D old->curframe; fr >=3D 0; fr--) {
 		state =3D old->frame[fr];
 		state_reg =3D state->regs;
+		first =3D true;
 		for (i =3D 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type !=3D SCALAR_VALUE ||
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", fr, i);
-			err =3D mark_chain_precision_frame(env, fr, i);
-			if (err < 0)
-				return err;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating r%d", fr, i);
+				else
+					verbose(env, ",r%d", i);
+			}
+			bt_set_frame_reg(&env->bt, fr, i);
+			first =3D false;
 		}
=20
 		for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -15401,14 +15396,24 @@ static int propagate_precision(struct bpf_verif=
ier_env *env,
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating fp%d\n",
-					fr, (-i - 1) * BPF_REG_SIZE);
-			err =3D mark_chain_precision_stack_frame(env, fr, i);
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
+			first =3D false;
 		}
+		if (!first)
+			verbose(env, "\n");
 	}
+
+	err =3D mark_chain_precision_batch(env);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
=20
--=20
2.34.1


