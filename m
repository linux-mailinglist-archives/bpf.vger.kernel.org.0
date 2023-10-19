Return-Path: <bpf+bounces-12647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABA7CEE9D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8E281F33
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FF17FD;
	Thu, 19 Oct 2023 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC8566D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:24:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC790121
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:15 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39INkcMR004746
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ttbw6xvkf-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:24:15 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 21:24:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D175C39FE741D; Wed, 18 Oct 2023 21:24:08 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 1/7] bpf: improve JEQ/JNE branch taken logic
Date: Wed, 18 Oct 2023 21:23:59 -0700
Message-ID: <20231019042405.2971130-2-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: j5uFI_vBwR8Q4XbEVnAnElNt7yNqpY2G
X-Proofpoint-GUID: j5uFI_vBwR8Q4XbEVnAnElNt7yNqpY2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02

When determining if if/else branch will always or never be taken, use
signed range knowledge in addition to currently used unsigned range knowl=
edge.
If either signed or unsigned range suggests that condition is
always/never taken, return corresponding branch_taken verdict.

Current use of unsigned range for this seems arbitrary and unnecessarily
incomplete. It is possible for *signed* operations to be performed on
register, which could "invalidate" unsigned range for that register. In
such case branch_taken will be artificially useless, even if we can
still tell that some constant is outside of register value range based
on its signed bounds.

veristat-based validation shows zero differences across selftests,
Cilium, and Meta-internal BPF object files.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb58987e4844..c87144e3c5e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13663,12 +13663,16 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
 			return !!tnum_equals_const(subreg, val);
 		else if (val < reg->u32_min_value || val > reg->u32_max_value)
 			return 0;
+		else if (sval < reg->s32_min_value || sval > reg->s32_max_value)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(subreg))
 			return !tnum_equals_const(subreg, val);
 		else if (val < reg->u32_min_value || val > reg->u32_max_value)
 			return 1;
+		else if (sval < reg->s32_min_value || sval > reg->s32_max_value)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~subreg.mask & subreg.value) & val)
@@ -13740,12 +13744,16 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg, u64 val, u8 opcode)
 			return !!tnum_equals_const(reg->var_off, val);
 		else if (val < reg->umin_value || val > reg->umax_value)
 			return 0;
+		else if (sval < reg->smin_value || sval > reg->smax_value)
+			return 0;
 		break;
 	case BPF_JNE:
 		if (tnum_is_const(reg->var_off))
 			return !tnum_equals_const(reg->var_off, val);
 		else if (val < reg->umin_value || val > reg->umax_value)
 			return 1;
+		else if (sval < reg->smin_value || sval > reg->smax_value)
+			return 1;
 		break;
 	case BPF_JSET:
 		if ((~reg->var_off.mask & reg->var_off.value) & val)
--=20
2.34.1


