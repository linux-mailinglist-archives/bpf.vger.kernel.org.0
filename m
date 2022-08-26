Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6219E5A1DB9
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 02:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiHZAiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHZAiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 20:38:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2AC7F91
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PM4BPK020179
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZiAAsl4SRHINxzN5VaAnOzsWvdiflC3xHaeBOV5mIug=;
 b=Q3ZbArY2cjOlkGGiP+PmafEFYpLhJO60XZXLUlf5sETgOQiP36LRE0Ff5VlggsrkxDeE
 BhoBufb77lGuf9cbguVLkR00GSqa3+8IeHdFm2lNyWCrBkhxwb4Cnbikf/Gzmy36ftnT
 G49g7Qf7f0EYiZjghcKaCVuDwo2rAi3IarM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j69jtmrs8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:07 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 17:38:05 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A5AF671E4B94; Thu, 25 Aug 2022 17:37:53 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Test parameterized task BPF iterators.
Date:   Thu, 25 Aug 2022 17:37:11 -0700
Message-ID: <20220826003712.2810158-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826003712.2810158-1-kuifeng@fb.com>
References: <20220826003712.2810158-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1xqbQ-uZo2U6WI7OQQomYvvTIUceaYn7
X-Proofpoint-ORIG-GUID: 1xqbQ-uZo2U6WI7OQQomYvvTIUceaYn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test iterators of vma, files, and tasks of tasks.

Ensure the API works appropriately to visit all tasks,
tasks in a process, or a particular task.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-
 .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
 6 files changed, 322 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index e89685bd587c..00f8ed1091a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #include <test_progs.h>
+#include <unistd.h>
+#include <sys/syscall.h>
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
@@ -14,6 +16,7 @@
 #include "bpf_iter_udp4.skel.h"
 #include "bpf_iter_udp6.skel.h"
 #include "bpf_iter_unix.skel.h"
+#include "bpf_iter_vma_offset.skel.h"
 #include "bpf_iter_test_kern1.skel.h"
 #include "bpf_iter_test_kern2.skel.h"
 #include "bpf_iter_test_kern3.skel.h"
@@ -43,13 +46,13 @@ static void test_btf_id_or_null(void)
 	}
 }
=20
-static void do_dummy_read(struct bpf_program *prog)
+static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter=
_attach_opts *opts)
 {
 	struct bpf_link *link;
 	char buf[16] =3D {};
 	int iter_fd, len;
=20
-	link =3D bpf_program__attach_iter(prog, NULL);
+	link =3D bpf_program__attach_iter(prog, opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		return;
=20
@@ -68,6 +71,11 @@ static void do_dummy_read(struct bpf_program *prog)
 	bpf_link__destroy(link);
 }
=20
+static void do_dummy_read(struct bpf_program *prog)
+{
+	do_dummy_read_opts(prog, NULL);
+}
+
 static void do_read_map_iter_fd(struct bpf_object_skeleton **skel, struc=
t bpf_program *prog,
 				struct bpf_map *map)
 {
@@ -167,19 +175,140 @@ static void test_bpf_map(void)
 	bpf_iter_bpf_map__destroy(skel);
 }
=20
-static void test_task(void)
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+static void check_bpf_link_info(const struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link_info info =3D {};
+	struct bpf_link *link;
+	__u32 info_len;
+	int err;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	link =3D bpf_program__attach_iter(prog, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	info_len =3D sizeof(info);
+	err =3D bpf_obj_get_info_by_fd(bpf_link__fd(link), &info, &info_len);
+	ASSERT_OK(err, "bpf_obj_get_info_by_fd");
+	ASSERT_EQ(info.iter.task.tid, getpid(), "check_task_tid");
+
+	bpf_link__destroy(link);
+}
+
+static pthread_mutex_t do_nothing_mutex;
+
+static void *do_nothing_wait(void *arg)
+{
+	pthread_mutex_lock(&do_nothing_mutex);
+	pthread_mutex_unlock(&do_nothing_mutex);
+
+	pthread_exit(arg);
+}
+
+static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
+				     int *num_unknown, int *num_known)
 {
 	struct bpf_iter_task *skel;
+	pthread_t thread_id;
+	void *ret;
=20
 	skel =3D bpf_iter_task__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_task);
+	ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock");
+
+	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
+		  "pthread_create");
+
+	skel->bss->tid =3D getpid();
+
+	do_dummy_read_opts(skel->progs.dump_task, opts);
+
+	*num_unknown =3D skel->bss->num_unknown_tid;
+	*num_known =3D skel->bss->num_known_tid;
+
+	ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unloc=
k");
+	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
+		     "pthread_join");
=20
 	bpf_iter_task__destroy(skel);
 }
=20
+static void test_task_common(struct bpf_iter_attach_opts *opts, int num_=
unknown, int num_known)
+{
+	int num_unknown_tid, num_known_tid;
+
+	test_task_common_nocheck(opts, &num_unknown_tid, &num_known_tid);
+	ASSERT_EQ(num_unknown_tid, num_unknown, "check_num_unknown_tid");
+	ASSERT_EQ(num_known_tid, num_known, "check_num_known_tid");
+}
+
+static void test_task_tid(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int num_unknown_tid, num_known_tid;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+	test_task_common(&opts, 0, 1);
+
+	linfo.task.tid =3D 0;
+	linfo.task.pid =3D getpid();
+	test_task_common(&opts, 1, 1);
+
+	test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
+	ASSERT_GT(num_unknown_tid, 1, "check_num_unknown_tid");
+	ASSERT_EQ(num_known_tid, 1, "check_num_known_tid");
+}
+
+static void test_task_pid(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.pid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_common(&opts, 1, 1);
+}
+
+static void test_task_pidfd(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int pidfd;
+
+	pidfd =3D pidfd_open(getpid(), 0);
+	if (!ASSERT_GT(pidfd, 0, "pidfd_open"))
+		return;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.pid_fd =3D pidfd;
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_common(&opts, 1, 1);
+
+	close(pidfd);
+}
+
 static void test_task_sleepable(void)
 {
 	struct bpf_iter_task *skel;
@@ -212,14 +341,11 @@ static void test_task_stack(void)
 	bpf_iter_task_stack__destroy(skel);
 }
=20
-static void *do_nothing(void *arg)
-{
-	pthread_exit(arg);
-}
-
 static void test_task_file(void)
 {
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_task_file *skel;
+	union bpf_iter_link_info linfo;
 	pthread_t thread_id;
 	void *ret;
=20
@@ -229,19 +355,36 @@ static void test_task_file(void)
=20
 	skel->bss->tgid =3D getpid();
=20
-	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
-		  "pthread_create"))
-		goto done;
+	ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock");
=20
-	do_dummy_read(skel->progs.dump_task_file);
+	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
+		  "pthread_create");
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
=20
-	if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
-		  "pthread_join"))
-		goto done;
+	do_dummy_read_opts(skel->progs.dump_task_file, &opts);
=20
 	ASSERT_EQ(skel->bss->count, 0, "check_count");
+	ASSERT_EQ(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
+
+	skel->bss->last_tgid =3D 0;
+	skel->bss->count =3D 0;
+	skel->bss->unique_tgid_count =3D 0;
+
+	do_dummy_read(skel->progs.dump_task_file);
+
+	ASSERT_EQ(skel->bss->count, 0, "check_count");
+	ASSERT_GT(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
+
+	check_bpf_link_info(skel->progs.dump_task_file);
+
+	ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unloc=
k");
+	ASSERT_OK(pthread_join(thread_id, &ret), "pthread_join");
+	ASSERT_NULL(ret, "phtread_join");
=20
-done:
 	bpf_iter_task_file__destroy(skel);
 }
=20
@@ -1249,7 +1392,7 @@ static void str_strip_first_line(char *str)
 	*dst =3D '\0';
 }
=20
-static void test_task_vma(void)
+static void test_task_vma_common(struct bpf_iter_attach_opts *opts)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
 	struct bpf_iter_task_vma *skel;
@@ -1261,13 +1404,14 @@ static void test_task_vma(void)
 		return;
=20
 	skel->bss->pid =3D getpid();
+	skel->bss->one_task =3D opts ? 1 : 0;
=20
 	err =3D bpf_iter_task_vma__load(skel);
 	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
 		goto out;
=20
 	skel->links.proc_maps =3D bpf_program__attach_iter(
-		skel->progs.proc_maps, NULL);
+		skel->progs.proc_maps, opts);
=20
 	if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) =
{
 		skel->links.proc_maps =3D NULL;
@@ -1291,6 +1435,8 @@ static void test_task_vma(void)
 			goto out;
 		len +=3D err;
 	}
+	if (opts)
+		ASSERT_EQ(skel->bss->one_task_error, 0, "unexpected task");
=20
 	/* read CMP_BUFFER_SIZE (1kB) from /proc/pid/maps */
 	snprintf(maps_path, 64, "/proc/%u/maps", skel->bss->pid);
@@ -1306,6 +1452,9 @@ static void test_task_vma(void)
 	str_strip_first_line(proc_maps_output);
=20
 	ASSERT_STREQ(task_vma_output, proc_maps_output, "compare_output");
+
+	check_bpf_link_info(skel->progs.proc_maps);
+
 out:
 	close(proc_maps_fd);
 	close(iter_fd);
@@ -1325,8 +1474,93 @@ void test_bpf_sockmap_map_iter_fd(void)
 	bpf_iter_sockmap__destroy(skel);
 }
=20
+static void test_task_vma(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_vma_common(&opts);
+	test_task_vma_common(NULL);
+}
+
+/* uprobe attach point */
+static noinline int trigger_func(int arg)
+{
+	asm volatile ("");
+	return arg + 1;
+}
+
+static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opt=
s, bool one_proc)
+{
+	struct bpf_iter_vma_offset *skel;
+	struct bpf_link *link;
+	char buf[16] =3D {};
+	int iter_fd, len;
+	int pgsz, shift;
+
+	skel =3D bpf_iter_vma_offset__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_vma_offset__open_and_load"))
+		return;
+
+	skel->bss->pid =3D getpid();
+	skel->bss->address =3D (uintptr_t)trigger_func;
+	for (pgsz =3D getpagesize(), shift =3D 0; pgsz; pgsz >>=3D 1, shift++)
+		;
+	skel->bss->page_shift =3D shift;
+
+	link =3D bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return;
+
+	iter_fd =3D bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
+		goto exit;
+
+	while ((len =3D read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	buf[15] =3D 0;
+	ASSERT_EQ(strcmp(buf, "OK\n"), 0, "strcmp");
+
+	ASSERT_EQ(skel->bss->offset, get_uprobe_offset(trigger_func), "offset")=
;
+	if (one_proc)
+		ASSERT_EQ(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
+	else
+		ASSERT_GT(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
+
+	close(iter_fd);
+
+exit:
+	bpf_link__destroy(link);
+}
+
+static void test_task_vma_offset(void)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.pid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_vma_offset_common(&opts, true);
+
+	linfo.task.pid =3D 0;
+	linfo.task.tid =3D getpid();
+	test_task_vma_offset_common(&opts, true);
+
+	test_task_vma_offset_common(NULL, false);
+}
+
 void test_bpf_iter(void)
 {
+	ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_i=
nit");
+
 	if (test__start_subtest("btf_id_or_null"))
 		test_btf_id_or_null();
 	if (test__start_subtest("ipv6_route"))
@@ -1335,8 +1569,12 @@ void test_bpf_iter(void)
 		test_netlink();
 	if (test__start_subtest("bpf_map"))
 		test_bpf_map();
-	if (test__start_subtest("task"))
-		test_task();
+	if (test__start_subtest("task_tid"))
+		test_task_tid();
+	if (test__start_subtest("task_pid"))
+		test_task_pid();
+	if (test__start_subtest("task_pidfd"))
+		test_task_pidfd();
 	if (test__start_subtest("task_sleepable"))
 		test_task_sleepable();
 	if (test__start_subtest("task_stack"))
@@ -1397,4 +1635,6 @@ void test_bpf_iter(void)
 		test_ksym_iter();
 	if (test__start_subtest("bpf_sockmap_map_iter_fd"))
 		test_bpf_sockmap_map_iter_fd();
+	if (test__start_subtest("vma_offset"))
+		test_task_vma_offset();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
index a1bae92be1fc..343e4506c5dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -764,7 +764,7 @@ static void test_btf_dump_struct_data(struct btf *btf=
, struct btf_dump *d,
=20
 	/* union with nested struct */
 	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_=
F_COMPACT,
-			   "(union bpf_iter_link_info){.map =3D (struct){.map_fd =3D (__u32)1=
,},.cgroup =3D (struct){.order =3D (enum bpf_cgroup_iter_order)BPF_ITER_S=
ELF_ONLY,.cgroup_fd =3D (__u32)1,},}",
+			   "(union bpf_iter_link_info){.map =3D (struct){.map_fd =3D (__u32)1=
,},.cgroup =3D (struct){.order =3D (enum bpf_cgroup_iter_order)BPF_ITER_S=
ELF_ONLY,.cgroup_fd =3D (__u32)1,},.task =3D (struct){.tid =3D (__u32)1,.=
pid =3D (__u32)1,},}",
 			   { .cgroup =3D { .order =3D 1, .cgroup_fd =3D 1, }});
=20
 	/* struct skb with nested structs/unions; because type output is so
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_task.c
index d22741272692..96131b9a1caa 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
@@ -6,6 +6,10 @@
=20
 char _license[] SEC("license") =3D "GPL";
=20
+uint32_t tid =3D 0;
+int num_unknown_tid =3D 0;
+int num_known_tid =3D 0;
+
 SEC("iter/task")
 int dump_task(struct bpf_iter__task *ctx)
 {
@@ -18,6 +22,11 @@ int dump_task(struct bpf_iter__task *ctx)
 		return 0;
 	}
=20
+	if (task->pid !=3D tid)
+		num_unknown_tid++;
+	else
+		num_known_tid++;
+
 	if (ctx->meta->seq_num =3D=3D 0)
 		BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
=20
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_task_file.c
index 6e7b400888fe..b0255080662d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -7,14 +7,16 @@ char _license[] SEC("license") =3D "GPL";
=20
 int count =3D 0;
 int tgid =3D 0;
+int last_tgid =3D 0;
+int unique_tgid_count =3D 0;
=20
 SEC("iter/task_file")
 int dump_task_file(struct bpf_iter__task_file *ctx)
 {
 	struct seq_file *seq =3D ctx->meta->seq;
 	struct task_struct *task =3D ctx->task;
-	__u32 fd =3D ctx->fd;
 	struct file *file =3D ctx->file;
+	__u32 fd =3D ctx->fd;
=20
 	if (task =3D=3D (void *)0 || file =3D=3D (void *)0)
 		return 0;
@@ -27,6 +29,11 @@ int dump_task_file(struct bpf_iter__task_file *ctx)
 	if (tgid =3D=3D task->tgid && task->tgid !=3D task->pid)
 		count++;
=20
+	if (last_tgid !=3D task->tgid) {
+		last_tgid =3D task->tgid;
+		unique_tgid_count++;
+	}
+
 	BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
 		       (long)file->f_op);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_task_vma.c
index 4ea6a37d1345..dd923dc637d5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
@@ -20,6 +20,8 @@ char _license[] SEC("license") =3D "GPL";
 #define D_PATH_BUF_SIZE 1024
 char d_path_buf[D_PATH_BUF_SIZE] =3D {};
 __u32 pid =3D 0;
+__u32 one_task =3D 0;
+__u32 one_task_error =3D 0;
=20
 SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
 {
@@ -33,8 +35,11 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__ta=
sk_vma *ctx)
 		return 0;
=20
 	file =3D vma->vm_file;
-	if (task->tgid !=3D pid)
+	if (task->tgid !=3D pid) {
+		if (one_task)
+			one_task_error =3D 1;
 		return 0;
+	}
 	perm_str[0] =3D (vma->vm_flags & VM_READ) ? 'r' : '-';
 	perm_str[1] =3D (vma->vm_flags & VM_WRITE) ? 'w' : '-';
 	perm_str[2] =3D (vma->vm_flags & VM_EXEC) ? 'x' : '-';
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
new file mode 100644
index 000000000000..03db36da5da8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+__u32 unique_tgid_cnt =3D 0;
+uintptr_t address =3D 0;
+uintptr_t offset =3D 0;
+__u32 last_tgid =3D 0;
+__u32 pid =3D 0;
+__u32 page_shift =3D 0;
+
+SEC("iter/task_vma")
+int get_vma_offset(struct bpf_iter__task_vma *ctx)
+{
+	struct vm_area_struct *vma =3D ctx->vma;
+	struct seq_file *seq =3D ctx->meta->seq;
+	struct task_struct *task =3D ctx->task;
+
+	if (task =3D=3D NULL || vma =3D=3D NULL)
+		return 0;
+
+	if (last_tgid !=3D task->tgid)
+		unique_tgid_cnt++;
+	last_tgid =3D task->tgid;
+
+	if (task->tgid !=3D pid)
+		return 0;
+
+	if (vma->vm_start <=3D address && vma->vm_end > address) {
+		offset =3D address - vma->vm_start + (vma->vm_pgoff << 12);
+		BPF_SEQ_PRINTF(seq, "OK\n");
+	}
+	return 0;
+}
--=20
2.30.2

