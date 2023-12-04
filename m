Return-Path: <bpf+bounces-16620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF9803E57
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10D8B20400
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715C315B0;
	Mon,  4 Dec 2023 19:26:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97448AC
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:26:33 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4JFaiw001722
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 11:26:32 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3usmcwr9n7-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:26:32 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 11:26:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 0DA7B3C94B8C0; Mon,  4 Dec 2023 11:26:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 06/10] bpf: preserve constant zero when doing partial register restore
Date: Mon, 4 Dec 2023 11:25:57 -0800
Message-ID: <20231204192601.2672497-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204192601.2672497-1-andrii@kernel.org>
References: <20231204192601.2672497-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IqHuqta-ns3ipA7P1Rfr1wN8RAx4Ao3M
X-Proofpoint-ORIG-GUID: IqHuqta-ns3ipA7P1Rfr1wN8RAx4Ao3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02

Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes from
stack from slot that has register spilled into it and that register has
a constant value zero, preserve that zero and mark spilled register as
precise for that. This makes spilled const zero register and STACK_ZERO
cases equivalent in their behavior.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e96c53d0a112..0ef76a63ccd1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4767,22 +4767,39 @@ static int check_stack_read_fixed_off(struct bpf_=
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


