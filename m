Return-Path: <bpf+bounces-15619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D027F3B2D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82ACB218D8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2717CE;
	Wed, 22 Nov 2023 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D12DD
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:21:47 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM0FFro017824
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:21:47 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh6xbrckj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:21:46 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:19:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id F06713BE88955; Tue, 21 Nov 2023 17:17:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 09/10] selftests/bpf: validate async callback return value check correctness
Date: Tue, 21 Nov 2023 17:16:55 -0800
Message-ID: <20231122011656.1105943-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122011656.1105943-1-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Oygp_bgxP85kQiaTw_Fz6U7YX4vLSK3S
X-Proofpoint-ORIG-GUID: Oygp_bgxP85kQiaTw_Fz6U7YX4vLSK3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

Adjust timer/timer_ret_1 test to validate more carefully verifier logic
of enforcing async callback return value. This test will pass only if
return result is marked precise and read.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/timer_failure.c       | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/te=
sting/selftests/bpf/progs/timer_failure.c
index 9000da1e2120..a8dab6697810 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -21,17 +21,32 @@ struct {
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
+		"if r0 > 1000 goto 1f;"
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
 __failure __msg("should have been in [0, 0]")
-int BPF_PROG2(test_ret_1, int, a)
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+int BPF_PROG2(test_bad_ret, int, a)
 {
 	int key =3D 0;
 	struct bpf_timer *timer;
@@ -39,7 +54,7 @@ int BPF_PROG2(test_ret_1, int, a)
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


