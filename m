Return-Path: <bpf+bounces-14533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC317E60E0
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D89BB20FC7
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D43374CD;
	Wed,  8 Nov 2023 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392C37155
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:12:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1723259B
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:12:10 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A8KNKUJ018767
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 15:12:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u7w2atcmx-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:12:08 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 15:12:06 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6B16D3B2E7DEB; Wed,  8 Nov 2023 15:12:02 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: add more test cases for check_cfg()
Date: Wed, 8 Nov 2023 15:11:52 -0800
Message-ID: <20231108231152.3583545-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108231152.3583545-1-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bov1uCJ4HopmJfuBk1vM-ZG_cMV6unBE
X-Proofpoint-ORIG-GUID: bov1uCJ4HopmJfuBk1vM-ZG_cMV6unBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02

Add a few more simple cases to validate proper privileged vs unprivileged
loop detection behavior. conditional_loop2 is the one reported by Hao
Sun that triggered this set of fixes.

Suggested-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/tes=
ting/selftests/bpf/progs/verifier_cfg.c
index 65d205474f33..bba622814123 100644
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


