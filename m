Return-Path: <bpf+bounces-16429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BA8012D9
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358022821D4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447994F8BC;
	Fri,  1 Dec 2023 18:34:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A5133
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:34:18 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1IBZTL027008
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 10:34:17 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uq7jsvgt9-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:34:17 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:34:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 846443C6DB4A8; Fri,  1 Dec 2023 10:34:08 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v4 bpf-next 04/11] bpf: enforce exact retval range on subprog/callback exit
Date: Fri, 1 Dec 2023 10:33:52 -0800
Message-ID: <20231201183359.1769668-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201183359.1769668-1-andrii@kernel.org>
References: <20231201183359.1769668-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9WbSCSR3jUTHTWeqIZZ3JkajMGjyhwcX
X-Proofpoint-ORIG-GUID: 9WbSCSR3jUTHTWeqIZZ3JkajMGjyhwcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_16,2023-11-30_01,2023-05-22_02

Instead of relying on potentially imprecise tnum representation of
expected return value range for callbacks and subprogs, validate that
smin/smax range satisfy exact expected range of return values.

E.g., if callback would need to return [0, 2] range, tnum can't
represent this precisely and instead will allow [0, 3] range. By
checking smin/smax range, we can make sure that subprog/callback indeed
returns only valid [0, 2] range.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  7 ++++++-
 kernel/bpf/verifier.c        | 33 ++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

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
index 849fbf47b5f3..f3d9d7de68da 100644
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
@@ -9560,6 +9565,11 @@ static bool in_rbtree_lock_required_cb(struct bpf_=
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
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state, *prev_st;
@@ -9583,9 +9593,6 @@ static int prepare_func_exit(struct bpf_verifier_en=
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
@@ -9597,7 +9604,11 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 		if (err)
 			return err;
=20
-		if (!tnum_in(range, r0->var_off)) {
+		/* enforce R0 return value range */
+		if (!retval_range_within(callee->callback_ret_range, r0)) {
+			struct tnum range =3D tnum_range(callee->callback_ret_range.minval,
+						       callee->callback_ret_range.maxval);
+
 			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
 			return -EINVAL;
 		}
--=20
2.34.1


