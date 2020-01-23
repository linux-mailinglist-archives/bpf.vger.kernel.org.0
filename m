Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBF146CB3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAWPZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgAWPZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id 62so1677839pfu.11
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MmRJe3DElaN6x34LdFhi955VR7hntKawxO/WlNWMHYE=;
        b=AUMGBbBRa+ZQXAPMJHFivBlNtYgG7SGyNNJddvjw0j9t5D+tl6WBpRtKwA00qZpp6I
         UBeptFdGetKXP781nQN6RIvmcL1Sv/j6lri1XRHEikkCMl3JgSnbte0w23AH6tk8nJN6
         5MQ3BJjv+XiBHauGdU02oiWrDMmlmHwbYOHr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MmRJe3DElaN6x34LdFhi955VR7hntKawxO/WlNWMHYE=;
        b=OG/i3VuLNqKpVPnRGswu1RVnvXFOA1uTcWshrPKnxAWAGZU0Qt7tmASTbS9lRoXQXA
         IxFzbW9NRp6mN6bYqIT4C4nK9aU032E7rWXwbFTgJWeD3waHOXD00cJsIwsIcU1UJkKk
         dyAHi1M66mKy2SxvWhv+65rurdoSaHir3kimS2UfyqSaBoNEZi1ej69RhdOW+ReVdBSL
         69D7DNKDfxaNdhbqSQqaTrxtRnqW96qgBqxgS4CdN+bCYD/IG4XyY0IBB697ozhP8R3j
         WBVrR6vdpL0Lk6HzG9wML2ZzgirSlEN4Ogn45gTGnxkqRcbpvWRKliNBH+mOxvxsloki
         /1MA==
X-Gm-Message-State: APjAAAVO7J7mI74rOq7LlBnmlW6XCWCVWQXIZPOhwp4EHkBfY/X01nXR
        vytgmJJxsczNtwtd1Xp4hTYpFA==
X-Google-Smtp-Source: APXvYqwCfzKnHVrml3SIxl4VLRdTCUr8xN43FTo8AM8sb1ZHHMOJ28xhBQs7HKB4eiJVhYpFMzhezQ==
X-Received: by 2002:a62:7c58:: with SMTP id x85mr4551590pfc.76.1579793125244;
        Thu, 23 Jan 2020 07:25:25 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:24 -0800 (PST)
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 09/10] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Thu, 23 Jan 2020 07:24:39 -0800
Message-Id: <20200123152440.28956-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Load a BPF program that audits mprotect calls
* Attach the program to the "file_mprotect" LSM hook.
* Do an mprotect on some memory allocated on the heap
* Verify if the audit event was received using the shared global
  result variable.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 MAINTAINERS                                   |  3 +
 tools/testing/selftests/bpf/lsm_helpers.h     | 19 ++++++
 .../bpf/prog_tests/lsm_mprotect_audit.c       | 58 +++++++++++++++++++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  | 47 +++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c606b3d89992..32236d89d00b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3210,6 +3210,9 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
 F:	include/linux/bpf_lsm.h
+F:	tools/testing/selftests/bpf/lsm_helpers.h
+F:	tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
+F:	tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
diff --git a/tools/testing/selftests/bpf/lsm_helpers.h b/tools/testing/selftests/bpf/lsm_helpers.h
new file mode 100644
index 000000000000..8bad08f77654
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
+struct lsm_mprotect_audit_result {
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
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
new file mode 100644
index 000000000000..ff90b874eafc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
@@ -0,0 +1,58 @@
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
+	struct lsm_mprotect_audit_result *result;
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
diff --git a/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
new file mode 100644
index 000000000000..231cd64fd0f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include "bpf_trace_helpers.h"
+#include "lsm_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct lsm_mprotect_audit_result result = {
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
-- 
2.20.1

