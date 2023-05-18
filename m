Return-Path: <bpf+bounces-920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D0708AD5
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A874B1C20EB8
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F4271E0;
	Thu, 18 May 2023 21:55:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5424E89
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 21:55:05 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E2E7A
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGAMlB019063
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:01 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qnqa228mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:01 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 14:55:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 005DE30EEE4D6; Thu, 18 May 2023 14:54:51 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests
Date: Thu, 18 May 2023 14:54:44 -0700
Message-ID: <20230518215444.1418789-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518215444.1418789-1-andrii@kernel.org>
References: <20230518215444.1418789-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MqM_vMQ-xbyTYLNgXZMv0MfL_UIjyNhx
X-Proofpoint-ORIG-GUID: MqM_vMQ-xbyTYLNgXZMv0MfL_UIjyNhx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
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

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_obj_pinning.c          | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
new file mode 100644
index 000000000000..a5f6063198aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
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
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+			         int to_dfd, const char *to_path,
+			         unsigned int ms_flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, ms_=
flags);
+}
+
+void test_bpf_obj_pinning(void)
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
--=20
2.34.1


