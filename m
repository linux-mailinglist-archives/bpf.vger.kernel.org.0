Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32352B726B
	for <lists+bpf@lfdr.de>; Wed, 18 Nov 2020 00:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKQX3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 18:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKQX3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 18:29:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644FC0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 15:29:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so3011041wmg.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pj9GAd6lPX1luvhTRtjAwGqzDzBvcBv8m7DVR+Is5uw=;
        b=UAKmz27BMPIPbI0bWQo8kRhYVHct0edQpiEo4rQhkH4BwgyomWNfUA1Y7wFQ1iPgx9
         Q7sEV+P93u7JGo1xzJrbcrqTPztosr7+bK26ORfOamwjtMZRBIx8bCmLv8B9xlhXEr2S
         uS7ByHTyfDA8JDJEP2J6XkXGMYvEjc2WO0Sm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pj9GAd6lPX1luvhTRtjAwGqzDzBvcBv8m7DVR+Is5uw=;
        b=VqtTliqhhM1CftrgjEjiV2GGJU1AMK0CFw7Igui1XqPFsq1xb50oYYmTJvkGsmrOKE
         gAAO6sgv/Ny2v+2Jei1ZWQRluN9FX4fVoc/MOxDd1Nppt2ek1ui38/lxMFzjHuuWo9cK
         lj0clFGL3GIUyUlV9hcAx1H+t/LKvUXjwUFSs10U1QgJNf0XZrkyGqwM+/ICyKk/DUre
         ojweVLMe70DxWPmJa9jip3osWTTbUYl0JCSGbCtnJeMiI/zvOb6DGvUx4dh1hN3kNRH3
         1l+v6rXZJ3SQ7HbAUjbaRuZwf9uvowQfHDNnk0nCm9cnhM1JNTXA1Bk4MZYY6f8akSbD
         4h9w==
X-Gm-Message-State: AOAM5300wIhgE90iiXi6DTY1hJf4ovBwN7+e528i8uq7bf1oq4YSJh+T
        HxKbQ6uMqTDGjM3P80Iz7Q+xjQ==
X-Google-Smtp-Source: ABdhPJzbgwwvQLLgNXiU4qs1FUcMhc/h3RfJiZXP6ECYiZWhZaxzr26Wf0leeiMoAq00m5jcGd4xeg==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr1396001wme.77.1605655771928;
        Tue, 17 Nov 2020 15:29:31 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id k3sm10212083wrn.81.2020.11.17.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:29:31 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next v4 2/2] bpf: Add tests for bpf_bprm_opts_set helper
Date:   Tue, 17 Nov 2020 23:29:29 +0000
Message-Id: <20201117232929.2156341-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232929.2156341-1-kpsingh@chromium.org>
References: <20201117232929.2156341-1-kpsingh@chromium.org>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/prog_tests/test_bprm_opts.c | 116 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bprm_opts.c |  34 +++++
 2 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/bprm_opts.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
new file mode 100644
index 000000000000..2559bb775762
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
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
+		execle("/bin/bash", "bash", "-c",
+		       "[[ -z \"${TMPDIR}\" ]] || exit 10 && exit 20", NULL,
+		       bash_envp);
+		exit(errno);
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		ret = WEXITSTATUS(child_status);
+
+		/* If a secureexec occurred, the exit status should be 20 */
+		if (secureexec && ret == 20)
+			return 0;
+
+		/* If normal execution happened, the exit code should be 10 */
+		if (!secureexec && ret == 10)
+			return 0;
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
+	if (CHECK(err, "run_set_secureexec:0", "err = %d\n", err))
+		goto close_prog;
+
+	/* Run the test with the secureexec bit set */
+	err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
+				 1 /* secureexec */);
+	if (CHECK(err, "run_set_secureexec:1", "err = %d\n", err))
+		goto close_prog;
+
+close_prog:
+	bprm_opts__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bprm_opts.c b/tools/testing/selftests/bpf/progs/bprm_opts.c
new file mode 100644
index 000000000000..5bfef2887e70
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
+		bpf_bprm_opts_set(bprm, BPF_F_BPRM_SECUREEXEC);
+
+	return 0;
+}
-- 
2.29.2.299.gdc1121823c-goog

