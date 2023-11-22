Return-Path: <bpf+bounces-15611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E47F3B19
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1069B282A6F
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABE1842;
	Wed, 22 Nov 2023 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66F1A3
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:12 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM0KwdV031348
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:12 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh4dp9eug-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:12 -0800
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:17:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 81C563BE888E1; Tue, 21 Nov 2023 17:17:07 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 04/10] bpf: enforce exact retval range on subprog/callback exit
Date: Tue, 21 Nov 2023 17:16:50 -0800
Message-ID: <20231122011656.1105943-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122011656.1105943-1-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FhwmEFvaKiLUcH9V-2KIaULZ_UaLjsHR
X-Proofpoint-ORIG-GUID: FhwmEFvaKiLUcH9V-2KIaULZ_UaLjsHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

Instead of relying on potentially imprecise tnum representation of
expected return value range for callbacks and subprogs, validate that
both tnum and umin/umax range satisfy exact expected range of return
values.

E.g., if callback would need to return [0, 2] range, tnum can't
represent this precisely and instead will allow [0, 3] range. By
additionally checking umin/umax range, we can make sure that
subprog/callback indeed returns only valid [0, 2] range.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  7 +++++-
 kernel/bpf/verifier.c        | 45 +++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f019da8bf423..00702a3cca62 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -275,6 +275,11 @@ struct bpf_reference_state {
 	int callback_ref;
 };
=20
+struct bpf_retval_range {
+	u32 minval;
+	u32 maxval;
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
index b227f23e063d..fc103fd03896 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2272,6 +2272,19 @@ static void init_reg_state(struct bpf_verifier_env=
 *env,
 	regs[BPF_REG_FP].frameno =3D state->frameno;
 }
=20
+static struct bpf_retval_range retval_range(u32 minval, u32 maxval)
+{
+	return (struct bpf_retval_range){ minval, maxval };
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
 #define BPF_MAIN_FUNC (-1)
 static void init_func_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *state,
@@ -2280,7 +2293,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->callsite =3D callsite;
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
-	state->callback_ret_range =3D tnum_range(0, 0);
+	state->callback_ret_range =3D retval_range(0, 0);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
 }
@@ -9300,7 +9313,7 @@ static int set_map_elem_callback_state(struct bpf_v=
erifier_env *env,
 		return err;
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9322,7 +9335,7 @@ static int set_loop_callback_state(struct bpf_verif=
ier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9352,7 +9365,7 @@ static int set_timer_callback_state(struct bpf_veri=
fier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9380,7 +9393,7 @@ static int set_find_vma_callback_state(struct bpf_v=
erifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9403,7 +9416,7 @@ static int set_user_ringbuf_callback_state(struct b=
pf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
=20
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9435,7 +9448,7 @@ static int set_rbtree_add_callback_state(struct bpf=
_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
-	callee->callback_ret_range =3D tnum_range(0, 1);
+	callee->callback_ret_range =3D retval_range(0, 1);
 	return 0;
 }
=20
@@ -9464,6 +9477,16 @@ static bool in_rbtree_lock_required_cb(struct bpf_=
verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
=20
+static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
+{
+	struct tnum trange =3D retval_range_as_tnum(range);
+
+	if (!tnum_in(trange, reg->var_off))
+		return false;
+
+	return range.minval <=3D reg->umin_value && reg->umax_value <=3D range.=
maxval;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -9486,9 +9509,6 @@ static int prepare_func_exit(struct bpf_verifier_en=
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
@@ -9500,7 +9520,10 @@ static int prepare_func_exit(struct bpf_verifier_e=
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


