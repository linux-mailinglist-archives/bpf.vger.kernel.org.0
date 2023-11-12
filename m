Return-Path: <bpf+bounces-14896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C57E8DCF
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8779D280D93
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2015C1;
	Sun, 12 Nov 2023 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695317C5
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD68F30FA
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABNdSVZ019849
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua7m3jq1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:29 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DAFF53B5D519F; Sat, 11 Nov 2023 17:06:16 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Shung-Hsi Yu
	<shung-hsi.yu@suse.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 03/13] bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
Date: Sat, 11 Nov 2023 17:05:59 -0800
Message-ID: <20231112010609.848406-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UrsYqnBRUGs2LL5ki4Kw_dZTKrWjPFx-
X-Proofpoint-ORIG-GUID: UrsYqnBRUGs2LL5ki4Kw_dZTKrWjPFx-
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
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
that otherwise would be "inconclusive" (i.e., is_branch_taken() would
return -1). This can happen, for example, when registers are initialized
as 64-bit u64/s64, then compared for inequality as 32-bit subregisters,
and then followed by 64-bit equality/inequality check. That 32-bit
inequality can establish some pattern for lower 32 bits of a register
(e.g., s< 0 condition determines whether the bit #31 is zero or not),
while overall 64-bit value could be anything (according to a value range
representation).

This is not a fancy quirky special case, but actually a handling that's
necessary to prevent correctness issue with BPF verifier's range
tracking: set_range_min_max() assumes that register ranges are
non-overlapping, and if that condition is not guaranteed by
is_branch_taken() we can end up with invalid ranges, where min > max.

  [0] https://lore.kernel.org/bpf/CACkBjsY2q1_fUohD7hRmKGqv1MV=3DeP2f6XK8kj=
kYNw7BaiF8iQ@mail.gmail.com/

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f459ad99256e..65570eedfe88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14283,6 +14283,18 @@ static int is_scalar_branch_taken(struct bpf_reg_s=
tate *reg1, struct bpf_reg_sta
 			return 0;
 		if (smin1 > smax2 || smax1 < smin2)
 			return 0;
+		if (!is_jmp32) {
+			/* if 64-bit ranges are inconclusive, see if we can
+			 * utilize 32-bit subrange knowledge to eliminate
+			 * branches that can't be taken a priori
+			 */
+			if (reg1->u32_min_value > reg2->u32_max_value ||
+			    reg1->u32_max_value < reg2->u32_min_value)
+				return 0;
+			if (reg1->s32_min_value > reg2->s32_max_value ||
+			    reg1->s32_max_value < reg2->s32_min_value)
+				return 0;
+		}
 		break;
 	case BPF_JNE:
 		/* constants, umin/umax and smin/smax checks would be
@@ -14295,6 +14307,18 @@ static int is_scalar_branch_taken(struct bpf_reg_s=
tate *reg1, struct bpf_reg_sta
 			return 1;
 		if (smin1 > smax2 || smax1 < smin2)
 			return 1;
+		if (!is_jmp32) {
+			/* if 64-bit ranges are inconclusive, see if we can
+			 * utilize 32-bit subrange knowledge to eliminate
+			 * branches that can't be taken a priori
+			 */
+			if (reg1->u32_min_value > reg2->u32_max_value ||
+			    reg1->u32_max_value < reg2->u32_min_value)
+				return 1;
+			if (reg1->s32_min_value > reg2->s32_max_value ||
+			    reg1->s32_max_value < reg2->s32_min_value)
+				return 1;
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32)) {
--=20
2.34.1


