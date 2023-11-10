Return-Path: <bpf+bounces-14723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D87E790E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE066281813
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FF5693;
	Fri, 10 Nov 2023 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8963B4
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:14:40 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7075274
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:14:38 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYChC023237
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 22:14:38 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u8q20jcat-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:14:37 -0800
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 22:14:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 452453B43D58D; Thu,  9 Nov 2023 22:14:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Hao Sun
	<sunhao.th@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add more test cases for check_cfg()
Date: Thu, 9 Nov 2023 22:14:11 -0800
Message-ID: <20231110061412.2995786-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110061412.2995786-1-andrii@kernel.org>
References: <20231110061412.2995786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MjH-k2IEoHKKH-irW7oUQIUbBGVevJTi
X-Proofpoint-GUID: MjH-k2IEoHKKH-irW7oUQIUbBGVevJTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_03,2023-11-09_01,2023-05-22_02

Add a few more simple cases to validate proper privileged vs unprivileged
loop detection behavior. conditional_loop2 is the one reported by Hao
Sun that triggered this set of fixes.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/tes=
ting/selftests/bpf/progs/verifier_cfg.c
index df7697b94007..c1f55e1d80a4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -97,4 +97,66 @@ l0_%=3D:	r2 =3D r0;					\
 "	::: __clobber_all);
 }
=20
+SEC("socket")
+__description("conditional loop (2)")
+__success
+__failure_unpriv __msg_unpriv("back-edge from insn 10 to 11")
+__naked void conditional_loop2(void)
+{
+	asm volatile ("					\
+	r9 =3D 2 ll;					\
+	r3 =3D 0x20 ll;					\
+	r4 =3D 0x35 ll;					\
+	r8 =3D r4;					\
+	goto l1_%=3D;					\
+l0_%=3D:	r9 -=3D r3;					\
+	r9 -=3D r4;					\
+	r9 -=3D r8;					\
+l1_%=3D:	r8 +=3D r4;					\
+	if r8 < 0x64 goto l0_%=3D;			\
+	r0 =3D r9;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unconditional loop after conditional jump")
+__failure __msg("infinite loop detected")
+__failure_unpriv __msg_unpriv("back-edge from insn 3 to 2")
+__naked void uncond_loop_after_cond_jmp(void)
+{
+	asm volatile ("					\
+	r0 =3D 0;						\
+	if r0 > 0 goto l1_%=3D;				\
+l0_%=3D:	r0 =3D 1;						\
+	goto l0_%=3D;					\
+l1_%=3D:	exit;						\
+"	::: __clobber_all);
+}
+
+
+__naked __noinline __used
+static unsigned long never_ending_subprog()
+{
+	asm volatile ("					\
+	r0 =3D r1;					\
+	goto -1;					\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("unconditional loop after conditional jump")
+/* infinite loop is detected *after* check_cfg() */
+__failure __msg("infinite loop detected")
+__naked void uncond_loop_in_subprog_after_cond_jmp(void)
+{
+	asm volatile ("					\
+	r0 =3D 0;						\
+	if r0 > 0 goto l1_%=3D;				\
+l0_%=3D:	r0 +=3D 1;					\
+	call never_ending_subprog;			\
+l1_%=3D:	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


