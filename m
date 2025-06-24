Return-Path: <bpf+bounces-61349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18065AE5A6A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE271B68303
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C3221DA8;
	Tue, 24 Jun 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4lWemH9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF791F4628
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734793; cv=none; b=k6ENKkUgTL6tIz9wWaxhS+BK9V5pR8lP7ywusttGZjqOl0apZdycM1qE59MU+lRHDAiD3Nz+rqpuuTDNnhg8DdeDwt04B2AFRbO1WvV8ZTyxEixL5Sng/LXMBP9JopzIXdHdCAi8sXU9W5QFe97GUn6iMlIBFl4DhErcNwa+7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734793; c=relaxed/simple;
	bh=gzspNBiyTFepXSmxZQj66oqVAIH50ck2TuwxexIVxDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYRNq/KBi7MDOfdqXiweCpqJLZM71gMiYOYjPbWmATh1uJMw7NjFIdJjc3onWPPx9xBM0INPU+8N9/NoIBUpSegGLbw8mydUr6A799w/77pYJoPqh3r8AbIgCwWPDfOxhVECkNcOcZALuhLpGUThq+F0JvIcwlTbWuxXUBNtSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4lWemH9; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ade4679fba7so925174666b.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734789; x=1751339589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ius8ojRj+wJx6VEAbPqCPbkN0ngKyWHNV/C54M+JLsc=;
        b=D4lWemH9hrWsqhd07+bX3E6x6kJkNy569GPPpFsgAaovsIIl1nqR/k3aXQEzjrAqQr
         CFmvBv48R/CMDnW0ZyOiic8VZhmyJny/7DUYgZKr66WmdSyTIBYcykjtNaJD8kMLTTZo
         nsV9K1ysBisuAfXJnx1Of3Jfx1gSEX+E6953g74vzZjBc43VO3rKt+ZTegq0dFILlwic
         Z1o7jyXBjjiuSSECq9830UuWFTBg0tdO4Nigoe2H6oTwyTCrWZ4aCClO3HwTx7/Zu7HS
         urOUXdOc6YrEcXTpZSFVWIoCuLpXfnO+WUonDGc5q1ggca9poIkNh/rlGpo8wS5ub1PZ
         DN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734789; x=1751339589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ius8ojRj+wJx6VEAbPqCPbkN0ngKyWHNV/C54M+JLsc=;
        b=IEimPdhq7byuu1G7ezyN+Z/zr44fGISsiatUv1EzgLrP8YHjrpr7MT7OP8ULkqjWEM
         9fnEIPzBzIlWSqiJ8OrnXpsjarXrhalqNY6CMddBTdi0NPObZ9u7PKhVTqh00OlLLPFF
         XRKhXoOLeQ8hBqxoHWHdaqyy/sq+lwCSNiXsN73xl/bvpjOInHKITbzJqDxFl1t4Se4m
         hcLj9SSiZroJ+H74Mhb6kkNv/f5k4XvSAKYuM1/McxHT3B8qiy+ZUu0cRs+vRuVWuhOM
         2wbUId8pf1Dqxhzce+XXn242rFxcqTtYLj2dyAsgKO6B/EwQLCRJlWS94LgSI24jGF9I
         zxcA==
X-Gm-Message-State: AOJu0YzHfKINyPJ72bqqoqlWw2w/1g5olgWg87j1cftaORk3c6aibzBK
	Nbi959RsZAVixn35LOTrD0uUgDxYUo9HlfMsfFlhsrTLA1ndO9GzOOPTAPEcEMD3HN8qNA==
X-Gm-Gg: ASbGncvDxu5ywwvNTS1E2oGKy0vL9aUZSNNNurSRLVP2zkiCyqkdHRMf2iq6Xa2lHLR
	/6gQ0AnQeQErSYrHp8x9lac+yf6zvRnqn6ab4wE98L15dFXu957NwAkTeibOBYDWzSIBa6/cnp8
	9SRGHCdx5LUMV+zuRL3nlYJWo9syM7+8GtdTfu0jYbSEM2Ke23PcRFasV2GufFBmkKE2ORdYpt9
	pJwmpxozwaqjFFbDfO4EJcu06oGNkCYKKrKgvZLM8CvCXxKW1DcUgo2ul4RS59vDAnhEILSSIdh
	atwRzYY+aczs3WwmUHPDzHgtwh7Gt+yBVqC2a9UGD4yR4lEeiotKoAbDe2byCg==
X-Google-Smtp-Source: AGHT+IHQT2yGJOyhIBUYlzN2tg54IhjxYyrTQmacbB7uxc/zcTm+n1Ja5xR0HUaLEaDItBuKq84FVA==
X-Received: by 2002:a17:907:26c9:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-ae057acc409mr1295869866b.28.1750734789329;
        Mon, 23 Jun 2025 20:13:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae086a98f6dsm363321066b.32.2025.06.23.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/12] selftests/bpf: Add tests for prog streams
Date: Mon, 23 Jun 2025 20:12:52 -0700
Message-ID: <20250624031252.2966759-13-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7634; h=from:subject; bh=gzspNBiyTFepXSmxZQj66oqVAIH50ck2TuwxexIVxDA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWf6DfN9RKhJVW8aGk6EKwYoGi1ZQza8B8VG4wu 2IT1pHaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnwAKCRBM4MiGSL8RyokzD/ 9OBApK9gu56oG1saXQV2h0tP+o1Vk6fVMZ9KjWqUOKfTxlhB0rUiAhjbEPM7wbSB0YKGmbEltYJwBM 1lxno38eli1qx8ideECd+VYtTS2obL/UZ9Ab8bOfAyGs08sYgwZIQDtrbqvX7TBIIejNI8apd/+MyC 8oX3AwhEJu3rR5LnXbZaots16O1z8/zFLaGByyvQWrNUj48i3Gv8y5B32rhDDgoRWyHiyjEP8Y+3K5 MadutBEMTRijkXFRMmNnO+U5wv1nDI+98fPjoaWKxatzUKLtl1AtODFE4b9sapB8qKxlnbvZvstbnI 4yiLmfWuMVlBsNWq+nVRnytEwKoWte44CL0zFsWDhBLK2kyHQ6x46HDj5MzsPTyk2E6mTOaFPF6YjE Hjh7Y431ZbcaA7po+5H75FVcbW0fsLZnXAj5gJZe01QvspTqixAjkAyVE/2TVqpJbtz0o6GxXnaru4 49I7rlJrMrgXs5gsW6Bj1C3QkGh1UrBzChJCWzTfBrfS0t4dZ6OOtzlaaglbTd6n38UDhWHfdO43sH dYvZHfUeeS6i4RvwDVu7+FrUUxMDVMgYYBuMLN4d1fGjltA5EvaNEZgsifPHvCYcQK06SuFO4aXd+i O5E5iGYpBeEnKnkp+fz9QKgucnb45Cq+Bj5Ke9eGOnO/vJsW038BWZxrxJBQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested and
functional.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 140 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  75 ++++++++++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +++
 3 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
new file mode 100644
index 000000000000..b14ce6e682aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <regex.h>
+
+#include "stream.skel.h"
+#include "stream_fail.skel.h"
+
+void test_stream_failure(void)
+{
+	RUN_TESTS(stream_fail);
+}
+
+void test_stream_success(void)
+{
+	RUN_TESTS(stream);
+	return;
+}
+
+struct {
+	int prog_off;
+	const char *errstr;
+} stream_error_arr[] = {
+	{
+		offsetof(struct stream, progs.stream_cond_break),
+		"ERROR: Timeout detected for may_goto instruction\n\0"
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: test_progs\n\0"
+		"Call trace:\n\0"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n\0"
+		"|[ \t]+[^\n]+\n\0)*",
+	},
+	{
+		offsetof(struct stream, progs.stream_deadlock),
+		"ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock\n\0"
+		"Attempted lock   = (0x[0-9a-fA-F]+)\n\0"
+		"Total held locks = 1\n\0"
+		"Held lock\\[ 0\\] = \\1\n\0"  // Lock address must match
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: test_progs\n\0"
+		"Call trace:\n\0"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n\0"
+		"|[ \t]+[^\n]+\n\0)*",
+	},
+};
+
+static int match_regex(const char *pattern, const char *string)
+{
+	int err, rc;
+	regex_t re;
+
+	err = regcomp(&re, pattern, REG_EXTENDED | REG_NEWLINE);
+	if (err)
+		return -1;
+	rc = regexec(&re, string, 0, NULL, 0);
+	regfree(&re);
+	return rc == 0 ? 1 : 0;
+}
+
+void test_stream_errors(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	char buf[1024] = {};
+	struct stream *skel;
+	int ret, prog_fd;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(stream_error_arr); i++) {
+		struct bpf_program **prog;
+
+		prog = (struct bpf_program **)(((char *)skel) + stream_error_arr[i].prog_off);
+		prog_fd = bpf_program__fd(*prog);
+		ret = bpf_prog_test_run_opts(prog_fd, &opts);
+		ASSERT_OK(ret, "ret");
+		ASSERT_OK(opts.retval, "retval");
+
+#if !defined(__x86_64__)
+		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
+		if (i == 0) {
+			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
+			ASSERT_EQ(ret, 0, "stream read");
+			continue;
+		}
+#endif
+
+		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
+		ASSERT_GT(ret, 0, "stream read");
+		ASSERT_LE(ret, 1023, "len for buf");
+		buf[ret] = '\0';
+
+		ret = match_regex(stream_error_arr[i].errstr, buf);
+		ASSERT_TRUE(ret == 1, "regex match");
+	}
+
+	stream__destroy(skel);
+}
+
+void test_stream_syscall(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	struct stream *skel;
+	int ret, prog_fd;
+	char buf[64];
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.stream_syscall);
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+
+	ASSERT_LT(bpf_prog_stream_read(0, BPF_STREAM_STDOUT, buf, sizeof(buf), &ropts), 0, "error");
+	ret = -errno;
+	ASSERT_EQ(ret, -EINVAL, "bad prog_fd");
+
+	ASSERT_LT(bpf_prog_stream_read(prog_fd, 0, buf, sizeof(buf), &ropts), 0, "error");
+	ret = -errno;
+	ASSERT_EQ(ret, -ENOENT, "bad stream id");
+
+	ASSERT_LT(bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, NULL, sizeof(buf), NULL), 0, "error");
+	ret = -errno;
+	ASSERT_EQ(ret, -EFAULT, "bad stream buf");
+
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, NULL);
+	ASSERT_EQ(ret, 2, "bytes");
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 2, NULL);
+	ASSERT_EQ(ret, 2, "bytes");
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 1, &ropts);
+	ASSERT_EQ(ret, 0, "no bytes stdout");
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, 1, &ropts);
+	ASSERT_EQ(ret, 0, "no bytes stderr");
+
+	stream__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
new file mode 100644
index 000000000000..1fb0e810afc6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct arr_elem {
+	struct bpf_res_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct arr_elem);
+} arrmap SEC(".maps");
+
+#define ENOSPC 28
+#define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+
+#define STREAM_STR (u64)(_STR _STR _STR _STR)
+
+SEC("syscall")
+__success __retval(0)
+int stream_exhaust(void *ctx)
+{
+	bpf_repeat(BPF_MAX_LOOPS)
+		if (bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC)
+			return 0;
+	return 1;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_cond_break(void *ctx)
+{
+	while (can_loop)
+		;
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_deadlock(void *ctx)
+{
+	struct bpf_res_spin_lock *lock, *nlock;
+
+	lock = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!lock)
+		return 0;
+	nlock = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!nlock)
+		return 0;
+	if (bpf_res_spin_lock(lock))
+		return 0;
+	if (bpf_res_spin_lock(nlock)) {
+		bpf_res_spin_unlock(lock);
+		return 0;
+	}
+	bpf_res_spin_unlock(nlock);
+	bpf_res_spin_unlock(lock);
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_syscall(void *ctx)
+{
+	bpf_stream_printk(BPF_STDOUT, "foo");
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
new file mode 100644
index 000000000000..12004d5092b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed")
+int stream_vprintk_null_arg(void *ctx)
+{
+	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


