Return-Path: <bpf+bounces-3695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB652741FBF
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 07:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CF1280CF5
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60F5399;
	Thu, 29 Jun 2023 05:18:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E505384
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:18:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAAB194
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:50 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0jaZC021819
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgypq1pnk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:50 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9530633AFB462; Wed, 28 Jun 2023 22:18:38 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 03/14] selftests/bpf: add BPF_TOKEN_CREATE test
Date: Wed, 28 Jun 2023 22:18:21 -0700
Message-ID: <20230629051832.897119-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X73oEpFQa3_MzE5dlsd86UwWKGRR46sx
X-Proofpoint-ORIG-GUID: X73oEpFQa3_MzE5dlsd86UwWKGRR46sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a subtest validating BPF_TOKEN_CREATE command, pinning/getting BPF
token in/from BPF FS, and creating derived BPF tokens using token_fd
parameter.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..153c4e26ef6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include "linux/bpf.h"
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cap_helpers.h"
+
+static int drop_priv_caps(__u64 *old_caps)
+{
+	return cap_disable_effective((1ULL << CAP_BPF) |
+				     (1ULL << CAP_PERFMON) |
+				     (1ULL << CAP_NET_ADMIN) |
+				     (1ULL << CAP_SYS_ADMIN), old_caps);
+}
+
+static int restore_priv_caps(__u64 old_caps)
+{
+	return cap_enable_effective(old_caps, NULL);
+}
+
+#define BPFFS_PATH "/sys/fs/bpf"
+#define TOKEN_PATH BPFFS_PATH "/test_token"
+
+static void subtest_token_create(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, opts);
+	int token_fd =3D 0, limited_token_fd =3D 0, err;
+	__u64 old_caps =3D 0;
+
+	/* check that any current and future cmd can be specified */
+	opts.allowed_cmds =3D ~0ULL;
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &opts);
+	if (!ASSERT_OK(err, "token_create_future_proof"))
+		return;
+	unlink(TOKEN_PATH);
+
+	/* create BPF token which allows creating derived BPF tokens */
+	opts.allowed_cmds =3D 1ULL << BPF_TOKEN_CREATE;
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &opts);
+	if (!ASSERT_OK(err, "token_create"))
+		return;
+
+	token_fd =3D bpf_obj_get(TOKEN_PATH);
+	if (!ASSERT_GT(token_fd, 0, "token_get"))
+		goto cleanup;
+	unlink(TOKEN_PATH);
+
+	/* validate pinning and getting works as expected */
+	err =3D bpf_obj_pin(token_fd, TOKEN_PATH);
+	if (!ASSERT_ERR(err, "token_pin_unexpected_success"))
+		goto cleanup;
+
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE should fail */
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, NULL);
+	if (!ASSERT_ERR(err, "token_create_unpriv_fail"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE using granted BPF token succeeds */
+	opts.allowed_cmds =3D 0; /* ask for BPF token which doesn't allow new t=
okens */
+	opts.token_fd =3D token_fd;
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &opts);
+	if (!ASSERT_OK(limited_token_fd, "token_create_limited"))
+		goto cleanup;
+
+	limited_token_fd =3D bpf_obj_get(TOKEN_PATH);
+	if (!ASSERT_GT(limited_token_fd, 0, "token_get_limited"))
+		goto cleanup;
+	unlink(TOKEN_PATH);
+
+	/* creating yet another token using "limited" BPF token should fail */
+	opts.allowed_cmds =3D 0;
+	opts.token_fd =3D limited_token_fd;
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH,  &opts);
+	if (!ASSERT_ERR(err, "token_create_from_lim_fail"))
+		goto cleanup;
+
+cleanup:
+	if (token_fd)
+		close(token_fd);
+	if (limited_token_fd)
+		close(limited_token_fd);
+	unlink(TOKEN_PATH);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
+void test_token(void)
+{
+	if (test__start_subtest("token_create"))
+		subtest_token_create();
+}
--=20
2.34.1


