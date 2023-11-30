Return-Path: <bpf+bounces-16208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003557FE47A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB44281F73
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254D385;
	Thu, 30 Nov 2023 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08967D7D
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:13 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATKOGMm020440
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:12 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upa3djkck-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:12 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 16:04:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4E59E3C556631; Wed, 29 Nov 2023 16:04:26 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 04/10] selftests/bpf: add selftest validating callback result is enforced
Date: Wed, 29 Nov 2023 16:04:00 -0800
Message-ID: <20231130000406.480870-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130000406.480870-1-andrii@kernel.org>
References: <20231130000406.480870-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PMHPrQaHvL6cBmF89EHOlwBsv65XmBxh
X-Proofpoint-ORIG-GUID: PMHPrQaHvL6cBmF89EHOlwBsv65XmBxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

BPF verifier expects callback subprogs to return values from specified
range (typically [0, 1]). This requires that r0 at exit is both precise
(because we rely on specific value range) and is marked as read
(otherwise state comparison will ignore such register as unimportant).

Add a simple test that validates that all these conditions are enforced.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_subprog_precision.c    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index b5efcaeaa1ae..d41d2a8bb97e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -117,6 +117,56 @@ __naked int global_subprog_result_precise(void)
 	);
 }
=20
+__naked __noinline __used
+static unsigned long loop_callback_bad()
+{
+	/* bpf_loop() callback that can return values outside of [0, 1] range *=
/
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 s> 1000 goto 1f;"
+		"r0 =3D 0;"
+	"1:"
+		"goto +0;" /* checkpoint */
+		/* bpf_loop() expects [0, 1] values, so branch above skipping
+		 * r0 =3D 0; should lead to a failure, but if exit instruction
+		 * doesn't enforce r0's precision, this callback will be
+		 * successfully verified
+		 */
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_common
+	);
+}
+
+SEC("?raw_tp")
+__failure __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check that fallthrough code path marks r0 as precise */
+__msg("mark_precise: frame1: regs=3Dr0 stack=3D before 11: (b7) r0 =3D 0=
")
+/* check that we have branch code path doing its own validation */
+__msg("from 10 to 12: frame1: R0=3Dscalar(smin=3Dumin=3D1001")
+/* check that branch code path marks r0 as precise, before failing */
+__msg("mark_precise: frame1: regs=3Dr0 stack=3D before 9: (85) call bpf_=
get_prandom_u32#7")
+__msg("At callback return the register R0 has value (0x0; 0x7fffffffffff=
ffff) should have been in (0x0; 0x1)")
+__naked int callback_precise_return_fail(void)
+{
+	asm volatile (
+		"r1 =3D 1;"			/* nr_loops */
+		"r2 =3D %[loop_callback_bad];"	/* callback_fn */
+		"r3 =3D 0;"			/* callback_ctx */
+		"r4 =3D 0;"			/* flags */
+		"call %[bpf_loop];"
+
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm_ptr(loop_callback_bad),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
 SEC("?raw_tp")
 __success __log_level(2)
 /* First simulated path does not include callback body,
--=20
2.34.1


