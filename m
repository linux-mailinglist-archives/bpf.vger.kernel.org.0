Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10899166565
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBTRxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgBTRxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so5619258wru.7
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adfWj6krnYMDay+GPoQfqpNZuN5MZlEFMLgjeZEuGG8=;
        b=B3piX1VDd0y+GiS3xOijNGSIS70I0ytViQp349mNrJ9q866rEPEN8mdD4TzrOQT4WM
         CwRexqXTw0sefFk71rFC7BkFTTbNbCwH5qtot+ZlZxLAzhoO9BrOS55PvQNOFIlSPuyO
         ia7M5YF+7sylLkAXIQY8vfxLf3QJ2PkYBVCzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adfWj6krnYMDay+GPoQfqpNZuN5MZlEFMLgjeZEuGG8=;
        b=bScjyjHzUyEqhwjxo/u3ZjtseSRR0o+Vjdpfy6y3PWNPHcAFFQ25CnRPugZfQ52aq1
         rO2ZsKlrE13Ayufzv0A5+L9w9cOESvCxn2CXDVvSO7PsWfynUS7eewCZx3iAwO9+lP7D
         k+MGwij+Go28Fx5n6xtHV4Eezdj87helrZ2NsRcwY86jVlh0ofoag4FDYhnFvVYfq22k
         Evo6RTLmuhRpYjblgfJDyZfM19cXU8CS1chw4QMIJ6pn5cFuQOFTaWb8HN5bsAkEPi4t
         wDldYCPZzp2FzpuulHzDf/z43VcxOVINEbqCoPdkHF5aMUNXOq+ra7eoAIGmwiczGbXp
         JJug==
X-Gm-Message-State: APjAAAVwtMyOHMCofxTRS9Kl7Kvw5OpRX4p5Ps6eqLEI9zPL5A1aYiyd
        TtGz13qwnx9tH4cDTkpJlgxTSw==
X-Google-Smtp-Source: APXvYqyKZvCNuUcqJozkMRYf/cFD+U0nFmP2+o8GPNyDe0jeSaF09jaWPuXvxncvQlu+uLdva4G56Q==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr43474331wrq.396.1582221183000;
        Thu, 20 Feb 2020 09:53:03 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:53:02 -0800 (PST)
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
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Thu, 20 Feb 2020 18:52:49 +0100
Message-Id: <20200220175250.10795-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Load a BPF program that hooks to the mprotect calls.
* Attach the program to the "file_mprotect" LSM hook.
* Do an mprotect on some memory allocated on the heap
* Verify if the return value is overridden.
* Verify if the audit event was received using the shared global
  result variable.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 tools/testing/selftests/bpf/lsm_helpers.h     | 19 ++++
 .../selftests/bpf/prog_tests/lsm_mprotect.c   | 96 +++++++++++++++++++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  | 48 ++++++++++
 .../selftests/bpf/progs/lsm_mprotect_mac.c    | 53 ++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c

diff --git a/tools/testing/selftests/bpf/lsm_helpers.h b/tools/testing/selftests/bpf/lsm_helpers.h
new file mode 100644
index 000000000000..b973ec1c4a0b
--- /dev/null
+++ b/tools/testing/selftests/bpf/lsm_helpers.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+#ifndef _LSM_HELPERS_H
+#define _LSM_HELPERS_H
+
+struct lsm_mprotect_result {
+	/* This ensures that the LSM Hook only monitors the PID requested
+	 * by the loader
+	 */
+	__u32 monitored_pid;
+	/* The number of mprotect calls for the monitored PID.
+	 */
+	__u32 mprotect_count;
+};
+
+#endif /* _LSM_HELPERS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c
new file mode 100644
index 000000000000..93c3b5fb2ef0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <malloc.h>
+#include "lsm_helpers.h"
+#include "lsm_mprotect_audit.skel.h"
+#include "lsm_mprotect_mac.skel.h"
+
+int heap_mprotect(void)
+{
+	void *buf;
+	long sz;
+
+	sz = sysconf(_SC_PAGESIZE);
+	if (sz < 0)
+		return sz;
+
+	buf = memalign(sz, 2 * sz);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	return mprotect(buf, sz, PROT_READ | PROT_EXEC);
+}
+
+void test_lsm_mprotect_audit(void)
+{
+	struct lsm_mprotect_result *result;
+	struct lsm_mprotect_audit *skel = NULL;
+	int err, duration = 0;
+
+	skel = lsm_mprotect_audit__open_and_load();
+	if (CHECK(!skel, "skel_load", "lsm_mprotect_audit skeleton failed\n"))
+		goto close_prog;
+
+	err = lsm_mprotect_audit__attach(skel);
+	if (CHECK(err, "attach", "lsm_mprotect_audit attach failed: %d\n", err))
+		goto close_prog;
+
+	result = &skel->bss->result;
+	result->monitored_pid = getpid();
+
+	err = heap_mprotect();
+	if (CHECK(err < 0, "heap_mprotect", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	/* Make sure mprotect_audit program was triggered
+	 * and detected an mprotect on the heap.
+	 */
+	CHECK_FAIL(result->mprotect_count != 1);
+
+close_prog:
+	lsm_mprotect_audit__destroy(skel);
+}
+
+void test_lsm_mprotect_mac(void)
+{
+	struct lsm_mprotect_result *result;
+	struct lsm_mprotect_mac *skel = NULL;
+	int err, duration = 0;
+
+	skel = lsm_mprotect_mac__open_and_load();
+	if (CHECK(!skel, "skel_load", "lsm_mprotect_mac skeleton failed\n"))
+		goto close_prog;
+
+	err = lsm_mprotect_mac__attach(skel);
+	if (CHECK(err, "attach", "lsm_mprotect_mac attach failed: %d\n", err))
+		goto close_prog;
+
+	result = &skel->bss->result;
+	result->monitored_pid = getpid();
+
+	err = heap_mprotect();
+	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
+		  errno))
+		goto close_prog;
+
+	/* Make sure mprotect_mac program was triggered
+	 * and detected an mprotect on the heap.
+	 */
+	CHECK_FAIL(result->mprotect_count != 1);
+
+close_prog:
+	lsm_mprotect_mac__destroy(skel);
+}
+
+void test_lsm_mprotect(void)
+{
+	test_lsm_mprotect_audit();
+	test_lsm_mprotect_mac();
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
new file mode 100644
index 000000000000..c68fb02b57fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include "bpf_trace_helpers.h"
+#include  <errno.h>
+#include "lsm_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct lsm_mprotect_result result = {
+	.mprotect_count = 0,
+	.monitored_pid = 0,
+};
+
+/*
+ * Define some of the structs used in the BPF program.
+ * Only the field names and their sizes need to be the
+ * same as the kernel type, the order is irrelevant.
+ */
+struct mm_struct {
+	unsigned long start_brk, brk;
+} __attribute__((preserve_access_index));
+
+struct vm_area_struct {
+	unsigned long vm_start, vm_end;
+	struct mm_struct *vm_mm;
+} __attribute__((preserve_access_index));
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
+	     unsigned long reqprot, unsigned long prot)
+{
+	__u32 pid = bpf_get_current_pid_tgid();
+	int is_heap = 0;
+
+	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+		   vma->vm_end <= vma->vm_mm->brk);
+
+	if (is_heap && result.monitored_pid == pid)
+		result.mprotect_count++;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c b/tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c
new file mode 100644
index 000000000000..c0ae344593e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_mprotect_mac.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include "bpf_trace_helpers.h"
+#include  <errno.h>
+#include "lsm_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct lsm_mprotect_result result = {
+	.mprotect_count = 0,
+	.monitored_pid = 0,
+};
+
+/*
+ * Define some of the structs used in the BPF program.
+ * Only the field names and their sizes need to be the
+ * same as the kernel type, the order is irrelevant.
+ */
+struct mm_struct {
+	unsigned long start_brk, brk;
+} __attribute__((preserve_access_index));
+
+struct vm_area_struct {
+	unsigned long vm_start, vm_end;
+	struct mm_struct *vm_mm;
+} __attribute__((preserve_access_index));
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(mprotect_mac, struct vm_area_struct *vma,
+	     unsigned long reqprot, unsigned long prot, int ret)
+{
+	if (ret != 0)
+		return ret;
+
+	__u32 pid = bpf_get_current_pid_tgid();
+	int is_heap = 0;
+
+	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+		   vma->vm_end <= vma->vm_mm->brk);
+
+	if (is_heap && result.monitored_pid == pid) {
+		result.mprotect_count++;
+		ret = -EPERM;
+	}
+
+	return ret;
+}
-- 
2.20.1

