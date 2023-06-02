Return-Path: <bpf+bounces-1690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C8720514
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905B51C20CCB
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C919BB8;
	Fri,  2 Jun 2023 15:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017A1992C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:00:28 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A19E53
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:00:26 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3527VDrb028690
	for <bpf@vger.kernel.org>; Fri, 2 Jun 2023 08:00:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qyc3papdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 08:00:25 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:23 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3A31B31E04817; Fri,  2 Jun 2023 08:00:18 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 03/18] selftests/bpf: add BPF_TOKEN_CREATE test
Date: Fri, 2 Jun 2023 07:59:56 -0700
Message-ID: <20230602150011.1657856-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oMdfXoCde1uvz1MqhnckvDTu638csp-Q
X-Proofpoint-ORIG-GUID: oMdfXoCde1uvz1MqhnckvDTu638csp-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
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
 .../testing/selftests/bpf/prog_tests/token.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..fe78b558d697
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,95 @@
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
+#define TOKEN_PATH "/sys/fs/bpf/test_token"
+
+static void subtest_token_create(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, opts);
+	int token_fd =3D 0, limited_token_fd =3D 0, tmp_fd =3D 0, err;
+	__u64 old_caps =3D 0;
+
+	/* create BPF token which allows creating derived BPF tokens */
+	opts.allowed_cmds =3D 1ULL << BPF_TOKEN_CREATE;
+	token_fd =3D bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* check that IGNORE_UNKNOWN_CMDS flag is respected */
+	opts.flags =3D BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS;
+	opts.allowed_cmds =3D ~0ULL; /* any current and future cmd is allowed *=
/
+	tmp_fd =3D bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(tmp_fd);
+	tmp_fd =3D 0;
+
+	/* validate pinning and getting works as expected */
+	err =3D bpf_obj_pin(token_fd, TOKEN_PATH);
+	if (!ASSERT_OK(err, "token_pin"))
+		goto cleanup;
+
+	tmp_fd =3D bpf_obj_get(TOKEN_PATH);
+	ASSERT_GT(tmp_fd, 0, "token_get");
+	close(tmp_fd);
+	tmp_fd =3D 0;
+	unlink(TOKEN_PATH);
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE should fail */
+	tmp_fd =3D bpf_token_create(NULL);
+	if (!ASSERT_LT(tmp_fd, 0, "token_create_unpriv_fail"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE with associated BPF token succeeds */
+	opts.flags =3D 0;
+	opts.allowed_cmds =3D 0; /* ask for BPF token which doesn't allow new t=
okens */
+	opts.token_fd =3D token_fd;
+	limited_token_fd =3D bpf_token_create(&opts);
+	if (!ASSERT_GT(limited_token_fd, 0, "token_create_limited"))
+		goto cleanup;
+
+	/* creating yet another token using "limited" BPF token should fail */
+	opts.flags =3D 0;
+	opts.allowed_cmds =3D 0;
+	opts.token_fd =3D limited_token_fd;
+	tmp_fd =3D bpf_token_create(&opts);
+	if (!ASSERT_LT(tmp_fd, 0, "token_create_from_lim_fail"))
+		goto cleanup;
+
+cleanup:
+	if (tmp_fd)
+		close(tmp_fd);
+	if (token_fd)
+		close(token_fd);
+	if (limited_token_fd)
+		close(limited_token_fd);
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


