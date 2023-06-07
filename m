Return-Path: <bpf+bounces-2058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D0727374
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42451C20F50
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF81DCAF;
	Wed,  7 Jun 2023 23:54:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA691DCA6
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F5212E
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357GAuc6032579
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2w6bb685-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:15 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E5FC932857E01; Wed,  7 Jun 2023 16:54:12 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 09/18] selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
Date: Wed, 7 Jun 2023 16:53:43 -0700
Message-ID: <20230607235352.1723243-10-andrii@kernel.org>
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
X-Proofpoint-GUID: g-RZdkK2sEV7dZuiMdxWZVVOrLtTmfbe
X-Proofpoint-ORIG-GUID: g-RZdkK2sEV7dZuiMdxWZVVOrLtTmfbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_12,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add test for creating BPF token with support for BPF_MAP_CREATE
delegation. And validate that its allowed_map_types filter works as
expected and allows to create privileged BPF maps through delegated
token, as long as they are allowed by privileged creator of a token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index cba84c480ac5..61707b3e81a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -86,8 +86,58 @@ static void subtest_token_create(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
=20
+static void subtest_map_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int token_fd =3D 0, map_fd =3D 0;
+	__u64 old_caps =3D 0;
+
+	/* check that it's ok to allow any map type */
+	token_opts.allowed_map_types =3D ~0ULL; /* any current and future map t=
ypes is allowed */
+	token_fd =3D bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(token_fd);
+
+	/* create BPF token allowing STACK, but not QUEUE map */
+	token_opts.allowed_cmds =3D 1ULL << BPF_MAP_CREATE;
+	token_opts.allowed_map_types =3D 1ULL << BPF_MAP_TYPE_STACK; /* but not=
 QUEUE */
+	token_fd =3D bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
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


