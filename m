Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E64608226
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJUXpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUXo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:44:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164675A8F4
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:56 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LMHluu002507
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/Br7dXNk1OysbH1v0hVWjTAtPPAPbEcjWKvJ2ynHgoM=;
 b=Kt7Nm9h5pT7PH0e+aGart1joSUnGYCyUZPofh0KgVj1cR4XDPDslaXGKH5AYVfZRZhy0
 JGhDPUb/tvH5a0Ic961ln9LD76vkHPxhmAylIJyu90w8aF8AKC0/C8P0QjNV3C/vRP5O
 MPB0hg6nBcGkbfhSBLIwe7kXq/4dKV4SvTc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kbytwujuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:56 -0700
Received: from twshared17038.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:44:55 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 653F211011355; Fri, 21 Oct 2022 16:44:48 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: Add selftests for cgroup local storage
Date:   Fri, 21 Oct 2022 16:44:48 -0700
Message-ID: <20221021234448.2334234-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021234416.2328241-1-yhs@fb.com>
References: <20221021234416.2328241-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fUbEJ5IBPhdA9c2I3CEjdaNux3x6F-Yl
X-Proofpoint-ORIG-GUID: fUbEJ5IBPhdA9c2I3CEjdaNux3x6F-Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests for cgroup local storage, one to test bpf program helpers
and user space map APIs, and the other to test recursive fentry
triggering won't deadlock.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/cgroup_local_storage.c     | 92 +++++++++++++++++++
 .../bpf/progs/cgroup_local_storage.c          | 88 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_ls_recursion.c | 70 ++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_local_s=
torage.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_local_storag=
e.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_ls_recursion=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_local_storage.=
c b/tools/testing/selftests/bpf/prog_tests/cgroup_local_storage.c
new file mode 100644
index 000000000000..69b1abda0d42
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_local_storage.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <test_progs.h>
+#include "cgroup_local_storage.skel.h"
+#include "cgroup_ls_recursion.skel.h"
+
+static void test_sys_enter_exit(int cgroup_fd)
+{
+	struct cgroup_local_storage *skel;
+	long val1 =3D 1, val2 =3D 0;
+	int err;
+
+	skel =3D cgroup_local_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* populate a value in cgrp_storage_2 */
+	err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cg=
roup_fd, &val1, BPF_ANY);
+	if (!ASSERT_OK(err, "map_update_elem"))
+		goto out;
+
+	/* check value */
+	err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cg=
roup_fd, &val2);
+	if (!ASSERT_OK(err, "map_lookup_elem"))
+		goto out;
+	if (!ASSERT_EQ(val2, 1, "map_lookup_elem, invalid val"))
+		goto out;
+
+	/* delete value */
+	err =3D bpf_map_delete_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cg=
roup_fd);
+	if (!ASSERT_OK(err, "map_delete_elem"))
+		goto out;
+
+	skel->bss->target_pid =3D syscall(SYS_gettid);
+
+	err =3D cgroup_local_storage__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	syscall(SYS_gettid);
+	syscall(SYS_gettid);
+
+	skel->bss->target_pid =3D 0;
+
+	/* 3x syscalls: 1x attach and 2x gettid */
+	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
+	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
+	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
+out:
+	cgroup_local_storage__destroy(skel);
+}
+
+static void test_recursion(int cgroup_fd)
+{
+	struct cgroup_ls_recursion *skel;
+	int err;
+
+	skel =3D cgroup_ls_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err =3D cgroup_ls_recursion__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	/* trigger sys_enter, make sure it does not cause deadlock */
+	syscall(SYS_gettid);
+
+out:
+	cgroup_ls_recursion__destroy(skel);
+}
+
+void test_cgroup_local_storage(void)
+{
+	int cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/cgroup_local_storage");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgroup_local_storage"))
+		return;
+
+	if (test__start_subtest("sys_enter_exit"))
+		test_sys_enter_exit(cgroup_fd);
+	if (test__start_subtest("recursion"))
+		test_recursion(cgroup_fd);
+
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_local_storage.c b/t=
ools/testing/selftests/bpf/progs/cgroup_local_storage.c
new file mode 100644
index 000000000000..dee63d4c1512
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_local_storage.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} cgrp_storage_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} cgrp_storage_2 SEC(".maps");
+
+#define MAGIC_VALUE 0xabcd1234
+
+pid_t target_pid =3D 0;
+int mismatch_cnt =3D 0;
+int enter_cnt =3D 0;
+int exit_cnt =3D 0;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+	int err;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	/* populate value 0 */
+	ptr =3D bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, =
0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	/* delete value 0 */
+	err =3D bpf_cgrp_storage_delete(&cgrp_storage_1, task->cgroups->dfl_cgr=
p);
+	if (err)
+		return 0;
+
+	/* value is not available */
+	ptr =3D bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, =
0, 0);
+	if (ptr)
+		return 0;
+
+	/* re-populate the value */
+	ptr =3D bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, =
0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+	__sync_fetch_and_add(&enter_cnt, 1);
+	*ptr =3D MAGIC_VALUE + enter_cnt;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_exit")
+int BPF_PROG(on_exit, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	ptr =3D bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, =
0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	__sync_fetch_and_add(&exit_cnt, 1);
+	if (*ptr !=3D MAGIC_VALUE + exit_cnt)
+		__sync_fetch_and_add(&mismatch_cnt, 1);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_ls_recursion.c b/to=
ols/testing/selftests/bpf/progs/cgroup_ls_recursion.c
new file mode 100644
index 000000000000..a043d8fefdac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_ls_recursion.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_a SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} map_b SEC(".maps");
+
+SEC("fentry/bpf_local_storage_lookup")
+int BPF_PROG(on_lookup)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
+	bpf_cgrp_storage_delete(&map_b, task->cgroups->dfl_cgrp);
+	return 0;
+}
+
+SEC("fentry/bpf_local_storage_update")
+int BPF_PROG(on_update)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	long *ptr;
+
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	ptr =3D bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr +=3D 1;
+
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	ptr =3D bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 200;
+
+	ptr =3D bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		*ptr =3D 100;
+	return 0;
+}
--=20
2.30.2

