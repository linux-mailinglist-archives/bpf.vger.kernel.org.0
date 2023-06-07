Return-Path: <bpf+bounces-2066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93A727380
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36373280DCE
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BCF1DCD9;
	Wed,  7 Jun 2023 23:54:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A491DCCF
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D539E
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:32 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357GBGmv000798
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2w6bb68u-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:32 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7ADD232857E3C; Wed,  7 Jun 2023 16:54:22 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 13/18] bpf: keep BPF_PROG_LOAD permission checks clear of validations
Date: Wed, 7 Jun 2023 16:53:47 -0700
Message-ID: <20230607235352.1723243-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KXuiESMzxIaMxMl_vU8_lGR3PQQov6T_
X-Proofpoint-ORIG-GUID: KXuiESMzxIaMxMl_vU8_lGR3PQQov6T_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_12,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move out flags validation and license checks out of the permission
checks. They were intermingled, which makes subsequent changes harder.
Clean this up: perform straightforward flag validation upfront, and
fetch and check license later, right where we use it. Also consolidate
capabilities check in one block, right after basic attribute sanity
checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d9f971ec227..8e5c42af978c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2582,7 +2582,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	struct btf *attach_btf =3D NULL;
 	int err;
 	char license[128];
-	bool is_gpl;
=20
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2601,16 +2600,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
=20
-	/* copy eBPF program license from user space */
-	if (strncpy_from_bpfptr(license,
-				make_bpfptr(attr->license, uattr.is_kernel),
-				sizeof(license) - 1) < 0)
-		return -EFAULT;
-	license[sizeof(license) - 1] =3D 0;
-
-	/* eBPF programs must be GPL compatible to use GPL-ed functions */
-	is_gpl =3D license_is_gpl_compatible(license);
-
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
@@ -2703,12 +2692,20 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 			     make_bpfptr(attr->insns, uattr.is_kernel),
 			     bpf_prog_insn_size(prog)) !=3D 0)
 		goto free_prog_sec;
+	/* copy eBPF program license from user space */
+	if (strncpy_from_bpfptr(license,
+				make_bpfptr(attr->license, uattr.is_kernel),
+				sizeof(license) - 1) < 0)
+		goto free_prog_sec;
+	license[sizeof(license) - 1] =3D 0;
+
+	/* eBPF programs must be GPL compatible to use GPL-ed functions */
+	prog->gpl_compatible =3D license_is_gpl_compatible(license) ? 1 : 0;
=20
 	prog->orig_prog =3D NULL;
 	prog->jited =3D 0;
=20
 	atomic64_set(&prog->aux->refcnt, 1);
-	prog->gpl_compatible =3D is_gpl ? 1 : 0;
=20
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err =3D bpf_prog_dev_bound_init(prog, attr);
--=20
2.34.1


