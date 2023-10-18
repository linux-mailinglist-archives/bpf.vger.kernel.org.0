Return-Path: <bpf+bounces-12604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF997CE6CC
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D051C20E07
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452D41E46;
	Wed, 18 Oct 2023 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A242BF0
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:36:59 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B558118
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIN7c1024563
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tsqqtbdve-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:55 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 11:36:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2DC8A39F88BC1; Wed, 18 Oct 2023 11:36:40 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 6/7] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
Date: Wed, 18 Oct 2023 11:36:24 -0700
Message-ID: <20231018183625.3952512-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018183625.3952512-1-andrii@kernel.org>
References: <20231018183625.3952512-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iDum6VusSKHTzietiecxFwOhlAsa9-Ij
X-Proofpoint-ORIG-GUID: iDum6VusSKHTzietiecxFwOhlAsa9-Ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_16,2023-10-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When performing 32-bit conditional operation operating on lower 32 bits
of a full 64-bit register, register full value isn't changed. We just
potentially gain new knowledge about that register's lower 32 bits.

Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
reg_set_min_max() performs as a last step, can lose information in some
cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
That's bad and completely unnecessary. Especially __reg_assign_32_into_64=
()
looks completely out of place here, because we are not performing
zero-extending subregister assignment during conditional jump.

So this patch replaced __reg_combine_* with just a normal
reg_bounds_sync() which will do a proper job of deriving u64/s64 bounds
from u32/s32, and vice versa (among all other combinations).

__reg_combine_64_into_32() is also used in one more place,
coerce_reg_to_size(), while handling 1- and 2-byte register loads.
Looking into this, it seems like besides marking subregister as
unbounded before performing reg_bounds_sync(), we were also performing
deduction of smin32/smax32 and umin32/umax32 bounds from respective
smin/smax and umin/umax bounds. It's now redundant as reg_bounds_sync()
performs all the same logic more generically (e.g., without unnecessary
assumption that upper 32 bits of full register should be zero).

Long story short, we remove __reg_combine_64_into_32() completely, and
coerce_reg_to_size() now only does resetting subreg to unbounded and then
performing reg_bounds_sync() to recover as much information as possible
from 64-bit umin/umax and smin/smax bounds, set explicitly in
coerce_reg_to_size() earlier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 60 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf5cd6bf8652..a603ac82d50c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2348,51 +2348,6 @@ static void __reg_assign_32_into_64(struct bpf_reg=
_state *reg)
 	}
 }
=20
-static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
-{
-	/* special case when 64-bit register has upper 32-bit register
-	 * zeroed. Typically happens after zext or <<32, >>32 sequence
-	 * allowing us to use 32-bit bounds directly,
-	 */
-	if (tnum_equals_const(tnum_clear_subreg(reg->var_off), 0)) {
-		__reg_assign_32_into_64(reg);
-	} else {
-		/* Otherwise the best we can do is push lower 32bit known and
-		 * unknown bits into register (var_off set from jmp logic)
-		 * then learn as much as possible from the 64-bit tnum
-		 * known and unknown bits. The previous smin/smax bounds are
-		 * invalid here because of jmp32 compare so mark them unknown
-		 * so they do not impact tnum bounds calculation.
-		 */
-		__mark_reg64_unbounded(reg);
-	}
-	reg_bounds_sync(reg);
-}
-
-static bool __reg64_bound_s32(s64 a)
-{
-	return a >=3D S32_MIN && a <=3D S32_MAX;
-}
-
-static bool __reg64_bound_u32(u64 a)
-{
-	return a >=3D U32_MIN && a <=3D U32_MAX;
-}
-
-static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
-{
-	__mark_reg32_unbounded(reg);
-	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_v=
alue)) {
-		reg->s32_min_value =3D (s32)reg->smin_value;
-		reg->s32_max_value =3D (s32)reg->smax_value;
-	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_v=
alue)) {
-		reg->u32_min_value =3D (u32)reg->umin_value;
-		reg->u32_max_value =3D (u32)reg->umax_value;
-	}
-	reg_bounds_sync(reg);
-}
-
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
@@ -6089,9 +6044,10 @@ static void coerce_reg_to_size(struct bpf_reg_stat=
e *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size >=3D 4)
-		return;
-	__reg_combine_64_into_32(reg);
+	if (size < 4) {
+		__mark_reg32_unbounded(reg);
+		reg_bounds_sync(reg);
+	}
 }
=20
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
@@ -14169,13 +14125,13 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
 					     tnum_subreg(false_32off));
 		true_reg->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
 					    tnum_subreg(true_32off));
-		__reg_combine_32_into_64(false_reg);
-		__reg_combine_32_into_64(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	} else {
 		false_reg->var_off =3D false_64off;
 		true_reg->var_off =3D true_64off;
-		__reg_combine_64_into_32(false_reg);
-		__reg_combine_64_into_32(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	}
 }
=20
--=20
2.34.1


