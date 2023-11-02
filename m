Return-Path: <bpf+bounces-13892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCED7DEB78
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5297A1C20E00
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6AD1865;
	Thu,  2 Nov 2023 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5F1C35
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:23 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AFA9F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:18 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21e5W4018824
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:18 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwehu-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:18 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 415CE3AC97EEB; Wed,  1 Nov 2023 20:38:11 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v6 bpf-next 05/17] bpf: derive subreg bounds from full bounds when upper 32 bits are constant
Date: Wed, 1 Nov 2023 20:37:47 -0700
Message-ID: <20231102033759.2541186-6-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: T75xltIy7pdID5lwYEdP3IDqwvMVM6sb
X-Proofpoint-GUID: T75xltIy7pdID5lwYEdP3IDqwvMVM6sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Comments in code try to explain the idea behind why this is correct.
Please check the code and comments.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b93818abe7fc..e48a6180627b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2324,6 +2324,51 @@ static void __update_reg_bounds(struct bpf_reg_sta=
te *reg)
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 {
+	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
+	 * bits to improve our u32/s32 boundaries.
+	 *
+	 * E.g., the case where we have upper 32 bits as zero ([10, 20] in
+	 * u64) is pretty trivial, it's obvious that in u32 we'll also have
+	 * [10, 20] range. But this property holds for any 64-bit range as
+	 * long as upper 32 bits in that entire range of values stay the same.
+	 *
+	 * E.g., u64 range [0x10000000A, 0x10000000F] ([4294967306, 4294967311]
+	 * in decimal) has the same upper 32 bits throughout all the values in
+	 * that range. As such, lower 32 bits form a valid [0xA, 0xF] ([10, 15]=
)
+	 * range.
+	 *
+	 * Note also, that [0xA, 0xF] is a valid range both in u32 and in s32,
+	 * following the rules outlined below about u64/s64 correspondence
+	 * (which equally applies to u32 vs s32 correspondence). In general it
+	 * depends on actual hexadecimal values of 32-bit range. They can form
+	 * only valid u32, or only valid s32 ranges in some cases.
+	 *
+	 * So we use all these insights to derive bounds for subregisters here.
+	 */
+	if ((reg->umin_value >> 32) =3D=3D (reg->umax_value >> 32)) {
+		/* u64 to u32 casting preserves validity of low 32 bits as
+		 * a range, if upper 32 bits are the same
+		 */
+		reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)reg->umin_v=
alue);
+		reg->u32_max_value =3D min_t(u32, reg->u32_max_value, (u32)reg->umax_v=
alue);
+
+		if ((s32)reg->umin_value <=3D (s32)reg->umax_value) {
+			reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->umin_=
value);
+			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->umax_=
value);
+		}
+	}
+	if ((reg->smin_value >> 32) =3D=3D (reg->smax_value >> 32)) {
+		/* low 32 bits should form a proper u32 range */
+		if ((u32)reg->smin_value <=3D (u32)reg->smax_value) {
+			reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)reg->smin_=
value);
+			reg->u32_max_value =3D min_t(u32, reg->u32_max_value, (u32)reg->smax_=
value);
+		}
+		/* low 32 bits should form a proper s32 range */
+		if ((s32)reg->smin_value <=3D (s32)reg->smax_value) {
+			reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->smin_=
value);
+			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_=
value);
+		}
+	}
 	/* if u32 range forms a valid s32 range (due to matching sign bit),
 	 * try to learn from that
 	 */
--=20
2.34.1


