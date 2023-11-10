Return-Path: <bpf+bounces-14663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7667E75EC
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9561C20D3A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111C7EB;
	Fri, 10 Nov 2023 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F470628
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:26:56 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80830D1
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:26:56 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZAjP002443
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 16:26:55 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u91swvhp1-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 16:26:55 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:26:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 939303B3FA05D; Thu,  9 Nov 2023 16:26:45 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking logic test
Date: Thu, 9 Nov 2023 16:26:38 -0800
Message-ID: <20231110002638.4168352-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110002638.4168352-1-andrii@kernel.org>
References: <20231110002638.4168352-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lHKsinznQMbm_Yyf_dL36kb9WwmGHoch
X-Proofpoint-ORIG-GUID: lHKsinznQMbm_Yyf_dL36kb9WwmGHoch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02

Add a dedicated selftests to try to set up conditions to have a state
with same first and last instruction index, but it actually is a loop
3->4->1->2->3. This confuses mark_chain_precision() if verifier doesn't
take into account jump history.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_precision.c  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
index 193c0f8272d0..6b564d4c0986 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -91,3 +91,43 @@ __naked int bpf_end_bswap(void)
 }
=20
 #endif /* v4 instruction */
+
+SEC("?raw_tp")
+__success __log_level(2)
+/*
+ * Without the bug fix there will be no history between "last_idx 3 firs=
t_idx 3"
+ * and "parent state regs=3D" lines. "R0_w=3D6" parts are here to help a=
nchor
+ * expected log messages to the one specific mark_chain_precision operat=
ion.
+ *
+ * This is quite fragile: if verifier checkpointing heuristic changes, t=
his
+ * might need adjusting.
+ */
+__msg("2: (07) r0 +=3D 1                       ; R0_w=3D6")
+__msg("3: (35) if r0 >=3D 0xa goto pc+1")
+__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 2: (07) r0 +=3D 1=
")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (07) r0 +=3D 1=
")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (05) goto pc-4=
")
+__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (35) if r0 >=3D=
 0xa goto pc+1")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DP4"=
)
+__msg("3: R0_w=3D6")
+__naked int state_loop_first_last_equal(void)
+{
+	asm volatile (
+		"r0 =3D 0;"
+	"l0_%=3D:"
+		"r0 +=3D 1;"
+		"r0 +=3D 1;"
+		/* every few iterations we'll have a checkpoint here with
+		 * first_idx =3D=3D last_idx, potentially confusing precision
+		 * backtracking logic
+		 */
+		"if r0 >=3D 10 goto l1_%=3D;"	/* checkpoint + mark_precise */
+		"goto l0_%=3D;"
+	"l1_%=3D:"
+		"exit;"
+		::: __clobber_common
+	);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


