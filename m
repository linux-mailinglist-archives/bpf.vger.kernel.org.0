Return-Path: <bpf+bounces-13894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF107DEB7B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C96EB212FC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832651FA5;
	Thu,  2 Nov 2023 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B501FA1
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:26 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C72119
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:24 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A223qii001478
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u42n90rbc-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:23 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5E24F3AC97EF9; Wed,  1 Nov 2023 20:38:15 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v6 bpf-next 07/17] bpf: improve deduction of 64-bit bounds from 32-bit bounds
Date: Wed, 1 Nov 2023 20:37:49 -0700
Message-ID: <20231102033759.2541186-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102033759.2541186-1-andrii@kernel.org>
References: <20231102033759.2541186-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WiNxTPkjQ2ve1pB2hFfiyBjKtNE_JmxI
X-Proofpoint-GUID: WiNxTPkjQ2ve1pB2hFfiyBjKtNE_JmxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Add a few interesting cases in which we can tighten 64-bit bounds based
on newly learnt information about 32-bit bounds. E.g., when full u64/s64
registers are used in BPF program, and then eventually compared as
u32/s32. The latter comparison doesn't change the value of full
register, but it does impose new restrictions on possible lower 32 bits
of such full registers. And we can use that to derive additional full
register bounds information.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 08888784cbc8..d0d0a1a1b662 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2536,10 +2536,54 @@ static void __reg64_deduce_bounds(struct bpf_reg_=
state *reg)
 	}
 }
=20
+static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
+{
+	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
+	 * values on both sides of 64-bit range in hope to have tigher range.
+	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
+	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
+	 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
+	 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
+	 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
+	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
+	 * We just need to make sure that derived bounds we are intersecting
+	 * with are well-formed ranges in respecitve s64 or u64 domain, just
+	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
+	 */
+	__u64 new_umin, new_umax;
+	__s64 new_smin, new_smax;
+
+	/* u32 -> u64 tightening, it's always well-formed */
+	new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
+	new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
+	reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
+	reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
+	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range v=
alidity */
+	new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
+	new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
+	reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
+	reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
+
+	/* if s32 can be treated as valid u32 range, we can use it as well */
+	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
+		/* s32 -> u64 tightening */
+		new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_va=
lue;
+		new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_va=
lue;
+		reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
+		reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
+		/* s32 -> s64 tightening */
+		new_smin =3D (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_va=
lue;
+		new_smax =3D (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_va=
lue;
+		reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
+		reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
+	}
+}
+
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
 {
 	__reg32_deduce_bounds(reg);
 	__reg64_deduce_bounds(reg);
+	__reg_deduce_mixed_bounds(reg);
 }
=20
 /* Attempts to improve var_off based on unsigned min/max information */
--=20
2.34.1


