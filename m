Return-Path: <bpf+bounces-13458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08F7D9FB0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFABF1C210FA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D33C084;
	Fri, 27 Oct 2023 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276923D3A1
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:17:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1DF4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5aBP006235
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:00 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu37t-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:17:00 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E36843A7965CA; Fri, 27 Oct 2023 11:14:03 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 07/23] bpf: improve deduction of 64-bit bounds from 32-bit bounds
Date: Fri, 27 Oct 2023 11:13:30 -0700
Message-ID: <20231027181346.4019398-8-andrii@kernel.org>
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
X-Proofpoint-GUID: dhB7ABts0dMGD1Bux_lCaCtobfWC8d1l
X-Proofpoint-ORIG-GUID: dhB7ABts0dMGD1Bux_lCaCtobfWC8d1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Add a few interesting cases in which we can tighten 64-bit bounds based
on newly learnt information about 32-bit bounds. E.g., when full u64/s64
registers are used in BPF program, and then eventually compared as
u32/s32. The latter comparison doesn't change the value of full
register, but it does impose new restrictions on possible lower 32 bits
of such full registers. And we can use that to derive additional full
register bounds information.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 38d21d0e46bd..768247e3d667 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2535,10 +2535,57 @@ static void __reg64_deduce_bounds(struct bpf_reg_=
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
+
+	/* s32 -> u64 tightening, s32 should be a valid u32 range (same sign) *=
/
+	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
+		new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_va=
lue;
+		new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_va=
lue;
+		reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
+		reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
+	}
+
+	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range v=
alidity */
+	new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
+	new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
+	reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
+	reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
+
+	/* s32 -> s64 tightening, check that s32 range behaves as u32 range */
+	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
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


