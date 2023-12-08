Return-Path: <bpf+bounces-17275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0A80B096
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA261F21421
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34C55ABA9;
	Fri,  8 Dec 2023 23:30:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2901171E
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 15:30:49 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8M0wYI027509
	for <bpf@vger.kernel.org>; Fri, 8 Dec 2023 15:30:49 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uuqb40nx0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 15:30:49 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 8 Dec 2023 15:30:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5E8EB3CD39CA9; Fri,  8 Dec 2023 15:30:33 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: fix timer/test_bad_ret subtest on test_progs-cpuv4 flavor
Date: Fri, 8 Dec 2023 15:30:28 -0800
Message-ID: <20231208233028.3412690-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uBLwbPJTUs8U5vbJJdfRPw49D1cC14RV
X-Proofpoint-ORIG-GUID: uBLwbPJTUs8U5vbJJdfRPw49D1cC14RV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_14,2023-12-07_01,2023-05-22_02

Because test_bad_ret main program is not written in assembly, we don't
control instruction indices in timer_cb_ret_bad() subprog. This bites us
in timer/test_bad_ret subtest, where we see difference between cpuv4 and
other flavors.

For now, make __msg() expectations not rely on instruction indices by
anchoring them around bpf_get_prandom_u32 call. Once we have regex/glob
support for __msg(), this can be expressed a bit more nicely, but for
now just mitigating the problem with available means.

Fixes: e02dea158dda ("selftests/bpf: validate async callback return value=
 check correctness")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/timer_failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/te=
sting/selftests/bpf/progs/timer_failure.c
index 9fbc69c77bbb..0996c2486f05 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -47,9 +47,10 @@ __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __failure
 /* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 22: (b7) r0 =3D 0=
")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before")
+__msg(": (85) call bpf_get_prandom_u32#7") /* anchor message */
 /* check that branch code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 24: (85) call bpf=
_get_prandom_u32#7")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before ") __msg(": (85) =
call bpf_get_prandom_u32#7")
 __msg("should have been in [0, 0]")
 long BPF_PROG2(test_bad_ret, int, a)
 {
--=20
2.34.1


