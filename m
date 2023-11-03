Return-Path: <bpf+bounces-14056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119167DFD7D
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F431C21023
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AF7E1;
	Fri,  3 Nov 2023 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868B620
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:11:52 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF77136
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:11:51 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MZh1d016167
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:11:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4mprrcfb-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:11:50 -0700
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:11:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B20143AD8A779; Thu,  2 Nov 2023 17:08:35 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 06/13] bpf: make __reg{32,64}_deduce_bounds logic more robust
Date: Thu, 2 Nov 2023 17:08:15 -0700
Message-ID: <20231103000822.2509815-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103000822.2509815-1-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gkd_9zOOTj8_hpqQfsjHCJe-q5HuJ0Xs
X-Proofpoint-ORIG-GUID: gkd_9zOOTj8_hpqQfsjHCJe-q5HuJ0Xs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

This change doesn't seem to have any effect on selftests and production
BPF object files, but we preemptively try to make it more robust.

First, "learn sign from signed bounds" comment is misleading, as we are
learning not just sign, but also values.

Second, we simplify the check for determining whether entire range is
positive or negative similarly to other checks added earlier, using
appropriate u32/u64 cast and single comparisons. As explain in comments
in __reg64_deduce_bounds(), the checks are equivalent.

Last but not least, smin/smax and s32_min/s32_max reassignment based on
min/max of both umin/umax and smin/smax (and 32-bit equivalents) is hard
to explain and justify. We are updating unsigned bounds from signed
bounds, why would we update signed bounds at the same time? This might
be correct, but it's far from obvious why and the code or comments don't
try to justify this. Given we've added a separate deduction of signed
bounds from unsigned bounds earlier, this seems at least redundant, if
not just wrong.

In short, we remove doubtful pieces, and streamline the rest to follow
the logic and approach of the rest of reg_bounds_sync() checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7b2fe78a07f..91271961c9c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2399,17 +2399,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_=
state *reg)
 		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, reg->u32_min_val=
ue);
 		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, reg->u32_max_val=
ue);
 	}
-	/* Learn sign from signed bounds.
-	 * If we cannot cross the sign boundary, then signed and unsigned bound=
s
+	/* If we cannot cross the sign boundary, then signed and unsigned bound=
s
 	 * are the same, so combine.  This works even in the negative case, e.g=
.
 	 * -3 s<=3D x s<=3D -1 implies 0xf...fd u<=3D x u<=3D 0xf...ff.
 	 */
-	if (reg->s32_min_value >=3D 0 || reg->s32_max_value < 0) {
-		reg->s32_min_value =3D reg->u32_min_value =3D
-			max_t(u32, reg->s32_min_value, reg->u32_min_value);
-		reg->s32_max_value =3D reg->u32_max_value =3D
-			min_t(u32, reg->s32_max_value, reg->u32_max_value);
-		return;
+	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
+		reg->u32_min_value =3D max_t(u32, reg->s32_min_value, reg->u32_min_val=
ue);
+		reg->u32_max_value =3D min_t(u32, reg->s32_max_value, reg->u32_max_val=
ue);
 	}
 }
=20
@@ -2486,17 +2482,13 @@ static void __reg64_deduce_bounds(struct bpf_reg_=
state *reg)
 		reg->smin_value =3D max_t(s64, reg->smin_value, reg->umin_value);
 		reg->smax_value =3D min_t(s64, reg->smax_value, reg->umax_value);
 	}
-	/* Learn sign from signed bounds.
-	 * If we cannot cross the sign boundary, then signed and unsigned bound=
s
+	/* If we cannot cross the sign boundary, then signed and unsigned bound=
s
 	 * are the same, so combine.  This works even in the negative case, e.g=
.
 	 * -3 s<=3D x s<=3D -1 implies 0xf...fd u<=3D x u<=3D 0xf...ff.
 	 */
-	if (reg->smin_value >=3D 0 || reg->smax_value < 0) {
-		reg->smin_value =3D reg->umin_value =3D max_t(u64, reg->smin_value,
-							  reg->umin_value);
-		reg->smax_value =3D reg->umax_value =3D min_t(u64, reg->smax_value,
-							  reg->umax_value);
-		return;
+	if ((u64)reg->smin_value <=3D (u64)reg->smax_value) {
+		reg->umin_value =3D max_t(u64, reg->smin_value, reg->umin_value);
+		reg->umax_value =3D min_t(u64, reg->smax_value, reg->umax_value);
 	}
 }
=20
--=20
2.34.1


