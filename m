Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38A675DF3
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjATTZs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjATTZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:43 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB8BCE32;
        Fri, 20 Jan 2023 11:25:34 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id k6so6791774vsk.1;
        Fri, 20 Jan 2023 11:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYSOy7KaZSpPPXApCQ/R8qmtFi6iw6Cs65q0EVBBJUw=;
        b=IVlZSC59kp5op/c3OrvPZMyb4I13/flRUGiqVango4bqSEzCqPsk2eiGqvbgCmMLSn
         bWF6ZJllxXgL5GlJt202xCygH4PLfEUr/EuAOZXN20GlAMl+e9bSgZKdP5e/eMtyG4Fk
         5OyogdRQ8bAABmDKNm6HTvbNDaZdJ9BNePixuP+5EPox2/OVC8QqMpm1u508IRbltSAk
         7CHNEmObQD53md/KrXAgsTEVkWkSm5gb31NJOxrWSaZ9i3+xnvFUIGHnULMVM6ZeKt3K
         IR99U+ZVHs6Pz9kkaf/mL1OffIf+Wx/Sz653FBtd7hPl8WlHqUA2dKMiuWcufrIqTKC9
         6rlQ==
X-Gm-Message-State: AFqh2kqIHiXIdxo56cxtOGTHNW8EBs1S+FiW+T9c37LChrNk1+yzH8k7
        9u6ZXjuBIAk4hqalC5EtJ6EWaBZhekl5EXHS
X-Google-Smtp-Source: AMrXdXsX+FRRCFXXyJK49ELFhZljYF7JbKrm+LC8fZeJBQHtJbEAXZasWTPDFhjZPxW+/Nt/uuqFWQ==
X-Received: by 2002:a05:6102:304f:b0:3d3:e24b:fdb6 with SMTP id w15-20020a056102304f00b003d3e24bfdb6mr15165176vsa.0.1674242732755;
        Fri, 20 Jan 2023 11:25:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006fbb4b98a25sm26932908qkl.109.2023.01.20.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:32 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 5/9] selftests/bpf: Add nested trust selftests suite
Date:   Fri, 20 Jan 2023 13:25:19 -0600
Message-Id: <20230120192523.3650503-6-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
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
 .../selftests/bpf/prog_tests/nested_trust.c   | 12 +++++++
 .../selftests/bpf/progs/nested_trust_common.h | 12 +++++++
 .../bpf/progs/nested_trust_failure.c          | 33 +++++++++++++++++++
 .../bpf/progs/nested_trust_success.c          | 31 +++++++++++++++++
 5 files changed, 89 insertions(+)
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
index 000000000000..39886f58924e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "nested_trust_failure.skel.h"
+#include "nested_trust_success.skel.h"
+
+void test_nested_trust(void)
+{
+	RUN_TESTS(nested_trust_success);
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
index 000000000000..398098d24987
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -0,0 +1,31 @@
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
+__success
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

