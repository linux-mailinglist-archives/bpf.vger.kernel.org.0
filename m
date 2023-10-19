Return-Path: <bpf+bounces-12649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3C7CEE9E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0E281F12
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE617FD;
	Thu, 19 Oct 2023 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA8441C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:24:20 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E900123
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:20 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39INkcMX004746
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ttbw6xvkf-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:19 -0700
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 21:24:15 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2BC3939FE742F; Wed, 18 Oct 2023 21:24:10 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 2/7] bpf: derive smin/smax from umin/max bounds
Date: Wed, 18 Oct 2023 21:24:00 -0700
Message-ID: <20231019042405.2971130-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019042405.2971130-1-andrii@kernel.org>
References: <20231019042405.2971130-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tgw_HUXLYn95gcH09fBZJPrNc3Wtj76G
X-Proofpoint-GUID: tgw_HUXLYn95gcH09fBZJPrNc3Wtj76G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02

Add smin/smax derivation from appropriate umin/umax values. Previously th=
e
logic was surprisingly asymmetric, trying to derive umin/umax from smin/s=
max
(if possible), but not trying to do the same in the other direction. A si=
mple
addition to __reg64_deduce_bounds() fixes this.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c87144e3c5e8..ee9837463092 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2151,6 +2151,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
=20
 static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 {
+	/* u64 range forms a valid s64 range (due to matching sign bit),
+	 * so try to learn from that
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


