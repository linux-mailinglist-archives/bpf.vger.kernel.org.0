Return-Path: <bpf+bounces-13891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068587DEB76
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4712281AEE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E36185E;
	Thu,  2 Nov 2023 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB281C20
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:23 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299EE8
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:19 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A22remK010175
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u3e3tsae2-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:18 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4FC843AC97EF2; Wed,  1 Nov 2023 20:38:13 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v6 bpf-next 06/17] bpf: add special smin32/smax32 derivation from 64-bit bounds
Date: Wed, 1 Nov 2023 20:37:48 -0700
Message-ID: <20231102033759.2541186-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102033759.2541186-1-andrii@kernel.org>
References: <20231102033759.2541186-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: du_I_Ywz9k6kuzuBIxB7jCzNe29clk65
X-Proofpoint-ORIG-GUID: du_I_Ywz9k6kuzuBIxB7jCzNe29clk65
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Add a special case where we can derive valid s32 bounds from umin/umax
or smin/smax by stitching together negative s32 subrange and
non-negative s32 subrange. That requires upper 32 bits to form a [N, N+1]
range in u32 domain (taking into account wrap around, so 0xffffffff
to 0x00000000 is a valid [N, N+1] range in this sense). See code comment
for concrete examples.

Eduard Zingerman also provided an alternative explanation ([0]) for more
mathematically inclined readers:

Suppose:
. there are numbers a, b, c
. 2**31 <=3D b < 2**32
. 0 <=3D c < 2**31
. umin =3D 2**32 * a + b
. umax =3D 2**32 * (a + 1) + c

The number of values in the range represented by [umin; umax] is:
. N =3D umax - umin + 1 =3D 2**32 + c - b + 1
. min(N) =3D 2**32 + 0 - (2**32-1) + 1 =3D 2, with b =3D 2**32-1, c =3D 0
. max(N) =3D 2**32 + (2**31 - 1) - 2**31 + 1 =3D 2**32, with b =3D 2**31, c=
 =3D 2**31-1

Hence [(s32)b; (s32)c] forms a valid range.

  [0] https://lore.kernel.org/bpf/d7af631802f0cfae20df77fe70068702d24bbd31.=
camel@gmail.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e48a6180627b..08888784cbc8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2369,6 +2369,29 @@ static void __reg32_deduce_bounds(struct bpf_reg_sta=
te *reg)
 			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_va=
lue);
 		}
 	}
+	/* Special case where upper bits form a small sequence of two
+	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
+	 * 0x00000000 is also valid), while lower bits form a proper s32 range
+	 * going from negative numbers to positive numbers. E.g., let's say we
+	 * have s64 range [-1, 1] ([0xffffffffffffffff, 0x0000000000000001]).
+	 * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
+	 * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits,
+	 * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x00000001]).
+	 * Note that it doesn't have to be 0xffffffff going to 0x00000000 in
+	 * upper 32 bits. As a random example, s64 range
+	 * [0xfffffff0fffffff0; 0xfffffff100000010], forms a valid s32 range
+	 * [-16, 16] ([0xfffffff0; 0x00000010]) in its 32 bit subregister.
+	 */
+	if ((u32)(reg->umin_value >> 32) + 1 =3D=3D (u32)(reg->umax_value >> 32) =
&&
+	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >=3D 0) {
+		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->umin_val=
ue);
+		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->umax_val=
ue);
+	}
+	if ((u32)(reg->smin_value >> 32) + 1 =3D=3D (u32)(reg->smax_value >> 32) =
&&
+	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >=3D 0) {
+		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->smin_val=
ue);
+		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_val=
ue);
+	}
 	/* if u32 range forms a valid s32 range (due to matching sign bit),
 	 * try to learn from that
 	 */
--=20
2.34.1


