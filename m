Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68A2B456B
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgKPOBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 09:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgKPOBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 09:01:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7BC0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:01:15 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so18778966wrb.9
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOygS4wWi0Mj1OKkBe1SNoBK+tephMdRiAacrMx8etU=;
        b=NgM9NiqMXIwVQwGA4tiLK8TugEdapmeUTnU0tcd32I1WRaTpnt52QkfVJ5P7xmtzfY
         VfyeF056+ZgDX4g0V3z9p85HtXd+NCWVFUh9LTTHqYBCJn7ng7UxArhtuaR5ysPm2n/f
         i4frP9y3JhVjmFiKDJuDAJW6DDjtUL6T16cXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOygS4wWi0Mj1OKkBe1SNoBK+tephMdRiAacrMx8etU=;
        b=PsVM4f1h1MFnW+9aD1CJffclunJD9DX3CTwtKOrt2AkzmrGCG5u2fmsdDAoR4SXSLd
         fRINHAR2IRBuwdREKBvq5Zo5PSxSPW/H869tU+e1lExa+6Me+NqB1kLpJ1WgfCF77n/e
         U5WulGguNBpsHzkxtbIbh6UfKSAGyzpUY7H6WO5rXaZ9jYVYnmxhRIvNzkF+wrs1AceA
         cK6CBzvCzETM+kvl1GsCFUu9sJJJ5WdsfY8ShB1zojipD2KcKMPWYE8jc4+XkIYtzGU/
         HJG/2xxky1n5/lEuhZBsaj2OQEzYobK/VPwfR9wobdCLRbaDdgPa5VP60MnnjL45g4kn
         2hLg==
X-Gm-Message-State: AOAM531dz2yLtKJhqG3WCDuXpu4rh54+DBdpFI0ln3lVBXceDM2PEOBF
        83CMWiFO/2iF4TNpRiullGUSXg==
X-Google-Smtp-Source: ABdhPJwFCz/cQODQFE7vC86rW4ighvTHoYBoaQ+wLVzowqnryyeBjVSkpYBnA0UOvY9KWPkBhWRD6g==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr14382452wru.292.1605535273948;
        Mon, 16 Nov 2020 06:01:13 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id i11sm23172477wrm.1.2020.11.16.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:01:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
Date:   Mon, 16 Nov 2020 15:01:10 +0100
Message-Id: <20201116140110.1412642-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116140110.1412642-1-kpsingh@chromium.org>
References: <20201116140110.1412642-1-kpsingh@chromium.org>
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
 tools/testing/selftests/bpf/progs/bprm_opts.c |  35 +++++
 2 files changed, 159 insertions(+)
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
index 000000000000..af4741fc5765
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bprm_opts.c
@@ -0,0 +1,35 @@
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
+	if (!secureexec)
+		return 0;
+
+	if (*secureexec)
+		bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);
+	return 0;
+}
-- 
2.29.2.299.gdc1121823c-goog

