Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8B6528A6
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiLTWBz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiLTWBx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:01:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4A265B;
        Tue, 20 Dec 2022 14:01:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so13802201pjo.4;
        Tue, 20 Dec 2022 14:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Een9ADhaz5ehEAwvU7HmNyImJ88Ez5hMroHk5J56uIY=;
        b=SYMe3153Rgqa44SBJ483+8SEvUSJddnUW99SDn7Cb7pisiecKZ4W9gurVO9hgUr85U
         xWVIaidt/JbnlDs+ZA+sEB+RmzsUVxqHG5Bkxr5AczT73lAmR6y9BTa2QCambxcvjt9N
         ifU4qYhtoyoQYg6OgVNToRz7WshXgdBhqs0hDtHbQSY7ALJ1ViRQXukWfMO9uL/UxXIo
         izzbQ5JUfhgnciKx9aawh7HZsvmWErSipBZNEhxjWsgUVBuwSfnD92MEaqgap4ZbT0C+
         PcjfLOUpLXVcUrDC9Oex6c4EGRq1ME2Mf5ftHlZD2gYc0lIrRepJJCpygbVjCj/4bwFr
         S47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Een9ADhaz5ehEAwvU7HmNyImJ88Ez5hMroHk5J56uIY=;
        b=uPNyJI62gC73Mfjb1wbL4epExfc6cgZbFAN/p8M7SSSckokukXPlIRCCG+H2jjPy3S
         PRhz+BU13NpG8DMBfys8nSJ0mdjcHJ+9CCTI9mGOsMbLtvBvVSYpnQ3FE/Fh3pEMrCUW
         7A4GwW5NVlYwAD1VUXTr6bYiVHQt6QoFbaAf6/REJBfBtj8ET5EtVJYpPOM4Yzvwd7+t
         m8lEAAD8Wo6GPrrFsUE9zIWs4ZOGCa1bPnDgynYkhpKw13xHxuhFVeErU8app4GWjpJ/
         JPYj4ugEwyrTutmwvJ07/99c8e2fn2p/ad3a4F+G6jYwHxccbbWQvIQMEMpC7IU/QKvw
         l9mA==
X-Gm-Message-State: ANoB5pn8BknGcIcWXjU5eBhgJrLPZRzfQLarlACLLdSDcOrWbJGXBUEq
        DEt8YVgN7mFl1GGGsvclCUo=
X-Google-Smtp-Source: AA0mqf54MeYpjZZW+1Y7x5xPCzVqiUZI5umLUtQO1SZfSgWrcvf7l7Y/KSS2ywRVk0CE1Z9PrRZJ3Q==
X-Received: by 2002:a17:90a:db04:b0:219:b936:6bd7 with SMTP id g4-20020a17090adb0400b00219b9366bd7mr49496981pjv.19.1671573711192;
        Tue, 20 Dec 2022 14:01:51 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:68c4:de54:581a:ee2])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a174200b00217090ece49sm14374pjm.31.2022.12.20.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:01:50 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add perf_event_read_sample test cases
Date:   Tue, 20 Dec 2022 14:01:44 -0800
Message-Id: <20221220220144.4016213-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221220220144.4016213-1-namhyung@kernel.org>
References: <20221220220144.4016213-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It checks the perf event sample access with bpf_cast_to_kern_ctx().
It should access sample data only event->attr.sample_type allows.
Other fields might not be initialized.

  $ ./vmtest.sh ./test_progs -t perf_event_read_sample
  ...
  #135/1   perf_event_read_sample/perf_event_read_sample_ok:OK
  #135/2   perf_event_read_sample/perf_event_read_sample_invalid:OK
  #135     perf_event_read_sample:OK

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_sample.c    | 167 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_sample.c    |  33 ++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_sample.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_sample.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_sample.c b/tools/testing/selftests/bpf/prog_tests/perf_sample.c
new file mode 100644
index 000000000000..dc1e88711e23
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_sample.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/perf_event.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+
+#include <test_progs.h>
+#include "test_perf_sample.skel.h"
+
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+/* treat user-stack data as invalid (for testing only) */
+#define PERF_SAMPLE_INVALID  PERF_SAMPLE_STACK_USER
+
+#define PERF_MMAP_SIZE  8192
+#define DATA_MMAP_SIZE  4096
+
+static int perf_fd = -1;
+static void *perf_ringbuf;
+static struct test_perf_sample *skel;
+
+static int open_perf_event(u64 sample_flags)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_PAGE_FAULTS,
+		.sample_type = sample_flags,
+		.sample_period = 1,
+		.disabled = 1,
+		.size = sizeof(attr),
+	};
+	int fd;
+	void *ptr;
+
+	fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+	if (!ASSERT_GT(fd, 0, "perf_event_open"))
+		return -1;
+
+	ptr = mmap(NULL, PERF_MMAP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(ptr, MAP_FAILED, "mmap")) {
+		close(fd);
+		return -1;
+	}
+
+	perf_fd = fd;
+	perf_ringbuf = ptr;
+
+	return 0;
+}
+
+static void close_perf_event(void)
+{
+	if (perf_fd == -1)
+		return;
+
+	munmap(perf_ringbuf, PERF_MMAP_SIZE);
+	close(perf_fd);
+
+	perf_fd = -1;
+	perf_ringbuf = NULL;
+}
+
+static noinline void *trigger_perf_event(void)
+{
+	int *buf = mmap(NULL, DATA_MMAP_SIZE, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
+
+	if (!ASSERT_NEQ(buf, MAP_FAILED, "mmap"))
+		return NULL;
+
+	ioctl(perf_fd, PERF_EVENT_IOC_ENABLE);
+
+	/* it should generate a page fault which triggers the perf_event */
+	*buf = 1;
+
+	ioctl(perf_fd, PERF_EVENT_IOC_DISABLE);
+
+	munmap(buf, DATA_MMAP_SIZE);
+
+	/* return the map address to check the sample addr */
+	return buf;
+}
+
+/* check if the perf ringbuf has a sample data */
+static int check_perf_event(void)
+{
+	struct perf_event_mmap_page *page = perf_ringbuf;
+	struct perf_event_header *hdr;
+
+	if (page->data_head == page->data_tail)
+		return 0;
+
+	hdr = perf_ringbuf + page->data_offset;
+
+	if (hdr->type != PERF_RECORD_SAMPLE)
+		return 0;
+
+	return 1;
+}
+
+static void setup_perf_sample_bpf_skel(void)
+{
+	struct bpf_link *link;
+
+	skel = test_perf_sample__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_perf_sample_open_and_load"))
+		return;
+
+	link = bpf_program__attach_perf_event(skel->progs.perf_sample_filter, perf_fd);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_perf_event"))
+		return;
+}
+
+static void clean_perf_sample_bpf_skel(void)
+{
+	test_perf_sample__detach(skel);
+	test_perf_sample__destroy(skel);
+}
+
+static void test_perf_event_read_sample_ok(void)
+{
+	u64 flags = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR;
+	uintptr_t map_addr;
+
+	if (open_perf_event(flags) < 0)
+		return;
+	setup_perf_sample_bpf_skel();
+	map_addr = (uintptr_t)trigger_perf_event();
+
+	ASSERT_EQ(check_perf_event(), 1, "number of sample");
+	ASSERT_EQ(skel->bss->sample_addr, map_addr, "sample addr");
+	ASSERT_EQ((int)skel->bss->sample_pid, getpid(), "sample pid");
+	/* just assume the IP in (trigger_perf_event, +4096) */
+	ASSERT_GT(skel->bss->sample_ip, (uintptr_t)trigger_perf_event, "sample ip");
+	ASSERT_LT(skel->bss->sample_ip, (uintptr_t)trigger_perf_event + 4096, "sample ip");
+
+	clean_perf_sample_bpf_skel();
+	close_perf_event();
+}
+
+static void test_perf_event_read_sample_invalid(void)
+{
+	u64 flags = PERF_SAMPLE_INVALID;
+
+	if (open_perf_event(flags) < 0)
+		return;
+	setup_perf_sample_bpf_skel();
+	trigger_perf_event();
+
+	ASSERT_EQ(check_perf_event(), 0, "number of sample");
+
+	clean_perf_sample_bpf_skel();
+	close_perf_event();
+}
+
+void test_perf_event_read_sample(void)
+{
+	if (test__start_subtest("perf_event_read_sample_ok"))
+		test_perf_event_read_sample_ok();
+	if (test__start_subtest("perf_event_read_sample_invalid"))
+		test_perf_event_read_sample_invalid();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_sample.c b/tools/testing/selftests/bpf/progs/test_perf_sample.c
new file mode 100644
index 000000000000..b1f498d447b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_sample.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022 Google
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+unsigned long long sample_ip;
+unsigned long long sample_pid;
+unsigned long long sample_addr;
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+#define SAMPLE_FLAGS  (PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR)
+
+SEC("perf_event")
+int perf_sample_filter(void *ctx)
+{
+	struct bpf_perf_event_data_kern *kctx;
+
+	kctx = bpf_cast_to_kern_ctx(ctx);
+
+	if ((kctx->event->attr.sample_type & SAMPLE_FLAGS) != SAMPLE_FLAGS)
+		return 0;
+
+	sample_ip = kctx->data->ip;
+	sample_pid = kctx->data->tid_entry.pid;
+	sample_addr = kctx->data->addr;
+
+	/* generate sample data */
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.0.314.g84b9a713c41-goog

