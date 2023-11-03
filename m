Return-Path: <bpf+bounces-14045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A37DFD6F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EC281D9B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7751119;
	Fri,  3 Nov 2023 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA257FF
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:08:46 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9A195
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:08:44 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MZbQT016103
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:08:43 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4mprrc0e-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:08:43 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:08:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 84CAD3AD8A6EC; Thu,  2 Nov 2023 17:08:29 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 03/13] bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
Date: Thu, 2 Nov 2023 17:08:12 -0700
Message-ID: <20231103000822.2509815-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103000822.2509815-1-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RQIHVSEDII5Ci544BvlSXxWHS05LMBRx
X-Proofpoint-ORIG-GUID: RQIHVSEDII5Ci544BvlSXxWHS05LMBRx
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
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

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

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2627461164ed..8691cacd3ad3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14214,6 +14214,18 @@ static int is_scalar_branch_taken(struct bpf_reg_s=
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
@@ -14226,6 +14238,18 @@ static int is_scalar_branch_taken(struct bpf_reg_s=
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


