Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD05B2B54EB
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 00:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgKPXZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 18:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgKPXZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 18:25:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD7C0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 15:25:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so1114341wmd.4
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 15:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oYXnwzsUfYkv/JbwSH8+mON82/DrYcgv5qDf+JbWgU=;
        b=BYj+9NivNd1L+uIdzH+Ut2iu9Ng00xASQjO6PENMmx/hr+J3xU3oryjBkw7cKT3GXk
         zTC1H9Cg0+8aq3QUGUvrxTDFM8+Zlsh6xFi9MB8HTw9YWxftWkw37u5AMs6bK2gJGWyY
         aXgCIhp3ovASMOzn1Hv9UyjXAXPqtbYqiAyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oYXnwzsUfYkv/JbwSH8+mON82/DrYcgv5qDf+JbWgU=;
        b=pWUWagAFkP4coAOShhPu34YfObQyo3jV/6t33APcnGnEVeKfmS+dE0tAAMqRzxKUjJ
         riTlwcjPLFHX3r7ZrcbZgNyU3Y6iL9anntNb2xA6uIOJFvRSZ5WGgh8hBgYqwDx1PQfa
         tuG4NWzcDlUwNJyLqf5WhbQP1lh0k0UjoLg2v4RygysPhnd60OsUUtvESRVxt1vWlLTp
         JqO3Y3qi3aKm3TbobPYlWwz/9y9VSWJBsomFgZJkux+xU3KcNFf7B/3v94wu0MRmMx8w
         Aw24rWAFdZzcWEqWPJKoMH4yq+D+775FCsQuUBo5G+XPirQ27ddqRxaCtMFKwcSh85rW
         XlFA==
X-Gm-Message-State: AOAM530w6OjbXKHKDCzUoGHDVyrJBzkhBv8Sh7MxCOlU64MV1WsLlNHV
        qUMdA+88NeIszD0H5WKbEvvQ11J7bdQi7w==
X-Google-Smtp-Source: ABdhPJwrJrfhxqBusXlw+/3eFQwaCjchh8Y/xWcVfCkuFmNd08i5iXm1/bHLyH8w/EMxUl9OMKpX4g==
X-Received: by 2002:a1c:1dc1:: with SMTP id d184mr1162802wmd.169.1605569139040;
        Mon, 16 Nov 2020 15:25:39 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm20783212wrv.6.2020.11.16.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:25:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
Date:   Mon, 16 Nov 2020 23:25:36 +0000
Message-Id: <20201116232536.1752908-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116232536.1752908-1-kpsingh@chromium.org>
References: <20201116232536.1752908-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The test forks a child process, updates the local storage to set/unset
the securexec bit.

The BPF program in the test attaches to bprm_creds_for_exec which checks
the local storage of the current task to set the secureexec bit on the
binary parameters (bprm).

The child then execs a bash command with the environment variable
TMPDIR set in the envp.  The bash command returns a different exit code
based on its observed value of the TMPDIR variable.

Since TMPDIR is one of the variables that is ignored by the dynamic
loader when the secureexec bit is set, one should expect the
child execution to not see this value when the secureexec bit is set.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/prog_tests/test_bprm_opts.c | 124 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bprm_opts.c |  34 +++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/bprm_opts.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
new file mode 100644
index 000000000000..cba1ef3dc8b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <asm-generic/errno-base.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include <linux/limits.h>
+
+#include "bprm_opts.skel.h"
+#include "network_helpers.h"
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+
+static const char * const bash_envp[] = { "TMPDIR=shouldnotbeset", NULL };
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static int update_storage(int map_fd, int secureexec)
+{
+	int task_fd, ret = 0;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (task_fd < 0)
+		return errno;
+
+	ret = bpf_map_update_elem(map_fd, &task_fd, &secureexec, BPF_NOEXIST);
+	if (ret)
+		ret = errno;
+
+	close(task_fd);
+	return ret;
+}
+
+static int run_set_secureexec(int map_fd, int secureexec)
+{
+
+	int child_pid, child_status, ret, null_fd;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		null_fd = open("/dev/null", O_WRONLY);
+		if (null_fd == -1)
+			exit(errno);
+		dup2(null_fd, STDOUT_FILENO);
+		dup2(null_fd, STDERR_FILENO);
+		close(null_fd);
+
+		/* Ensure that all executions from hereon are
+		 * secure by setting a local storage which is read by
+		 * the bprm_creds_for_exec hook and sets bprm->secureexec.
+		 */
+		ret = update_storage(map_fd, secureexec);
+		if (ret)
+			exit(ret);
+
+		/* If the binary is executed with securexec=1, the dynamic
+		 * loader ingores and unsets certain variables like LD_PRELOAD,
+		 * TMPDIR etc. TMPDIR is used here to simplify the example, as
+		 * LD_PRELOAD requires a real .so file.
+		 *
+		 * If the value of TMPDIR is set, the bash command returns 10
+		 * and if the value is unset, it returns 20.
+		 */
+		ret = execle("/bin/bash", "bash", "-c",
+			     "[[ -z \"${TMPDIR}\" ]] || exit 10 && exit 20",
+			     NULL, bash_envp);
+		if (ret)
+			exit(errno);
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		ret = WEXITSTATUS(child_status);
+
+		/* If a secureexec occured, the exit status should be 20.
+		 */
+		if (secureexec && ret == 20)
+			return 0;
+
+		/* If normal execution happened the exit code should be 10.
+		 */
+		if (!secureexec && ret == 10)
+			return 0;
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+void test_test_bprm_opts(void)
+{
+	int err, duration = 0;
+	struct bprm_opts *skel = NULL;
+
+	skel = bprm_opts__open_and_load();
+	if (CHECK(!skel, "skel_load", "skeleton failed\n"))
+		goto close_prog;
+
+	err = bprm_opts__attach(skel);
+	if (CHECK(err, "attach", "attach failed: %d\n", err))
+		goto close_prog;
+
+	/* Run the test with the secureexec bit unset */
+	err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
+				 0 /* secureexec */);
+	if (CHECK(err, "run_set_secureexec:0", "err = %d", err))
+		goto close_prog;
+
+	/* Run the test with the secureexec bit set */
+	err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
+				 1 /* secureexec */);
+	if (CHECK(err, "run_set_secureexec:1", "err = %d", err))
+		goto close_prog;
+
+close_prog:
+	bprm_opts__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bprm_opts.c b/tools/testing/selftests/bpf/progs/bprm_opts.c
new file mode 100644
index 000000000000..f353b4fdc0b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bprm_opts.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} secure_exec_task_map SEC(".maps");
+
+SEC("lsm/bprm_creds_for_exec")
+int BPF_PROG(secure_exec, struct linux_binprm *bprm)
+{
+	int *secureexec;
+
+	secureexec = bpf_task_storage_get(&secure_exec_task_map,
+				   bpf_get_current_task_btf(), 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	if (secureexec && *secureexec)
+		bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);
+
+	return 0;
+}
-- 
2.29.2.299.gdc1121823c-goog

