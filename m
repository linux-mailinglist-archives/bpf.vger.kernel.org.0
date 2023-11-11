Return-Path: <bpf+bounces-14887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759097E8C85
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9E01F20FC7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C81DA22;
	Sat, 11 Nov 2023 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67571D55C
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 20:16:55 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674973A85
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:53 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABKGFWs023953
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua884hqjf-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:52 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 12:16:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 37C5D3B5A8FB4; Sat, 11 Nov 2023 12:16:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 4/8] bpf: print spilled register state in stack slot
Date: Sat, 11 Nov 2023 12:16:29 -0800
Message-ID: <20231111201633.3434794-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111201633.3434794-1-andrii@kernel.org>
References: <20231111201633.3434794-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vCa32rT440KUKpjLaHpahNZP66Dh-lrf
X-Proofpoint-ORIG-GUID: vCa32rT440KUKpjLaHpahNZP66Dh-lrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_16,2023-11-09_01,2023-05-22_02

Print the same register state representation when printing stack state,
as we do for normal registers. Note that if stack slot contains
subregister spill (1, 2, or 4 byte long), we'll still emit "m0?" mask
for those bytes that are not part of spilled register.

While means we can get something like fp-8=3D0000scalar() for a 4-byte
spill with other 4 bytes still being STACK_ZERO.

Some example before and after, taken from the log of
pyperf_subprogs.bpf.o:

49: (7b) *(u64 *)(r10 -256) =3D r1      ; frame1: R1_w=3Dctx(off=3D0,imm=3D=
0) R10=3Dfp0 fp-256_w=3Dctx
49: (7b) *(u64 *)(r10 -256) =3D r1      ; frame1: R1_w=3Dctx(off=3D0,imm=3D=
0) R10=3Dfp0 fp-256_w=3Dctx(off=3D0,imm=3D0)

150: (7b) *(u64 *)(r10 -264) =3D r0     ; frame1: R0_w=3Dmap_value_or_nul=
l(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0) R10=3Dfp0 fp-264_w=3Dmap_value_=
or_null
150: (7b) *(u64 *)(r10 -264) =3D r0     ; frame1: R0_w=3Dmap_value_or_nul=
l(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0) R10=3Dfp0 fp-264_w=3Dmap_value_=
or_null(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0)

5192: (61) r1 =3D *(u32 *)(r10 -272)    ; frame1: R1_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf)) R10=3Df=
p0 fp-272=3D
5192: (61) r1 =3D *(u32 *)(r10 -272)    ; frame1: R1_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf)) R10=3Df=
p0 fp-272=3D????scalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
15,var_off=3D(0x0; 0xf))

While at it, do a few other simple clean ups:
  - skip slot if it's not scratched before detecting whether it's valid;
  - move taking spilled_reg pointer outside of switch (only DYNPTR has
    to adjust that to get to the "main" slot);
  - don't recalculate types_buf second time for MISC/ZERO/default case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 05d737e2fab3..97a1641e848e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -618,7 +618,6 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_func_st
 			  bool print_all)
 {
 	const struct bpf_reg_state *reg;
-	enum bpf_reg_type t;
 	int i;
=20
 	if (state->frameno)
@@ -637,32 +636,38 @@ void print_verifier_state(struct bpf_verifier_env *=
env, const struct bpf_func_st
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		char types_buf[BPF_REG_SIZE + 1];
 		bool valid =3D false;
+		u8 slot_type;
 		int j;
=20
+		if (!print_all && !stack_slot_scratched(env, i))
+			continue;
+
 		for (j =3D 0; j < BPF_REG_SIZE; j++) {
-			if (state->stack[i].slot_type[j] !=3D STACK_INVALID)
+			slot_type =3D state->stack[i].slot_type[j];
+			if (slot_type !=3D STACK_INVALID)
 				valid =3D true;
-			types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
+			types_buf[j] =3D slot_type_char[slot_type];
 		}
 		types_buf[BPF_REG_SIZE] =3D 0;
 		if (!valid)
 			continue;
-		if (!print_all && !stack_slot_scratched(env, i))
-			continue;
+
+		reg =3D &state->stack[i].spilled_ptr;
 		switch (state->stack[i].slot_type[BPF_REG_SIZE - 1]) {
 		case STACK_SPILL:
-			reg =3D &state->stack[i].spilled_ptr;
-			t =3D reg->type;
+			/* print MISC/ZERO/INVALID slots above subreg spill */
+			for (j =3D 0; j < BPF_REG_SIZE; j++)
+				if (state->stack[i].slot_type[j] =3D=3D STACK_SPILL)
+					break;
+			types_buf[j] =3D '\0';
=20
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 			print_liveness(env, reg->live);
-			verbose(env, "=3D%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, =
t));
-			if (t =3D=3D SCALAR_VALUE && reg->precise)
-				verbose(env, "P");
-			if (t =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_off))
-				verbose(env, "%lld", reg->var_off.value + reg->off);
+			verbose(env, "=3D%s", types_buf);
+			print_reg_state(env, reg);
 			break;
 		case STACK_DYNPTR:
+			/* skip to main dynptr slot */
 			i +=3D BPF_DYNPTR_NR_SLOTS - 1;
 			reg =3D &state->stack[i].spilled_ptr;
=20
@@ -674,7 +679,6 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_func_st
 			break;
 		case STACK_ITER:
 			/* only main slot has ref_obj_id set; skip others */
-			reg =3D &state->stack[i].spilled_ptr;
 			if (!reg->ref_obj_id)
 				continue;
=20
@@ -688,12 +692,6 @@ void print_verifier_state(struct bpf_verifier_env *e=
nv, const struct bpf_func_st
 		case STACK_MISC:
 		case STACK_ZERO:
 		default:
-			reg =3D &state->stack[i].spilled_ptr;
-
-			for (j =3D 0; j < BPF_REG_SIZE; j++)
-				types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
-			types_buf[BPF_REG_SIZE] =3D 0;
-
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 			print_liveness(env, reg->live);
 			verbose(env, "=3D%s", types_buf);
--=20
2.34.1


