Return-Path: <bpf+bounces-8165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE24782F81
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED6F1C20901
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6218F4E;
	Mon, 21 Aug 2023 17:34:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BA8F48
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:34:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28257F7
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:32 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFPtag000307
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lV1G3+VLUeR+2IdZernEFRRlN//AJ7Pju9rZDNfEFzQ=;
 b=O8yRLRBrgp7sX8GWnB3tnq+4Pn4vBWZxPtIswZiIEGvT1YgXcZbNjcfqN6BIfw1CCt4q
 P2CuYajt46Q+2fCOBcQMf3dO5pAzU3kYyDozjPTyk68m+pVa0gZUq5VJUSxTf1tMLEdt
 waRyNPoFCKgxucyFA6JpkVQYVG7t5+UFAiQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjw25n1q7-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:31 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 10:34:28 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 65BC92300E6E3; Mon, 21 Aug 2023 10:34:17 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        <sdf@google.com>, Dave Marchevsky
	<davemarchevsky@fb.com>,
        Nathan Slingerland <slinger@meta.com>
Subject: [PATCH v2 bpf-next 2/3] bpf: Introduce task_vma open-coded iterator kfuncs
Date: Mon, 21 Aug 2023 10:34:14 -0700
Message-ID: <20230821173415.1970776-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821173415.1970776-1-davemarchevsky@fb.com>
References: <20230821173415.1970776-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qn6OzrLjuWkqUyaM3FY3wPs3LFXWIerz
X-Proofpoint-GUID: qn6OzrLjuWkqUyaM3FY3wPs3LFXWIerz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_06,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_task_vma in open-coded
iterator style. BPF programs can use these kfuncs directly or through
bpf_for_each macro for natural-looking iteration of all task vmas.

The implementation borrows heavily from bpf_find_vma helper's locking -
differing only in that it holds the mmap_read lock for all iterations
while the helper only executes its provided callback on a maximum of 1
vma. Aside from locking, struct vma_iterator and vma_next do all the
heavy lifting.

The newly-added struct bpf_iter_task_vma has a name collision with a
selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/=
progs
file is renamed in order to avoid the collision.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Nathan Slingerland <slinger@meta.com>
---
 include/uapi/linux/bpf.h                      |  4 +
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 79 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  5 ++
 tools/lib/bpf/bpf_helpers.h                   |  8 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
 ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
 7 files changed, 112 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d21deb46f49f..d90f9bf8080f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7291,4 +7291,8 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
=20
+struct bpf_iter_task_vma {
+	__u64 __opaque[4]; /* See bpf_iter_num comment above */
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..7a06dea749f1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..fb934ca9e020 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -7,7 +7,9 @@
 #include <linux/fs.h>
 #include <linux/fdtable.h>
 #include <linux/filter.h>
+#include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
+#include <linux/mm_types.h>
 #include "mmap_unlock_work.h"
=20
 static const char * const iter_task_type_names[] =3D {
@@ -823,6 +825,83 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
 	.arg5_type	=3D ARG_ANYTHING,
 };
=20
+/* Non-opaque version of uapi bpf_iter_task_vma */
+struct bpf_iter_task_vma_kern {
+	struct task_struct *task;
+	struct mm_struct *mm;
+	struct mmap_unlock_irq_work *work;
+	struct vma_iterator *vmi;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
+				      struct task_struct *task, u64 addr)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+	bool irq_work_busy =3D false;
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(struct b=
pf_iter_task_vma));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __alignof_=
_(struct bpf_iter_task_vma));
+
+	/* NULL i->mm signals failed bpf_iter_task_vma initialization.
+	 * i->work =3D=3D NULL is valid.
+	 */
+	kit->mm =3D NULL;
+	kit->task =3D NULL;
+	if (!task)
+		return -ENOENT;
+
+	kit->task =3D get_task_struct(task);
+	kit->mm =3D task->mm;
+	if (!kit->mm) {
+		err =3D -ENOENT;
+		goto err_put_task;
+	}
+
+	kit->vmi =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct vma_iterator))=
;
+	if (!kit->vmi) {
+		err =3D -ENOMEM;
+		goto err_put_task;
+	}
+
+	irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->work);
+	if (irq_work_busy || !mmap_read_trylock(kit->mm)) {
+		err =3D -EBUSY;
+		goto err_put_task;
+	}
+
+	vma_iter_init(kit->vmi, kit->mm, addr);
+	return 0;
+
+err_put_task:
+	if (kit->task)
+		put_task_struct(kit->task);
+	if (kit->vmi)
+		bpf_mem_free(&bpf_global_ma, kit->vmi);
+	kit->mm =3D NULL;
+	return err;
+}
+
+__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+
+	if (!kit->mm) /* bpf_iter_task_vma_new failed */
+		return NULL;
+	return vma_next(kit->vmi);
+}
+
+__bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+
+	if (kit->mm) {
+		bpf_mmap_unlock_mm(kit->work, kit->mm);
+		put_task_struct(kit->task);
+		bpf_mem_free(&bpf_global_ma, kit->vmi);
+	}
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
=20
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index d21deb46f49f..c4a65968f9f5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7291,4 +7291,9 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
=20
+struct bpf_iter_task_vma {
+	__u64 __opaque[9]; /* See bpf_iter_num comment above */
+	char __opaque_c[3];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index bbab9ad9dc5a..d885ffee4d88 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -302,6 +302,14 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it,=
 int start, int end) __weak
 extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
 extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
=20
+struct bpf_iter_task_vma;
+
+extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
+				 struct task_struct *task,
+				 unsigned long addr) __weak __ksym;
+extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_tas=
k_vma *it) __weak __ksym;
+extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __we=
ak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct=
 for
  * using BPF open-coded iterators without having to write mundane explic=
it
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..41aba139b20b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -10,7 +10,7 @@
 #include "bpf_iter_task.skel.h"
 #include "bpf_iter_task_stack.skel.h"
 #include "bpf_iter_task_file.skel.h"
-#include "bpf_iter_task_vma.skel.h"
+#include "bpf_iter_task_vmas.skel.h"
 #include "bpf_iter_task_btf.skel.h"
 #include "bpf_iter_tcp4.skel.h"
 #include "bpf_iter_tcp6.skel.h"
@@ -1399,19 +1399,19 @@ static void str_strip_first_line(char *str)
 static void test_task_vma_common(struct bpf_iter_attach_opts *opts)
 {
 	int err, iter_fd =3D -1, proc_maps_fd =3D -1;
-	struct bpf_iter_task_vma *skel;
+	struct bpf_iter_task_vmas *skel;
 	int len, read_size =3D 4;
 	char maps_path[64];
=20
-	skel =3D bpf_iter_task_vma__open();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
+	skel =3D bpf_iter_task_vmas__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
 		return;
=20
 	skel->bss->pid =3D getpid();
 	skel->bss->one_task =3D opts ? 1 : 0;
=20
-	err =3D bpf_iter_task_vma__load(skel);
-	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
+	err =3D bpf_iter_task_vmas__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
 		goto out;
=20
 	skel->links.proc_maps =3D bpf_program__attach_iter(
@@ -1462,25 +1462,25 @@ static void test_task_vma_common(struct bpf_iter_=
attach_opts *opts)
 out:
 	close(proc_maps_fd);
 	close(iter_fd);
-	bpf_iter_task_vma__destroy(skel);
+	bpf_iter_task_vmas__destroy(skel);
 }
=20
 static void test_task_vma_dead_task(void)
 {
-	struct bpf_iter_task_vma *skel;
+	struct bpf_iter_task_vmas *skel;
 	int wstatus, child_pid =3D -1;
 	time_t start_tm, cur_tm;
 	int err, iter_fd =3D -1;
 	int wait_sec =3D 3;
=20
-	skel =3D bpf_iter_task_vma__open();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
+	skel =3D bpf_iter_task_vmas__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
 		return;
=20
 	skel->bss->pid =3D getpid();
=20
-	err =3D bpf_iter_task_vma__load(skel);
-	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
+	err =3D bpf_iter_task_vmas__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
 		goto out;
=20
 	skel->links.proc_maps =3D bpf_program__attach_iter(
@@ -1533,7 +1533,7 @@ static void test_task_vma_dead_task(void)
 out:
 	waitpid(child_pid, &wstatus, 0);
 	close(iter_fd);
-	bpf_iter_task_vma__destroy(skel);
+	bpf_iter_task_vmas__destroy(skel);
 }
=20
 void test_bpf_sockmap_map_iter_fd(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
rename to tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
--=20
2.34.1


