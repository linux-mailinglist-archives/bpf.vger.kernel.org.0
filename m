Return-Path: <bpf+bounces-8803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF8D789FF4
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCEF1C2092C
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C7111B3;
	Sun, 27 Aug 2023 15:28:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBC1096A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:36 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8F11B
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:28:34 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 072F5257ED05C; Sun, 27 Aug 2023 08:28:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 11/13] selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
Date: Sun, 27 Aug 2023 08:28:27 -0700
Message-Id: <20230827152827.2001784-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827152729.1995219-1-yonghong.song@linux.dev>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a non-sleepable cgrp_local_storage test with percpu kptr. The
test does allocation of percpu data, assigning values to percpu
data and retrieval of percpu data. The de-allocation of percpu
data is done when the map is freed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   |  40 +++++++
 .../progs/percpu_alloc_cgrp_local_storage.c   | 105 ++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_l=
ocal_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 0fb536822f14..41bf784a4bb3 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "percpu_alloc_array.skel.h"
+#include "percpu_alloc_cgrp_local_storage.skel.h"
=20
 static void test_array(void)
 {
@@ -69,10 +70,49 @@ static void test_array_sleepable(void)
 	percpu_alloc_array__destroy(skel);
 }
=20
+static void test_cgrp_local_storage(void)
+{
+	struct percpu_alloc_cgrp_local_storage *skel;
+	int err, cgroup_fd, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	cgroup_fd =3D test__join_cgroup("/percpu_alloc");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /percpu_alloc"))
+		return;
+
+	skel =3D percpu_alloc_cgrp_local_storage__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_cgrp_local_storage__open"))
+		goto close_fd;
+
+	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
+
+	err =3D percpu_alloc_cgrp_local_storage__load(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_cgrp_local_storage__load"))
+		goto destroy_skel;
+
+	err =3D percpu_alloc_cgrp_local_storage__attach(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_cgrp_local_storage__attach"))
+		goto destroy_skel;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test_cgrp_local_storage_1);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run cgrp_local_storage 1-3");
+	ASSERT_EQ(topts.retval, 0, "test_run cgrp_local_storage 1-3");
+	ASSERT_EQ(skel->bss->cpu0_field_d, 2, "cpu0_field_d");
+	ASSERT_EQ(skel->bss->sum_field_c, 1, "sum_field_c");
+
+destroy_skel:
+	percpu_alloc_cgrp_local_storage__destroy(skel);
+close_fd:
+	close(cgroup_fd);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
 		test_array();
 	if (test__start_subtest("array_sleepable"))
 		test_array_sleepable();
+	if (test__start_subtest("cgrp_local_storage"))
+		test_cgrp_local_storage();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_st=
orage.c b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_stora=
ge.c
new file mode 100644
index 000000000000..1c36a241852c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
@@ -0,0 +1,105 @@
+#include "bpf_experimental.h"
+
+struct val_t {
+	long b, c, d;
+};
+
+struct elem {
+	long sum;
+	struct val_t __percpu_kptr *pc;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct elem);
+} cgrp SEC(".maps");
+
+const volatile int nr_cpus;
+
+/* Initialize the percpu object */
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_cgrp_local_storage_1)
+{
+	struct task_struct *task;
+	struct val_t __percpu_kptr *p;
+	struct elem *e;
+
+	task =3D bpf_get_current_task_btf();
+	e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!e)
+		return 0;
+
+	p =3D bpf_percpu_obj_new(struct val_t);
+	if (!p)
+		return 0;
+
+	p =3D bpf_kptr_xchg(&e->pc, p);
+	if (p)
+		bpf_percpu_obj_drop(p);
+
+	return 0;
+}
+
+/* Percpu data collection */
+SEC("fentry/bpf_fentry_test2")
+int BPF_PROG(test_cgrp_local_storage_2)
+{
+	struct task_struct *task;
+	struct val_t __percpu_kptr *p;
+	struct val_t *v;
+	struct elem *e;
+
+	task =3D bpf_get_current_task_btf();
+	e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0, 0);
+	if (!e)
+		return 0;
+
+	p =3D e->pc;
+	if (!p)
+		return 0;
+
+	v =3D bpf_per_cpu_ptr(p, 0);
+	if (!v)
+		return 0;
+	v->c =3D 1;
+	v->d =3D 2;
+	return 0;
+}
+
+int cpu0_field_d, sum_field_c;
+
+/* Summarize percpu data collection */
+SEC("fentry/bpf_fentry_test3")
+int BPF_PROG(test_cgrp_local_storage_3)
+{
+	struct task_struct *task;
+	struct val_t __percpu_kptr *p;
+	struct val_t *v;
+	struct elem *e;
+	int i;
+
+	task =3D bpf_get_current_task_btf();
+	e =3D bpf_cgrp_storage_get(&cgrp, task->cgroups->dfl_cgrp, 0, 0);
+	if (!e)
+		return 0;
+
+	p =3D e->pc;
+	if (!p)
+		return 0;
+
+	bpf_for(i, 0, nr_cpus) {
+		v =3D bpf_per_cpu_ptr(p, i);
+		if (v) {
+			if (i =3D=3D 0)
+				cpu0_field_d =3D v->d;
+			sum_field_c +=3D v->c;
+		}
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


