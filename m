Return-Path: <bpf+bounces-11833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945EA7C03FF
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B061F1C20E59
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12138DEA;
	Tue, 10 Oct 2023 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b3WfWsIk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F52FE11
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 19:00:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9C93
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AIgKQj007969
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qekMFz9DkVZTfA1aGqyjSnMQwPkMgwNKHz4OmU/M/AY=;
 b=b3WfWsIkMT5LIBXkBckN5R8+90SGqAaZT+qShJadapqtn3vfVJ699cu384Nxr/vn/oTc
 k71E29jYYwH7asUJvsnXifhadoqPVex459gL2Qrt3pJTY1zh47lxhCUewD5fxprudDgk
 54CKh1YpmBjhm+v7sbj+FQ/vmTHiNPdb/oE= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tnc4a85qb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:09 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 10 Oct 2023 11:59:57 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 1BAB5258848FA; Tue, 10 Oct 2023 11:59:48 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 4/4] selftests/bpf: Add tests for open-coded task_vma iter
Date: Tue, 10 Oct 2023 11:59:44 -0700
Message-ID: <20231010185944.3888849-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010185944.3888849-1-davemarchevsky@fb.com>
References: <20231010185944.3888849-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EH3l8ZbHcBFd8K69LkX6cJHgcQ_zDLwX
X-Proofpoint-GUID: EH3l8ZbHcBFd8K69LkX6cJHgcQ_zDLwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_14,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The open-coded task_vma iter added earlier in this series allows for
natural iteration over a task's vmas using existing open-coded iter
infrastructure, specifically bpf_for_each.

This patch adds a test demonstrating this pattern and validating
correctness. The vma->vm_start and vma->vm_end addresses of the first
1000 vmas are recorded and compared to /proc/PID/maps output. As
expected, both see the same vmas and addresses - with the exception of
the [vsyscall] vma - which is explained in a comment in the prog_tests
program.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
 .../testing/selftests/bpf/prog_tests/iters.c  | 58 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_vma.c      | 46 +++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index 9aa29564bd74..2c8cb3f61529 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -159,6 +159,14 @@ extern void *bpf_percpu_obj_new_impl(__u64 local_typ=
e_id, void *meta) __ksym;
  */
 extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
=20
+struct bpf_iter_task_vma;
+
+extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
+				 struct task_struct *task,
+				 unsigned long addr) __ksym;
+extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_tas=
k_vma *it) __ksym;
+extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ks=
ym;
+
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testi=
ng/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..633030c12674 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -8,6 +8,7 @@
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
 #include "iters_testmod_seq.skel.h"
+#include "iters_task_vma.skel.h"
=20
 static void subtest_num_iters(void)
 {
@@ -90,6 +91,61 @@ static void subtest_testmod_seq_iters(void)
 	iters_testmod_seq__destroy(skel);
 }
=20
+static void subtest_task_vma_iters(void)
+{
+	unsigned long start, end, bpf_iter_start, bpf_iter_end;
+	struct iters_task_vma *skel;
+	char rest_of_line[1000];
+	unsigned int seen;
+	int err;
+	FILE *f;
+
+	skel =3D iters_task_vma__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->target_pid =3D getpid();
+
+	err =3D iters_task_vma__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	getpgid(skel->bss->target_pid);
+	iters_task_vma__detach(skel);
+
+	if (!ASSERT_GT(skel->bss->vmas_seen, 0, "vmas_seen_gt_zero"))
+		goto cleanup;
+
+	f =3D fopen("/proc/self/maps", "r");
+	if (!ASSERT_OK_PTR(f, "proc_maps_fopen"))
+		goto cleanup;
+
+	seen =3D 0;
+	while (fscanf(f, "%lx-%lx %[^\n]\n", &start, &end, rest_of_line) =3D=3D=
 3) {
+		/* [vsyscall] vma isn't _really_ part of task->mm vmas.
+		 * /proc/PID/maps returns it when out of vmas - see get_gate_vma
+		 * calls in fs/proc/task_mmu.c
+		 */
+		if (strstr(rest_of_line, "[vsyscall]"))
+			continue;
+
+		bpf_iter_start =3D skel->bss->vm_ranges[seen].vm_start;
+		bpf_iter_end =3D skel->bss->vm_ranges[seen].vm_end;
+
+		ASSERT_EQ(bpf_iter_start, start, "vma->vm_start match");
+		ASSERT_EQ(bpf_iter_end, end, "vma->vm_end match");
+		seen++;
+	}
+
+	if (!ASSERT_EQ(skel->bss->vmas_seen, seen, "vmas_seen_eq"))
+		goto cleanup;
+
+cleanup:
+	if (f)
+		fclose(f);
+	iters_task_vma__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +159,6 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
+	if (test__start_subtest("task_vma"))
+		subtest_task_vma_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/t=
esting/selftests/bpf/progs/iters_task_vma.c
new file mode 100644
index 000000000000..e3759e425420
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <limits.h>
+#include <linux/errno.h>
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+pid_t target_pid =3D 0;
+unsigned int vmas_seen =3D 0;
+
+struct {
+	__u64 vm_start;
+	__u64 vm_end;
+} vm_ranges[1000];
+
+SEC("raw_tp/sys_enter")
+int iter_task_vma_for_each(const void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+	unsigned int seen =3D 0;
+
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	if (vmas_seen)
+		return 0;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		if (seen >=3D 1000)
+			break;
+
+		vm_ranges[seen].vm_start =3D vma->vm_start;
+		vm_ranges[seen].vm_end =3D vma->vm_end;
+		seen++;
+	}
+
+	if (!vmas_seen)
+		vmas_seen =3D seen;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


