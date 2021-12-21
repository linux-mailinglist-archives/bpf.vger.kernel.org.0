Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54E47B9B8
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 06:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhLUFyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 00:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhLUFyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 00:54:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71837C061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:54:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 196so7175381pfw.10
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uieDkl7DxCjlW74QVZKOedQWqym2cjHiLJMoOOVvQ+Y=;
        b=pivcQbcbZsxhJsorw1wrRy38VbATwobGfdSpFqWovlLdwNqvhSbO0sGZvNa8Tn2lCm
         13kxpRZV0kHmezhH79EPRBN/U+3Ye4QuGBX7tln0LU/K2fiXKsNdRnH0oZEraompzlcA
         LtI243JopFE/72Gu6Dfp1yEvG1/Mq6U/IgEAfCVVJL0eo7rVVCi38Oev7mTjOl1ESm3D
         IFbxHR1sDY32LBPMBhCsQ7H0dvQYPa83BI63PJOQ+rBaaZD1rVrKJRg7b9D55i4wyl7P
         3tXim6ZYXveemru/6IFkRVhKVRopyHTSRak1OwvfRzV8Fz56o57a6bE1CC7IqIGSH5t6
         2cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uieDkl7DxCjlW74QVZKOedQWqym2cjHiLJMoOOVvQ+Y=;
        b=ZRr+p3T6LnWcOgHpI7Yd2R1NPGGBQY+IiXo4fff7QjGBrJzQn4awlX1N+lp6wdbDuP
         t9a9fFh1Tjg16QWtKFAMfURWYrx+XmQ7UycxPN5EL3NO64G3Gben+Cr8Mf6Ysz7DAfVn
         56AMTetciAompLUBm9GbElIGOvxXNvSMsyhgw5gnghavr+1dih0N8vu1QhvLLS3jRca3
         uI6VUxoRRl/+7fcuNKObkZCTqU55RLsAjJXh1Wam9rXElR6Qu6myGLA4XcQF24uYbC3H
         Y61tCl1hF/xhuj8Z3rhM7ZejkdGrkkP/KtUvaXCou0xzeq0o3UtRQJaV+D+G6KOZvCic
         KtMw==
X-Gm-Message-State: AOAM532pk1Q5kITCTCvtvnl8GvO79IHBfaYSNxiyRMXdDOiZ+3zHE3Cf
        h2b0C66e8YSmkmT4tFqATNKNv5wR/vWs6g==
X-Google-Smtp-Source: ABdhPJwHeJ5nzidQ/AyDaX/x9cLlP0GlHi0GohYzNPm5OLDfUh9YOEH7jE01bYzcuh2f80QxZ3/ytQ==
X-Received: by 2002:a63:5147:: with SMTP id r7mr1491115pgl.581.1640066040833;
        Mon, 20 Dec 2021 21:54:00 -0800 (PST)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id s16sm20441330pfu.109.2021.12.20.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 21:54:00 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
Date:   Tue, 21 Dec 2021 05:53:12 +0000
Message-Id: <20211221055312.3371414-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211221055312.3371414-1-hengqi.chen@gmail.com>
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests for the newly added BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/kprobe_syscall.c | 40 ++++++++++++++++++
 .../selftests/bpf/progs/test_kprobe_syscall.c | 41 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
new file mode 100644
index 000000000000..a1fad70bbb69
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include "test_kprobe_syscall.skel.h"
+
+void test_kprobe_syscall(void)
+{
+	struct test_kprobe_syscall *skel;
+	int err, fd = 0;
+
+	skel = test_kprobe_syscall__open();
+	if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
+		return;
+
+	skel->rodata->my_pid = getpid();
+
+	err = test_kprobe_syscall__load(skel);
+	if (!ASSERT_OK(err, "could not load BPF object"))
+		goto cleanup;
+
+	err = test_kprobe_syscall__attach(skel);
+	if (!ASSERT_OK(err, "could not attach BPF object"))
+		goto cleanup;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	ASSERT_GT(fd, 0, "socket failed");
+	ASSERT_EQ(skel->bss->domain, AF_UNIX, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->type, SOCK_STREAM, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->protocol, 0, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->fd, fd, "BPF_KRETPROBE_SYSCALL failed");
+
+cleanup:
+	if (fd)
+		close(fd);
+	test_kprobe_syscall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
new file mode 100644
index 000000000000..ecef9d19007c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+const volatile pid_t my_pid = 0;
+int domain = 0;
+int type = 0;
+int protocol = 0;
+int fd = 0;
+
+SEC("kprobe/__x64_sys_socket")
+int BPF_KPROBE_SYSCALL(socket_enter, int d, int t, int p)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	domain = d;
+	type = t;
+	protocol = p;
+	return 0;
+}
+
+SEC("kretprobe/__x64_sys_socket")
+int BPF_KRETPROBE_SYSCALL(socket_exit, int ret)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	fd = ret;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.30.2
