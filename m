Return-Path: <bpf+bounces-13450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E720E7D9FA9
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD42B21686
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFF3C066;
	Fri, 27 Oct 2023 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EF3C079
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E512F4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE5R2i031877
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3u08vevbgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:52 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 508B73A7966EA; Fri, 27 Oct 2023 11:14:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 16/23] bpf: prepare reg_set_min_max for second set of registers
Date: Fri, 27 Oct 2023 11:13:39 -0700
Message-ID: <20231027181346.4019398-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TQM-1-_AA9whB3igNVskejzS7XRSaRIk
X-Proofpoint-ORIG-GUID: TQM-1-_AA9whB3igNVskejzS7XRSaRIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Similarly to is_branch_taken()-related refactorings, start preparing
reg_set_min_max() to handle more generic case of two non-const
registers. Start with renaming arguments to accommodate later addition
of second register as an input argument.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 80 +++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b911d1111fad..dde04b17c3a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14386,25 +14386,25 @@ static int is_branch_taken(struct bpf_reg_state=
 *reg1, struct bpf_reg_state *reg
  * simply doing a BPF_K check.
  * In JEQ/JNE cases we also adjust the var_off values.
  */
-static void reg_set_min_max(struct bpf_reg_state *true_reg,
-			    struct bpf_reg_state *false_reg,
+static void reg_set_min_max(struct bpf_reg_state *true_reg1,
+			    struct bpf_reg_state *false_reg1,
 			    u64 val, u32 val32,
 			    u8 opcode, bool is_jmp32)
 {
-	struct tnum false_32off =3D tnum_subreg(false_reg->var_off);
-	struct tnum false_64off =3D false_reg->var_off;
-	struct tnum true_32off =3D tnum_subreg(true_reg->var_off);
-	struct tnum true_64off =3D true_reg->var_off;
+	struct tnum false_32off =3D tnum_subreg(false_reg1->var_off);
+	struct tnum false_64off =3D false_reg1->var_off;
+	struct tnum true_32off =3D tnum_subreg(true_reg1->var_off);
+	struct tnum true_64off =3D true_reg1->var_off;
 	s64 sval =3D (s64)val;
 	s32 sval32 =3D (s32)val32;
=20
 	/* If the dst_reg is a pointer, we can't learn anything about its
 	 * variable offset from the compare (unless src_reg were a pointer into
 	 * the same object, but we don't bother with that.
-	 * Since false_reg and true_reg have the same type by construction, we
+	 * Since false_reg1 and true_reg1 have the same type by construction, w=
e
 	 * only need to check one of them for pointerness.
 	 */
-	if (__is_pointer_value(false, false_reg))
+	if (__is_pointer_value(false, false_reg1))
 		return;
=20
 	switch (opcode) {
@@ -14419,20 +14419,20 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 	 */
 	case BPF_JEQ:
 		if (is_jmp32) {
-			__mark_reg32_known(true_reg, val32);
-			true_32off =3D tnum_subreg(true_reg->var_off);
+			__mark_reg32_known(true_reg1, val32);
+			true_32off =3D tnum_subreg(true_reg1->var_off);
 		} else {
-			___mark_reg_known(true_reg, val);
-			true_64off =3D true_reg->var_off;
+			___mark_reg_known(true_reg1, val);
+			true_64off =3D true_reg1->var_off;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
-			__mark_reg32_known(false_reg, val32);
-			false_32off =3D tnum_subreg(false_reg->var_off);
+			__mark_reg32_known(false_reg1, val32);
+			false_32off =3D tnum_subreg(false_reg1->var_off);
 		} else {
-			___mark_reg_known(false_reg, val);
-			false_64off =3D false_reg->var_off;
+			___mark_reg_known(false_reg1, val);
+			false_64off =3D false_reg1->var_off;
 		}
 		break;
 	case BPF_JSET:
@@ -14455,16 +14455,16 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 			u32 false_umax =3D opcode =3D=3D BPF_JGT ? val32  : val32 - 1;
 			u32 true_umin =3D opcode =3D=3D BPF_JGT ? val32 + 1 : val32;
=20
-			false_reg->u32_max_value =3D min(false_reg->u32_max_value,
+			false_reg1->u32_max_value =3D min(false_reg1->u32_max_value,
 						       false_umax);
-			true_reg->u32_min_value =3D max(true_reg->u32_min_value,
+			true_reg1->u32_min_value =3D max(true_reg1->u32_min_value,
 						      true_umin);
 		} else {
 			u64 false_umax =3D opcode =3D=3D BPF_JGT ? val    : val - 1;
 			u64 true_umin =3D opcode =3D=3D BPF_JGT ? val + 1 : val;
=20
-			false_reg->umax_value =3D min(false_reg->umax_value, false_umax);
-			true_reg->umin_value =3D max(true_reg->umin_value, true_umin);
+			false_reg1->umax_value =3D min(false_reg1->umax_value, false_umax);
+			true_reg1->umin_value =3D max(true_reg1->umin_value, true_umin);
 		}
 		break;
 	}
@@ -14475,14 +14475,14 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 			s32 false_smax =3D opcode =3D=3D BPF_JSGT ? sval32    : sval32 - 1;
 			s32 true_smin =3D opcode =3D=3D BPF_JSGT ? sval32 + 1 : sval32;
=20
-			false_reg->s32_max_value =3D min(false_reg->s32_max_value, false_smax=
);
-			true_reg->s32_min_value =3D max(true_reg->s32_min_value, true_smin);
+			false_reg1->s32_max_value =3D min(false_reg1->s32_max_value, false_sm=
ax);
+			true_reg1->s32_min_value =3D max(true_reg1->s32_min_value, true_smin)=
;
 		} else {
 			s64 false_smax =3D opcode =3D=3D BPF_JSGT ? sval    : sval - 1;
 			s64 true_smin =3D opcode =3D=3D BPF_JSGT ? sval + 1 : sval;
=20
-			false_reg->smax_value =3D min(false_reg->smax_value, false_smax);
-			true_reg->smin_value =3D max(true_reg->smin_value, true_smin);
+			false_reg1->smax_value =3D min(false_reg1->smax_value, false_smax);
+			true_reg1->smin_value =3D max(true_reg1->smin_value, true_smin);
 		}
 		break;
 	}
@@ -14493,16 +14493,16 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 			u32 false_umin =3D opcode =3D=3D BPF_JLT ? val32  : val32 + 1;
 			u32 true_umax =3D opcode =3D=3D BPF_JLT ? val32 - 1 : val32;
=20
-			false_reg->u32_min_value =3D max(false_reg->u32_min_value,
+			false_reg1->u32_min_value =3D max(false_reg1->u32_min_value,
 						       false_umin);
-			true_reg->u32_max_value =3D min(true_reg->u32_max_value,
+			true_reg1->u32_max_value =3D min(true_reg1->u32_max_value,
 						      true_umax);
 		} else {
 			u64 false_umin =3D opcode =3D=3D BPF_JLT ? val    : val + 1;
 			u64 true_umax =3D opcode =3D=3D BPF_JLT ? val - 1 : val;
=20
-			false_reg->umin_value =3D max(false_reg->umin_value, false_umin);
-			true_reg->umax_value =3D min(true_reg->umax_value, true_umax);
+			false_reg1->umin_value =3D max(false_reg1->umin_value, false_umin);
+			true_reg1->umax_value =3D min(true_reg1->umax_value, true_umax);
 		}
 		break;
 	}
@@ -14513,14 +14513,14 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 			s32 false_smin =3D opcode =3D=3D BPF_JSLT ? sval32    : sval32 + 1;
 			s32 true_smax =3D opcode =3D=3D BPF_JSLT ? sval32 - 1 : sval32;
=20
-			false_reg->s32_min_value =3D max(false_reg->s32_min_value, false_smin=
);
-			true_reg->s32_max_value =3D min(true_reg->s32_max_value, true_smax);
+			false_reg1->s32_min_value =3D max(false_reg1->s32_min_value, false_sm=
in);
+			true_reg1->s32_max_value =3D min(true_reg1->s32_max_value, true_smax)=
;
 		} else {
 			s64 false_smin =3D opcode =3D=3D BPF_JSLT ? sval    : sval + 1;
 			s64 true_smax =3D opcode =3D=3D BPF_JSLT ? sval - 1 : sval;
=20
-			false_reg->smin_value =3D max(false_reg->smin_value, false_smin);
-			true_reg->smax_value =3D min(true_reg->smax_value, true_smax);
+			false_reg1->smin_value =3D max(false_reg1->smin_value, false_smin);
+			true_reg1->smax_value =3D min(true_reg1->smax_value, true_smax);
 		}
 		break;
 	}
@@ -14529,17 +14529,17 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 	}
=20
 	if (is_jmp32) {
-		false_reg->var_off =3D tnum_or(tnum_clear_subreg(false_64off),
+		false_reg1->var_off =3D tnum_or(tnum_clear_subreg(false_64off),
 					     tnum_subreg(false_32off));
-		true_reg->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
+		true_reg1->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
 					    tnum_subreg(true_32off));
-		reg_bounds_sync(false_reg);
-		reg_bounds_sync(true_reg);
+		reg_bounds_sync(false_reg1);
+		reg_bounds_sync(true_reg1);
 	} else {
-		false_reg->var_off =3D false_64off;
-		true_reg->var_off =3D true_64off;
-		reg_bounds_sync(false_reg);
-		reg_bounds_sync(true_reg);
+		false_reg1->var_off =3D false_64off;
+		true_reg1->var_off =3D true_64off;
+		reg_bounds_sync(false_reg1);
+		reg_bounds_sync(true_reg1);
 	}
 }
=20
--=20
2.34.1


