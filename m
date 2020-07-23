Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50722B576
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWSM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 14:12:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbgGWSM5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 14:12:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06NICYOM031927
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:12:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HC19BocnzqfbZdasNet2djSQezi7uoWDz8ER7wUvdIo=;
 b=Og9KjKkzc6vLHdUHDjzKNL4zRAJ/wygzf3LSyuOEbNdUSUJE/ZzfmG0J9OuOy7px5GXU
 LUhTcZcvc7lLjAi3Ye82mIN6MOul8MTy2zYcRItOlsCMRZq3+4HFT8sCVhhpd2kpKfjb
 fTYC+zgbeBddyfNYYEmfHsVjXp0gQ/IxA+E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32er2fec0k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:12:55 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:12:54 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C824A62E5087; Thu, 23 Jul 2020 11:07:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 4/5] selftests/bpf: add callchain_stackid
Date:   Thu, 23 Jul 2020 11:06:47 -0700
Message-ID: <20200723180648.1429892-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723180648.1429892-1-songliubraving@fb.com>
References: <20200723180648.1429892-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This tests new helper function bpf_get_stackid_pe and bpf_get_stack_pe.
These two helpers have different implementation for perf_event with PEB
entries.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../bpf/prog_tests/perf_event_stackmap.c      | 116 ++++++++++++++++++
 .../selftests/bpf/progs/perf_event_stackmap.c |  59 +++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_event_sta=
ckmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/perf_event_stackmap=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c=
 b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
new file mode 100644
index 0000000000000..72c3690844fba
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <test_progs.h>
+#include "perf_event_stackmap.skel.h"
+
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+noinline int func_1(void)
+{
+	static int val =3D 1;
+
+	val +=3D 1;
+
+	usleep(100);
+	return val;
+}
+
+noinline int func_2(void)
+{
+	return func_1();
+}
+
+noinline int func_3(void)
+{
+	return func_2();
+}
+
+noinline int func_4(void)
+{
+	return func_3();
+}
+
+noinline int func_5(void)
+{
+	return func_4();
+}
+
+noinline int func_6(void)
+{
+	int i, val =3D 1;
+
+	for (i =3D 0; i < 100; i++)
+		val +=3D func_5();
+
+	return val;
+}
+
+void test_perf_event_stackmap(void)
+{
+	struct perf_event_attr attr =3D {
+		/* .type =3D PERF_TYPE_SOFTWARE, */
+		.type =3D PERF_TYPE_HARDWARE,
+		.config =3D PERF_COUNT_HW_CPU_CYCLES,
+		.precise_ip =3D 2,
+		.sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_BRANCH_STACK |
+			PERF_SAMPLE_CALLCHAIN,
+		.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER |
+			PERF_SAMPLE_BRANCH_NO_FLAGS |
+			PERF_SAMPLE_BRANCH_NO_CYCLES |
+			PERF_SAMPLE_BRANCH_CALL_STACK,
+		.sample_period =3D 5000,
+		.size =3D sizeof(struct perf_event_attr),
+	};
+	struct perf_event_stackmap *skel;
+	__u32 duration =3D 0;
+	cpu_set_t cpu_set;
+	int pmu_fd, err;
+
+	skel =3D perf_event_stackmap__open();
+
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	err =3D perf_event_stackmap__load(skel);
+	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
+		goto cleanup;
+
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_se=
t);
+	if (CHECK(err, "set_affinity", "err %d, errno %d\n", err, errno))
+		goto cleanup;
+
+	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (pmu_fd < 0) {
+		printf("%s:SKIP:cpu doesn't support the event\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->links.oncpu =3D bpf_program__attach_perf_event(skel->progs.oncpu,
+							   pmu_fd);
+	if (CHECK(IS_ERR(skel->links.oncpu), "attach_perf_event",
+		  "err %ld\n", PTR_ERR(skel->links.oncpu))) {
+		close(pmu_fd);
+		goto cleanup;
+	}
+
+	/* create kernel and user stack traces for testing */
+	func_6();
+
+	CHECK(skel->data->stackid_kernel !=3D 2, "get_stackid_kernel", "failed\=
n");
+	CHECK(skel->data->stackid_user !=3D 2, "get_stackid_user", "failed\n");
+	CHECK(skel->data->stack_kernel !=3D 2, "get_stack_kernel", "failed\n");
+	CHECK(skel->data->stack_user !=3D 2, "get_stack_user", "failed\n");
+
+cleanup:
+	perf_event_stackmap__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/perf_event_stackmap.c b/to=
ols/testing/selftests/bpf/progs/perf_event_stackmap.c
new file mode 100644
index 0000000000000..25467d13c356a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/perf_event_stackmap.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
+typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16384);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(stack_trace_t));
+} stackmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, stack_trace_t);
+} stackdata_map SEC(".maps");
+
+long stackid_kernel =3D 1;
+long stackid_user =3D 1;
+long stack_kernel =3D 1;
+long stack_user =3D 1;
+
+SEC("perf_event")
+int oncpu(void *ctx)
+{
+	stack_trace_t *trace;
+	__u32 key =3D 0;
+	long val;
+
+	val =3D bpf_get_stackid(ctx, &stackmap, 0);
+	if (val > 0)
+		stackid_kernel =3D 2;
+	val =3D bpf_get_stackid(ctx, &stackmap, BPF_F_USER_STACK);
+	if (val > 0)
+		stackid_user =3D 2;
+
+	trace =3D bpf_map_lookup_elem(&stackdata_map, &key);
+	if (!trace)
+		return 0;
+
+	val =3D bpf_get_stack(ctx, trace, sizeof(stack_trace_t), 0);
+	if (val > 0)
+		stack_kernel =3D 2;
+
+	val =3D bpf_get_stack(ctx, trace, sizeof(stack_trace_t), BPF_F_USER_STA=
CK);
+	if (val > 0)
+		stack_user =3D 2;
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.24.1

