Return-Path: <bpf+bounces-16509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA65801E04
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4853A1F21052
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294AB200D9;
	Sat,  2 Dec 2023 17:57:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63E124
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 09:57:35 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B29mEfc014768
	for <bpf@vger.kernel.org>; Sat, 2 Dec 2023 09:57:35 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ur1guhq87-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 09:57:35 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 09:57:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 0A4A13C7A8270; Sat,  2 Dec 2023 09:57:29 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v5 bpf-next 10/11] selftests/bpf: adjust global_func15 test to validate prog exit precision
Date: Sat, 2 Dec 2023 09:57:04 -0800
Message-ID: <20231202175705.885270-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202175705.885270-1-andrii@kernel.org>
References: <20231202175705.885270-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5GKBDQ_h6z6wt_thwoiF5A8SUslenJbS
X-Proofpoint-ORIG-GUID: 5GKBDQ_h6z6wt_thwoiF5A8SUslenJbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02

Add one more subtest to  global_func15 selftest to validate that
verifier properly marks r0 as precise and avoids erroneous state pruning
of the branch that has return value outside of expected [0, 1] value.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/test_global_func15.c  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/too=
ls/testing/selftests/bpf/progs/test_global_func15.c
index f80207480e8a..b4e089d6981d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -22,3 +22,35 @@ int global_func15(struct __sk_buff *skb)
=20
 	return v;
 }
+
+SEC("cgroup_skb/ingress")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__failure
+/* check that fallthrough code path marks r0 as precise */
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 2: (b7) r0 =3D 1"=
)
+/* check that branch code path marks r0 as precise */
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_=
get_prandom_u32#7")
+__msg("At program exit the register R0 has ")
+__naked int global_func15_tricky_pruning(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 s> 1000 goto 1f;"
+		"r0 =3D 1;"
+	"1:"
+		"goto +0;" /* checkpoint */
+		/* cgroup_skb/ingress program is expected to return [0, 1]
+		 * values, so branch above makes sure that in a fallthrough
+		 * case we have a valid 1 stored in R0 register, but in
+		 * a branch case we assign some random value to R0.  So if
+		 * there is something wrong with precision tracking for R0 at
+		 * program exit, we might erronenously prune branch case,
+		 * because R0 in fallthrough case is imprecise (and thus any
+		 * value is valid from POV of verifier is_state_equal() logic)
+		 */
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_common
+	);
+}
--=20
2.34.1


