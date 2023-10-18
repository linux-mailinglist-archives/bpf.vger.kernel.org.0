Return-Path: <bpf+bounces-12601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707237CE6C8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A5E1C20AA8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C341E3B;
	Wed, 18 Oct 2023 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B614448B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:36:52 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985CF7
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:50 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39IIN4Nd001525
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:49 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tsep2wtn8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:49 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 11:36:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C1F5439F88B8E; Wed, 18 Oct 2023 11:36:35 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/7] bpf: improve deduction of 64-bit bounds from 32-bit bounds
Date: Wed, 18 Oct 2023 11:36:22 -0700
Message-ID: <20231018183625.3952512-5-andrii@kernel.org>
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
X-Proofpoint-GUID: KqKAMr6xRLFZyZP9N1Kmvo_AJxsxbAxq
X-Proofpoint-ORIG-GUID: KqKAMr6xRLFZyZP9N1Kmvo_AJxsxbAxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_16,2023-10-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index d5fd41fb3031..0a968dac3294 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2242,10 +2242,57 @@ static void __reg64_deduce_bounds(struct bpf_reg_=
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


