Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91256650701
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 05:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiLSEQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 23:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiLSEQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 23:16:05 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854321A7
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 20:16:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b12so5366705pgj.6
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 20:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncnXB0rwjtIsbkYq9pbKmmm21LDgoO0imeQIOZaU0xE=;
        b=WHOzHKYl9II/3JyBAZhjEZYkE7EFTTVbXb2bbYIPrtQowusqhYCX6wpDSrmxMaO3sv
         KbqT5HE0PH6BQIQ7TL8631ATNJzaeudknYgzh6towPRf79J96DeiqXvDFmdrZK0gDy/W
         SHadOQZzdcA2uIT4Ws66jv2yBKeF+XjfoOqoZZxbxW8dykHZzCv9gtRZvLVSSGnvUfph
         3Xnu2q2EhyuIyPG7d1bM6aWScE9yWnMPwC6rMXib+JcuVmaL/mXuV8T84txw2Bu2J1wb
         D/Xj2T1BBR4uBiZfH/CCaL2ga1Ddev1WznNQP/e/GNWoaVfQ51Ws57zEvYUpZTSr8kaJ
         rXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncnXB0rwjtIsbkYq9pbKmmm21LDgoO0imeQIOZaU0xE=;
        b=Vyf2fXN67H4os02AeB6eXqQ2whlymTG1RlD92JGvtHp51suGK8i73oBGAdLyslS6x5
         DcadGv4vUJ2soOIwQCNj0zMD2uS43uLuT3mPHOTpKKkv8slqeTpMpYAppkEezwW9Sv9b
         IJ+4pCmDRSpCB+ihZOOZ22Ba8LC1hlVeGrqTun7Lalm4v28PTvH1g3O1NOGThJOmzd6m
         fKJAWfDGYd/DH5EE9mg7pAfiryZlgK4sdL5KT9hrIGwj89CYEmw/7sf5QmmJgMIV5pP6
         QREdvbTEKiPwm6Xg8Kp6XIMwSXZgmXznByNI/fl9Ec2QdSg7G9NQoFR8Jvh/tbRyA4SU
         63Pg==
X-Gm-Message-State: ANoB5pnx288jD81zkGTdsbH4lfj7qQ9x3nX0PVeOlOkOV9dDvNhmmt41
        UVzz/HxE6nOXt4C/6tlNplBysHO/qpd861vqyuQ=
X-Google-Smtp-Source: AA0mqf7CcAyDKExr5XhYHut5cnqx0xBn9HsKywsRhD0RLyVj6bXj8rK+zzpKY4vc7cnBMhXdQKuj6g==
X-Received: by 2002:aa7:90c5:0:b0:572:6e9b:9f9e with SMTP id k5-20020aa790c5000000b005726e9b9f9emr38300655pfk.19.1671423363163;
        Sun, 18 Dec 2022 20:16:03 -0800 (PST)
Received: from localhost.localdomain ([1.202.165.115])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b00575caf8478dsm5363055pfr.41.2022.12.18.20.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2022 20:16:02 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
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
Subject: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
Date:   Mon, 19 Dec 2022 12:15:51 +0800
Message-Id: <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

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

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
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
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
 .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 99cc33c51eaa..87e8fc9c9df2 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
 get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
 get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
 htab_update/reenter_update
+htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
 kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
 kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
 kfunc_call/subprog_lskel                         # skel unexpected error: -2
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 585fcf73c731..735239b31050 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -26,6 +26,7 @@ get_func_args_test	                 # trampoline
 get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
 kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
 kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
 kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
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
index 000000000000..d394f95e97c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
@@ -0,0 +1,32 @@
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
+/* nmi_handle on x86 platform. If changing keyword
+ * "static" to "inline", this prog load failed. */
+SEC("fentry/nmi_handle")
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

