Return-Path: <bpf+bounces-12951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2197D25F4
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B11C20868
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB9134CB;
	Sun, 22 Oct 2023 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6414111BA
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:58:08 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E3EB
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:05 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MHGEJa022358
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tvcfyw2gx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:04 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 22 Oct 2023 13:58:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9D4303A33D2BE; Sun, 22 Oct 2023 13:57:53 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds deduction logic
Date: Sun, 22 Oct 2023 13:57:39 -0700
Message-ID: <20231022205743.72352-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022205743.72352-1-andrii@kernel.org>
References: <20231022205743.72352-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: F0x-w4QLhcX1HOwdp74-UEkjoyrKR_Tg
X-Proofpoint-ORIG-GUID: F0x-w4QLhcX1HOwdp74-UEkjoyrKR_Tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_19,2023-10-19_01,2023-05-22_02

Add handling of a bunch of possible cases which allows deducing extra
information about subregister bounds, both u32 and s32, from full registe=
r
u64/s64 bounds.

Also add smin32/smax32 bounds derivation from corresponding umin32/umax32
bounds, similar to what we did with smin/smax from umin/umax derivation i=
n
previous patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 885dd4a2ff3a..3fc9bd5e72b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2130,6 +2130,58 @@ static void __update_reg_bounds(struct bpf_reg_sta=
te *reg)
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 {
+	/* if upper 32 bits of u64/s64 range don't change,
+	 * we can use lower 32 bits to improve our u32/s32 boundaries
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
+	/* Special case where upper bits form a small sequence of two
+	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
+	 * 0x00000000 is also valid), while lower bits form a proper s32 range
+	 * going from negative numbers to positive numbers.
+	 * E.g.: [0xfffffff0ffffff00; 0xfffffff100000010]. Iterating
+	 * over full 64-bit numbers range will form a proper [-16, 16]
+	 * ([0xffffff00; 0x00000010]) range in its lower 32 bits.
+	 */
+	if ((u32)(reg->umin_value >> 32) + 1 =3D=3D (u32)(reg->umax_value >> 32=
) &&
+	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >=3D 0) {
+		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->umin_v=
alue);
+		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->umax_v=
alue);
+	}
+	if ((u32)(reg->smin_value >> 32) + 1 =3D=3D (u32)(reg->smax_value >> 32=
) &&
+	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >=3D 0) {
+		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->smin_v=
alue);
+		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_v=
alue);
+	}
+	/* if u32 range forms a valid s32 range (due to matching sign bit),
+	 * try to learn from that
+	 */
+	if ((s32)reg->u32_min_value <=3D (s32)reg->u32_max_value) {
+		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, reg->u32_min_val=
ue);
+		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, reg->u32_max_val=
ue);
+	}
 	/* Learn sign from signed bounds.
 	 * If we cannot cross the sign boundary, then signed and unsigned bound=
s
 	 * are the same, so combine.  This works even in the negative case, e.g=
.
--=20
2.34.1


