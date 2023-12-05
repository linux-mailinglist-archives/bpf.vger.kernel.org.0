Return-Path: <bpf+bounces-16776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B59805DE9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DC71C2106E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA94A987;
	Tue,  5 Dec 2023 18:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC801A2
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:45:46 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5FexJu009691
	for <bpf@vger.kernel.org>; Tue, 5 Dec 2023 10:45:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ut2n0ukjk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:45:45 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 5 Dec 2023 10:45:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9E1123CA16FED; Tue,  5 Dec 2023 10:43:00 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 04/10] bpf: preserve STACK_ZERO slots on partial reg spills
Date: Tue, 5 Dec 2023 10:42:42 -0800
Message-ID: <20231205184248.1502704-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205184248.1502704-1-andrii@kernel.org>
References: <20231205184248.1502704-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bW-g0UTnD7HfobVfBYbY9Ujm4iqY9HDy
X-Proofpoint-GUID: bW-g0UTnD7HfobVfBYbY9Ujm4iqY9HDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02

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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3edca06de9fd..93de39a6e36e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1144,6 +1144,21 @@ static bool is_spilled_scalar_reg(const struct bpf=
_stack_state *stack)
 	       stack->spilled_ptr.type =3D=3D SCALAR_VALUE;
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
 static void scrub_spilled_slot(u8 *stype)
 {
 	if (*stype !=3D STACK_INVALID)
@@ -4386,7 +4401,8 @@ static void copy_register_state(struct bpf_reg_stat=
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
@@ -4401,7 +4417,7 @@ static void save_register_state(struct bpf_func_sta=
te *state,
=20
 	/* size < 8 bytes spill */
 	for (; i; i--)
-		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
+		mark_stack_slot_misc(env, &state->stack[spi].slot_type[i - 1]);
 }
=20
 static bool is_bpf_st_mem(struct bpf_insn *insn)
@@ -4463,7 +4479,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
-		save_register_state(state, spi, reg, size);
+		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id =3D 0;
@@ -4473,7 +4489,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
=20
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type =3D SCALAR_VALUE;
-		save_register_state(state, spi, &fake_reg, size);
+		save_register_state(env, state, spi, &fake_reg, size);
 		insn_flags =3D 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
@@ -4486,7 +4502,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
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
@@ -4757,6 +4773,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
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


