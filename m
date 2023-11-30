Return-Path: <bpf+bounces-16212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935C7FE47E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D06281957
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F310F6;
	Thu, 30 Nov 2023 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B383
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:14 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATNIYZm017208
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:14 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upeus07va-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:14 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 16:04:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E9E843C55669B; Wed, 29 Nov 2023 16:04:38 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 08/10] selftests/bpf: validate async callback return value check correctness
Date: Wed, 29 Nov 2023 16:04:04 -0800
Message-ID: <20231130000406.480870-9-andrii@kernel.org>
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
X-Proofpoint-GUID: 79_zWBSmWLITx4kFqjhv0_jUpTUrGZtE
X-Proofpoint-ORIG-GUID: 79_zWBSmWLITx4kFqjhv0_jUpTUrGZtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

Adjust timer/timer_ret_1 test to validate more carefully verifier logic
of enforcing async callback return value. This test will pass only if
return result is marked precise and read.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/timer_failure.c       | 36 ++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/te=
sting/selftests/bpf/progs/timer_failure.c
index 9000da1e2120..a9f717d4e269 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -21,17 +21,37 @@ struct {
 	__type(value, struct elem);
 } timer_map SEC(".maps");
=20
-static int timer_cb_ret1(void *map, int *key, struct bpf_timer *timer)
+__naked __noinline __used
+static unsigned long timer_cb_ret_bad()
 {
-	if (bpf_get_smp_processor_id() % 2)
-		return 1;
-	else
-		return 0;
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 s> 1000 goto 1f;"
+		"r0 =3D 0;"
+	"1:"
+		"goto +0;" /* checkpoint */
+		/* async callback is expected to return 0, so branch above
+		 * skipping r0 =3D 0; should lead to a failure, but if exit
+		 * instruction doesn't enforce r0's precision, this callback
+		 * will be successfully verified
+		 */
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_common
+	);
 }
=20
 SEC("fentry/bpf_fentry_test1")
-__failure __msg("should have been in [0, 0]")
-int BPF_PROG2(test_ret_1, int, a)
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure
+/* check that fallthrough code path marks r0 as precise */
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 22: (b4) w0 =3D 0=
")
+/* check that branch code path marks r0 as precise */
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 24: (85) call bpf=
_get_prandom_u32#7")
+__msg("should have been in [0, 0]")
+int BPF_PROG2(test_bad_ret, int, a)
 {
 	int key =3D 0;
 	struct bpf_timer *timer;
@@ -39,7 +59,7 @@ int BPF_PROG2(test_ret_1, int, a)
 	timer =3D bpf_map_lookup_elem(&timer_map, &key);
 	if (timer) {
 		bpf_timer_init(timer, &timer_map, CLOCK_BOOTTIME);
-		bpf_timer_set_callback(timer, timer_cb_ret1);
+		bpf_timer_set_callback(timer, timer_cb_ret_bad);
 		bpf_timer_start(timer, 1000, 0);
 	}
=20
--=20
2.34.1


