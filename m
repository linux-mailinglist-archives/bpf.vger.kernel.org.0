Return-Path: <bpf+bounces-13888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2967DEB74
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DEC1C20E07
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414151861;
	Thu,  2 Nov 2023 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F5185B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC939F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:15 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21VKkO018810
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3sftwepv-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:15 -0700
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 370703AC97EE4; Wed,  1 Nov 2023 20:38:09 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v6 bpf-next 04/17] bpf: derive smin32/smax32 from umin32/umax32 bounds
Date: Wed, 1 Nov 2023 20:37:46 -0700
Message-ID: <20231102033759.2541186-5-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: WisWatG_HGOx9uijUj6LJ3vkShcQZXVz
X-Proofpoint-GUID: WisWatG_HGOx9uijUj6LJ3vkShcQZXVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

All the logic that applies to u64 vs s64, equally applies for u32 vs s32
relationships (just taken in a smaller 32-bit numeric space). So do the
same deduction of smin32/smax32 from umin32/umax32, if we can.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8a4cdd2787ec..b93818abe7fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2324,6 +2324,13 @@ static void __update_reg_bounds(struct bpf_reg_sta=
te *reg)
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 {
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


