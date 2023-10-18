Return-Path: <bpf+bounces-12599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C67CE6C3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4621C20D75
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81741E3D;
	Wed, 18 Oct 2023 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68E42BF4
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:36:42 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48257118
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39IIN5j9001590
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tsep2wtm1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:36:37 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 11:36:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DDDDD39F88B54; Wed, 18 Oct 2023 11:36:28 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/7] bpf: improve JEQ/JNE branch taken logic
Date: Wed, 18 Oct 2023 11:36:19 -0700
Message-ID: <20231018183625.3952512-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018183625.3952512-1-andrii@kernel.org>
References: <20231018183625.3952512-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z2oYmL65zG3snEJp6lZQa6t0IJKd5EyU
X-Proofpoint-ORIG-GUID: Z2oYmL65zG3snEJp6lZQa6t0IJKd5EyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_16,2023-10-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


