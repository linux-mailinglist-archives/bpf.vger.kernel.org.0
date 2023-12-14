Return-Path: <bpf+bounces-17893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C0813E1F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441FD1C21EB9
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D66C6C1;
	Thu, 14 Dec 2023 23:13:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065386C6C8
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMCKCl009831
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:50:43 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v00ev4rc4-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:50:42 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 14:50:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id ABF463D2A7840; Thu, 14 Dec 2023 14:50:28 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: utilize string values for delegate_xxx mount options
Date: Thu, 14 Dec 2023 14:50:16 -0800
Message-ID: <20231214225016.1209867-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214225016.1209867-1-andrii@kernel.org>
References: <20231214225016.1209867-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Qx-nB0u1hd5CCPzS7ka1tIzbYfJ0YOLL
X-Proofpoint-ORIG-GUID: Qx-nB0u1hd5CCPzS7ka1tIzbYfJ0YOLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_15,2023-12-14_01,2023-05-22_02

Use both hex-based and string-based way to specify delegate mount
options for BPF FS.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 548aeb91ab0d..b5dce630e0e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -66,14 +66,22 @@ static int restore_priv_caps(__u64 old_caps)
 	return cap_enable_effective(old_caps, NULL);
 }
=20
-static int set_delegate_mask(int fs_fd, const char *key, __u64 mask)
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask, con=
st char *mask_str)
 {
 	char buf[32];
 	int err;
=20
-	snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+	if (!mask_str) {
+		if (mask =3D=3D ~0ULL) {
+			mask_str =3D "any";
+		} else {
+			snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+			mask_str =3D buf;
+		}
+	}
+
 	err =3D sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
-			   mask =3D=3D ~0ULL ? "any" : buf, 0);
+			   mask_str, 0);
 	if (err < 0)
 		err =3D -errno;
 	return err;
@@ -86,6 +94,10 @@ struct bpffs_opts {
 	__u64 maps;
 	__u64 progs;
 	__u64 attachs;
+	const char *cmds_str;
+	const char *maps_str;
+	const char *progs_str;
+	const char *attachs_str;
 };
=20
 static int create_bpffs_fd(void)
@@ -104,16 +116,16 @@ static int materialize_bpffs_fd(int fs_fd, struct b=
pffs_opts *opts)
 	int mnt_fd, err;
=20
 	/* set up token delegation mount options */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmd=
s_str);
 	if (!ASSERT_OK(err, "fs_cfg_cmds"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opts->map=
s_str);
 	if (!ASSERT_OK(err, "fs_cfg_maps"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs, opts->p=
rogs_str);
 	if (!ASSERT_OK(err, "fs_cfg_progs"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs, opt=
s->attachs_str);
 	if (!ASSERT_OK(err, "fs_cfg_attachs"))
 		return err;
=20
@@ -295,13 +307,13 @@ static void child(int sock_fd, struct bpffs_opts *o=
pts, child_callback_fn callba
 	}
=20
 	/* ensure unprivileged child cannot set delegation options */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_maps_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_progs_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm");
=20
 	/* pass BPF FS context object to parent */
@@ -325,22 +337,22 @@ static void child(int sock_fd, struct bpffs_opts *o=
pts, child_callback_fn callba
 	}
=20
 	/* ensure unprivileged child cannot reconfigure to set delegation optio=
ns */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_maps_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_progs_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
@@ -933,8 +945,8 @@ void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_MAP_CREATE,
-			.maps =3D 1ULL << BPF_MAP_TYPE_STACK,
+			.cmds_str =3D "map_create",
+			.maps_str =3D "stack",
 		};
=20
 		subtest_userns(&opts, userns_map_create);
@@ -948,9 +960,9 @@ void test_token(void)
 	}
 	if (test__start_subtest("prog_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_PROG_LOAD,
-			.progs =3D 1ULL << BPF_PROG_TYPE_XDP,
-			.attachs =3D 1ULL << BPF_XDP,
+			.cmds_str =3D "PROG_LOAD",
+			.progs_str =3D "XDP",
+			.attachs_str =3D "xdp",
 		};
=20
 		subtest_userns(&opts, userns_prog_load);
--=20
2.34.1


