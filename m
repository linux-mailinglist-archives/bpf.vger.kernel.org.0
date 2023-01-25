Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAD67B4EA
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjAYOj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjAYOj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:39:56 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C379BB448;
        Wed, 25 Jan 2023 06:39:29 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id j185so19904643vsc.13;
        Wed, 25 Jan 2023 06:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf+gzK0xZwUKtJt9QhZUfrs11Ga+ezcsG9eoAJLkf1c=;
        b=nO+1tX2qhNMnfP5hhNL4FCG+h6ihLShn67+dwa213nvI2HDxuPRh/HNK0/Nt6RCmPV
         Blqz7+qBI32Whs9N0MBd75vlgZnlpteAx3K591EsOQeZ+Xg4v2X4/mIAzKmKqSYrU8dW
         0tBoREKFGq2Ne+2h72W6u9JyApt4hLsGzK8tTa0Ten58KA7k1naRfXEjVCtaolAPCeel
         orCkQkX5OYrZqXreBzHfZAqOAoli1gYX9pRbbYUmm3FUXSf+7oC4TULUnwrfv40zTymp
         djDJNpz99gr+WE3bgI2zrdUvGN6dvFGx8K14NWSHO4dbEl4hgSF7dqsAMiayFxczLuTw
         /U1g==
X-Gm-Message-State: AFqh2kpUHUCUYuqbCXRTjca577a0O4v0Fsyh37NygRpyua6yKlz1kLmV
        arUBkL0LvYEZ4KluN1r4C3vVutsPRXlzqYdx
X-Google-Smtp-Source: AMrXdXtXv3Fx6m8ysFF4AVx2i9ho3OipnGLACknAFTHIDEPIshIlG2nJl4iM7pzJNlRQLndzRYg5cw==
X-Received: by 2002:a05:6102:22ef:b0:3d0:c57b:5626 with SMTP id b15-20020a05610222ef00b003d0c57b5626mr17792499vsh.16.1674657503017;
        Wed, 25 Jan 2023 06:38:23 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a158a00b007023fc46b64sm3556057qkk.113.2023.01.25.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:22 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 3/7] selftests/bpf: Add nested trust selftests suite
Date:   Wed, 25 Jan 2023 08:38:12 -0600
Message-Id: <20230125143816.721952-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
References: <20230125143816.721952-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
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
 .../bpf/progs/nested_trust_success.c          | 19 +++++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index b9ef9cc61d36..f18e367ca4b9 100644
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
index 000000000000..886ade4aa99d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -0,0 +1,19 @@
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
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_read_cpumask, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_test_cpu(0, task->cpus_ptr);
+	return 0;
+}
-- 
2.39.0

