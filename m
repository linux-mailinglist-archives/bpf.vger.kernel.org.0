Return-Path: <bpf+bounces-17570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979480F580
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F1B20D3C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28A7F541;
	Tue, 12 Dec 2023 18:26:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE031CF
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:22 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCH0f3C002755
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:22 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ux308a76p-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:22 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 10:26:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 638943D058935; Tue, 12 Dec 2023 10:26:06 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 8/8] selftests/bpf: add tests for BPF object load with implicit token
Date: Tue, 12 Dec 2023 10:25:47 -0800
Message-ID: <20231212182547.1873811-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212182547.1873811-1-andrii@kernel.org>
References: <20231212182547.1873811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fjHr0NePUa6OC-RnG4ua-nBEhtvIC-5Y
X-Proofpoint-ORIG-GUID: fjHr0NePUa6OC-RnG4ua-nBEhtvIC-5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

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


