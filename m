Return-Path: <bpf+bounces-22016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1CC85509C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6EAB2CDD0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883B8529E;
	Wed, 14 Feb 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="R0QCwz5D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7938529C
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932485; cv=none; b=IahmmvwfhZjGVaWxYcxKJ4Bfwli0VDxvb37Ctxf5rCBI3xft//1gbC13Uwmuy6X+OxEtzi8Cy1EdtWwpGZVadtd02fKPcI9Ig6uTHRPMMU3nZ0LSIVyNWLfgOaOQapu/uKx1N06gb5iDBrdZroYrR0C0jDET3nV+Ut1HmCknQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932485; c=relaxed/simple;
	bh=nomzOqG8qtQlSxsBxKy5X1xMNj4S0dr5Ifd+oiSg+rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3rGhDKbezfLN6DKu5NhQf0KL7moQZwxPkGXLmE6vboQZCb5S5+ajkhuDfBGtVVd6kkV1m6JuMbrAnt1q5AwtZZHKcdoRrDx8LygBXE/e9fWxnsNoGF7V0fV9cyaXmMxqKgOYXxw1gxoMAt+BgkKzcku+WjkwoiY2cQBAAdtQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=R0QCwz5D; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2e44aad03so2024796a34.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932482; x=1708537282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjezFELGsG5yYdoO8o3jjgWXUKsZRmSJ3eM36KaKRP0=;
        b=R0QCwz5DPYqkFzxtiGF6d2r89yTg+iapiIe5ujgDb5S47otsJJ3m8A2FgxcU9anVCp
         WmPg5fow8UvZ6abaRs5Y8KImqQIvd4/OkhjOhMkq9e79J8OqwRpIa9/6HJ/cYpOWs0VE
         oqMvCHidQm/tKJpUWumhYUW/c+XOOQ5MIVAbtg/eS8oD7bz+RIy/mBMdq6iGLSwyvnLw
         jHVwkfxHeEt/pom/tg4LzKf7WwzOhaHiIFkEQ7sd4mI1ylgSlOd5dWKjy2dUrx/DSl67
         a+8wFXYrgkOCavdO3PZ49HHheRCoLPEcQD+V8hoguxC3PualT4UbTdiH0kYuIXACl5M8
         N1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932482; x=1708537282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjezFELGsG5yYdoO8o3jjgWXUKsZRmSJ3eM36KaKRP0=;
        b=jPJi2UlzbqmxIoMxbWe3cay4f1iiEa253TcvvtstnKH+pXq2PrR/IjTLk8+03+1o+Q
         IXRVO/GA91CzlnZhmEXnXR5ZjQ9l6PGOmUxOTtBK0zZh8WWpCxqv2o2G/djpQ8Wo8PFW
         Ts6SD4Jp3LY3uyF1CsKQpoQuovLkn9JiOvrD9T4VGg6On061MRAq8w77FeQJk8Ms226n
         t4nlePIFxidjxSeg2F3k1dsjInOLeKyT562AceYlPk+0GZTI/q6qAhTHer9CHtKZza+W
         KYTkh+cdXyHNcg2w36EC10gyip6ET9/wCazLSwvn2FPq04TLVRkkpKiLY4IzpOkhm0S3
         ixhA==
X-Forwarded-Encrypted: i=1; AJvYcCWXURhlXg/qdcaqWHhIwFIt0S1+fz87BoargB990pzayfmUIprLNYLhvaWsXo2kbf3I13BN6IhRYuX3/+y4WWfIMnwi
X-Gm-Message-State: AOJu0YzvAmb3A+imRd1wMedKWVWfTBpzuqKwPzbyH9QUAGCa5BJ4fYHQ
	yiw0w++nRYAoHZr+WEItPFPEMfz6ESvjMm+pbnrQiviUY9+6cffplrpzp9sxQw==
X-Google-Smtp-Source: AGHT+IFmSEieag8tCyc8604BELPKwiIo404ZfsK6cYr9yraeW3R4mfErPRQxwNVYXWIs5kv7eyTTpg==
X-Received: by 2002:a05:6358:2c8e:b0:179:1f8b:445a with SMTP id l14-20020a0563582c8e00b001791f8b445amr3924795rwm.22.1707932482324;
        Wed, 14 Feb 2024 09:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnlM9zlbKauAzR+O8NeswMzBEQYMRe6SdGtLXHn/uwjuvV8h43PMKUBzKLCUE9aRV2+93xF/DSRqB51At0GMA+YYik2LfhT0r9Crq/4gW8JMAfnKoXl4scVMznsiXU0/1wKWBYKMSpApTNbCQl+72tg53WTWtuvDLlNZMnhiixbI9K7nUjBu3NUO2hH5KVu1Ergerb+p6hz5EPrL4glSTALBkq4rD3JxhxEaYiGPGa+XOfpfTBK/F141MywGj5TP4JVWbBK3P7nMBSnRIeX5Zu9OM13Q0OVN1lyQs61JEaqINGJ0TVte78/1GyrKq/ux/4LwN5DK/6dtEHpR+0BFEgu7l37GcqU59IwJr75apKFuxAB7dhyB5P1vif6bwxWDXdchPiaJgz2NAESVqq5kpM4hVsQ/7S6X95tlVe/jdivNR7W/WVGNnFlnNd9chn1Q14NMYpxaJA2zrPDgaUOfYSX+Wtbewj7b/VZQTZXtYOyLgnFZxCF8BrGcYAB2XhyE+zR0+odhLPKdvyGiIR0akRS5XZtT6/SCgqOyYT+7Njy8bOn8gwKxB5xfjyGRB4HxQa7zuoaVB5UmCHGUg9RZsrin0QkZo/exrBSj2p5MDypJetWkFDdPASRG1lzWUXGJY2LCr5kjT5UoWDAIrs+uBhhCIB7BKObl9Yibc=
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:41:21 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RESEND PATCH v5 4/4] selftest/bpf: Test a perf bpf program that suppresses side effects.
Date: Wed, 14 Feb 2024 09:39:35 -0800
Message-Id: <20240214173950.18570-5-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test sets a hardware breakpoint and uses a bpf program to suppress the
side effects of a perf event sample, including I/O availability signals,
SIGTRAPs, and decrementing the event counter limit, if the ip matches the
expected value. Then the function with the breakpoint is executed multiple
times to test that all effects behave as expected.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_skip.c      | 137 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
new file mode 100644
index 000000000000..37d8618800e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <test_progs.h>
+#include "test_perf_skip.skel.h"
+#include <linux/compiler.h>
+#include <linux/hw_breakpoint.h>
+#include <sys/mman.h>
+
+#ifndef TRAP_PERF
+#define TRAP_PERF 6
+#endif
+
+int sigio_count, sigtrap_count;
+
+static void handle_sigio(int sig __always_unused)
+{
+	++sigio_count;
+}
+
+static void handle_sigtrap(int signum __always_unused,
+			   siginfo_t *info,
+			   void *ucontext __always_unused)
+{
+	ASSERT_EQ(info->si_code, TRAP_PERF, "si_code");
+	++sigtrap_count;
+}
+
+static noinline int test_function(void)
+{
+	asm volatile ("");
+	return 0;
+}
+
+void serial_test_perf_skip(void)
+{
+	struct sigaction action = {};
+	struct sigaction previous_sigtrap;
+	sighandler_t previous_sigio = SIG_ERR;
+	struct test_perf_skip *skel = NULL;
+	struct perf_event_attr attr = {};
+	int perf_fd = -1;
+	int err;
+	struct f_owner_ex owner;
+	struct bpf_link *prog_link = NULL;
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = handle_sigtrap;
+	sigemptyset(&action.sa_mask);
+	if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), "sigaction"))
+		return;
+
+	previous_sigio = signal(SIGIO, handle_sigio);
+	if (!ASSERT_NEQ(previous_sigio, SIG_ERR, "signal"))
+		goto cleanup;
+
+	skel = test_perf_skip__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	attr.type = PERF_TYPE_BREAKPOINT;
+	attr.size = sizeof(attr);
+	attr.bp_type = HW_BREAKPOINT_X;
+	attr.bp_addr = (uintptr_t)test_function;
+	attr.bp_len = sizeof(long);
+	attr.sample_period = 1;
+	attr.sample_type = PERF_SAMPLE_IP;
+	attr.pinned = 1;
+	attr.exclude_kernel = 1;
+	attr.exclude_hv = 1;
+	attr.precise_ip = 3;
+	attr.sigtrap = 1;
+	attr.remove_on_exec = 1;
+
+	perf_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (perf_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
+		printf("SKIP:no PERF_TYPE_BREAKPOINT/HW_BREAKPOINT_X\n");
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(perf_fd < 0, "perf_event_open"))
+		goto cleanup;
+
+	/* Configure the perf event to signal on sample. */
+	err = fcntl(perf_fd, F_SETFL, O_ASYNC);
+	if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
+		goto cleanup;
+
+	owner.type = F_OWNER_TID;
+	owner.pid = syscall(__NR_gettid);
+	err = fcntl(perf_fd, F_SETOWN_EX, &owner);
+	if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
+		goto cleanup;
+
+	/* Allow at most one sample. A sample rejected by bpf should
+	 * not count against this.
+	 */
+	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
+		goto cleanup;
+
+	prog_link = bpf_program__attach_perf_event(skel->progs.handler, perf_fd);
+	if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event"))
+		goto cleanup;
+
+	/* Configure the bpf program to suppress the sample. */
+	skel->bss->ip = (uintptr_t)test_function;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 0, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
+
+	/* Configure the bpf program to allow the sample. */
+	skel->bss->ip = 0;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+	/* Test that the sample above is the only one allowed (by perf, not
+	 * by bpf)
+	 */
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+cleanup:
+	bpf_link__destroy(prog_link);
+	if (perf_fd >= 0)
+		close(perf_fd);
+	test_perf_skip__destroy(skel);
+
+	if (previous_sigio != SIG_ERR)
+		signal(SIGIO, previous_sigio);
+	sigaction(SIGTRAP, &previous_sigtrap, NULL);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/testing/selftests/bpf/progs/test_perf_skip.c
new file mode 100644
index 000000000000..7eb8b6de7a57
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+uintptr_t ip;
+
+SEC("perf_event")
+int handler(struct bpf_perf_event_data *data)
+{
+	/* Skip events that have the correct ip. */
+	return ip != PT_REGS_IP(&data->regs);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


