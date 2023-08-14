Return-Path: <bpf+bounces-7754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FBD77BEFF
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3212811C8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77523CA4B;
	Mon, 14 Aug 2023 17:29:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8FC2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:29:24 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D31E133
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:29:22 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 55E8824C220F5; Mon, 14 Aug 2023 10:29:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 13/15] selftests/bpf: Add tests for percpu struct with bpf list head
Date: Mon, 14 Aug 2023 10:29:18 -0700
Message-Id: <20230814172918.1369380-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
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

This is to test nested special fields with the following pattern:
  struct val_t {
       long b, c, d;
       struct bpf_list_head head __contains(foo, node);
       struct bpf_spin_lock lock;
  };
  struct map_val_t {
       ...
       struct val_t __percpu *pc;
       ...
  };

That is, the percpu data struct can hold a linked list.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   |  40 ++++++
 .../percpu_alloc_nested_special_fields.c      | 121 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_nested=
_special_fields.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 41bf784a4bb3..ee9dd495db7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
+#include "percpu_alloc_nested_special_fields.skel.h"
=20
 static void test_array(void)
 {
@@ -107,6 +108,43 @@ static void test_cgrp_local_storage(void)
 	close(cgroup_fd);
 }
=20
+static void test_nested_special_fields(void)
+{
+	struct percpu_alloc_nested_special_fields *skel;
+	int err, cgroup_fd, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	cgroup_fd =3D test__join_cgroup("/percpu_alloc");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /percpu_alloc"))
+		return;
+
+	skel =3D percpu_alloc_nested_special_fields__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_nested_special_fields__open"))
+		goto close_fd;
+
+	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
+
+	err =3D percpu_alloc_nested_special_fields__load(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_nested_special_fields__load"))
+		goto destroy_skel;
+
+	err =3D percpu_alloc_nested_special_fields__attach(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_nested_special_fields__attach"))
+		goto destroy_skel;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test_cgrp_local_storage_1);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run nested_special_fields 1-3");
+	ASSERT_EQ(topts.retval, 0, "test_run nested_special_fields 1-3");
+	ASSERT_EQ(skel->bss->cpu0_field_d, 2, "cpu0_field_d");
+	ASSERT_EQ(skel->bss->sum_field_c, 1, "sum_field_c");
+
+destroy_skel:
+	percpu_alloc_nested_special_fields__destroy(skel);
+close_fd:
+	close(cgroup_fd);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -115,4 +153,6 @@ void test_percpu_alloc(void)
 		test_array_sleepable();
 	if (test__start_subtest("cgrp_local_storage"))
 		test_cgrp_local_storage();
+	if (test__start_subtest("nested_special_fields"))
+		test_nested_special_fields();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_nested_specia=
l_fields.c b/tools/testing/selftests/bpf/progs/percpu_alloc_nested_specia=
l_fields.c
new file mode 100644
index 000000000000..d1a8e9b6b472
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_nested_special_field=
s.c
@@ -0,0 +1,121 @@
+#include "bpf_experimental.h"
+
+struct foo {
+	long key, data;
+	struct bpf_list_node node;
+};
+
+struct val_t {
+	long b, c, d;
+	struct bpf_list_head head __contains(foo, node);
+	struct bpf_spin_lock lock;
+};
+
+struct elem {
+	long sum;
+	struct val_t __percpu *pc;
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
+	struct val_t __percpu *p;
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
+	struct val_t __percpu *p;
+	struct val_t *v;
+	struct elem *e;
+	struct foo *f;
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
+
+	f =3D bpf_obj_new(struct foo);
+	if (!f)
+		return 0;
+	bpf_spin_lock(&v->lock);
+	bpf_list_push_back(&v->head, &f->node);
+	bpf_spin_unlock(&v->lock);
+
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
+	struct val_t __percpu *p;
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


