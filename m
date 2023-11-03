Return-Path: <bpf+bounces-14047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB467DFD71
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C71281D24
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7251386;
	Fri,  3 Nov 2023 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB17E2
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:08:45 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BB192
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:08:42 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MZbQP016103
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:08:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4mprrc0e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:08:41 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:08:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A192D3AD8A70D; Thu,  2 Nov 2023 17:08:33 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 05/13] bpf: remove redundant s{32,64} -> u{32,64} deduction logic
Date: Thu, 2 Nov 2023 17:08:14 -0700
Message-ID: <20231103000822.2509815-6-andrii@kernel.org>
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
X-Proofpoint-GUID: SfY9dfrdYfGfvdnUBRL23cVUkzZiyPUZ
X-Proofpoint-ORIG-GUID: SfY9dfrdYfGfvdnUBRL23cVUkzZiyPUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

Equivalent checks were recently added in more succinct and, arguably,
safer form in:
  - f188765f23a5 ("bpf: derive smin32/smax32 from umin32/umax32 bounds");
  - 2e74aef782d3 ("bpf: derive smin/smax from umin/max bounds").

The checks we are removing in this patch set do similar checks to detect
if entire u32/u64 range has signed bit set or not set, but does it with
two separate checks.

Further, we forcefully overwrite either smin or smax (and 32-bit equvalen=
ts)
without applying normal min/max intersection logic. It's not clear why
that would be correct in all cases and seems to work by accident. This
logic is also "gated" by previous signed -> unsigned derivation, which
returns early.

All this is quite confusing and seems error-prone, while we already have
at least equivalent checks happening earlier. So remove this duplicate
and error-prone logic to simplify things a bit.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af4e2fecbef2..e7b2fe78a07f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2411,24 +2411,6 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
 			min_t(u32, reg->s32_max_value, reg->u32_max_value);
 		return;
 	}
-	/* Learn sign from unsigned bounds.  Signed bounds cross the sign
-	 * boundary, so we must be careful.
-	 */
-	if ((s32)reg->u32_max_value >=3D 0) {
-		/* Positive.  We can't learn anything from the smin, but smax
-		 * is positive, hence safe.
-		 */
-		reg->s32_min_value =3D reg->u32_min_value;
-		reg->s32_max_value =3D reg->u32_max_value =3D
-			min_t(u32, reg->s32_max_value, reg->u32_max_value);
-	} else if ((s32)reg->u32_min_value < 0) {
-		/* Negative.  We can't learn anything from the smax, but smin
-		 * is negative, hence safe.
-		 */
-		reg->s32_min_value =3D reg->u32_min_value =3D
-			max_t(u32, reg->s32_min_value, reg->u32_min_value);
-		reg->s32_max_value =3D reg->u32_max_value;
-	}
 }
=20
 static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
@@ -2516,24 +2498,6 @@ static void __reg64_deduce_bounds(struct bpf_reg_s=
tate *reg)
 							  reg->umax_value);
 		return;
 	}
-	/* Learn sign from unsigned bounds.  Signed bounds cross the sign
-	 * boundary, so we must be careful.
-	 */
-	if ((s64)reg->umax_value >=3D 0) {
-		/* Positive.  We can't learn anything from the smin, but smax
-		 * is positive, hence safe.
-		 */
-		reg->smin_value =3D reg->umin_value;
-		reg->smax_value =3D reg->umax_value =3D min_t(u64, reg->smax_value,
-							  reg->umax_value);
-	} else if ((s64)reg->umin_value < 0) {
-		/* Negative.  We can't learn anything from the smax, but smin
-		 * is negative, hence safe.
-		 */
-		reg->smin_value =3D reg->umin_value =3D max_t(u64, reg->smin_value,
-							  reg->umin_value);
-		reg->smax_value =3D reg->umax_value;
-	}
 }
=20
 static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
--=20
2.34.1


