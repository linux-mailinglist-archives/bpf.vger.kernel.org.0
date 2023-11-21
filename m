Return-Path: <bpf+bounces-15461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570287F2210
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6187EB21A9D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D43EA5;
	Tue, 21 Nov 2023 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7023C7
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:59 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKMwvAb019752
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:59 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uggqp0fw0-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:22:59 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 16:22:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AD6213BD942BB; Mon, 20 Nov 2023 16:22:35 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 06/10] bpf: preserve constant zero when doing partial register restore
Date: Mon, 20 Nov 2023 16:22:17 -0800
Message-ID: <20231121002221.3687787-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121002221.3687787-1-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _MTVRoYPpeWPO1j4ctfgSdUSWsS49mhK
X-Proofpoint-GUID: _MTVRoYPpeWPO1j4ctfgSdUSWsS49mhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes from
stack from slot that has register spilled into it and that register has
a constant value zero, preserve that zero and mark spilled register as
precise for that. This makes spilled const zero register and STACK_ZERO
cases equivalent in their behavior.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5145afb5da25..00e6b17b71d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4695,22 +4695,39 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def =3D subreg_def;
 			} else {
+				int spill_cnt =3D 0, zero_cnt =3D 0;
+
 				for (i =3D 0; i < size; i++) {
 					type =3D stype[(slot - i) % BPF_REG_SIZE];
-					if (type =3D=3D STACK_SPILL)
+					if (type =3D=3D STACK_SPILL) {
+						spill_cnt++;
 						continue;
+					}
 					if (type =3D=3D STACK_MISC)
 						continue;
-					if (type =3D=3D STACK_ZERO)
+					if (type =3D=3D STACK_ZERO) {
+						zero_cnt++;
 						continue;
+					}
 					if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
 				}
-				mark_reg_unknown(env, state->regs, dst_regno);
-				insn_flags =3D 0; /* not restoring original register state */
+
+				if (spill_cnt =3D=3D size &&
+				    tnum_is_const(reg->var_off) && reg->var_off.value =3D=3D 0) {
+					__mark_reg_const_zero(&state->regs[dst_regno]);
+					/* this IS register fill, so keep insn_flags */
+				} else if (zero_cnt =3D=3D size) {
+					/* similarly to mark_reg_stack_read(), preserve zeroes */
+					__mark_reg_const_zero(&state->regs[dst_regno]);
+					insn_flags =3D 0; /* not restoring original register state */
+				} else {
+					mark_reg_unknown(env, state->regs, dst_regno);
+					insn_flags =3D 0; /* not restoring original register state */
+				}
 			}
 			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
 		} else if (dst_regno >=3D 0) {
--=20
2.34.1


