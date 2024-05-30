Return-Path: <bpf+bounces-30901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF98D45B6
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25BAB242C4
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350C3DAC00;
	Thu, 30 May 2024 07:05:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED03DABE7
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052717; cv=none; b=JA6lzAqDKgidUsAufdUQBYabrOhxAT1TKnDoUSSzl6z7gXwChNtOqVnMib2x2XyEaPDJSYTsuCeGYEeKke0ZhTnNxthlyDxMcdHHDMZMAzRxc+6heOErGSLpZ9D7npw1wa/6ci4Do6NilieDMUSP9Yb/dmbq1N9sgowENYXTpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052717; c=relaxed/simple;
	bh=vaMK7iVW3uzQZDjgrpL3uTp2gqYNa0VzJNbMWKp7aEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HydbgcWJCrmhncmDEuL2B24r14SE1vKokW5+4ow6leuSdq6deCA7RCguXYyaPp84gNYpmgFuT+zDxIuslm0QjysUu8ATitL5YE5/HCFKOE5DxhpaCWfAhY3OoadgG7ei2Uf3XGFp0XFVNc2kOLJiXmu/cCXp5OKr9BIFVhMyPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44U1MC14015361
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yds3khfv8-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:14 -0700
Received: from twshared20084.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:04:59 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 548535DFFC0B; Thu, 30 May 2024 00:04:54 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 7/8] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Wed, 29 May 2024 23:59:45 -0700
Message-ID: <20240530065946.979330-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
References: <20240530065946.979330-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2BNrq4kxkJmZHW25Od2VoKOWt0gHsYCT
X-Proofpoint-ORIG-GUID: 2BNrq4kxkJmZHW25Od2VoKOWt0gHsYCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Do detachment from the subsystem after a link being closed/freed.  This
test make sure the pattern implemented by bpf_dummy_do_link_detach() work=
s
correctly.

Refer to bpf_dummy_do_link_detach() in bpf_testmod.c for more details.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index f4000bf04752..3a8cdf440edd 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -362,6 +362,48 @@ static void test_subsystem_detach(void)
 	struct_ops_detach__destroy(skel);
 }
=20
+/* A subsystem detaches a link while the link is going to be free. */
+static void test_subsystem_detach_free(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4));
+	struct struct_ops_detach *skel;
+	struct bpf_link *link =3D NULL;
+	int prog_fd;
+	int err;
+
+	skel =3D struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+
+	prog_fd =3D bpf_program__fd(skel->progs.start_detach);
+	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
+		goto cleanup;
+
+	/* Do detachment from the registered subsystem */
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "start_detach_run"))
+		goto cleanup;
+
+	/* The link has zeroed refcount value or even has been
+	 * unregistered, so the detachment from the subsystem should fail.
+	 */
+	ASSERT_EQ(topts.retval, (u32)-ENOENT, "start_detach_run_retval");
+
+	/* Sync RCU to make sure the link is freed without any crash */
+	ASSERT_OK(kern_sync_rcu(), "kern_sync_rcu");
+
+cleanup:
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("struct_ops_load"))
@@ -378,5 +420,7 @@ void serial_test_struct_ops_module(void)
 		test_detach_link();
 	if (test__start_subtest("test_subsystem_detach"))
 		test_subsystem_detach();
+	if (test__start_subtest("test_subsystem_detach_free"))
+		test_subsystem_detach_free();
 }
=20
--=20
2.43.0


