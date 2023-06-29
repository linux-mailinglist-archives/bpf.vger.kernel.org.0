Return-Path: <bpf+bounces-3698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5D741FC4
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 07:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991B71C2092B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAF63DA;
	Thu, 29 Jun 2023 05:18:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1B4C9A
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:18:56 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B92733
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0NU44030396
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:54 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyc19rbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 22:18:54 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id BE55633AFB531; Wed, 28 Jun 2023 22:18:44 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 06/14] selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
Date: Wed, 28 Jun 2023 22:18:24 -0700
Message-ID: <20230629051832.897119-7-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 7dckiEsh6nktIOfBMFC_4sxs7HxX48Yl
X-Proofpoint-GUID: 7dckiEsh6nktIOfBMFC_4sxs7HxX48Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add test for creating BPF token with support for BPF_MAP_CREATE
delegation. And validate that its allowed_map_types filter works as
expected and allows to create privileged BPF maps through delegated
token, as long as they are allowed by privileged creator of a token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 153c4e26ef6b..0f832f9178a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -89,8 +89,63 @@ static void subtest_token_create(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
=20
+static void subtest_map_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int token_fd =3D 0, map_fd =3D 0, err;
+	__u64 old_caps =3D 0;
+
+	/* check that it's ok to allow any map type */
+	token_opts.allowed_map_types =3D ~0ULL; /* any current and future map t=
ypes is allowed */
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &token_opts);
+	if (!ASSERT_OK(err, "token_create_future_proof"))
+		return;
+	unlink(TOKEN_PATH);
+
+	/* create BPF token allowing STACK, but not QUEUE map */
+	token_opts.allowed_cmds =3D 1ULL << BPF_MAP_CREATE;
+	token_opts.allowed_map_types =3D 1ULL << BPF_MAP_TYPE_STACK; /* but not=
 QUEUE */
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &token_opts);
+	if (!ASSERT_OK(err, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	token_fd =3D bpf_obj_get(TOKEN_PATH);
+	if (!ASSERT_GT(token_fd, 0, "token_get"))
+		goto cleanup;
+
+	/* BPF_MAP_TYPE_STACK is privileged, but with given token_fd should suc=
ceed */
+	map_opts.token_fd =3D token_fd;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, "token_stack", 0, 8, 1, &=
map_opts);
+	if (!ASSERT_GT(map_fd, 0, "stack_map_fd"))
+		goto cleanup;
+	close(map_fd);
+	map_fd =3D 0;
+
+	/* BPF_MAP_TYPE_QUEUE is privileged, and token doesn't allow it, so sho=
uld fail */
+	map_opts.token_fd =3D token_fd;
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_QUEUE, "token_queue", 0, 8, 1, &=
map_opts);
+	if (!ASSERT_EQ(map_fd, -EPERM, "queue_map_fd"))
+		goto cleanup;
+
+cleanup:
+	if (map_fd > 0)
+		close(map_fd);
+	if (token_fd)
+		close(token_fd);
+	unlink(TOKEN_PATH);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("token_create"))
 		subtest_token_create();
+	if (test__start_subtest("map_token"))
+		subtest_map_token();
 }
--=20
2.34.1


