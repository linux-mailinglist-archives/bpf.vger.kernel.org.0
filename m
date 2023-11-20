Return-Path: <bpf+bounces-15384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D87F1BD4
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871DF1F258E4
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8B2FE30;
	Mon, 20 Nov 2023 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P/fZbGXa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73888A7
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:46 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHISVg028898
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MuKNvY+3BFWilUxwi5FUjN5PsKRQh5qRi2vksgVHt1s=;
 b=P/fZbGXaIcgHAlLjW9GO8TMSayZQ51NP++NHqIztSwGc99tzBXZjf7aCHBciKX/Id23w
 p8f8KyRmpdOBrTqypy/R3JFy8lRPPzjavGltkvUDgnexHLN9WKJRyz/xlzlLSwa5xXeO
 4GVtfKL2woSqxPnkG+5qH7b050ictH2yalc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ug57uay7k-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:46 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:59:41 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id E4E832792C101; Mon, 20 Nov 2023 09:59:27 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner
	<hannes@cmpxchg.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/2] selftests/bpf: Add test exercising mmapable task_local_storage
Date: Mon, 20 Nov 2023 09:59:25 -0800
Message-ID: <20231120175925.733167-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120175925.733167-1-davemarchevsky@fb.com>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fh6OZgbw0NKLl3vslVcZwVeTHKPOW14o
X-Proofpoint-GUID: fh6OZgbw0NKLl3vslVcZwVeTHKPOW14o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_18,2023-11-20_01,2023-05-22_02

This patch tests mmapable task_local storage functionality added earlier
in the series. The success tests focus on verifying correctness of the
various ways of reading from and writing to mmapable task_local storage:

  * Write through mmap'd region should be visible when BPF program
    makes bpf_task_storage_get call
  * If BPF program reads-and-incrs the mapval, the new value should be
    visible when userspace reads from mmap'd region or does
    map_lookup_elem call
  * If userspace does map_update_elem call, new value should be visible
    when userspace reads from mmap'd region or does map_lookup_elem
    call
  * After bpf_map_delete_elem, reading from mmap'd region should still
    succeed, but map_lookup_elem w/o BPF_LOCAL_STORAGE_GET_F_CREATE flag
    should fail
  * After bpf_map_delete_elem, creating a new map_val via mmap call
    should return a different memory region

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 177 ++++++++++++++++++
 .../bpf/progs/task_local_storage__mmap.c      |  59 ++++++
 .../bpf/progs/task_local_storage__mmap.h      |   7 +
 .../bpf/progs/task_local_storage__mmap_fail.c |  39 ++++
 4 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index ea8537c54413..08c589a12bd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -5,14 +5,19 @@
 #include <unistd.h>
 #include <sched.h>
 #include <pthread.h>
+#include <sys/mman.h>   /* For mmap and associated flags */
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
+#include <network_helpers.h>
 #include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
+#include "task_local_storage__mmap.skel.h"
+#include "task_local_storage__mmap_fail.skel.h"
 #include "task_ls_recursion.skel.h"
 #include "task_storage_nodeadlock.skel.h"
+#include "progs/task_local_storage__mmap.h"
=20
 static void test_sys_enter_exit(void)
 {
@@ -40,6 +45,173 @@ static void test_sys_enter_exit(void)
 	task_local_storage__destroy(skel);
 }
=20
+static int basic_mmapable_read_write(struct task_local_storage__mmap *sk=
el,
+				     long *mmaped_task_local)
+{
+	int err;
+
+	*mmaped_task_local =3D 42;
+
+	err =3D task_local_storage__mmap__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		return -1;
+
+	syscall(SYS_gettid);
+	ASSERT_EQ(skel->bss->mmaped_mapval, 42, "mmaped_mapval");
+
+	/* Incr from userspace should be visible when BPF prog reads */
+	*mmaped_task_local =3D *mmaped_task_local + 1;
+	syscall(SYS_gettid);
+	ASSERT_EQ(skel->bss->mmaped_mapval, 43, "mmaped_mapval_user_incr");
+
+	/* Incr from BPF prog should be visible from userspace */
+	skel->bss->read_and_incr =3D 1;
+	syscall(SYS_gettid);
+	ASSERT_EQ(skel->bss->mmaped_mapval, 44, "mmaped_mapval_bpf_incr");
+	ASSERT_EQ(skel->bss->mmaped_mapval, *mmaped_task_local, "bpf_incr_eq");
+	skel->bss->read_and_incr =3D 0;
+
+	return 0;
+}
+
+static void test_sys_enter_mmap(void)
+{
+	struct task_local_storage__mmap *skel;
+	long *task_local, *task_local2, value;
+	int err, task_fd, map_fd;
+
+	task_local =3D task_local2 =3D (long *)-1;
+	task_fd =3D sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
+		return;
+
+	skel =3D task_local_storage__mmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
+		close(task_fd);
+		return;
+	}
+
+	map_fd =3D bpf_map__fd(skel->maps.mmapable);
+	task_local =3D mmap(NULL, sizeof(long), PROT_READ | PROT_WRITE,
+			  MAP_SHARED, map_fd, 0);
+	if (!ASSERT_OK_PTR(task_local, "mmap_task_local_storage"))
+		goto out;
+
+	err =3D basic_mmapable_read_write(skel, task_local);
+	if (!ASSERT_OK(err, "basic_mmapable_read_write"))
+		goto out;
+
+	err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem") ||
+	    !ASSERT_EQ(value, 44, "bpf_map_lookup_elem value"))
+		goto out;
+
+	value =3D 148;
+	bpf_map_update_elem(map_fd, &task_fd, &value, BPF_EXIST);
+	if (!ASSERT_EQ(READ_ONCE(*task_local), 148, "mmaped_read_after_update")=
)
+		goto out;
+
+	err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem") ||
+	    !ASSERT_EQ(value, 148, "bpf_map_lookup_elem value"))
+		goto out;
+
+	/* The mmapable page is not released by map_delete_elem, but no longer
+	 * linked to local_storage
+	 */
+	err =3D bpf_map_delete_elem(map_fd, &task_fd);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem") ||
+	    !ASSERT_EQ(READ_ONCE(*task_local), 148, "mmaped_read_after_delete")=
)
+		goto out;
+
+	err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	if (!ASSERT_EQ(err, -ENOENT, "bpf_map_lookup_elem_after_delete"))
+		goto out;
+
+	task_local_storage__mmap__destroy(skel);
+
+	/* The mmapable page is not released when __destroy unloads the map.
+	 * It will stick around until we munmap it
+	 */
+	*task_local =3D -999;
+
+	/* Although task_local's page is still around, it won't be reused */
+	skel =3D task_local_storage__mmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load2"))
+		return;
+
+	map_fd =3D bpf_map__fd(skel->maps.mmapable);
+	err =3D task_local_storage__mmap__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach2"))
+		goto out;
+
+	skel->bss->read_and_incr =3D 1;
+	skel->bss->create_flag =3D BPF_LOCAL_STORAGE_GET_F_CREATE;
+	syscall(SYS_gettid);
+	ASSERT_EQ(skel->bss->mmaped_mapval, 1, "mmaped_mapval2");
+
+	skel->bss->read_and_incr =3D 0;
+	task_local2 =3D mmap(NULL, sizeof(long), PROT_READ | PROT_WRITE,
+			   MAP_SHARED, map_fd, 0);
+	if (!ASSERT_OK_PTR(task_local, "mmap_task_local_storage2"))
+		goto out;
+
+	if (!ASSERT_NEQ(task_local, task_local2, "second_mmap_address"))
+		goto out;
+
+	ASSERT_EQ(READ_ONCE(*task_local2), 1, "mmaped_mapval2_bpf_create_incr")=
;
+
+out:
+	close(task_fd);
+	if (task_local > 0)
+		munmap(task_local, sizeof(long));
+	if (task_local2 > 0)
+		munmap(task_local2, sizeof(long));
+	task_local_storage__mmap__destroy(skel);
+}
+
+static void test_sys_enter_mmap_big_mapval(void)
+{
+	struct two_page_struct *task_local, value;
+	struct task_local_storage__mmap *skel;
+	int task_fd, map_fd, err;
+
+	task_local =3D (struct two_page_struct *)-1;
+	task_fd =3D sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_NEQ(task_fd, -1, "sys_pidfd_open"))
+		return;
+
+	skel =3D task_local_storage__mmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
+		close(task_fd);
+		return;
+	}
+	map_fd =3D bpf_map__fd(skel->maps.mmapable_two_pages);
+	task_local =3D mmap(NULL, sizeof(struct two_page_struct),
+			  PROT_READ | PROT_WRITE, MAP_SHARED,
+			  map_fd, 0);
+	if (!ASSERT_OK_PTR(task_local, "mmap_task_local_storage"))
+		goto out;
+
+	skel->bss->use_big_mapval =3D 1;
+	err =3D basic_mmapable_read_write(skel, &task_local->val);
+	if (!ASSERT_OK(err, "basic_mmapable_read_write"))
+		goto out;
+
+	task_local->c[4096] =3D 'z';
+
+	err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem") ||
+	    !ASSERT_EQ(value.val, 44, "bpf_map_lookup_elem value"))
+		goto out;
+
+out:
+	close(task_fd);
+	if (task_local > 0)
+		munmap(task_local, sizeof(struct two_page_struct));
+	task_local_storage__mmap__destroy(skel);
+}
+
 static void test_exit_creds(void)
 {
 	struct task_local_storage_exit_creds *skel;
@@ -237,10 +409,15 @@ void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
 		test_sys_enter_exit();
+	if (test__start_subtest("sys_enter_mmap"))
+		test_sys_enter_mmap();
+	if (test__start_subtest("sys_enter_mmap_big_mapval"))
+		test_sys_enter_mmap_big_mapval();
 	if (test__start_subtest("exit_creds"))
 		test_exit_creds();
 	if (test__start_subtest("recursion"))
 		test_recursion();
 	if (test__start_subtest("nodeadlock"))
 		test_nodeadlock();
+	RUN_TESTS(task_local_storage__mmap_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c=
 b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c
new file mode 100644
index 000000000000..1c8850c8d189
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "task_local_storage__mmap.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
+	__type(key, int);
+	__type(value, long);
+} mmapable SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
+	__type(key, int);
+	__type(value, struct two_page_struct);
+} mmapable_two_pages SEC(".maps");
+
+long mmaped_mapval =3D 0;
+int read_and_incr =3D 0;
+int create_flag =3D 0;
+int use_big_mapval =3D 0;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct two_page_struct *big_mapval;
+	struct task_struct *task;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	if (!task)
+		return 1;
+
+	if (use_big_mapval) {
+		big_mapval =3D bpf_task_storage_get(&mmapable_two_pages, task, 0,
+						  create_flag);
+		if (!big_mapval)
+			return 2;
+		ptr =3D &big_mapval->val;
+	} else {
+		ptr =3D bpf_task_storage_get(&mmapable, task, 0, create_flag);
+	}
+
+	if (!ptr)
+		return 3;
+
+	if (read_and_incr)
+		*ptr =3D *ptr + 1;
+
+	mmaped_mapval =3D *ptr;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h=
 b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h
new file mode 100644
index 000000000000..f4a3264142c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+struct two_page_struct {
+	long val;
+	char c[4097];
+};
diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap_f=
ail.c b/tools/testing/selftests/bpf/progs/task_local_storage__mmap_fail.c
new file mode 100644
index 000000000000..f32c5bfe370a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap_fail.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
+	__type(key, int);
+	__type(value, long);
+} mmapable SEC(".maps");
+
+__failure __msg("invalid access to map value, value_size=3D8 off=3D8 siz=
e=3D8")
+SEC("tp_btf/sys_enter")
+long BPF_PROG(fail_read_past_mapval_end, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	long *ptr;
+	long res;
+
+	task =3D bpf_get_current_task_btf();
+	if (!task)
+		return 1;
+
+	ptr =3D bpf_task_storage_get(&mmapable, task, 0, 0);
+	if (!ptr)
+		return 3;
+	/* Although mmapable mapval is given an entire page, verifier shouldn't
+	 * allow r/w past end of 'long' type
+	 */
+	res =3D *(ptr + 1);
+
+	return res;
+}
--=20
2.34.1


