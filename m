Return-Path: <bpf+bounces-14779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E97E7DA2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D9728143E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0E1DDCD;
	Fri, 10 Nov 2023 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6561DA58
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:11:27 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E9A3BF36
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:25 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAx842022162
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:25 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u9k82sx6p-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:25 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 08:11:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6176B3B49988A; Fri, 10 Nov 2023 08:11:16 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 8/8] bpf: emit frameno for PTR_TO_STACK regs if it differs from current one
Date: Fri, 10 Nov 2023 08:10:57 -0800
Message-ID: <20231110161057.1943534-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110161057.1943534-1-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xHyPlBBmopjR8uOpgWcjkVh_D5aftAIs
X-Proofpoint-ORIG-GUID: xHyPlBBmopjR8uOpgWcjkVh_D5aftAIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_13,2023-11-09_01,2023-05-22_02

It's possible to pass a pointer to parent's stack to child subprogs. In
such case verifier state output is ambiguous not showing whether
register container a pointer to "current" stack, belonging to current
subprog (frame), or it's actually a pointer to one of parent frames.

So emit this information if frame number differs between the state which
register is part of. E.g., if current state is in frame 2 and it has
a register pointing to stack in grand parent state (frame #0), we'll see
something like 'R1=3Dfp[0]-16', while "local stack pointer" will be just
'R2=3Dfp-16'.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 2f4d055849a4..d3d397ed7407 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -615,7 +615,9 @@ static bool type_is_map_ptr(enum bpf_reg_type t) {
 	}
 }
=20
-static void print_reg_state(struct bpf_verifier_env *env, const struct b=
pf_reg_state *reg)
+static void print_reg_state(struct bpf_verifier_env *env,
+			    const struct bpf_func_state *state,
+			    const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type t;
 	const char *sep =3D "";
@@ -623,10 +625,8 @@ static void print_reg_state(struct bpf_verifier_env =
*env, const struct bpf_reg_s
 	t =3D reg->type;
 	if (t =3D=3D SCALAR_VALUE && reg->precise)
 		verbose(env, "P");
-	if ((t =3D=3D SCALAR_VALUE || t =3D=3D PTR_TO_STACK) &&
-	    tnum_is_const(reg->var_off)) {
+	if (t =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_off)) {
 		/* reg->off should be 0 for SCALAR_VALUE */
-		verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t));
 		verbose_snum(env, reg->var_off.value + reg->off);
 		return;
 	}
@@ -637,6 +637,14 @@ static void print_reg_state(struct bpf_verifier_env =
*env, const struct bpf_reg_s
 #define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS__=
); sep =3D ","; })
=20
 	verbose(env, "%s", reg_type_str(env, t));
+	if (t =3D=3D PTR_TO_STACK) {
+		if (state->frameno !=3D reg->frameno)
+			verbose(env, "[%d]", reg->frameno);
+		if (tnum_is_const(reg->var_off)) {
+			verbose_snum(env, reg->var_off.value + reg->off);
+			return;
+		}
+	}
 	if (base_type(t) =3D=3D PTR_TO_BTF_ID)
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
@@ -694,7 +702,7 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_func_st
 		verbose(env, " R%d", i);
 		print_liveness(env, reg->live);
 		verbose(env, "=3D");
-		print_reg_state(env, reg);
+		print_reg_state(env, state, reg);
 	}
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		char types_buf[BPF_REG_SIZE + 1];
@@ -727,7 +735,7 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_func_st
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 			print_liveness(env, reg->live);
 			verbose(env, "=3D%s", types_buf);
-			print_reg_state(env, reg);
+			print_reg_state(env, state, reg);
 			break;
 		case STACK_DYNPTR:
 			/* skip to main dynptr slot */
--=20
2.34.1


