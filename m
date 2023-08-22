Return-Path: <bpf+bounces-8220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C378390F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B564D280F35
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857F5257;
	Tue, 22 Aug 2023 05:06:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C863290C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:06:37 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBBCE2
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:06:32 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M3Ub0D021552
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:06:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bCen6zmSioX3EuaMKsc3zqIezrOBODd4ABsAZsebbOE=;
 b=OSie0vxZQ+2G/zz4nR99X+7QrxHvinhN9+qcjNJfbDP1JG8M5pbRR8UAMYaMdFEcmVBA
 4pyWyFafmJ0dSpNgLDRrIQEvVrLXmnXFNUaWjz35EJjRy9bzhrhQOZkRLK/00rbPWDlf
 KlM+wVARcKBSrgNuK4NV/imlQawc2lY7C1U= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3smbfc5u2v-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:06:31 -0700
Received: from twshared7236.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 22:06:18 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id E59372307A968; Mon, 21 Aug 2023 22:06:04 -0700 (PDT)
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
	<davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Add tests for open-coded task_vma iter
Date: Mon, 21 Aug 2023 22:05:58 -0700
Message-ID: <20230822050558.2937659-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822050558.2937659-1-davemarchevsky@fb.com>
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NfBI-IZueCzmrNYA1GPRSV2AD3Fp-bI5
X-Proofpoint-ORIG-GUID: NfBI-IZueCzmrNYA1GPRSV2AD3Fp-bI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_03,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
 .../testing/selftests/bpf/prog_tests/iters.c  | 71 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_vma.c      | 56 +++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testi=
ng/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..f91f4a49066a 100644
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
@@ -90,6 +91,74 @@ static void subtest_testmod_seq_iters(void)
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
+	skel =3D iters_task_vma__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.iter_task_vma_for_each, true);
+
+	err =3D iters_task_vma__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid =3D getpid();
+
+	err =3D iters_task_vma__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	iters_task_vma__detach(skel);
+	getpgid(skel->bss->target_pid);
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
+		err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.vm_start),
+					  &seen, &bpf_iter_start);
+		if (!ASSERT_OK(err, "vm_start map_lookup_elem"))
+			goto cleanup;
+
+		err =3D bpf_map_lookup_elem(bpf_map__fd(skel->maps.vm_end),
+					  &seen, &bpf_iter_end);
+		if (!ASSERT_OK(err, "vm_end map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(bpf_iter_start, start, "vma->vm_start match");
+		ASSERT_EQ(bpf_iter_end, end, "vma->vm_end match");
+		seen++;
+	}
+
+	fclose(f);
+
+	if (!ASSERT_EQ(skel->bss->vmas_seen, seen, "vmas_seen_eq"))
+		goto cleanup;
+
+cleanup:
+	iters_task_vma__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +172,6 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
+	if (test__start_subtest("task_vma"))
+		subtest_task_vma_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/t=
esting/selftests/bpf/progs/iters_task_vma.c
new file mode 100644
index 000000000000..b961d0a12223
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <limits.h>
+#include <linux/errno.h>
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+pid_t target_pid =3D 0;
+unsigned int vmas_seen =3D 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, unsigned long);
+} vm_start SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, unsigned long);
+} vm_end SEC(".maps");
+
+SEC("?raw_tp/sys_enter")
+int iter_task_vma_for_each(const void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+	struct vm_area_struct *vma;
+	unsigned long *start, *end;
+
+	if (task->pid !=3D target_pid)
+		return 0;
+
+	bpf_for_each(task_vma, vma, task, 0) {
+		if (vmas_seen >=3D 1000)
+			break;
+
+		start =3D bpf_map_lookup_elem(&vm_start, &vmas_seen);
+		if (!start)
+			break;
+		*start =3D vma->vm_start;
+
+		end =3D bpf_map_lookup_elem(&vm_end, &vmas_seen);
+		if (!end)
+			break;
+		*end =3D vma->vm_end;
+
+		vmas_seen++;
+	}
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


