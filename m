Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355DA3D61B7
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhGZPco convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Jul 2021 11:32:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21286 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233626AbhGZPc1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 11:32:27 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QGAPhE008270
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0gcy2eda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:54 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:12:53 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4BBD23D405AD; Mon, 26 Jul 2021 09:12:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 bpf-next 14/14] selftests/bpf: add user_ctx selftests for high-level APIs
Date:   Mon, 26 Jul 2021 09:12:11 -0700
Message-ID: <20210726161211.925206-15-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726161211.925206-1-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UvbBrefVUUWX1o1vVh9j7sEySH4qMOyu
X-Proofpoint-ORIG-GUID: UvbBrefVUUWX1o1vVh9j7sEySH4qMOyu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftest with few subtests testing proper user_ctx usage.

Kprobe and uprobe subtests are pretty straightforward and just validate that
the same BPF program attached with different user_ctx will be triggered with
those different user_ctx values.

Tracepoint subtest is a bit more interesting, as it is the only
perf_event-based BPF hook that shares bpf_prog_array between multiple
perf_events internally. This means that the same BPF program can't be attached
to the same tracepoint multiple times. So we have 3 identical copies. This
arrangement allows to test bpf_prog_array_copy()'s handling of bpf_prog_array
list manipulation logic when programs are attached and detached.  The test
validates that user_ctx isn't mixed up and isn't lost during such list
manipulations.

Perf_event subtest validates that two BPF links can be created against the
same perf_event (but not at the same time, only one BPF program can be
attached to perf_event itself), and that for each we can specify different
user_ctx value.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/user_ctx.c       | 254 ++++++++++++++++++
 .../selftests/bpf/progs/test_user_ctx.c       |  85 ++++++
 2 files changed, 339 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_user_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ctx.c b/tools/testing/selftests/bpf/prog_tests/user_ctx.c
new file mode 100644
index 000000000000..86374c8666dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_ctx.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "test_user_ctx.skel.h"
+
+static void kprobe_subtest(struct test_user_ctx *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct bpf_link *retlink1 = NULL, *retlink2 = NULL;
+
+	/* attach two kprobes */
+	opts.user_ctx = 0x1;
+	opts.retprobe = false;
+	link1 = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						 SYS_NANOSLEEP_KPROBE_NAME, &opts);
+	if (!ASSERT_OK_PTR(link1, "link1"))
+		goto cleanup;
+
+	opts.user_ctx = 0x2;
+	opts.retprobe = false;
+	link2 = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						 SYS_NANOSLEEP_KPROBE_NAME, &opts);
+	if (!ASSERT_OK_PTR(link2, "link2"))
+		goto cleanup;
+
+	/* attach two kretprobes */
+	opts.user_ctx = 0x10;
+	opts.retprobe = true;
+	retlink1 = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+						    SYS_NANOSLEEP_KPROBE_NAME, &opts);
+	if (!ASSERT_OK_PTR(retlink1, "retlink1"))
+		goto cleanup;
+
+	opts.user_ctx = 0x20;
+	opts.retprobe = true;
+	retlink2 = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+						    SYS_NANOSLEEP_KPROBE_NAME, &opts);
+	if (!ASSERT_OK_PTR(retlink2, "retlink2"))
+		goto cleanup;
+
+	/* trigger kprobe && kretprobe */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->kprobe_res, 0x1 | 0x2, "kprobe_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 0x10 | 0x20, "kretprobe_res");
+
+cleanup:
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(retlink1);
+	bpf_link__destroy(retlink2);
+}
+
+static void uprobe_subtest(struct test_user_ctx *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	struct bpf_link *retlink1 = NULL, *retlink2 = NULL;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+
+	base_addr = get_base_addr();
+	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
+
+	/* attach two uprobes */
+	opts.user_ctx = 0x100;
+	opts.retprobe = false;
+	link1 = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe, 0 /* self pid */,
+						"/proc/self/exe", uprobe_offset, &opts);
+	if (!ASSERT_OK_PTR(link1, "link1"))
+		goto cleanup;
+
+	opts.user_ctx = 0x200;
+	opts.retprobe = false;
+	link2 = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe, -1 /* any pid */,
+						"/proc/self/exe", uprobe_offset, &opts);
+	if (!ASSERT_OK_PTR(link2, "link2"))
+		goto cleanup;
+
+	/* attach two uretprobes */
+	opts.user_ctx = 0x1000;
+	opts.retprobe = true;
+	retlink1 = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe, -1 /* any pid */,
+						   "/proc/self/exe", uprobe_offset, &opts);
+	if (!ASSERT_OK_PTR(retlink1, "retlink1"))
+		goto cleanup;
+
+	opts.user_ctx = 0x2000;
+	opts.retprobe = true;
+	retlink2 = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe, 0 /* self pid */,
+						   "/proc/self/exe", uprobe_offset, &opts);
+	if (!ASSERT_OK_PTR(retlink2, "retlink2"))
+		goto cleanup;
+
+	/* trigger uprobe && uretprobe */
+	get_base_addr();
+
+	ASSERT_EQ(skel->bss->uprobe_res, 0x100 | 0x200, "uprobe_res");
+	ASSERT_EQ(skel->bss->uretprobe_res, 0x1000 | 0x2000, "uretprobe_res");
+
+cleanup:
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(retlink1);
+	bpf_link__destroy(retlink2);
+}
+
+static void tp_subtest(struct test_user_ctx *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tracepoint_opts, opts);
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+
+	/* attach first tp prog */
+	opts.user_ctx = 0x10000;
+	link1 = bpf_program__attach_tracepoint_opts(skel->progs.handle_tp1,
+						    "syscalls", "sys_enter_nanosleep", &opts);
+	if (!ASSERT_OK_PTR(link1, "link1"))
+		goto cleanup;
+
+	/* attach second tp prog */
+	opts.user_ctx = 0x20000;
+	link2 = bpf_program__attach_tracepoint_opts(skel->progs.handle_tp2,
+						    "syscalls", "sys_enter_nanosleep", &opts);
+	if (!ASSERT_OK_PTR(link2, "link2"))
+		goto cleanup;
+
+	/* trigger tracepoints */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->tp_res, 0x10000 | 0x20000, "tp_res1");
+
+	/* now we detach first prog and will attach third one, which causes
+	 * two internal calls to bpf_prog_array_copy(), shuffling
+	 * bpf_prog_array_items around. We test here that we don't lose track
+	 * of associated user_ctxs.
+	 */
+	bpf_link__destroy(link1);
+	link1 = NULL;
+	kern_sync_rcu();
+	skel->bss->tp_res = 0;
+
+	/* attach third tp prog */
+	opts.user_ctx = 0x40000;
+	link3 = bpf_program__attach_tracepoint_opts(skel->progs.handle_tp3,
+						    "syscalls", "sys_enter_nanosleep", &opts);
+	if (!ASSERT_OK_PTR(link3, "link3"))
+		goto cleanup;
+
+	/* trigger tracepoints */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->tp_res, 0x20000 | 0x40000, "tp_res2");
+
+cleanup:
+	bpf_link__destroy(link1);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link3);
+}
+
+static void burn_cpu(void)
+{
+	volatile int j = 0;
+	cpu_set_t cpu_set;
+	int i, err;
+
+	/* generate some branches on cpu 0 */
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	ASSERT_OK(err, "set_thread_affinity");
+
+	/* spin the loop for a while (random high number) */
+	for (i = 0; i < 1000000; ++i)
+		++j;
+}
+
+static void pe_subtest(struct test_user_ctx *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, opts);
+	struct bpf_link *link = NULL;
+	struct perf_event_attr attr;
+	int pfd = -1;
+
+	/* create perf event */
+	memset(&attr, 0, sizeof(attr));
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.freq = 1;
+	attr.sample_freq = 4000;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (!ASSERT_GE(pfd, 0, "perf_fd"))
+		goto cleanup;
+
+	opts.user_ctx = 0x100000;
+	link = bpf_program__attach_perf_event_opts(skel->progs.handle_pe, pfd, &opts);
+	if (!ASSERT_OK_PTR(link, "link1"))
+		goto cleanup;
+
+	burn_cpu(); /* trigger BPF prog */
+
+	ASSERT_EQ(skel->bss->pe_res, 0x100000, "pe_res1");
+
+	/* prevent bpf_link__destroy() closing pfd itself */
+	bpf_link__disconnect(link);
+	/* close BPF link's FD explicitly */
+	close(bpf_link__fd(link));
+	/* free up memory used by struct bpf_link */
+	bpf_link__destroy(link);
+	link = NULL;
+	kern_sync_rcu();
+	skel->bss->pe_res = 0;
+
+	opts.user_ctx = 0x200000;
+	link = bpf_program__attach_perf_event_opts(skel->progs.handle_pe, pfd, &opts);
+	if (!ASSERT_OK_PTR(link, "link2"))
+		goto cleanup;
+
+	burn_cpu(); /* trigger BPF prog */
+
+	ASSERT_EQ(skel->bss->pe_res, 0x200000, "pe_res2");
+
+cleanup:
+	close(pfd);
+	bpf_link__destroy(link);
+}
+
+void test_user_ctx(void)
+{
+	struct test_user_ctx *skel;
+
+	skel = test_user_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->my_tid = syscall(SYS_gettid);
+
+	if (test__start_subtest("kprobe"))
+		kprobe_subtest(skel);
+	if (test__start_subtest("uprobe"))
+		uprobe_subtest(skel);
+	if (test__start_subtest("tracepoint"))
+		tp_subtest(skel);
+	if (test__start_subtest("perf_event"))
+		pe_subtest(skel);
+
+	test_user_ctx__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_user_ctx.c b/tools/testing/selftests/bpf/progs/test_user_ctx.c
new file mode 100644
index 000000000000..e641bb5e1774
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_user_ctx.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int my_tid;
+
+int kprobe_res;
+int kprobe_multi_res;
+int kretprobe_res;
+int uprobe_res;
+int uretprobe_res;
+int tp_res;
+int pe_res;
+
+static void update(void *ctx, int *res)
+{
+	if (my_tid != (u32)bpf_get_current_pid_tgid())
+		return;
+
+	*res |= bpf_get_user_ctx(ctx);
+}
+
+SEC("kprobe/sys_nanosleep")
+int handle_kprobe(struct pt_regs *ctx)
+{
+	update(ctx, &kprobe_res);
+	return 0;
+}
+
+SEC("kretprobe/sys_nanosleep")
+int handle_kretprobe(struct pt_regs *ctx)
+{
+	update(ctx, &kretprobe_res);
+	return 0;
+}
+
+SEC("uprobe/trigger_func")
+int handle_uprobe(struct pt_regs *ctx)
+{
+	update(ctx, &uprobe_res);
+	return 0;
+}
+
+SEC("uretprobe/trigger_func")
+int handle_uretprobe(struct pt_regs *ctx)
+{
+	update(ctx, &uretprobe_res);
+	return 0;
+}
+
+/* bpf_prog_array, used by kernel internally to keep track of attached BPF
+ * programs to a given BPF hook (e.g., for tracepoints) doesn't allow the same
+ * BPF program to be attached multiple times. So have three identical copies
+ * ready to attach to the same tracepoint.
+ */
+SEC("tp/syscalls/sys_enter_nanosleep")
+int handle_tp1(struct pt_regs *ctx)
+{
+	update(ctx, &tp_res);
+	return 0;
+}
+SEC("tp/syscalls/sys_enter_nanosleep")
+int handle_tp2(struct pt_regs *ctx)
+{
+	update(ctx, &tp_res);
+	return 0;
+}
+SEC("tp/syscalls/sys_enter_nanosleep")
+int handle_tp3(void *ctx)
+{
+	update(ctx, &tp_res);
+	return 1;
+}
+
+SEC("perf_event")
+int handle_pe(struct pt_regs *ctx)
+{
+	update(ctx, &pe_res);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

