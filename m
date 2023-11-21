Return-Path: <bpf+bounces-15465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1984E7F2212
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90BD282692
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFCC10EF;
	Tue, 21 Nov 2023 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B39B4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:21 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKN8H70018312
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:21 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uggutgdcu-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:21 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 16:22:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 96DF43BD94296; Mon, 20 Nov 2023 16:22:33 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 05/10] selftests/bpf: validate STACK_ZERO is preserved on subreg spill
Date: Mon, 20 Nov 2023 16:22:16 -0800
Message-ID: <20231121002221.3687787-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121002221.3687787-1-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8JqrgTHoUx42vLohiAFLJuHE5wL-lT-0
X-Proofpoint-GUID: 8JqrgTHoUx42vLohiAFLJuHE5wL-lT-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

Add tests validating that STACK_ZERO slots are preserved when slot is
partially overwritten with subregister spill.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 6115520154e3..899a74ac9093 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -450,4 +450,40 @@ l0_%=3D:	r1 >>=3D 16;					\
 	: __clobber_all);
 }
=20
+SEC("raw_tp")
+__log_level(2)
+__success
+__msg("fp-8=3D0m??mmmm")
+__msg("fp-16=3D00mm??mm")
+__msg("fp-24=3D00mm???m")
+__naked void spill_subregs_preserve_stack_zero(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+
+		/* 32-bit subreg spill with ZERO, MISC, and INVALID */
+		"*(u8 *)(r10 -1) =3D 0;"  /* ZERO */
+		"*(u8 *)(r10 -2) =3D r0;" /* MISC */
+		/* fp-3 and fp-4 stay INVALID */
+		"*(u32 *)(r10 -8) =3D r0;"
+
+		/* 16-bit subreg spill with ZERO, MISC, and INVALID */
+		"*(u16 *)(r10 -10) =3D 0;"  /* ZERO */
+		"*(u16 *)(r10 -12) =3D r0;" /* MISC */
+		/* fp-13 and fp-14 stay INVALID */
+		"*(u16 *)(r10 -16) =3D r0;"
+
+		/* 8-bit subreg spill with ZERO, MISC, and INVALID */
+		"*(u16 *)(r10 -18) =3D 0;"  /* ZERO */
+		"*(u16 *)(r10 -20) =3D r0;" /* MISC */
+		/* fp-21, fp-22, and fp-23 stay INVALID */
+		"*(u8 *)(r10 -24) =3D r0;"
+
+		"r0 =3D 0;"
+		"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


