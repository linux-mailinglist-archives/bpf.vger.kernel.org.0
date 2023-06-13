Return-Path: <bpf+bounces-2557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66F72EF86
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1786A2812BB
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B802A9F0;
	Tue, 13 Jun 2023 22:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852D13ADF
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 22:35:52 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB2129
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DMC1rt023040
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xhxxab2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:51 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:35:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id EF61F32D4639E; Tue, 13 Jun 2023 15:35:42 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/4] bpf: keep BPF_PROG_LOAD permission checks clear of validations
Date: Tue, 13 Jun 2023 15:35:33 -0700
Message-ID: <20230613223533.3689589-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613223533.3689589-1-andrii@kernel.org>
References: <20230613223533.3689589-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: u90t1jElBvwJAb1XV1c8XzZE-xEHrcZM
X-Proofpoint-ORIG-GUID: u90t1jElBvwJAb1XV1c8XzZE-xEHrcZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
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
index 8324c64e1e54..1eaa16d3c6db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2550,7 +2550,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	struct btf *attach_btf =3D NULL;
 	int err;
 	char license[128];
-	bool is_gpl;
=20
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2569,16 +2568,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
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
@@ -2671,12 +2660,20 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
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


