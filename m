Return-Path: <bpf+bounces-2061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40D72737A
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D17C280E61
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27371DCBC;
	Wed,  7 Jun 2023 23:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A73B415
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:54:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39BC2682
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:54:28 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HPIjj002717
	for <bpf@vger.kernel.org>; Wed, 7 Jun 2023 16:54:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2n4cxjr5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 16:54:28 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7089A32857E2B; Wed,  7 Jun 2023 16:54:20 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 12/18] selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
Date: Wed, 7 Jun 2023 16:53:46 -0700
Message-ID: <20230607235352.1723243-13-andrii@kernel.org>
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
X-Proofpoint-GUID: _rwKtf3T1tyu0wLxS00y9YV3Ohpckz4f
X-Proofpoint-ORIG-GUID: _rwKtf3T1tyu0wLxS00y9YV3Ohpckz4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a simple test validating that BTF loading can be done from
unprivileged process through delegated BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 61707b3e81a7..ff8ada405576 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -134,10 +134,65 @@ static void subtest_map_token(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
=20
+static void subtest_btf_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_btf_load_opts, btf_opts);
+	int token_fd =3D 0, btf_fd =3D 0;
+	const void *raw_btf_data;
+	struct btf *btf =3D NULL;
+	__u32 raw_btf_size;
+	__u64 old_caps =3D 0;
+
+	/* create BPF token allowing BPF_BTF_LOAD command */
+	token_opts.allowed_cmds =3D 1ULL << BPF_BTF_LOAD;
+	token_fd =3D bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	btf =3D btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		goto cleanup;
+
+	ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "int_type");
+
+	raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
+	if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data"))
+		goto cleanup;
+
+	/* validate we can successfully load new BTF with token */
+	btf_opts.token_fd =3D token_fd;
+	btf_fd =3D bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_GT(btf_fd, 0, "btf_fd"))
+		goto cleanup;
+	close(btf_fd);
+
+	/* now validate that we *cannot* load BTF without token */
+	btf_opts.token_fd =3D 0;
+	btf_fd =3D bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_EQ(btf_fd, -EPERM, "btf_fd_eperm"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+	if (btf_fd > 0)
+		close(btf_fd);
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
 	if (test__start_subtest("map_token"))
 		subtest_map_token();
+	if (test__start_subtest("btf_token"))
+		subtest_btf_token();
 }
--=20
2.34.1


