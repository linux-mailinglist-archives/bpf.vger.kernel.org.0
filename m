Return-Path: <bpf+bounces-8693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076BF788F72
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F33281792
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B111193A3;
	Fri, 25 Aug 2023 19:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575FD322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:54:23 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D81987
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:54:21 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 53E1B2565A060; Fri, 25 Aug 2023 12:54:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 08/13] selftests/bpf: Add tests for array map with local percpu kptr
Date: Fri, 25 Aug 2023 12:54:09 -0700
Message-Id: <20230825195409.96115-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
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

Add non-sleepable and sleepable tests with percpu kptr. For
non-sleepable test, four programs are executed in the order of:
  1. allocate percpu data.
  2. assign values to percpu data.
  3. retrieve percpu data.
  4. de-allocate percpu data.

The sleepable prog tried to exercise all above 4 steps in a
single prog. Also for sleepable prog, rcu_read_lock is needed
to protect direct percpu ptr access (from map value) and
following bpf_this_cpu_ptr() and bpf_per_cpu_ptr() helpers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   |  78 ++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  | 187 ++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_array.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
new file mode 100644
index 000000000000..0fb536822f14
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "percpu_alloc_array.skel.h"
+
+static void test_array(void)
+{
+	struct percpu_alloc_array *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel =3D percpu_alloc_array__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_array__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_array_map_1, true);
+	bpf_program__set_autoload(skel->progs.test_array_map_2, true);
+	bpf_program__set_autoload(skel->progs.test_array_map_3, true);
+	bpf_program__set_autoload(skel->progs.test_array_map_4, true);
+
+	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
+
+	err =3D percpu_alloc_array__load(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_array__load"))
+		goto out;
+
+	err =3D percpu_alloc_array__attach(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_array__attach"))
+		goto out;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test_array_map_1);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run array_map 1-4");
+	ASSERT_EQ(topts.retval, 0, "test_run array_map 1-4");
+	ASSERT_EQ(skel->bss->cpu0_field_d, 2, "cpu0_field_d");
+	ASSERT_EQ(skel->bss->sum_field_c, 1, "sum_field_c");
+out:
+	percpu_alloc_array__destroy(skel);
+}
+
+static void test_array_sleepable(void)
+{
+	struct percpu_alloc_array *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel =3D percpu_alloc_array__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_array_map_10, true);
+
+	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
+
+	err =3D percpu_alloc_array__load(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_array__load"))
+		goto out;
+
+	err =3D percpu_alloc_array__attach(skel);
+	if (!ASSERT_OK(err, "percpu_alloc_array__attach"))
+		goto out;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test_array_map_10);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run array_map_10");
+	ASSERT_EQ(topts.retval, 0, "test_run array_map_10");
+	ASSERT_EQ(skel->bss->cpu0_field_d, 2, "cpu0_field_d");
+	ASSERT_EQ(skel->bss->sum_field_c, 1, "sum_field_c");
+out:
+	percpu_alloc_array__destroy(skel);
+}
+
+void test_percpu_alloc(void)
+{
+	if (test__start_subtest("array"))
+		test_array();
+	if (test__start_subtest("array_sleepable"))
+		test_array_sleepable();
+}
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/too=
ls/testing/selftests/bpf/progs/percpu_alloc_array.c
new file mode 100644
index 000000000000..3bd7d47870a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
@@ -0,0 +1,187 @@
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
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+const volatile int nr_cpus;
+
+/* Initialize the percpu object */
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(test_array_map_1)
+{
+	struct val_t __percpu_kptr *p;
+	struct elem *e;
+	int index =3D 0;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
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
+/* Update percpu data */
+SEC("?fentry/bpf_fentry_test2")
+int BPF_PROG(test_array_map_2)
+{
+	struct val_t __percpu_kptr *p;
+	struct val_t *v;
+	struct elem *e;
+	int index =3D 0;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
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
+	return 0;
+}
+
+int cpu0_field_d, sum_field_c;
+
+/* Summarize percpu data */
+SEC("?fentry/bpf_fentry_test3")
+int BPF_PROG(test_array_map_3)
+{
+	struct val_t __percpu_kptr *p;
+	int i, index =3D 0;
+	struct val_t *v;
+	struct elem *e;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
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
+/* Explicitly free allocated percpu data */
+SEC("?fentry/bpf_fentry_test4")
+int BPF_PROG(test_array_map_4)
+{
+	struct val_t __percpu_kptr *p;
+	struct elem *e;
+	int index =3D 0;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	/* delete */
+	p =3D bpf_kptr_xchg(&e->pc, NULL);
+	if (p) {
+		bpf_percpu_obj_drop(p);
+	}
+
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+int BPF_PROG(test_array_map_10)
+{
+	struct val_t __percpu_kptr *p, *p1;
+	int i, index =3D 0;
+	struct val_t *v;
+	struct elem *e;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	bpf_rcu_read_lock();
+	p =3D e->pc;
+	if (!p) {
+		p =3D bpf_percpu_obj_new(struct val_t);
+		if (!p)
+			goto out;
+
+		p1 =3D bpf_kptr_xchg(&e->pc, p);
+		if (p1) {
+			/* race condition */
+			bpf_percpu_obj_drop(p1);
+		}
+
+		p =3D e->pc;
+		if (!p)
+			goto out;
+	}
+
+	v =3D bpf_this_cpu_ptr(p);
+	v->c =3D 3;
+	v =3D bpf_this_cpu_ptr(p);
+	v->c =3D 0;
+
+	v =3D bpf_per_cpu_ptr(p, 0);
+	if (!v)
+		goto out;
+	v->c =3D 1;
+	v->d =3D 2;
+
+	/* delete */
+	p1 =3D bpf_kptr_xchg(&e->pc, NULL);
+	if (!p1)
+		goto out;
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
+	/* finally release p */
+	bpf_percpu_obj_drop(p1);
+out:
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


