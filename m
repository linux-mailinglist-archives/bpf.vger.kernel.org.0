Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8F195EBA
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC0T3M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54778 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgC0T3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so12639572wmd.4
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjN96pPP2Ws9AKqOwqjPj/iDmHQIGB0PlzbKlrnTivA=;
        b=H9RYIRC4MLsoxRogGWOsAjGK7I4zSI+8sGkO7aqruzXI+qO/Co1A2yHjdSST9m4lhO
         U5liN4MhqN9teJtAM1qnL8Njme1ihvRHSbZzI7nSIviAl8iqnT2WFDc1K0uIqq6QX0kc
         5fe0eOIZSUv46Cp9xDjOrJKZ+G34dKIFE9y9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjN96pPP2Ws9AKqOwqjPj/iDmHQIGB0PlzbKlrnTivA=;
        b=IOD9QCj4hwlEY+KEsLAMe4DlAiFoF902z+362XjTTGeglDAlFiwVDH25qQtfF+wBWK
         FykToGRZBsGJKBXsd7QXfVSj+AlukzolhPJ02VMSbGo1T0A3i95gFCflKOv0bhyfQcKp
         TRf6SQg7sQImsLW1lToG2/oTftlCK+zHnibdSwZ7uYUPgl0E/iYMVzTds7QdCb66SsBx
         Hrky8zgAa6TmI4kGTGOsBU+4yJwzwrQ2V5z99ZL7auweu2yTIoZYNy9EpTMvlu26yHmP
         5lGEu12utjOTtE8zky27AJhLP5uY3e4hRXC1cwiA9X1Amop3qYbD43RNk0+EmaVYJ0AL
         7uLg==
X-Gm-Message-State: ANhLgQ3JhsaIpYpWEJ0DQn1giKwpcrASa4IdUc4BJ4qjqNOuEmg/4Pbw
        pj7GgTQbMJ3y50bRr65RZoPp1w==
X-Google-Smtp-Source: ADFU+vvZQrbbq5LysQJtVTaesZD/q0q5uAv+i15vvDu/q53t97wXy300CvR2AJSWFUQIsY1zGp6anA==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr197718wmf.160.1585337345985;
        Fri, 27 Mar 2020 12:29:05 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:29:05 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v8 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Fri, 27 Mar 2020 20:28:53 +0100
Message-Id: <20200327192854.31150-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
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
index 000000000000..fcd839e88540
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
+	CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d\n",
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
+	      "mprotect_count = %d\n", skel->bss->mprotect_count);
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

