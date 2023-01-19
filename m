Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4946A6747B2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjASX7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjASX7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:09 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD59FDCC;
        Thu, 19 Jan 2023 15:58:44 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id n2so2725202qvo.1;
        Thu, 19 Jan 2023 15:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAQFuMVkd7GSe7ZmatX5AotUOkL7iU3RCvmNEyiIrJM=;
        b=cpA9caCUz4R3AQO5IdwXOh928HWMTLuqJmyZ+N5bRITgv/L/9wUuuPzsAI/ASkVwjE
         V1mhiFC0mZMcHZr6u2Jx4IyphewZuahXCsC5QxNWFckZcRZoRdJVj49PyrqG+MF/IAC2
         AKJp65ak/P1LyVEWPwBoarOlbiDfENjSYYWkJw3x4NaBZQrYCddi72pwI7W5meqSfbRa
         jjEkSCLfWdLqNv0mA1YLVJ2XHV3DXr5pRoQOJYX0ZlCjwcJc73w9usrOeY2nbD1uFa2M
         FercrjO0tA0ykfPVy+ymtA3pV9pFLlTVeHo3rQC18kQ/G5kZKPVzRhzow8d2BpqLQSHs
         bZWw==
X-Gm-Message-State: AFqh2ko1E2PHfGM8Sats5tiTY9U3330RXV36xgBNq1m24egmQg8EljQY
        Xo6v1QS91m6VJafUkJJEOHCWIVzjQTivzeo+
X-Google-Smtp-Source: AMrXdXt/vC7yq5ic29qzfm06hz9Qw4lFrdj6Wxy1QlAYM43537LeUSf9zMY58D/KAfYbNdVQV2TMKA==
X-Received: by 2002:a05:6214:5ec5:b0:4d1:5b10:51f0 with SMTP id mn5-20020a0562145ec500b004d15b1051f0mr18397534qvb.10.1674172722998;
        Thu, 19 Jan 2023 15:58:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a149600b007090bb886a2sm826414qkj.118.2023.01.19.15.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:42 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 5/8] selftests/bpf: Add nested trust selftests suite
Date:   Thu, 19 Jan 2023 17:58:30 -0600
Message-Id: <20230119235833.2948341-6-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that defining trusted fields in a struct is supported, we should add
selftests to verify the behavior. This patch adds a few such testcases.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../selftests/bpf/prog_tests/nested_trust.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/nested_trust_common.h | 12 ++++
 .../bpf/progs/nested_trust_failure.c          | 33 ++++++++++
 .../bpf/progs/nested_trust_success.c          | 29 +++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 96e8371f5c2a..1cf5b94cda30 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -44,6 +44,7 @@ map_kptr                                 # failed to open_and_load program: -524
 modify_return                            # modify_return attach failed: -524                                           (trampoline)
 module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
 mptcp
+nested_trust                             # JIT does not support calling kernel function
 netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
 probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
 rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
diff --git a/tools/testing/selftests/bpf/prog_tests/nested_trust.c b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
new file mode 100644
index 000000000000..4d13612f5001
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "nested_trust_failure.skel.h"
+#include "nested_trust_success.skel.h"
+
+static const char * const nested_trust_success_testcases[] = {
+	"test_read_cpumask",
+};
+
+static void verify_success(const char *prog_name)
+{
+	struct nested_trust_success *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+	int status;
+	pid_t child_pid;
+
+	skel = nested_trust_success__open();
+	if (!ASSERT_OK_PTR(skel, "nested_trust_success__open"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	nested_trust_success__load(skel);
+	if (!ASSERT_OK_PTR(skel, "nested_trust_success__load"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+	if (child_pid == 0)
+		_exit(0);
+	waitpid(child_pid, &status, 0);
+	ASSERT_OK(skel->bss->err, "post_wait_err");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	nested_trust_success__destroy(skel);
+}
+
+void test_nested_trust(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nested_trust_success_testcases); i++) {
+		if (!test__start_subtest(nested_trust_success_testcases[i]))
+			continue;
+
+		verify_success(nested_trust_success_testcases[i]);
+	}
+
+	RUN_TESTS(nested_trust_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_common.h b/tools/testing/selftests/bpf/progs/nested_trust_common.h
new file mode 100644
index 000000000000..83d33931136e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_trust_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _NESTED_TRUST_COMMON_H
+#define _NESTED_TRUST_COMMON_H
+
+#include <stdbool.h>
+
+bool bpf_cpumask_test_cpu(unsigned int cpu, const struct cpumask *cpumask) __ksym;
+bool bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+
+#endif /* _NESTED_TRUST_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
new file mode 100644
index 000000000000..14aff7676436
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "nested_trust_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Prototype for all of the program trace events below:
+ *
+ * TRACE_EVENT(task_newtask,
+ *         TP_PROTO(struct task_struct *p, u64 clone_flags)
+ */
+
+SEC("tp_btf/task_newtask")
+__failure __msg("R2 must be referenced or trusted")
+int BPF_PROG(test_invalid_nested_user_cpus, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_test_cpu(0, task->user_cpus_ptr);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("R1 must have zero offset when passed to release func or trusted arg to kfunc")
+int BPF_PROG(test_invalid_nested_offset, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_first_zero(&task->cpus_mask);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_success.c b/tools/testing/selftests/bpf/progs/nested_trust_success.c
new file mode 100644
index 000000000000..04079f120bea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "nested_trust_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid, err;
+
+static bool is_test_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_read_cpumask, struct task_struct *task, u64 clone_flags)
+{
+	if (!is_test_task())
+		return 0;
+
+	bpf_cpumask_test_cpu(0, task->cpus_ptr);
+	return 0;
+}
-- 
2.39.0

