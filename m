Return-Path: <bpf+bounces-13889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B27DEB75
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EFB281AB3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAC186A;
	Thu,  2 Nov 2023 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B271851
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773EAE8
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21VKkJ018810
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwepv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:12 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 228C93AC97EC6; Wed,  1 Nov 2023 20:38:07 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v6 bpf-next 03/17] bpf: derive smin/smax from umin/max bounds
Date: Wed, 1 Nov 2023 20:37:45 -0700
Message-ID: <20231102033759.2541186-4-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: O1aLCRnXvjfqO5yYylikBD-9Y7x0AzaL
X-Proofpoint-GUID: O1aLCRnXvjfqO5yYylikBD-9Y7x0AzaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Add smin/smax derivation from appropriate umin/umax values. Previously th=
e
logic was surprisingly asymmetric, trying to derive umin/umax from smin/s=
max
(if possible), but not trying to do the same in the other direction. A si=
mple
addition to __reg64_deduce_bounds() fixes this.

Added also generic comment about u64/s64 ranges and their relationship.
Hopefully that helps readers to understand all the bounds deductions
a bit better.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..8a4cdd2787ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2358,6 +2358,77 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
=20
 static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 {
+	/* If u64 range forms a valid s64 range (due to matching sign bit),
+	 * try to learn from that. Let's do a bit of ASCII art to see when
+	 * this is happening. Let's take u64 range first:
+	 *
+	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
+	 * |-------------------------------|--------------------------------|
+	 *
+	 * Valid u64 range is formed when umin and umax are anywhere in the
+	 * range [0, U64_MAX], and umin <=3D umax. u64 case is simple and
+	 * straightforward. Let's see how s64 range maps onto the same range
+	 * of values, annotated below the line for comparison:
+	 *
+	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
+	 * |-------------------------------|--------------------------------|
+	 * 0                        S64_MAX S64_MIN                        -1
+	 *
+	 * So s64 values basically start in the middle and they are logically
+	 * contiguous to the right of it, wrapping around from -1 to 0, and
+	 * then finishing as S64_MAX (0x7fffffffffffffff) right before
+	 * S64_MIN. We can try drawing the continuity of u64 vs s64 values
+	 * more visually as mapped to sign-agnostic range of hex values.
+	 *
+	 *  u64 start                                               u64 end
+	 *  _______________________________________________________________
+	 * /                                                               \
+	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
+	 * |-------------------------------|--------------------------------|
+	 * 0                        S64_MAX S64_MIN                        -1
+	 *                                / \
+	 * >------------------------------   ------------------------------->
+	 * s64 continues...        s64 end   s64 start          s64 "midpoint"
+	 *
+	 * What this means is that, in general, we can't always derive
+	 * something new about u64 from any random s64 range, and vice versa.
+	 *
+	 * But we can do that in two particular cases. One is when entire
+	 * u64/s64 range is *entirely* contained within left half of the above
+	 * diagram or when it is *entirely* contained in the right half. I.e.:
+	 *
+	 * |-------------------------------|--------------------------------|
+	 *     ^                   ^            ^                 ^
+	 *     A                   B            C                 D
+	 *
+	 * [A, B] and [C, D] are contained entirely in their respective halves
+	 * and form valid contiguous ranges as both u64 and s64 values. [A, B]
+	 * will be non-negative both as u64 and s64 (and in fact it will be
+	 * identical ranges no matter the signedness). [C, D] treated as s64
+	 * will be a range of negative values, while in u64 it will be
+	 * non-negative range of values larger than 0x8000000000000000.
+	 *
+	 * Now, any other range here can't be represented in both u64 and s64
+	 * simultaneously. E.g., [A, C], [A, D], [B, C], [B, D] are valid
+	 * contiguous u64 ranges, but they are discontinuous in s64. [B, C]
+	 * in s64 would be properly presented as [S64_MIN, C] and [B, S64_MAX],
+	 * for example. Similarly, valid s64 range [D, A] (going from negative
+	 * to positive values), would be two separate [D, U64_MAX] and [0, A]
+	 * ranges as u64. Currently reg_state can't represent two segments per
+	 * numeric domain, so in such situations we can only derive maximal
+	 * possible range ([0, U64_MAX] for u64, and [S64_MIN, S64_MAX] for s64=
).
+	 *
+	 * So we use these facts to derive umin/umax from smin/smax and vice
+	 * versa only if they stay within the same "half". This is equivalent
+	 * to checking sign bit: lower half will have sign bit as zero, upper
+	 * half have sign bit 1. Below in code we simplify this by just
+	 * casting umin/umax as smin/smax and checking if they form valid
+	 * range, and vice versa. Those are equivalent checks.
+	 */
+	if ((s64)reg->umin_value <=3D (s64)reg->umax_value) {
+		reg->smin_value =3D max_t(s64, reg->smin_value, reg->umin_value);
+		reg->smax_value =3D min_t(s64, reg->smax_value, reg->umax_value);
+	}
 	/* Learn sign from signed bounds.
 	 * If we cannot cross the sign boundary, then signed and unsigned bound=
s
 	 * are the same, so combine.  This works even in the negative case, e.g=
.
--=20
2.34.1


