Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC513CA96
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAORNe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:13:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAORNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so727585wmi.5
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 09:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lk48qetZKyKWukIhgwRh7oanEwAxdHUHawT8EKhLs24=;
        b=VoK/cfOe18OMZeAhDw6GvIcgIn+YfEmL6obJDGmidtIeyWIry3wPOk4NCkSghYOqgt
         FeSzZ7cht3VGP5OcZA27IdhxA1nLZrCn47WOd4vn8st/5s/ELgE31T77Hh95XdCiVWTq
         +WTpsm9K1VCH6FCQ9+xRFEFX/AGr4ShHKjHKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lk48qetZKyKWukIhgwRh7oanEwAxdHUHawT8EKhLs24=;
        b=e7kFoPltu1RH2iexuZpkI3dnX2xRKr4o0sjPt3k/RJlWz+rVShhfPFEhbzUX8hFLsr
         nKjNWk191QyiPCdhBMm0EX0swzBmwmLHAZE7RhwvdXrjUxRDz52vqqhUB89ZNGPlDYx0
         BHR9S7KM3aYDyx9P1G//goAI97xKgq+cnGw/XWVr3JVJJiV6RscQVfyKkW/OMDe215ss
         0BeL+Kl9zITUmX0qF1vWxO7Q0vPoBBMJtuuq7wwC8bFlxwGPcXUcepKRjn5ZHMBMuTZK
         TkZTtUPBOARVAsAgxya0NEFNC2F+ngdegsHMKJjOdmkTv60V7RFiItQjsXx8askbnp/I
         4MAA==
X-Gm-Message-State: APjAAAW5yY5XO36YYYaMut97dhAOBKEmyP9OyNH9PdY3zsV1n9ZJONa9
        5IhNOoo8gZh/mcArWPrpwFn5VA==
X-Google-Smtp-Source: APXvYqxZnUBXj2TFr0fRlMTriJRJqkxc4KcmmCaQtMroHNbH2lkUynRPDo66FDJDeFTfsoDchvsRXw==
X-Received: by 2002:a05:600c:2c2:: with SMTP id 2mr879104wmn.155.1579108411281;
        Wed, 15 Jan 2020 09:13:31 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:30 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v2 09/10] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Wed, 15 Jan 2020 18:13:32 +0100
Message-Id: <20200115171333.28811-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Load a BPF program that audits mprotect calls
* Attach the program to the "file_mprotect" LSM hook
* Initialize the perf events buffer and poll for audit events
* Do an mprotect on some memory allocated on the heap
* Verify if the audit event was received

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS                                   |  2 +
 tools/testing/selftests/bpf/lsm_helpers.h     | 19 ++++++
 .../bpf/prog_tests/lsm_mprotect_audit.c       | 58 +++++++++++++++++++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  | 48 +++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 02d7e05e9b75..5d553c2e7452 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3210,6 +3210,8 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
 F:	include/linux/bpf_lsm.h
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
index 000000000000..f4569b418616
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
+#include "bpf_helpers.h"
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

