Return-Path: <bpf+bounces-19861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8183228F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B3E2877CA
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7458817;
	Fri, 19 Jan 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="XupO7X72"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454318A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623297; cv=none; b=YCfILcIyPnHuzirguQloBh165zP137gDPe4Hi6B/rI2lMQVDM+wn3ucL4fMgAqP5o/94bSmgWsIrqfLkL4OpEv5CBYti4nxjd1DGNY0pT48Mpxzqm0m8EmDAVx/2Yw5gVjYt0H0RM0xRe7Piq5601Y3g3oO5GxvtpT5/cKAuYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623297; c=relaxed/simple;
	bh=lgztwFbOxvCSZQBlFKLsXosQinxtlxOmxqJ20zMs7Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/whJMLRQjL+qPimFlfRaVo5650ZfT+qMF30EcUzQRzZ5mg7bfayGYiIBPKvTTzk0ZsxZNYE26cpTQmGIWW+bPGd276Fb3v3mC6YdcWiN/d00B2YSC4GXmT3mkhS4WvHcsxbfJhOHBDtwfuoMHqJu6XKZ4LawYU2HIB/3BIe4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=XupO7X72; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d50d0c98c3so10800765ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623294; x=1706228094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KAoEfpbtZugctsvQWmIErusprU1vjdWQA1H3EUTUAE=;
        b=XupO7X72OFlt2YjQ4lEe/fBPu5e3h5RALmEQrIq4r/6gO+Lrt8U9eBWcOAbgYe5s8M
         isEVmgid1Y13IvTCIepzoLnb+rUko+oh37FO8xTAYS71wNgw0oHAFz5VRnin3HQiUKxD
         FvZLxRL1i80qgd9xZtYuERfyP61gAYAgGrD76wuvL+lcQDk5D6KrJ5n16jK30y/6AABY
         f5LxrDzhvdUWpM7zy7bGpEJZEha+61YfWnmOmvlAHCTDq5hsFim2IgKjeoSFGQvUQyuR
         beF5GQYqpk71EJhhbzrNpqVUsu9kq+V3EejWqHMO0nulG6Tad+eg0TR5DKNJOo8ejSc8
         B4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623294; x=1706228094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KAoEfpbtZugctsvQWmIErusprU1vjdWQA1H3EUTUAE=;
        b=F4Go2x9Owpu1r1GXWu2UrhyrEGyQQvXUZ4V7i9FKYXX9fGHVKd89WBjoI7s7bUxcWI
         YRYpZ2sbtkYjEcH1K8epTKMi9gE8C1oiNgkZqlpdsQ/nTetUftHW9w62Z/mJiVBMbYaK
         9FXKi8V0MGFOwh9iHUPELqwm5PJ95mVmSfK7jlSy0sTxt4Kmqa/HwRksdM5IdMZfiXHM
         sgt1xwV33kHQVoiq07LUTnyvCR/KhZHQ2uWnOwllCpDWZXT2pwlXAE5D/FF2Sdx8tVVi
         YdMrSlB+MQNEZFeg5hYERpL+O21rA+9KXQlm6/1gSx7/H4pf7ajgJmEOEhFdRWth+C40
         OJCA==
X-Gm-Message-State: AOJu0YyDRASqK3VJSKlnPN3fpk8qrAiQvtI0EebUNNpoPxsRHTILaYZh
	ed8rSEkjgY7CHWm0vIhQWV33A6dL8Ort9F147EOQT6B46aybqNFabzRL6yeIGA==
X-Google-Smtp-Source: AGHT+IH7/HWrPOJEMKFFfVf2axY9b8wQCQlVN82voRPP0r/VV1qz9l5kOc3qny64GVMHXyV/ljKGCw==
X-Received: by 2002:a17:902:7245:b0:1d5:7524:6d21 with SMTP id c5-20020a170902724500b001d575246d21mr181163pll.42.1705623294291;
        Thu, 18 Jan 2024 16:14:54 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:53 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/4] selftest/bpf: Test a perf bpf program that suppresses side effects.
Date: Thu, 18 Jan 2024 16:13:51 -0800
Message-Id: <20240119001352.9396-5-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119001352.9396-1-khuey@kylehuey.com>
References: <20240119001352.9396-1-khuey@kylehuey.com>
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
---
 .../selftests/bpf/prog_tests/perf_skip.c      | 136 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
 2 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
new file mode 100644
index 000000000000..c79dae34ae90
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -0,0 +1,136 @@
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
+	ASSERT_EQ(info->si_code, TRAP_PERF, "wrong si_code");
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
+	sighandler_t previous_sigio;
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
+	signal(SIGIO, previous_sigio);
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


