Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45FE6F633F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEDDQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEDDQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:16:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DC1BDB
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:15:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab05018381so35047945ad.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683170141; x=1685762141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h/CDMFgSlP9yOUQI1sdefuI1Wb9xgpW0pTUn973WII=;
        b=DZaAmqCtovbHBk30MsBFccw1jnzr6slYyxFHkbaexwKg6dSUNVOTHG8M8ve0HBrbwk
         QxOkQOQZbP3qyMpxDOVZ2HNqvUe3pZAJ5d4k9Rk54/2ev85+2bBQdadB/xzxW4AUv/dl
         tzSMzafvrKxjkgxqEMzF/DAmTwrUGldQdJj6KPXEuVZY1OjZEtx99icxQEyKpqlF8Fp7
         db4kGJBuRc6wIQ3wANzCl1rkOrSNUjtNBNwpzOsHMx81WHc9ZrZ1UCHERy4azvJSGX+X
         2EcWJY17WQCeYk1bvmQWfUJRTKRThguBrTlRSLhvz+2P6mK9ERMUrxxUQvW+3ITLu30T
         hZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170141; x=1685762141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h/CDMFgSlP9yOUQI1sdefuI1Wb9xgpW0pTUn973WII=;
        b=jzw/LqfukErfpNO2FKS2fAEZkgyGY/9RjFfZBekkyrPRNLPgrV4XTJ4nJCi4B9DjGK
         LpCzKo3R25As8NlzN6RC+WlyFRoPgGQLP/GA+LjCnuwKQnwNsLm7buDgC/ZLiSzTQS+L
         PJnBcNdL7Z2aiGLaaoRz3OlLXaTMzXnuw8i1kyDSrsyh7BdXBRiK+AdzwBwirj47jyR7
         E/F17QuSsLYZLZQvfGAsTYM0m37PFzSFCykebjn6geLfBF+/o1gys3JAUTFDldKFYcgP
         E2IX96cq0/ywGexz8UoIZzViLcZpSFZ+zKLKjT64gc0uVF+iiK3EaQpEZ6xAZm99EjBn
         gdlg==
X-Gm-Message-State: AC+VfDy7PpGApWgseSHAV+u58kDRqk2knmRRmWJoXDXBkrM4u9kasMXm
        X8TIqhunzSSmXlY0kVe+L2MftQ==
X-Google-Smtp-Source: ACHHUZ6YpmbBk6/OyNzhF5pRP/eT8QxaYf5z0kyAKyuQfBSfXVB/klS335Qb3ukkQpsEgDXopID+tQ==
X-Received: by 2002:a17:903:41d2:b0:1aa:d545:462e with SMTP id u18-20020a17090341d200b001aad545462emr3029250ple.13.1683170141134;
        Wed, 03 May 2023 20:15:41 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm7146121plb.289.2023.05.03.20.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:15:40 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add testcase for bpf_task_under_cgroup
Date:   Thu,  4 May 2023 11:15:12 +0800
Message-Id: <20230504031513.13749-3-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
References: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

test_progs:
Tests new kfunc bpf_task_under_cgroup().

The bpf program saves the new task's pid within a given cgroup to
the remote_pid, which is convenient for the user-mode program to
verify the test correctness.

The user-mode program creates its own mount namespace, and mounts the
cgroupsv2 hierarchy in there, call the fork syscall, then check if
remote_pid and local_pid are unequal.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 54 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index c7463f3ec3c0..5061d9e24c16 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -26,3 +26,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
 verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
 xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
 xdp_metadata                             # JIT does not support calling kernel function                                (kfunc)
+test_task_under_cgroup                   # JIT does not support calling kernel function                                (kfunc)
diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
new file mode 100644
index 000000000000..fa3a98eae5ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_under_cgroup.skel.h"
+
+#define FOO	"/foo"
+
+void test_task_under_cgroup(void)
+{
+	struct test_task_under_cgroup *skel;
+	int ret, foo = -1;
+	pid_t pid;
+
+	foo = test__join_cgroup(FOO);
+	if (!ASSERT_OK(foo < 0, "cgroup_join_foo"))
+		return;
+
+	skel = test_task_under_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_under_cgroup__open"))
+		goto cleanup;
+
+	skel->rodata->local_pid = getpid();
+	skel->bss->remote_pid = getpid();
+	skel->rodata->cgid = get_cgroup_id(FOO);
+
+	ret = test_task_under_cgroup__load(skel);
+	if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
+		goto cleanup;
+
+	ret = test_task_under_cgroup__attach(skel);
+	if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
+		goto cleanup;
+
+	pid = fork();
+	if (pid == 0)
+		exit(0);
+
+	ret = (pid == -1);
+	if (ASSERT_OK(ret, "fork process"))
+		wait(NULL);
+
+	test_task_under_cgroup__detach(skel);
+
+	ASSERT_NEQ(skel->bss->remote_pid, skel->rodata->local_pid,
+		   "test task_under_cgroup");
+
+cleanup:
+	close(foo);
+
+	test_task_under_cgroup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
new file mode 100644
index 000000000000..79d98e65c7eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+const volatile int local_pid;
+const volatile __u64 cgid;
+int remote_pid;
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(handle__task_newtask, struct task_struct *task, u64 clone_flags)
+{
+	struct cgroup *cgrp = NULL;
+	struct task_struct *acquired;
+
+	if (local_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
+
+	if (local_pid == acquired->tgid)
+		goto out;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		goto out;
+
+	if (bpf_task_under_cgroup(acquired, cgrp))
+		remote_pid = acquired->tgid;
+
+out:
+	if (acquired)
+		bpf_task_release(acquired);
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.20.1

