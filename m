Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1879766577F
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 10:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAKJbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAKJbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 04:31:05 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404110541
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 01:29:46 -0800 (PST)
X-QQ-mid: bizesmtp72t1673429368tmgngxj8
Received: from localhost.localdomain ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 11 Jan 2023 17:29:26 +0800 (CST)
X-QQ-SSF: 01000000000000707000000A0000000
X-QQ-FEAT: bQWkUqbw9Zb3xVZXFea3FPhZza47qd7cTBrClFlUvLOpwpHMm9GnUNlGZCZWl
        I021bYpMI5DKzdx0NBsEMaiK/X5hfDXBKr4uDtWX6so7MoACsJdY7kqeATVTKxa2rP+eCZI
        kyq0YKYDxhRJcCrxFjy1ZiFPOi3jC3n1AuqeiPn8ON0zjU6BVUVOVSb0/9gCXRWfS7DRQuK
        63Cwca2nMDrMjPWmMMQb3v//2Ncxawj0pl27pbCyejC/A+9j6VGy90+bp3mYC75/cJ1u4Ys
        FolhFibRp7xzsbsASBibx4CqTZGzp1dxaBvKOOImRg9Rhi/fjH9dmnZpDUf/7RCCFjSopAE
        FsbUFvZlzOjn1vTNV7Y5mQJVWLxvEWFncvf9jF34JEDlUA8vw25jCd1jPOcIQ==
X-QQ-GoodBg: 0
From:   tong@infragraf.org
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next v5 2/3] selftests/bpf: add test case for htab map
Date:   Wed, 11 Jan 2023 17:29:02 +0800
Message-Id: <20230111092903.92389-2-tong@infragraf.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230111092903.92389-1-tong@infragraf.org>
References: <20230111092903.92389-1-tong@infragraf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <tong@infragraf.org>

This testing show how to reproduce deadlock in special case.
We update htab map in Task and NMI context. Task can be interrupted by
NMI, if the same map bucket was locked, there will be a deadlock.

* map max_entries is 2.
* NMI using key 4 and Task context using key 20.
* so same bucket index but map_locked index is different.

The selftest use perf to produce the NMI and fentry nmi_handle.
Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
map syscall increase this counter in bpf_disable_instrumentation.
Then fentry nmi_handle and update hash map will reproduce the issue.

Signed-off-by: Tonghao Zhang <tong@infragraf.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
 .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 99cc33c51eaa..42d98703f209 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
 get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
 get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
 htab_update/reenter_update
+htab_deadlock                                    # fentry failed: -524 (trampoline)
 kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
 kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
 kfunc_call/subprog_lskel                         # skel unexpected error: -2
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 3efe091255bf..ab11f71842a5 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -26,6 +26,7 @@ get_func_args_test	                 # trampoline
 get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+htab_deadlock                            # fentry failed: -524                                                         (trampoline)
 jit_probe_mem                            # jit_probe_mem__open_and_load unexpected error: -524                         (kfunc)
 kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
 kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
new file mode 100644
index 000000000000..137dce8f1346
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 DiDi Global Inc. */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <test_progs.h>
+
+#include "htab_deadlock.skel.h"
+
+static int perf_event_open(void)
+{
+	struct perf_event_attr attr = {0};
+	int pfd;
+
+	/* create perf event on CPU 0 */
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	attr.freq = 1;
+	attr.sample_freq = 1000;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+
+	return pfd >= 0 ? pfd : -errno;
+}
+
+void test_htab_deadlock(void)
+{
+	unsigned int val = 0, key = 20;
+	struct bpf_link *link = NULL;
+	struct htab_deadlock *skel;
+	int err, i, pfd;
+	cpu_set_t cpus;
+
+	skel = htab_deadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = htab_deadlock__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto clean_skel;
+
+	/* NMI events. */
+	pfd = perf_event_open();
+	if (pfd < 0) {
+		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
+			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+			test__skip();
+			goto clean_skel;
+		}
+		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
+			goto clean_skel;
+	}
+
+	link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
+		goto clean_pfd;
+
+	/* Pinned on CPU 0 */
+	CPU_ZERO(&cpus);
+	CPU_SET(0, &cpus);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
+
+	/* update bpf map concurrently on CPU0 in NMI and Task context.
+	 * there should be no kernel deadlock.
+	 */
+	for (i = 0; i < 100000; i++)
+		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
+				    &key, &val, BPF_ANY);
+
+	bpf_link__destroy(link);
+clean_pfd:
+	close(pfd);
+clean_skel:
+	htab_deadlock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
new file mode 100644
index 000000000000..dacd003b1ccb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 DiDi Global Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 2);
+	__uint(map_flags, BPF_F_ZERO_SEED);
+	__type(key, unsigned int);
+	__type(value, unsigned int);
+} htab SEC(".maps");
+
+SEC("fentry/perf_event_overflow")
+int bpf_nmi_handle(struct pt_regs *regs)
+{
+	unsigned int val = 0, key = 4;
+
+	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
+	return 0;
+}
+
+SEC("perf_event")
+int bpf_empty(struct pt_regs *regs)
+{
+	return 0;
+}
-- 
2.27.0

