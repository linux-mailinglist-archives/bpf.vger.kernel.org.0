Return-Path: <bpf+bounces-17714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5F811E45
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC67728275C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C368260;
	Wed, 13 Dec 2023 19:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877AC128
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:44 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3BDIXTj0026104
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3uxq0kaw60-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:43 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 11:09:36 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7AFCC3D185B81; Wed, 13 Dec 2023 11:09:32 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 10/10] selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
Date: Wed, 13 Dec 2023 11:08:42 -0800
Message-ID: <20231213190842.3844987-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190842.3844987-1-andrii@kernel.org>
References: <20231213190842.3844987-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5l9lM0rCINLoqEB58glkiJpxRmyUq-mq
X-Proofpoint-ORIG-GUID: 5l9lM0rCINLoqEB58glkiJpxRmyUq-mq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02

Add new subtest validating LIBBPF_BPF_TOKEN_PATH envvar semantics.
Extend existing test to validate that LIBBPF_BPF_TOKEN_PATH allows to
disable implicit BPF token creation by setting envvar to empty string.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 1a3c3aacf537..548aeb91ab0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -769,6 +769,9 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
=20
+#define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
+#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
+
 static int userns_obj_priv_implicit_token(int mnt_fd)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
@@ -791,6 +794,20 @@ static int userns_obj_priv_implicit_token(int mnt_fd=
)
 	if (!ASSERT_OK(err, "move_mount_bpffs"))
 		return -EINVAL;
=20
+	/* disable implicit BPF token creation by setting
+	 * LIBBPF_BPF_TOKEN_PATH envvar to empty value, load should fail
+	 */
+	err =3D setenv(TOKEN_ENVVAR, "", 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		return -EINVAL;
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_token_envvar_disabled_load")) {
+		unsetenv(TOKEN_ENVVAR);
+		dummy_st_ops_success__destroy(skel);
+		return -EINVAL;
+	}
+	unsetenv(TOKEN_ENVVAR);
+
 	/* now the same struct_ops skeleton should succeed thanks to libppf
 	 * creating BPF token from /sys/fs/bpf mount point
 	 */
@@ -826,6 +843,90 @@ static int userns_obj_priv_implicit_token(int mnt_fd=
)
 	return 0;
 }
=20
+static int userns_obj_priv_implicit_token_envvar(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct dummy_st_ops_success *skel;
+	int err;
+
+	/* before we mount BPF FS with token delegation, struct_ops skeleton
+	 * should fail to load
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		dummy_st_ops_success__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* mount custom BPF FS over custom location, so libbpf can't create
+	 * BPF token implicitly, unless pointed to it through
+	 * LIBBPF_BPF_TOKEN_PATH envvar
+	 */
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_custom"))
+		goto err_out;
+	err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_M=
OUNT_F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		goto err_out;
+
+	/* even though we have BPF FS with delegation, it's not at default
+	 * /sys/fs/bpf location, so we still fail to load until envvar is set u=
p
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load2")) {
+		dummy_st_ops_success__destroy(skel);
+		goto err_out;
+	}
+
+	err =3D setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		goto err_out;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from custom mount point
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		goto err_out;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, envvar
+	 * will be ignored, should fail
+	 */
+	opts.bpf_token_path =3D "";
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		goto err_out;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
+		goto err_out;
+
+	/* now disable implicit token through negative bpf_token_fd, envvar
+	 * will be ignored, should fail
+	 */
+	opts.bpf_token_path =3D NULL;
+	opts.bpf_token_fd =3D -1;
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_neg_token_fd_open"))
+		goto err_out;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_neg_token_fd_load"))
+		goto err_out;
+
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	unsetenv(TOKEN_ENVVAR);
+	return 0;
+err_out:
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	unsetenv(TOKEN_ENVVAR);
+	return -EINVAL;
+}
+
 #define bit(n) (1ULL << (n))
=20
 void test_token(void)
@@ -904,4 +1005,15 @@ void test_token(void)
=20
 		subtest_userns(&opts, userns_obj_priv_implicit_token);
 	}
+	if (test__start_subtest("obj_priv_implicit_token_envvar")) {
+		struct bpffs_opts opts =3D {
+			/* allow BTF loading */
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
+	}
 }
--=20
2.34.1


