Return-Path: <bpf+bounces-1053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB29070CEAF
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 01:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E381C20BC1
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929217731;
	Mon, 22 May 2023 23:32:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D322174FD
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 23:32:18 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA5109
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 16:32:15 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MMl2rp019281
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 16:32:14 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpur5yea7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 16:32:14 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:32:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 55A77312BC0C1; Mon, 22 May 2023 16:29:27 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests
Date: Mon, 22 May 2023 16:29:17 -0700
Message-ID: <20230522232917.2454595-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522232917.2454595-1-andrii@kernel.org>
References: <20230522232917.2454595-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4NBR8JOAkDHw6MMSZZUfmSJqtB2JgL7p
X-Proofpoint-ORIG-GUID: 4NBR8JOAkDHw6MMSZZUfmSJqtB2JgL7p
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest demonstrating using detach-mounted BPF FS using new mount
APIs, and pinning and getting BPF map using such mount. This
demonstrates how something like container manager could setup BPF FS,
pin and adjust all the necessary objects in it, all before exposing BPF
FS to a particular mount namespace.

Also add a few subtests validating all meaningful combinations of
path_fd and pathname. We use mounted /sys/fs/bpf location for these.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_obj_pinning.c          | 268 ++++++++++++++++++
 1 file changed, 268 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
new file mode 100644
index 000000000000..31f1e815f671
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/unistd.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+
+static inline int sys_fsopen(const char *fsname, unsigned flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key, c=
onst void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
+{
+	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
+}
+
+__attribute__((unused))
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+			         int to_dfd, const char *to_path,
+			         unsigned int ms_flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, ms_=
flags);
+}
+
+static void bpf_obj_pinning_detached(void)
+{
+	LIBBPF_OPTS(bpf_obj_pin_opts, pin_opts);
+	LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
+	int fs_fd =3D -1, mnt_fd =3D -1;
+	int map_fd =3D -1, map_fd2 =3D -1;
+	int zero =3D 0, src_value, dst_value, err;
+	const char *map_name =3D "fsmount_map";
+
+	/* A bunch of below UAPI calls are constructed based on reading:
+	 * https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
+	 */
+
+	/* create VFS context */
+	fs_fd =3D sys_fsopen("bpf", 0);
+	if (!ASSERT_GE(fs_fd, 0, "fs_fd"))
+		goto cleanup;
+
+	/* instantiate FS object */
+	err =3D sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (!ASSERT_OK(err, "fs_create"))
+		goto cleanup;
+
+	/* create O_PATH fd for detached mount */
+	mnt_fd =3D sys_fsmount(fs_fd, 0, 0);
+	if (!ASSERT_GE(mnt_fd, 0, "mnt_fd"))
+		goto cleanup;
+
+	/* If we wanted to expose detached mount in the file system, we'd do
+	 * something like below. But the whole point is that we actually don't
+	 * even have to expose BPF FS in the file system to be able to work
+	 * (pin/get objects) with it.
+	 *
+	 * err =3D sys_move_mount(mnt_fd, "", -EBADF, mnt_path, MOVE_MOUNT_F_EMPT=
Y_PATH);
+	 * if (!ASSERT_OK(err, "move_mount"))
+	 *	goto cleanup;
+	 */
+
+	/* create BPF map to pin */
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, map_name, 4, 4, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
+		goto cleanup;
+
+	/* pin BPF map into detached BPF FS through mnt_fd */
+	pin_opts.file_flags =3D BPF_F_PATH_FD;
+	pin_opts.path_fd =3D mnt_fd;
+	err =3D bpf_obj_pin_opts(map_fd, map_name, &pin_opts);
+	if (!ASSERT_OK(err, "map_pin"))
+		goto cleanup;
+
+	/* get BPF map from detached BPF FS through mnt_fd */
+	get_opts.file_flags =3D BPF_F_PATH_FD;
+	get_opts.path_fd =3D mnt_fd;
+	map_fd2 =3D bpf_obj_get_opts(map_name, &get_opts);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* update map through one FD */
+	src_value =3D 0xcafebeef;
+	err =3D bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value =3D 0;
+	err =3D bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq1");
+	ASSERT_EQ(dst_value, 0xcafebeef, "map_value_eq2");
+
+cleanup:
+	if (map_fd >=3D 0)
+		ASSERT_OK(close(map_fd), "close_map_fd");
+	if (map_fd2 >=3D 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	if (fs_fd >=3D 0)
+		ASSERT_OK(close(fs_fd), "close_fs_fd");
+	if (mnt_fd >=3D 0)
+		ASSERT_OK(close(mnt_fd), "close_mnt_fd");
+}
+
+enum path_kind
+{
+	PATH_STR_ABS,
+	PATH_STR_REL,
+	PATH_FD_REL,
+};
+
+static void validate_pin(int map_fd, const char *map_name, int src_value,
+			 enum path_kind path_kind)
+{
+	LIBBPF_OPTS(bpf_obj_pin_opts, pin_opts);
+	char abs_path[PATH_MAX], old_cwd[PATH_MAX];
+	const char *pin_path =3D NULL;
+	int zero =3D 0, dst_value, map_fd2, err;
+
+	snprintf(abs_path, sizeof(abs_path), "/sys/fs/bpf/%s", map_name);
+	old_cwd[0] =3D '\0';
+
+	switch (path_kind) {
+	case PATH_STR_ABS:
+		/* absolute path */
+		pin_path =3D abs_path;
+		break;
+	case PATH_STR_REL:
+		/* cwd + relative path */
+		ASSERT_OK_PTR(getcwd(old_cwd, sizeof(old_cwd)), "getcwd");
+		ASSERT_OK(chdir("/sys/fs/bpf"), "chdir");
+		pin_path =3D map_name;
+		break;
+	case PATH_FD_REL:
+		/* dir fd + relative path */
+		pin_opts.file_flags =3D BPF_F_PATH_FD;
+		pin_opts.path_fd =3D open("/sys/fs/bpf", O_PATH);
+		ASSERT_GE(pin_opts.path_fd, 0, "path_fd");
+		pin_path =3D map_name;
+		break;
+	}
+
+	/* pin BPF map using specified path definition */
+	err =3D bpf_obj_pin_opts(map_fd, pin_path, &pin_opts);
+	ASSERT_OK(err, "obj_pin");
+
+	/* cleanup */
+	if (pin_opts.path_fd >=3D 0)
+		close(pin_opts.path_fd);
+	if (old_cwd[0])
+		ASSERT_OK(chdir(old_cwd), "restore_cwd");
+
+	map_fd2 =3D bpf_obj_get(abs_path);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* update map through one FD */
+	err =3D bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value =3D 0;
+	err =3D bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq");
+cleanup:
+	if (map_fd2 >=3D 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	unlink(abs_path);
+}
+
+static void validate_get(int map_fd, const char *map_name, int src_value,
+			 enum path_kind path_kind)
+{
+	LIBBPF_OPTS(bpf_obj_get_opts, get_opts);
+	char abs_path[PATH_MAX], old_cwd[PATH_MAX];
+	const char *pin_path =3D NULL;
+	int zero =3D 0, dst_value, map_fd2, err;
+
+	snprintf(abs_path, sizeof(abs_path), "/sys/fs/bpf/%s", map_name);
+	/* pin BPF map using specified path definition */
+	err =3D bpf_obj_pin(map_fd, abs_path);
+	if (!ASSERT_OK(err, "pin_map"))
+		return;
+
+	old_cwd[0] =3D '\0';
+
+	switch (path_kind) {
+	case PATH_STR_ABS:
+		/* absolute path */
+		pin_path =3D abs_path;
+		break;
+	case PATH_STR_REL:
+		/* cwd + relative path */
+		ASSERT_OK_PTR(getcwd(old_cwd, sizeof(old_cwd)), "getcwd");
+		ASSERT_OK(chdir("/sys/fs/bpf"), "chdir");
+		pin_path =3D map_name;
+		break;
+	case PATH_FD_REL:
+		/* dir fd + relative path */
+		get_opts.file_flags =3D BPF_F_PATH_FD;
+		get_opts.path_fd =3D open("/sys/fs/bpf", O_PATH);
+		ASSERT_GE(get_opts.path_fd, 0, "path_fd");
+		pin_path =3D map_name;
+		break;
+	}
+
+	map_fd2 =3D bpf_obj_get_opts(pin_path, &get_opts);
+	if (!ASSERT_GE(map_fd2, 0, "map_get"))
+		goto cleanup;
+
+	/* cleanup */
+	if (get_opts.path_fd >=3D 0)
+		close(get_opts.path_fd);
+	if (old_cwd[0])
+		ASSERT_OK(chdir(old_cwd), "restore_cwd");
+
+	/* update map through one FD */
+	err =3D bpf_map_update_elem(map_fd, &zero, &src_value, 0);
+	ASSERT_OK(err, "map_update");
+
+	/* check values written/read through different FDs do match */
+	dst_value =3D 0;
+	err =3D bpf_map_lookup_elem(map_fd2, &zero, &dst_value);
+	ASSERT_OK(err, "map_lookup");
+	ASSERT_EQ(dst_value, src_value, "map_value_eq");
+cleanup:
+	if (map_fd2 >=3D 0)
+		ASSERT_OK(close(map_fd2), "close_map_fd2");
+	unlink(abs_path);
+}
+
+static void bpf_obj_pinning_mounted(enum path_kind path_kind)
+{
+	const char *map_name =3D "mounted_map";
+	int map_fd;
+
+	/* create BPF map to pin */
+	map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, map_name, 4, 4, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
+		return;
+
+	validate_pin(map_fd, map_name, 100 + (int)path_kind, path_kind);
+	validate_get(map_fd, map_name, 200 + (int)path_kind, path_kind);
+	ASSERT_OK(close(map_fd), "close_map_fd");
+}
+
+void test_bpf_obj_pinning()
+{
+	if (test__start_subtest("detached"))
+		bpf_obj_pinning_detached();
+	if (test__start_subtest("mounted-str-abs"))
+		bpf_obj_pinning_mounted(PATH_STR_ABS);
+	if (test__start_subtest("mounted-str-rel"))
+		bpf_obj_pinning_mounted(PATH_STR_REL);
+	if (test__start_subtest("mounted-fd-rel"))
+		bpf_obj_pinning_mounted(PATH_FD_REL);
+}
--=20
2.34.1


