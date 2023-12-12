Return-Path: <bpf+bounces-17568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E580F57B
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742111F217A3
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2947F558;
	Tue, 12 Dec 2023 18:26:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A7CE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:12 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCH18RH003530
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:11 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxmtykc4r-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:26:11 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 10:26:04 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4EFF33D058923; Tue, 12 Dec 2023 10:26:04 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 7/8] selftests/bpf: add BPF object loading tests with explicit token passing
Date: Tue, 12 Dec 2023 10:25:46 -0800
Message-ID: <20231212182547.1873811-8-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 2kRK4l-X6EZRAl_OT4wKYtjonTgdwNs9
X-Proofpoint-GUID: 2kRK4l-X6EZRAl_OT4wKYtjonTgdwNs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Add a few tests that attempt to load BPF object containing privileged
map, program, and the one requiring mandatory BTF uploading into the
kernel (to validate token FD propagation to BPF_BTF_LOAD command).

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 159 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/priv_map.c  |  13 ++
 tools/testing/selftests/bpf/progs/priv_prog.c |  13 ++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index dc03790c6272..9812292336c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -14,6 +14,9 @@
 #include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/un.h>
+#include "priv_map.skel.h"
+#include "priv_prog.skel.h"
+#include "dummy_st_ops_success.skel.h"
=20
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -643,6 +646,123 @@ static int userns_prog_load(int mnt_fd)
 	return err;
 }
=20
+static int userns_obj_priv_map(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct priv_map *skel;
+	int err, token_fd;
+
+	skel =3D priv_map__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		priv_map__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path =3D buf;
+	skel =3D priv_map__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err =3D priv_map__load(skel);
+	priv_map__destroy(skel);
+	if (!ASSERT_OK(err, "obj_token_path_load"))
+		return -EINVAL;
+
+	/* create token and pass it through bpf_token_fd */
+	token_fd =3D bpf_token_create(mnt_fd, NULL);
+	if (!ASSERT_GT(token_fd, 0, "create_token"))
+		return -EINVAL;
+
+	opts.bpf_token_path =3D NULL;
+	opts.bpf_token_fd =3D token_fd;
+	skel =3D priv_map__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_fd_open"))
+		return -EINVAL;
+
+	/* we can close our token FD, bpf_object owns dup()'ed FD now */
+	close(token_fd);
+
+	err =3D priv_map__load(skel);
+	priv_map__destroy(skel);
+	if (!ASSERT_OK(err, "obj_token_fd_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int userns_obj_priv_prog(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct priv_prog *skel;
+	int err;
+
+	skel =3D priv_prog__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		priv_prog__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path =3D buf;
+	skel =3D priv_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err =3D priv_prog__load(skel);
+	priv_prog__destroy(skel);
+	if (!ASSERT_OK(err, "obj_token_path_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* this test is called with BPF FS that doesn't delegate BPF_BTF_LOAD co=
mmand,
+ * which should cause struct_ops application to fail, as BTF won't be up=
loaded
+ * into the kernel, even if STRUCT_OPS programs themselves are allowed
+ */
+static int validate_struct_ops_load(int mnt_fd, bool expect_success)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	char buf[256];
+	struct dummy_st_ops_success *skel;
+	int err;
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path =3D buf;
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_token_path_open"))
+		return -EINVAL;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (expect_success) {
+		if (!ASSERT_OK(err, "obj_token_path_load"))
+			return -EINVAL;
+	} else /* expect failure */ {
+		if (!ASSERT_ERR(err, "obj_token_path_load"))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int userns_obj_priv_btf_fail(int mnt_fd)
+{
+	return validate_struct_ops_load(mnt_fd, false /* should fail */);
+}
+
+static int userns_obj_priv_btf_success(int mnt_fd)
+{
+	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
+}
+
+#define bit(n) (1ULL << (n))
+
 void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
@@ -669,4 +789,43 @@ void test_token(void)
=20
 		subtest_userns(&opts, userns_prog_load);
 	}
+	if (test__start_subtest("obj_priv_map")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D bit(BPF_MAP_CREATE),
+			.maps =3D bit(BPF_MAP_TYPE_QUEUE),
+		};
+
+		subtest_userns(&opts, userns_obj_priv_map);
+	}
+	if (test__start_subtest("obj_priv_prog")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D bit(BPF_PROG_LOAD),
+			.progs =3D bit(BPF_PROG_TYPE_KPROBE),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_prog);
+	}
+	if (test__start_subtest("obj_priv_btf_fail")) {
+		struct bpffs_opts opts =3D {
+			/* disallow BTF loading */
+			.cmds =3D bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_btf_fail);
+	}
+	if (test__start_subtest("obj_priv_btf_success")) {
+		struct bpffs_opts opts =3D {
+			/* allow BTF loading */
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_btf_success);
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/priv_map.c b/tools/testing=
/selftests/bpf/progs/priv_map.c
new file mode 100644
index 000000000000..9085be50f03b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_map.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u32);
+} priv_map SEC(".maps");
diff --git a/tools/testing/selftests/bpf/progs/priv_prog.c b/tools/testin=
g/selftests/bpf/progs/priv_prog.c
new file mode 100644
index 000000000000..3c7b2b618c8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_prog.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("kprobe")
+int kprobe_prog(void *ctx)
+{
+	return 1;
+}
--=20
2.34.1


