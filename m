Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6632F3EC7D4
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhHOHHO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19992 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234351AbhHOHHL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F76gv2017795
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ae9vqc1w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:42 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:40 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1966D3D405A0; Sun, 15 Aug 2021 00:06:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 bpf-next 12/16] selftests/bpf: test low-level perf BPF link API
Date:   Sun, 15 Aug 2021 00:06:05 -0700
Message-ID: <20210815070609.987780-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4avmjxeyjG-UaNk2R_g5JOXh6nQtZzui
X-Proofpoint-ORIG-GUID: 4avmjxeyjG-UaNk2R_g5JOXh6nQtZzui
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests utilizing low-level bpf_link_create() API to create perf BPF link.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_link.c      | 89 +++++++++++++++++++
 .../selftests/bpf/progs/test_perf_link.c      | 16 ++++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
new file mode 100644
index 000000000000..b1abd0c46607
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <test_progs.h>
+#include "test_perf_link.skel.h"
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
+void test_perf_link(void)
+{
+	struct test_perf_link *skel = NULL;
+	struct perf_event_attr attr;
+	int pfd = -1, link_fd = -1, err;
+	int run_cnt_before, run_cnt_after;
+	struct bpf_link_info info;
+	__u32 info_len = sizeof(info);
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
+	skel = test_perf_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handler), pfd,
+				  BPF_PERF_EVENT, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		goto cleanup;
+
+	memset(&info, 0, sizeof(info));
+	err = bpf_obj_get_info_by_fd(link_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "link_get_info"))
+		goto cleanup;
+
+	ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "link_type");
+	ASSERT_GT(info.id, 0, "link_id");
+	ASSERT_GT(info.prog_id, 0, "link_prog_id");
+
+	/* ensure we get at least one perf_event prog execution */
+	burn_cpu();
+	ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+
+	/* perf_event is still active, but we close link and BPF program
+	 * shouldn't be executed anymore
+	 */
+	close(link_fd);
+	link_fd = -1;
+
+	/* make sure there are no stragglers */
+	kern_sync_rcu();
+
+	run_cnt_before = skel->bss->run_cnt;
+	burn_cpu();
+	run_cnt_after = skel->bss->run_cnt;
+
+	ASSERT_EQ(run_cnt_before, run_cnt_after, "run_cnt_before_after");
+
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	if (pfd >= 0)
+		close(pfd);
+	test_perf_link__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_link.c b/tools/testing/selftests/bpf/progs/test_perf_link.c
new file mode 100644
index 000000000000..c1db9fd98d0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_link.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int run_cnt = 0;
+
+SEC("perf_event")
+int handler(struct pt_regs *ctx)
+{
+	__sync_fetch_and_add(&run_cnt, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

