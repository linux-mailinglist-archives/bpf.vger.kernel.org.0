Return-Path: <bpf+bounces-13444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE67D9FA1
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E8E1C2100E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98053C082;
	Fri, 27 Oct 2023 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EE3C067
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1993F3
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5prN006204
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tywry0f4u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:46 -0700
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D91303A7965AC; Fri, 27 Oct 2023 11:14:01 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Shung-Hsi Yu
	<shung-hsi.yu@suse.com>
Subject: [PATCH v5 bpf-next 06/23] bpf: add special smin32/smax32 derivation from 64-bit bounds
Date: Fri, 27 Oct 2023 11:13:29 -0700
Message-ID: <20231027181346.4019398-7-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: NJYKUifIF1TNVEbvPS1nFic771IpsWhn
X-Proofpoint-GUID: NJYKUifIF1TNVEbvPS1nFic771IpsWhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Add a special case where we can derive valid s32 bounds from umin/umax
or smin/smax by stitching together negative s32 subrange and
non-negative s32 subrange. That requires upper 32 bits to form a [N, N+1]
range in u32 domain (taking into account wrap around, so 0xffffffff
to 0x00000000 is a valid [N, N+1] range in this sense). See code comment
for concrete examples.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5082ca1ea5dc..38d21d0e46bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2369,6 +2369,29 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
 			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_=
value);
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
+	 * [0xfffffff0ffffff00; 0xfffffff100000010], forms a valid s32 range
+	 * [-16, 16] ([0xffffff00; 0x00000010]) in its 32 bit subregister.
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
 	/* if u32 range forms a valid s32 range (due to matching sign bit),
 	 * try to learn from that
 	 */
--=20
2.34.1


