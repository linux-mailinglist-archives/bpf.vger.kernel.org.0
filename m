Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5655B19416E
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgCZO3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 10:29:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34814 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgCZO2o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so7562248wmk.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0D2qE0TthBZ6mLMUn5wGGpixTsHsgsgDg257+To4wvU=;
        b=XYUKCxo/IwmasfiaT9g/7rlTqCKHtu3uL2ytSOnB+a0JO9I/KdH0zKD952z9ZG1EhK
         wzVv99GCUTNAkbMwF2wvKUwa37J4e1YfGWbwhRl/fHmGEIALX9bbtXbhw9iVTqSGJHgm
         FOXuRfhA4QEs49hriaN27YoGaZuLXlVoWDTBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0D2qE0TthBZ6mLMUn5wGGpixTsHsgsgDg257+To4wvU=;
        b=nXXSz5mq2k+R8qGGDSA2pkOPvFw4CUSshCaOM11bR9+rd3qJxXdz+QYR2jqPLTahFa
         8aFvDkV2g8a8TIQWqTMpUTIem6ztPudJ71IJ+KPBypEDBDSa82mr/4rygnph2FDK+8Vv
         QNMZ05h9AfA7EtzhxHisizKsm4knVSUp51OpLenE63PCIOH7OnAJ1o6yblT/sDK2dhQi
         U+Zp02OdGwKi3ZHCB1OwEkh5/K8uMPCbmKY0TD9psGVuk0WavKma1gqPLkfKn0+0PIp6
         ANoQe2/x/Cfrx1dZxN6nXvJLN/Wvl3M/NRZNTun34atRW0cKCp0zTm279feofSn3hoX8
         DvNA==
X-Gm-Message-State: ANhLgQ2QerFzgVzHRLJ62oc1XYBsgyRD8p1jVa2LXqZtnETA9kU5lhaF
        OHoEkpzMPgT8QUOy8s7VOX6k+w==
X-Google-Smtp-Source: ADFU+vtC/oT86hzA9d339JN9sfEpptbj+hFl53JHVms84DNEqAhUYK6mXMMYkkdIh2Sy3OiNle1QoQ==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr257591wmn.66.1585232922642;
        Thu, 26 Mar 2020 07:28:42 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:42 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Thu, 26 Mar 2020 15:28:22 +0100
Message-Id: <20200326142823.26277-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Load/attach a BPF program that hooks to file_mprotect (int)
  and bprm_committed_creds (void).
* Perform an action that triggers the hook.
* Verify if the audit event was received using the shared global
  variables for the process executed.
* Verify if the mprotect returns a -EPERM.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 tools/testing/selftests/bpf/config            |  2 +
 .../selftests/bpf/prog_tests/test_lsm.c       | 86 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 5dc109f4c097..60e3ae5d4e48 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -35,3 +35,5 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
 CONFIG_BPF_JIT=y
+CONFIG_BPF_LSM=y
+CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
new file mode 100644
index 000000000000..6eb7060e4422
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <malloc.h>
+#include <stdlib.h>
+
+#include "lsm.skel.h"
+
+char *CMD_ARGS[] = {"true", NULL};
+
+int heap_mprotect(void)
+{
+	void *buf;
+	long sz;
+	int ret;
+
+	sz = sysconf(_SC_PAGESIZE);
+	if (sz < 0)
+		return sz;
+
+	buf = memalign(sz, 2 * sz);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	ret = mprotect(buf, sz, PROT_READ | PROT_EXEC);
+	free(buf);
+	return ret;
+}
+
+int exec_cmd(int *monitored_pid)
+{
+	int child_pid, child_status;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		*monitored_pid = getpid();
+		execvp(CMD_ARGS[0], CMD_ARGS);
+		return -EINVAL;
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		return child_status;
+	}
+
+	return -EINVAL;
+}
+
+void test_test_lsm(void)
+{
+	struct lsm *skel = NULL;
+	int err, duration = 0;
+
+	skel = lsm__open_and_load();
+	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
+		goto close_prog;
+
+	err = lsm__attach(skel);
+	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
+		goto close_prog;
+
+	err = exec_cmd(&skel->bss->monitored_pid);
+	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d",
+	      skel->bss->bprm_count);
+
+	skel->bss->monitored_pid = getpid();
+
+	err = heap_mprotect();
+	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
+		  errno))
+		goto close_prog;
+
+	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
+	      "mprotect_count = %d", skel->bss->mprotect_count);
+
+close_prog:
+	lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
new file mode 100644
index 000000000000..a4e3c223028d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include  <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+int monitored_pid = 0;
+int mprotect_count = 0;
+int bprm_count = 0;
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
+	     unsigned long reqprot, unsigned long prot, int ret)
+{
+	if (ret != 0)
+		return ret;
+
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	int is_heap = 0;
+
+	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+		   vma->vm_end <= vma->vm_mm->brk);
+
+	if (is_heap && monitored_pid == pid) {
+		mprotect_count++;
+		ret = -EPERM;
+	}
+
+	return ret;
+}
+
+SEC("lsm/bprm_committed_creds")
+int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (monitored_pid == pid)
+		bprm_count++;
+
+	return 0;
+}
-- 
2.20.1

