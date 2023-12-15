Return-Path: <bpf+bounces-18057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02B8154BF
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B191B1F2643B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7181956391;
	Fri, 15 Dec 2023 23:58:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6814B5DE
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFMdWgB012156
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:58:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v0qt4m8gv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:58:38 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 15 Dec 2023 15:58:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 795463D3A31A5; Fri, 15 Dec 2023 15:58:23 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Maxim Mikityanskiy
	<maxtram95@gmail.com>
Subject: [PATCH bpf-next] bpf: ensure precise is reset to false in __mark_reg_const_zero()
Date: Fri, 15 Dec 2023 15:58:22 -0800
Message-ID: <20231215235822.908223-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3xW3uuBEuBlU8xlCg0f1Jm8KlcTaNtQc
X-Proofpoint-ORIG-GUID: 3xW3uuBEuBlU8xlCg0f1Jm8KlcTaNtQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_11,2023-12-14_01,2023-05-22_02

It is safe to always start with imprecise SCALAR_VALUE register.
Previously __mark_reg_const_zero() relied on caller to reset precise
mark, but it's very error prone and we already missed it in a few
places. So instead make __mark_reg_const_zero() reset precision always,
as it's a safe default for SCALAR_VALUE. Explanation is basically the
same as for why we are resetting (or rather not setting) precision in
current state. If necessary, precision propagation will set it to
precise correctly.

As such, also remove a big comment about forward precision propagation
in mark_reg_stack_read() and avoid unnecessarily setting precision to
true after reading from STACK_ZERO stack. Again, precision propagation
will correctly handle this, if that SCALAR_VALUE register will ever be
needed to be precise.

Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                            | 16 +++-------------
 .../selftests/bpf/progs/verifier_spill_fill.c    | 10 ++++++++--
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..3009d1faec86 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1781,6 +1781,7 @@ static void __mark_reg_const_zero(struct bpf_reg_st=
ate *reg)
 {
 	__mark_reg_known(reg, 0);
 	reg->type =3D SCALAR_VALUE;
+	reg->precise =3D false; /* all scalars are assumed imprecise initially =
*/
 }
=20
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
@@ -4706,21 +4707,10 @@ static void mark_reg_stack_read(struct bpf_verifi=
er_env *env,
 		zeros++;
 	}
 	if (zeros =3D=3D max_off - min_off) {
-		/* any access_size read into register is zero extended,
-		 * so the whole register =3D=3D const_zero
+		/* Any access_size read into register is zero extended,
+		 * so the whole register =3D=3D const_zero.
 		 */
 		__mark_reg_const_zero(&state->regs[dst_regno]);
-		/* backtracking doesn't support STACK_ZERO yet,
-		 * so mark it precise here, so that later
-		 * backtracking can stop here.
-		 * Backtracking may not need this if this register
-		 * doesn't participate in pointer adjustment.
-		 * Forward propagation of precise flag is not
-		 * necessary either. This mark is only to stop
-		 * backtracking. Any register that contributed
-		 * to const 0 was marked precise before spill.
-		 */
-		state->regs[dst_regno].precise =3D true;
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 508f5d6c7347..39fe3372e0e0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -499,8 +499,14 @@ __success
 __msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
 /* but fp-16 is spilled IMPRECISE zero const reg */
 __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
-/* and now check that precision propagation works even for such tricky c=
ase */
-__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 fp-=
16_w=3D0")
+/* validate that assigning R2 from STACK_ZERO doesn't mark register
+ * precise immediately; if necessary, it will be marked precise later
+ */
+__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
_w=3D00000000")
+/* similarly, when R2 is assigned from spilled register, it is initially
+ * imprecise, but will be marked precise later once it is used in precis=
e context
+ */
+__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
 __msg("11: (0f) r1 +=3D r2")
 __msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
 __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D *=
(u8 *)(r10 -9)")
--=20
2.34.1


