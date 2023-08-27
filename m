Return-Path: <bpf+bounces-8804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85B789FF5
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF37C1C208CF
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD478111BB;
	Sun, 27 Aug 2023 15:28:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5E1096A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:41 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A5EC
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:28:39 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2FB30257ED0A7; Sun, 27 Aug 2023 08:28:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 12/13] selftests/bpf: Add some negative tests
Date: Sun, 27 Aug 2023 08:28:32 -0700
Message-Id: <20230827152832.2002421-1-yonghong.song@linux.dev>
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

Add a few negative tests for common mistakes with using percpu kptr
including:
  - store to percpu kptr.
  - type mistach in bpf_kptr_xchg arguments.
  - sleepable prog with untrusted arg for bpf_this_cpu_ptr().
  - bpf_percpu_obj_new && bpf_obj_drop, and bpf_obj_new && bpf_percpu_obj=
_drop
  - struct with ptr for bpf_percpu_obj_new
  - struct with special field (e.g., bpf_spin_lock) for bpf_percpu_obj_ne=
w

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   |   7 +
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 164 ++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 41bf784a4bb3..9541e9b3a034 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
+#include "percpu_alloc_fail.skel.h"
=20
 static void test_array(void)
 {
@@ -107,6 +108,10 @@ static void test_cgrp_local_storage(void)
 	close(cgroup_fd);
 }
=20
+static void test_failure(void) {
+	RUN_TESTS(percpu_alloc_fail);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -115,4 +120,6 @@ void test_percpu_alloc(void)
 		test_array_sleepable();
 	if (test__start_subtest("cgrp_local_storage"))
 		test_cgrp_local_storage();
+	if (test__start_subtest("failure_tests"))
+		test_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
new file mode 100644
index 000000000000..1a891d30f1fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -0,0 +1,164 @@
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct val_t {
+	long b, c, d;
+};
+
+struct val2_t {
+	long b;
+};
+
+struct val_with_ptr_t {
+	char *p;
+};
+
+struct val_with_rb_root_t {
+	struct bpf_spin_lock lock;
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
+long ret;
+
+SEC("?fentry/bpf_fentry_test1")
+__failure __msg("store to referenced kptr disallowed")
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
+	e->pc =3D (struct val_t __percpu_kptr *)ret;
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+__failure __msg("invalid kptr access, R2 type=3Dpercpu_ptr_val2_t expect=
ed=3Dptr_val_t")
+int BPF_PROG(test_array_map_2)
+{
+	struct val2_t __percpu_kptr *p2;
+	struct val_t __percpu_kptr *p;
+	struct elem *e;
+	int index =3D 0;
+
+	e =3D bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	p2 =3D bpf_percpu_obj_new(struct val2_t);
+	if (!p2)
+		return 0;
+
+	p =3D bpf_kptr_xchg(&e->pc, p2);
+	if (p)
+		bpf_percpu_obj_drop(p);
+
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_, percpu_rcu_ptr=
_, percpu_trusted_ptr_")
+int BPF_PROG(test_array_map_3)
+{
+	struct val_t __percpu_kptr *p, *p1;
+	struct val_t *v;
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
+	p1 =3D bpf_kptr_xchg(&e->pc, p);
+	if (p1)
+		bpf_percpu_obj_drop(p1);
+
+	v =3D bpf_this_cpu_ptr(p);
+	ret =3D v->b;
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("arg#0 expected for bpf_percpu_obj_drop_impl()")
+int BPF_PROG(test_array_map_4)
+{
+	struct val_t __percpu_kptr *p;
+
+	p =3D bpf_percpu_obj_new(struct val_t);
+	if (!p)
+		return 0;
+
+	bpf_obj_drop(p);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("arg#0 expected for bpf_obj_drop_impl()")
+int BPF_PROG(test_array_map_5)
+{
+	struct val_t *p;
+
+	p =3D bpf_obj_new(struct val_t);
+	if (!p)
+		return 0;
+
+	bpf_percpu_obj_drop(p);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("bpf_percpu_obj_new type ID argument must be of a struct=
 of scalars")
+int BPF_PROG(test_array_map_6)
+{
+	struct val_with_ptr_t __percpu_kptr *p;
+
+	p =3D bpf_percpu_obj_new(struct val_with_ptr_t);
+	if (!p)
+		return 0;
+
+	bpf_percpu_obj_drop(p);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("bpf_percpu_obj_new type ID argument must not contain sp=
ecial fields")
+int BPF_PROG(test_array_map_7)
+{
+	struct val_with_rb_root_t __percpu_kptr *p;
+
+	p =3D bpf_percpu_obj_new(struct val_with_rb_root_t);
+	if (!p)
+		return 0;
+
+	bpf_percpu_obj_drop(p);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


