Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183A5127F9A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfLTPmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfLTPmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so9826680wrn.7
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yc9ODbRkpfKhA+Bxs3/DUYVIlQWXjVZp723Z2EeGdZc=;
        b=WKw3HQHg8X+hta1mRj20MRUciozMczPH5i128KkU11Y/6Nfc2CEQ+6Ypk95wkKHT7r
         trfBNwxwBNf8iNEWqfH6SHFqHARVSDKiAIyucpNqWzGpe/cejc3LEOlUuUqu66H6ummD
         1X6RfGF7NJWW0klqQLrlq2ImKsEQBIB5k4ojE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yc9ODbRkpfKhA+Bxs3/DUYVIlQWXjVZp723Z2EeGdZc=;
        b=e2nmMLG/j1iziuRmM5IWTCUGrvUzUnFLKKCwWVexHXTVIOCRtapwEyQI3Rm625jZRt
         GJLGfRT9DUTeA4QuuHED+VNUg8JAcFGqQJV7aXSpn9F9ClVuzGizijgKK92SAsOrJ9P0
         jCY932z8KZXF/RqqgA3pGBqi/R8cR7cNG0SqI4mGc4m7z6Fkyq2sI8xpKQzs8z9ef2HC
         kWpwEfQE0gyEG1AZZ+New4jvobyXqVUT31EVb4K0OGjEs67fZOkdy1h7XmL/K8VENkNI
         hH1zniQQmlmhDRGUNiqISGlG1U6bSB7lJEpIMJ/sbOFHojIp7AA9IE62pHw95yTX5mO8
         QEag==
X-Gm-Message-State: APjAAAVWZbeM5aVv4hvr0FrwdYXuwgv1YBVJ6an6p4vCqlftKVO95haa
        IrmEktFxhDKAgGcmboCgx5eRmw==
X-Google-Smtp-Source: APXvYqzZ/HeRiZyZqrHoGSRsTXmhTrhLhDdpjhDTQVQ/O6PcFtqYk1+XLqNQTXzXh0J3Va+0rBVjAQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr15758099wrx.244.1576856539446;
        Fri, 20 Dec 2019 07:42:19 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:18 -0800 (PST)
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
Subject: [PATCH bpf-next v1 12/13] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Fri, 20 Dec 2019 16:42:07 +0100
Message-Id: <20191220154208.15895-13-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Load a BPF program that audits mprotect calls
* Attach the program to the "file_mprotect" LSM hook
* Verify if the program is actually loading by reading
  securityfs
* Initialize the perf events buffer and poll for audit events
* Do an mprotect on some memory allocated on the heap
* Verify if the audit event was received

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS                                   |   2 +
 .../bpf/prog_tests/lsm_mprotect_audit.c       | 129 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  |  58 ++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 681ae39bb2f0..652c93292ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3182,6 +3182,8 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
 F:	include/linux/bpf_lsm.h
+F:	tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
+F:	tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
new file mode 100644
index 000000000000..953531cec9fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
@@ -0,0 +1,129 @@
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
+
+#define EXPECTED_PROG_NAME "mprotect_audit"
+#define MPROTECT_AUDIT_MAGIC 0xDEAD
+
+struct mprotect_audit_log {
+	int is_heap, magic;
+};
+
+static void on_sample(void *ctx, int cpu, void *data, __u32 size)
+{
+	struct mprotect_audit_log *audit_log = data;
+	int duration = 0;
+
+	if (audit_log->magic != MPROTECT_AUDIT_MAGIC)
+		return;
+
+	if (CHECK(audit_log->is_heap != 1, "mprotect on heap",
+		  "is_heap = %d\n", audit_log->is_heap))
+		return;
+
+	*(bool *)ctx = true;
+}
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
+	struct bpf_prog_load_attr attr = {
+		.file = "./lsm_mprotect_audit.o",
+	};
+
+	struct perf_buffer_opts pb_opts = {};
+	struct perf_buffer *pb = NULL;
+	struct bpf_link *link = NULL;
+	struct bpf_map *perf_buf_map;
+	struct bpf_object *prog_obj;
+	struct bpf_program *prog;
+	int err, prog_fd, sfs_fd;
+	char sfs_buf[1024];
+	int duration = 0;
+	bool passed = false;
+
+	err = bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd);
+	if (CHECK(err, "prog_load lsm/file_mprotect",
+		  "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	prog = bpf_object__find_program_by_title(prog_obj, "lsm/file_mprotect");
+	if (CHECK(!prog, "find_prog", "lsm/file_mprotect not found\n"))
+		goto close_prog;
+
+	link = bpf_program__attach_lsm(prog);
+	if (CHECK(IS_ERR(link), "attach_lsm file_mprotect",
+				 "err %ld\n", PTR_ERR(link)))
+		goto close_prog;
+
+	sfs_fd = open("/sys/kernel/security/bpf/file_mprotect", O_RDONLY);
+	if (CHECK(sfs_fd < 0, "sfs_open file_mprotect",
+		  "err %d errno %d\n", sfs_fd, errno))
+		goto close_prog;
+
+	err = read(sfs_fd, sfs_buf, sizeof(sfs_buf));
+	if (CHECK(err < 0, "sfs_read file_mprotect",
+		  "err %d errno %d\n", sfs_fd, errno))
+		goto close_prog;
+
+	err = strncmp(sfs_buf, EXPECTED_PROG_NAME, strlen(EXPECTED_PROG_NAME));
+	if (CHECK(err != 0,
+		  "sfs_read value", "want = %s, got = %s\n",
+		  EXPECTED_PROG_NAME, sfs_buf))
+		goto close_prog;
+
+	perf_buf_map = bpf_object__find_map_by_name(prog_obj, "perf_buf_map");
+	if (CHECK(!perf_buf_map, "find_perf_buf_map", "not found\n"))
+		goto close_prog;
+
+	/* set up perf buffer */
+	pb_opts.sample_cb = on_sample;
+	pb_opts.ctx = &passed;
+	pb = perf_buffer__new(bpf_map__fd(perf_buf_map), 1, &pb_opts);
+	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
+		goto close_prog;
+
+	err = heap_mprotect();
+	if (CHECK(err < 0, "heap_mprotect",
+		  "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	/* read perf buffer */
+	err = perf_buffer__poll(pb, 100);
+	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
+		goto close_prog;
+
+	/*
+	 * make sure mprotect_audit program was triggered
+	 * and detected an mprotect on the heap
+	 */
+	CHECK_FAIL(!passed);
+
+close_prog:
+	perf_buffer__free(pb);
+	if (!IS_ERR_OR_NULL(link))
+		bpf_link__destroy(link);
+	bpf_object__close(prog_obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
new file mode 100644
index 000000000000..85048315baae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
@@ -0,0 +1,58 @@
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
+
+char _license[] SEC("license") = "GPL";
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} perf_buf_map SEC(".maps");
+
+#define MPROTECT_AUDIT_MAGIC 0xDEAD
+
+struct mprotect_audit_log {
+	int is_heap, magic;
+};
+
+/*
+ * Define some of the structs used in the BPF program.
+ * Only the field names and their sizes need to be the
+ * same as the kernel type, the order is irrelevant.
+ */
+struct mm_struct {
+	unsigned long start_brk, brk, start_stack;
+};
+
+struct vm_area_struct {
+	unsigned long start_brk, brk, start_stack;
+	unsigned long vm_start, vm_end;
+	struct mm_struct *vm_mm;
+	unsigned long vm_flags;
+};
+
+BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
+	    struct vm_area_struct *, vma,
+	    unsigned long, reqprot, unsigned long, prot)
+{
+	struct mprotect_audit_log audit_log = {};
+	int is_heap = 0;
+
+	__builtin_preserve_access_index(({
+		is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+				     vma->vm_end <= vma->vm_mm->brk);
+	}));
+
+	audit_log.magic = MPROTECT_AUDIT_MAGIC;
+	audit_log.is_heap = is_heap;
+	bpf_lsm_event_output(&perf_buf_map, BPF_F_CURRENT_CPU, &audit_log,
+			     sizeof(audit_log));
+	return 0;
+}
-- 
2.20.1

