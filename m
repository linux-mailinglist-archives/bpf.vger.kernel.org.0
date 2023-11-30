Return-Path: <bpf+bounces-16209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF67FE47B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BCF2823E8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA16C64E;
	Thu, 30 Nov 2023 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757210C6
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:13 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATNIS2p017146
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:13 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upeus07vd-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:13 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 16:04:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3FE243C556628; Wed, 29 Nov 2023 16:04:24 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 03/10] bpf: enforce exact retval range on subprog/callback exit
Date: Wed, 29 Nov 2023 16:03:59 -0800
Message-ID: <20231130000406.480870-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130000406.480870-1-andrii@kernel.org>
References: <20231130000406.480870-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: huQTzxr6HrPBkcCKlemHZUs6QNkOM-Xd
X-Proofpoint-ORIG-GUID: huQTzxr6HrPBkcCKlemHZUs6QNkOM-Xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

Instead of relying on potentially imprecise tnum representation of
expected return value range for callbacks and subprogs, validate that
smin/smax range satisfy exact expected range of return values.

E.g., if callback would need to return [0, 2] range, tnum can't
represent this precisely and instead will allow [0, 3] range. By
checking smin/smax range, we can make sure that subprog/callback indeed
returns only valid [0, 2] range.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  7 ++++++-
 kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0c0e1bccad45..3378cc753061 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -275,6 +275,11 @@ struct bpf_reference_state {
 	int callback_ref;
 };
=20
+struct bpf_retval_range {
+	s32 minval;
+	s32 maxval;
+};
+
 /* state of the program:
  * type of all registers and stack info
  */
@@ -297,7 +302,7 @@ struct bpf_func_state {
 	 * void foo(void) { bpf_timer_set_callback(,foo); }
 	 */
 	u32 async_entry_cnt;
-	struct tnum callback_ret_range;
+	struct bpf_retval_range callback_ret_range;
 	bool in_callback_fn;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 849fbf47b5f3..5cf5b6b77ec3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2305,6 +2305,11 @@ static void init_reg_state(struct bpf_verifier_env=
 *env,
 	regs[BPF_REG_FP].frameno =3D state->frameno;
 }
=20
+static struct bpf_retval_range retval_range(s32 minval, s32 maxval)
+{
+	return (struct bpf_retval_range){ minval, maxval };
+}
+
 #define BPF_MAIN_FUNC (-1)
 static void init_func_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *state,
@@ -2313,7 +2318,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->callsite =3D callsite;
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
-	state->callback_ret_range =3D tnum_range(0, 0);
+	state->callback_ret_range =3D retval_range(0, 0);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
 }
@@ -9396,7 +9401,7 @@ static int set_map_elem_callback_state(struct bpf_v=
erifier_env *env,
 		return err;
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9418,7 +9423,7 @@ static int set_loop_callback_state(struct bpf_verif=
ier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9448,7 +9453,7 @@ static int set_timer_callback_state(struct bpf_veri=
fier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9476,7 +9481,7 @@ static int set_find_vma_callback_state(struct bpf_v=
erifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9499,7 +9504,7 @@ static int set_user_ringbuf_callback_state(struct b=
pf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9531,7 +9536,7 @@ static int set_rbtree_add_callback_state(struct bpf=
_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_=
verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
=20
+static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
+{
+	return range.minval <=3D reg->smin_value && reg->smax_value <=3D range.=
maxval;
+}
+
+static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
+{
+	if (range.minval =3D=3D range.maxval)
+		return tnum_const(range.minval);
+	else
+		return tnum_range(range.minval, range.maxval);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state, *prev_st;
@@ -9583,9 +9601,6 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
=20
 	caller =3D state->frame[state->curframe - 1];
 	if (callee->in_callback_fn) {
-		/* enforce R0 return value range [0, 1]. */
-		struct tnum range =3D callee->callback_ret_range;
-
 		if (r0->type !=3D SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
 			return -EACCES;
@@ -9597,7 +9612,10 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 		if (err)
 			return err;
=20
-		if (!tnum_in(range, r0->var_off)) {
+		/* enforce R0 return value range */
+		if (!retval_range_within(callee->callback_ret_range, r0)) {
+			struct tnum range =3D retval_range_as_tnum(callee->callback_ret_range=
);
+
 			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
 			return -EINVAL;
 		}
--=20
2.34.1


