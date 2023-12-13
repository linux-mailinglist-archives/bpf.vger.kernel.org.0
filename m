Return-Path: <bpf+bounces-17715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA53811E42
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95A2B21116
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE568267;
	Wed, 13 Dec 2023 19:09:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020695
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:46 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3BDIXTj3026104
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:45 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3uxq0kaw60-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:09:45 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 11:09:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CEBC23D185B12; Wed, 13 Dec 2023 11:09:24 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>
Subject: [PATCH v3 bpf-next 08/10] selftests/bpf: add tests for BPF object load with implicit token
Date: Wed, 13 Dec 2023 11:08:40 -0800
Message-ID: <20231213190842.3844987-9-andrii@kernel.org>
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
X-Proofpoint-GUID: cSNd1rl7tGuuaa_VIkyNam9wS9xEV0ZZ
X-Proofpoint-ORIG-GUID: cSNd1rl7tGuuaa_VIkyNam9wS9xEV0ZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02

Add a test to validate libbpf's implicit BPF token creation from default
BPF FS location (/sys/fs/bpf). Also validate that disabling this
implicit BPF token creation works.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 9812292336c9..1a3c3aacf537 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -12,6 +12,7 @@
 #include <linux/unistd.h>
 #include <linux/mount.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/un.h>
 #include "priv_map.skel.h"
@@ -45,6 +46,13 @@ static inline int sys_fsmount(int fs_fd, unsigned flag=
s, unsigned ms_flags)
 	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
 }
=20
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+				 int to_dfd, const char *to_path,
+				 unsigned flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, f=
lags);
+}
+
 static int drop_priv_caps(__u64 *old_caps)
 {
 	return cap_disable_effective((1ULL << CAP_BPF) |
@@ -761,6 +769,63 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
=20
+static int userns_obj_priv_implicit_token(int mnt_fd)
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
+	/* mount custom BPF FS over /sys/fs/bpf so that libbpf can create BPF
+	 * token automatically and implicitly
+	 */
+	err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, "/sys/fs/bpf", MOVE_MOUNT_=
F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		return -EINVAL;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from /sys/fs/bpf mount point
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		return -EINVAL;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, should fail=
 */
+	opts.bpf_token_path =3D "";
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		return -EINVAL;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
+		return -EINVAL;
+
+	/* now disable implicit token through negative bpf_token_fd, should fai=
l */
+	opts.bpf_token_path =3D NULL;
+	opts.bpf_token_fd =3D -1;
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_neg_token_fd_open"))
+		return -EINVAL;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_neg_token_fd_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define bit(n) (1ULL << (n))
=20
 void test_token(void)
@@ -828,4 +893,15 @@ void test_token(void)
=20
 		subtest_userns(&opts, userns_obj_priv_btf_success);
 	}
+	if (test__start_subtest("obj_priv_implicit_token")) {
+		struct bpffs_opts opts =3D {
+			/* allow BTF loading */
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token);
+	}
 }
--=20
2.34.1


