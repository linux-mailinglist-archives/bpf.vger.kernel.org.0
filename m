Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B958F52B
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiHKARj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiHKARg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 20:17:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEB8D3DE
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27AGuS94024194
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PiQ+9l2BLleJIIqObmAknKgMI8oGEqU6xd0WAnG+PF4=;
 b=boingSlprKjbVg2L0qpKFctjfRf5daP/W7By/PXCuOe8OCgSOSfyI/cZiY2hbQAUUgsc
 Gd+MnlzPLN2G7bbk8VJPyaAn7znjyr8TMSv0qP8qP3lfhFI0uicX/68aiBbCIzEQhrFC
 kCyv37atb6F9PvalOXuWUBkeRxNxONvBmiA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hvdb5wbyk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:34 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 17:17:32 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 667CE683D659; Wed, 10 Aug 2022 17:17:19 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test parameterized task BPF iterators.
Date:   Wed, 10 Aug 2022 17:16:54 -0700
Message-ID: <20220811001654.1316689-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811001654.1316689-1-kuifeng@fb.com>
References: <20220811001654.1316689-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pLq62zrMMgBea7p6e55ZdzlORwIOSlVr
X-Proofpoint-ORIG-GUID: pLq62zrMMgBea7p6e55ZdzlORwIOSlVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../selftests/bpf/prog_tests/bpf_iter.c       | 204 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
 5 files changed, 203 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index a33874b081b6..e66f1f3db562 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #include <test_progs.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <signal.h>
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
@@ -42,13 +45,13 @@ static void test_btf_id_or_null(void)
 	}
 }
=20
-static void do_dummy_read(struct bpf_program *prog)
+static void do_dummy_read(struct bpf_program *prog, struct bpf_iter_atta=
ch_opts *opts)
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
@@ -91,7 +94,7 @@ static void test_ipv6_route(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_ipv6_route__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_ipv6_route);
+	do_dummy_read(skel->progs.dump_ipv6_route, NULL);
=20
 	bpf_iter_ipv6_route__destroy(skel);
 }
@@ -104,7 +107,7 @@ static void test_netlink(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_netlink__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_netlink);
+	do_dummy_read(skel->progs.dump_netlink, NULL);
=20
 	bpf_iter_netlink__destroy(skel);
 }
@@ -117,24 +120,139 @@ static void test_bpf_map(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_bpf_map);
+	do_dummy_read(skel->progs.dump_bpf_map, NULL);
=20
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
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct bpf_link_info info =3D {};
+	__u32 info_len;
+	struct bpf_link *link;
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
+	if (ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+		ASSERT_EQ(info.iter.task.tid, getpid(), "check_task_tid");
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
+static void test_task_(struct bpf_iter_attach_opts *opts, int num_unknow=
n, int num_known)
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
+	if (!ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mu=
tex_init"))
+		goto done;
+	if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lo=
ck"))
+		goto done;
+
+	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL)=
,
+		  "pthread_create"))
+		goto done;
+
+
+	skel->bss->tid =3D getpid();
+
+	do_dummy_read(skel->progs.dump_task, opts);
+
+	if (!ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_=
unlock"))
+		goto done;
+
+	if (num_unknown >=3D 0)
+		ASSERT_EQ(skel->bss->num_unknown_tid, num_unknown, "check_num_unknown_=
tid");
+	if (num_known >=3D 0)
+		ASSERT_EQ(skel->bss->num_known_tid, num_known, "check_num_known_tid");
=20
+	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
+		     "pthread_join");
+
+done:
 	bpf_iter_task__destroy(skel);
 }
=20
+static void test_task(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_(&opts, 0, 1);
+
+	test_task_(NULL, -1, 1);
+}
+
+static void test_task_tgid(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tgid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_(&opts, 1, 1);
+}
+
+static void test_task_pidfd(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int pidfd;
+
+	pidfd =3D pidfd_open(getpid(), 0);
+	if (!ASSERT_GE(pidfd, 0, "pidfd_open"))
+		return;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.pid_fd =3D pidfd;
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_(&opts, 1, 1);
+
+	close(pidfd);
+}
+
 static void test_task_sleepable(void)
 {
 	struct bpf_iter_task *skel;
@@ -143,7 +261,7 @@ static void test_task_sleepable(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_task_sleepable);
+	do_dummy_read(skel->progs.dump_task_sleepable, NULL);
=20
 	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
 		  "num_expected_failure_copy_from_user_task");
@@ -161,8 +279,8 @@ static void test_task_stack(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_stack__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_task_stack);
-	do_dummy_read(skel->progs.get_task_user_stacks);
+	do_dummy_read(skel->progs.dump_task_stack, NULL);
+	do_dummy_read(skel->progs.get_task_user_stacks, NULL);
=20
 	bpf_iter_task_stack__destroy(skel);
 }
@@ -174,7 +292,9 @@ static void *do_nothing(void *arg)
=20
 static void test_task_file(void)
 {
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct bpf_iter_task_file *skel;
+	union bpf_iter_link_info linfo;
 	pthread_t thread_id;
 	void *ret;
=20
@@ -188,15 +308,31 @@ static void test_task_file(void)
 		  "pthread_create"))
 		goto done;
=20
-	do_dummy_read(skel->progs.dump_task_file);
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	do_dummy_read(skel->progs.dump_task_file, &opts);
=20
 	if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
 		  "pthread_join"))
 		goto done;
=20
 	ASSERT_EQ(skel->bss->count, 0, "check_count");
+	ASSERT_EQ(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
=20
-done:
+	skel->bss->count =3D 0;
+	skel->bss->unique_tgid_count =3D 0;
+
+	do_dummy_read(skel->progs.dump_task_file, NULL);
+
+	ASSERT_GE(skel->bss->count, 0, "check_count");
+	ASSERT_GE(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
+
+	check_bpf_link_info(skel->progs.dump_task_file);
+
+ done:
 	bpf_iter_task_file__destroy(skel);
 }
=20
@@ -274,7 +410,7 @@ static void test_tcp4(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp4__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_tcp4);
+	do_dummy_read(skel->progs.dump_tcp4, NULL);
=20
 	bpf_iter_tcp4__destroy(skel);
 }
@@ -287,7 +423,7 @@ static void test_tcp6(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp6__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_tcp6);
+	do_dummy_read(skel->progs.dump_tcp6, NULL);
=20
 	bpf_iter_tcp6__destroy(skel);
 }
@@ -300,7 +436,7 @@ static void test_udp4(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp4__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_udp4);
+	do_dummy_read(skel->progs.dump_udp4, NULL);
=20
 	bpf_iter_udp4__destroy(skel);
 }
@@ -313,7 +449,7 @@ static void test_udp6(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp6__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_udp6);
+	do_dummy_read(skel->progs.dump_udp6, NULL);
=20
 	bpf_iter_udp6__destroy(skel);
 }
@@ -326,7 +462,7 @@ static void test_unix(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_unix__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_unix);
+	do_dummy_read(skel->progs.dump_unix, NULL);
=20
 	bpf_iter_unix__destroy(skel);
 }
@@ -988,7 +1124,7 @@ static void test_bpf_sk_storage_get(void)
 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_socket;
=20
-	do_dummy_read(skel->progs.fill_socket_owner);
+	do_dummy_read(skel->progs.fill_socket_owner, NULL);
=20
 	err =3D bpf_map_lookup_elem(map_fd, &sock_fd, &val);
 	if (CHECK(err || val !=3D getpid(), "bpf_map_lookup_elem",
@@ -996,7 +1132,7 @@ static void test_bpf_sk_storage_get(void)
 	    getpid(), val, err))
 		goto close_socket;
=20
-	do_dummy_read(skel->progs.negate_socket_local_storage);
+	do_dummy_read(skel->progs.negate_socket_local_storage, NULL);
=20
 	err =3D bpf_map_lookup_elem(map_fd, &sock_fd, &val);
 	CHECK(err || val !=3D -getpid(), "bpf_map_lookup_elem",
@@ -1116,7 +1252,7 @@ static void test_link_iter(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_link__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_bpf_link);
+	do_dummy_read(skel->progs.dump_bpf_link, NULL);
=20
 	bpf_iter_bpf_link__destroy(skel);
 }
@@ -1129,7 +1265,7 @@ static void test_ksym_iter(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
 		return;
=20
-	do_dummy_read(skel->progs.dump_ksym);
+	do_dummy_read(skel->progs.dump_ksym, NULL);
=20
 	bpf_iter_ksym__destroy(skel);
 }
@@ -1154,7 +1290,7 @@ static void str_strip_first_line(char *str)
 	*dst =3D '\0';
 }
=20
-static void test_task_vma(void)
+static void test_task_vma_(struct bpf_iter_attach_opts *opts)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
 	struct bpf_iter_task_vma *skel;
@@ -1166,13 +1302,14 @@ static void test_task_vma(void)
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
@@ -1211,12 +1348,29 @@ static void test_task_vma(void)
 	str_strip_first_line(proc_maps_output);
=20
 	ASSERT_STREQ(task_vma_output, proc_maps_output, "compare_output");
+
+	check_bpf_link_info(skel->progs.proc_maps);
+
 out:
 	close(proc_maps_fd);
 	close(iter_fd);
 	bpf_iter_task_vma__destroy(skel);
 }
=20
+static void test_task_vma(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.task.tid =3D getpid();
+	opts.link_info =3D &linfo;
+	opts.link_info_len =3D sizeof(linfo);
+
+	test_task_vma_(&opts);
+	test_task_vma_(NULL);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -1229,6 +1383,10 @@ void test_bpf_iter(void)
 		test_bpf_map();
 	if (test__start_subtest("task"))
 		test_task();
+	if (test__start_subtest("task_tgid"))
+		test_task_tgid();
+	if (test__start_subtest("task_pidfd"))
+		test_task_pidfd();
 	if (test__start_subtest("task_sleepable"))
 		test_task_sleepable();
 	if (test__start_subtest("task_stack"))
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
index 5fce7008d1ff..32c34ce9cbeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -764,7 +764,7 @@ static void test_btf_dump_struct_data(struct btf *btf=
, struct btf_dump *d,
=20
 	/* union with nested struct */
 	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_=
F_COMPACT,
-			   "(union bpf_iter_link_info){.map =3D (struct){.map_fd =3D (__u32)1=
,},}",
+			   "(union bpf_iter_link_info){.map =3D (struct){.map_fd =3D (__u32)1=
,},.task =3D (struct){.tid =3D (__u32)1,},}",
 			   { .map =3D { .map_fd =3D 1 }});
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
index 6e7b400888fe..031455ed8748 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -7,6 +7,8 @@ char _license[] SEC("license") =3D "GPL";
=20
 int count =3D 0;
 int tgid =3D 0;
+int last_tgid =3D -1;
+int unique_tgid_count =3D 0;
=20
 SEC("iter/task_file")
 int dump_task_file(struct bpf_iter__task_file *ctx)
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
index 4ea6a37d1345..44f4a31c2ddd 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
@@ -20,6 +20,7 @@ char _license[] SEC("license") =3D "GPL";
 #define D_PATH_BUF_SIZE 1024
 char d_path_buf[D_PATH_BUF_SIZE] =3D {};
 __u32 pid =3D 0;
+__u32 one_task =3D 0;
=20
 SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
 {
@@ -33,8 +34,11 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__ta=
sk_vma *ctx)
 		return 0;
=20
 	file =3D vma->vm_file;
-	if (task->tgid !=3D pid)
+	if (task->tgid !=3D pid) {
+		if (one_task)
+			BPF_SEQ_PRINTF(seq, "unexpected task (%d !=3D %d)", task->tgid, pid);
 		return 0;
+	}
 	perm_str[0] =3D (vma->vm_flags & VM_READ) ? 'r' : '-';
 	perm_str[1] =3D (vma->vm_flags & VM_WRITE) ? 'w' : '-';
 	perm_str[2] =3D (vma->vm_flags & VM_EXEC) ? 'x' : '-';
--=20
2.30.2

