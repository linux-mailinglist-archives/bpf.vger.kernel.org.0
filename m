Return-Path: <bpf+bounces-13666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4D7DC59F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FD1F2223D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3BC8F5;
	Tue, 31 Oct 2023 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E7D28D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:03:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C7DD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:56 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UKaShX002508
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u1p2ba7ng-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:55 -0700
Received: from twshared39705.02.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:03:48 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9AD883AA9B6F6; Mon, 30 Oct 2023 22:03:36 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 5/7] bpf: preserve STACK_ZERO slots on partial reg spills
Date: Mon, 30 Oct 2023 22:03:22 -0700
Message-ID: <20231031050324.1107444-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031050324.1107444-1-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ijn2O2dORuFnmJcx1g18JukoNKSXN9J1
X-Proofpoint-GUID: Ijn2O2dORuFnmJcx1g18JukoNKSXN9J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02

Instead of always forcing STACK_ZERO slots to STACK_MISC, preserve it in
situations where this is possible. E.g., when spilling register as
1/2/4-byte subslots on the stack, all the remaining bytes in the stack
slot do not automatically become unknown. If we knew they contained
zeroes, we can preserve those STACK_ZERO markers.

Add a helper mark_stack_slot_misc(), similar to scrub_spilled_slot(),
but that doesn't overwrite either STACK_INVALID nor STACK_ZERO. Note
that we need to take into account possibility of being in unprivileged
mode, in which case STACK_INVALID is forced to STACK_MISC for correctness=
,
as treating STACK_INVALID as equivalent STACK_MISC is only enabled in
privileged mode.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 82992c32c1bd..0eecc6b3109c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1355,6 +1355,21 @@ static void scrub_spilled_slot(u8 *stype)
 		*stype =3D STACK_MISC;
 }
=20
+/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in=
 which
+ * case they are equivalent, or it's STACK_ZERO, in which case we preser=
ve
+ * more precise STACK_ZERO.
+ * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
+ * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
+ */
+static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype=
)
+{
+	if (*stype =3D=3D STACK_ZERO)
+		return;
+	if (env->allow_ptr_leaks && *stype =3D=3D STACK_INVALID)
+		return;
+	*stype =3D STACK_MISC;
+}
+
 static void print_scalar_ranges(struct bpf_verifier_env *env,
 				const struct bpf_reg_state *reg,
 				const char **sep)
@@ -4577,7 +4592,8 @@ static void copy_register_state(struct bpf_reg_stat=
e *dst, const struct bpf_reg_
 	dst->live =3D live;
 }
=20
-static void save_register_state(struct bpf_func_state *state,
+static void save_register_state(struct bpf_verifier_env *env,
+				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
 				int size)
 {
@@ -4592,7 +4608,7 @@ static void save_register_state(struct bpf_func_sta=
te *state,
=20
 	/* size < 8 bytes spill */
 	for (; i; i--)
-		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
+		mark_stack_slot_misc(env, &state->stack[spi].slot_type[i - 1]);
 }
=20
 static bool is_bpf_st_mem(struct bpf_insn *insn)
@@ -4654,7 +4670,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
-		save_register_state(state, spi, reg, size);
+		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id =3D 0;
@@ -4664,7 +4680,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
=20
 		__mark_reg_known(&fake_reg, (u32)insn->imm);
 		fake_reg.type =3D SCALAR_VALUE;
-		save_register_state(state, spi, &fake_reg, size);
+		save_register_state(env, state, spi, &fake_reg, size);
 		insn_flags =3D 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
@@ -4677,7 +4693,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 			verbose(env, "cannot spill pointers to stack into stack frame of the =
caller\n");
 			return -EINVAL;
 		}
-		save_register_state(state, spi, reg, size);
+		save_register_state(env, state, spi, reg, size);
 	} else {
 		u8 type =3D STACK_MISC;
=20
@@ -4948,6 +4964,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 						continue;
 					if (type =3D=3D STACK_MISC)
 						continue;
+					if (type =3D=3D STACK_ZERO)
+						continue;
 					if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
--=20
2.34.1


