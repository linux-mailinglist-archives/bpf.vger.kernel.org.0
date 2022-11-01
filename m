Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CAA614430
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 06:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKAFXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 01:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiKAFXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 01:23:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7FB02;
        Mon, 31 Oct 2022 22:23:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 20so12544435pgc.5;
        Mon, 31 Oct 2022 22:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCQ6m+iiPPfCEHc1DMVvUTpMxY5WVNF+ufmtjL4sYpE=;
        b=BTX/s0xIMzCAql3L1tLe9UavK2LuJRDuNow7m4tbR6BXXp3GgiNOwKGipwUFB89nYb
         qXZoVuAhrg3cmWmjArGme96wSj/Org3eRW8khGUBOYGI3/dqF2N1t7HWcotTJ+fcBWOW
         g+QveSd1i1/IGoohora3JC98p7q0kaxwi4TiI8eTgjzY0TZLm7roIgowHOJ2Ka0gRdD2
         Bnhfckt9ZV/JUGpkRir6ubYwK8mO3bm21lz+7NhRap0HRq/m9pgy2VC+tSZR4xLXZNza
         N7OkHHU3DZcxX9xzLlBVHyzvuLKNui6oqO5AYW+rd39diYxUaFyfyQog15kF3rovcWuD
         2oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCQ6m+iiPPfCEHc1DMVvUTpMxY5WVNF+ufmtjL4sYpE=;
        b=lmFcgIBCVgPFY3HTCqwrVN02I3wNBBQpfOFKXNGdfJJtLUWKf0dH+s40qiHROP3inT
         EFTd5fm4kMLlTRFjIW9YjiwTjq/S1C2wYi50RhcLObPM4juQCp3ApXJIuUbMGHvxBjtE
         +zSTFiceWOj/N91yNgF8EdeotzKITeeFaFg+6wZS+jUxuSbRAGHAP+G2s/paffbjPYP6
         gZ+s4m4H9Gr/fMeBFTb1Yr2ML42lhom0iUBUWmuMJsLXpQyRVNUSBZ0m17mjcjEHAFlj
         S7ONKTYzM/oqQl4PHfNSmWhNfH/EF8SabTYnfKwKqmDR7Sh4NHBxF6MFFeUqMUJXfcbi
         g62g==
X-Gm-Message-State: ACrzQf3t/WfxKenVeXv5pzkCdZ0WdRfT7s9MK3lLfXc8Sm+ola53owDc
        LqOU/rzfTjyCwQ+ZHCUNSHU=
X-Google-Smtp-Source: AMsMyM7hOlhYp65WBPUClvIycuplWVBI76fOiFY3ifPRGxzwOTJ6yqcfirXxMoqkvaOGD6pIwg+oCQ==
X-Received: by 2002:a05:6a00:1253:b0:56d:8742:a9ff with SMTP id u19-20020a056a00125300b0056d8742a9ffmr7551351pfi.5.1667280228020;
        Mon, 31 Oct 2022 22:23:48 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7e9:8a64:69f2:c3c7])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b00561b53512b0sm5532254pfk.195.2022.10.31.22.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:23:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 3/3] bpf: Add perf_event_read_sample test cases
Date:   Mon, 31 Oct 2022 22:23:40 -0700
Message-Id: <20221101052340.1210239-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101052340.1210239-1-namhyung@kernel.org>
References: <20221101052340.1210239-1-namhyung@kernel.org>
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

It checks the bpf_perf_event_read_sample() helper with and without buffer
for supported PERF_SAMPLE_* flags.  The BPF program can control sample
data using the return value after checking the sample data and size.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_sample.c    | 172 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_sample.c    |  28 +++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_sample.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_sample.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_sample.c b/tools/testing/selftests/bpf/prog_tests/perf_sample.c
new file mode 100644
index 000000000000..eee11f23196c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_sample.c
@@ -0,0 +1,172 @@
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
+static noinline void trigger_perf_event(void)
+{
+	int *buf = mmap(NULL, DATA_MMAP_SIZE, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
+
+	if (!ASSERT_NEQ(buf, MAP_FAILED, "mmap"))
+		return;
+
+	ioctl(perf_fd, PERF_EVENT_IOC_ENABLE);
+
+	/* it should generate a page fault which triggers the perf_event */
+	*buf = 1;
+
+	ioctl(perf_fd, PERF_EVENT_IOC_DISABLE);
+
+	munmap(buf, DATA_MMAP_SIZE);
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
+static void setup_perf_sample_bpf_skel(u64 sample_flags)
+{
+	struct bpf_link *link;
+
+	skel = test_perf_sample__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_perf_sample_open_and_load"))
+		return;
+
+	skel->bss->sample_flag = sample_flags;
+	skel->bss->sample_size = sizeof(sample_flags);
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
+static void test_perf_event_read_sample_invalid(void)
+{
+	u64 flags = PERF_SAMPLE_INVALID;
+
+	if (open_perf_event(flags) < 0)
+		return;
+	setup_perf_sample_bpf_skel(flags);
+	trigger_perf_event();
+	ASSERT_EQ(check_perf_event(), 0, "number of sample");
+	clean_perf_sample_bpf_skel();
+	close_perf_event();
+}
+
+static void test_perf_event_read_sample_ip(void)
+{
+	u64 flags = PERF_SAMPLE_IP;
+
+	if (open_perf_event(flags) < 0)
+		return;
+	setup_perf_sample_bpf_skel(flags);
+	trigger_perf_event();
+	ASSERT_EQ(check_perf_event(), 1, "number of sample");
+	clean_perf_sample_bpf_skel();
+	close_perf_event();
+}
+
+static void test_perf_event_read_sample_addr(void)
+{
+	u64 flags = PERF_SAMPLE_ADDR;
+
+	if (open_perf_event(flags) < 0)
+		return;
+	setup_perf_sample_bpf_skel(flags);
+	trigger_perf_event();
+	ASSERT_EQ(check_perf_event(), 1, "number of sample");
+	clean_perf_sample_bpf_skel();
+	close_perf_event();
+}
+
+void test_perf_event_read_sample(void)
+{
+	if (test__start_subtest("perf_event_read_sample_invalid"))
+		test_perf_event_read_sample_invalid();
+	if (test__start_subtest("perf_event_read_sample_ip"))
+		test_perf_event_read_sample_ip();
+	if (test__start_subtest("perf_event_read_sample_addr"))
+		test_perf_event_read_sample_addr();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_sample.c b/tools/testing/selftests/bpf/progs/test_perf_sample.c
new file mode 100644
index 000000000000..79664acafcd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_sample.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022 Google
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+unsigned long long sample_flag;
+unsigned long long sample_size;
+
+SEC("perf_event")
+int perf_sample_filter(void *ctx)
+{
+	long size;
+	unsigned long long buf[1] = {};
+
+	size = bpf_perf_event_read_sample(ctx, NULL, 0, sample_flag);
+	if (size != sample_size)
+		return 0;
+
+	if (bpf_perf_event_read_sample(ctx, buf, sizeof(buf), sample_flag) < 0)
+		return 0;
+
+	/* generate sample data */
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

