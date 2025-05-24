Return-Path: <bpf+bounces-58886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57893AC2CDF
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E4E1BC7DE4
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C591E2823;
	Sat, 24 May 2025 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv2d0oOu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BE19DFA7
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049548; cv=none; b=O1TIbSpy0mMByWBjSs7mpPOr4I+uuB/ckM4epY34EaV3T3D3MiOYgS6wJ5ZjUfccqTSY6veJSR+TbkYXpDQYtCF3ogtkKN+LlIHfDpZsrapctf9nYnuyk7nk3vSosye9svna9U3SX0Uiu056TMsSmRCDGYCQFpYlUf3FFF0F6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049548; c=relaxed/simple;
	bh=SCj433yAAc2Yqcw0VQxpxkWYYcTxPh8+5+yH3Ad/FWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQAFvdcFQeUNMWSf1XevqMbejzC1+juPlzyHZvfnO3ahgXJpnRvpMs0X30j2Bzik7SOnIbJ6+UMM8Z8dk6X7sw/z/BkqiqNWzUwwqx92aqGvsPeDh9Zj5N0XrM3RlekdBIuw0Gc5b/vJmnrb4DToo05ihNPFqmPF73uQjFdAKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv2d0oOu; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a37a243388so390235f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049544; x=1748654344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqDytmcgLfLvDeLFHM5ndMHEp11z2d7DlDH5zane7/A=;
        b=Cv2d0oOu6CDdRQAvLd6F2ZOjIHD5TVLpCguArJy8hfPUXyUbLiccHd3bTORmntRKHh
         DwYQkZPMRAK2SGKlkFWO2De77UnVi2TlWTZdBnqpTHsOYUWRZEeXArjzH7J6KkZ6zKa7
         kEH3bCPTiVvs4tBPdQLMesLxnP3h1yx0eWp4mwGJl/9YFhHb7ADu7DV9EdZxRYap2nsX
         oSn7h2XPZ7NuM7iyfPiDsWmi0y83bbg/+NkHszhkNsZtSkwjXt7GIb5iLnEaJKT5gEXS
         2y7z55iSZAsM12XAZPv8oRbEJRg7+HNxCQxPOHt4R0uJbbIf+owSSHJ7dkr8aIxMm1Aw
         A1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049544; x=1748654344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqDytmcgLfLvDeLFHM5ndMHEp11z2d7DlDH5zane7/A=;
        b=ZL/c8v6Z2i81FRaqIFsa8Uic6vsvn1X9cW92FijKKEDuSn2+ghnETuu01gOeX18jte
         Y5jY8SPs/RmLrMvesl9SakZeTBd80uDYj7G9CoiSNSxxX2BPbmplH3Qp3jJY2MiZDoG4
         oIsxgopXs2bMxpLFi46PyWaFzn5urjiKCZ5SSZ+I3rXGgb/h8YtOpKgvjYpcxYEf7WpO
         3qick59wzCq3yEgHVfsofV9fKEx6WcWFlE9O0i8/yiZG4aOQWD5k59xn4nQncLo7pxJs
         UeaTfMnYqYlwghMwmbZGNvRAPoRPyHxvUgvnabHTIBT+OVX1zky7LrM25ytYCWWMUuBZ
         LVug==
X-Gm-Message-State: AOJu0Yy4j6PKm7goMNUv0AU7Z83ttkyZq5/D3FY1xu3uRERuJNUMPFqj
	7KEWYKluF3R92ZU3tQHBGsUpxTkqQLpxYm1s9gHzUCNdHeoaRp2xssrcFDOFhI0kHCc=
X-Gm-Gg: ASbGncsEZZ9qwbGeghGR3reRYfqIZfs0wiaMOr/o2l/fdUhhyXiA9WDqMuwGsVtteLM
	gHOM5GTTmMHdhQOvgmd8e8XxBSvvgShjiLO9UqwmLc/3ubbw59GQeJ3L2qq0958RuvLcPlGkhLv
	vEW50UhtWIXYV4OYjt7ATPhf7UIRAVpFMe8Ax0oj24t5oEzPUmfnBaFa7tS3oIhy4C9CjcXDDyY
	0an+GHlAiJRXB6UwiFkWePjZlMqp7yt57xbfbjIeimg8wxwObCP+RZBlldkwnWT5DO9qdv40xOx
	XMNH3Gd07k7DXf+q1JVJ1ABJC+fntHRgfuRZmIdy7thDcvRoLsM=
X-Google-Smtp-Source: AGHT+IFL7/+QnpOG6dYNJj1+uveMQnwTltPlx+MeFpNopoWRqeIbeDoThY71jqalMf8OOohF7XuIXw==
X-Received: by 2002:a05:6000:2083:b0:3a3:ec58:ea41 with SMTP id ffacd0b85a97d-3a4cb498271mr876619f8f.48.1748049544214;
        Fri, 23 May 2025 18:19:04 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c8cdc618sm1703587f8f.0.2025.05.23.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:19:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: Add tests for prog streams
Date: Fri, 23 May 2025 18:18:49 -0700
Message-ID: <20250524011849.681425-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6431; h=from:subject; bh=SCj433yAAc2Yqcw0VQxpxkWYYcTxPh8+5+yH3Ad/FWk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3QKvNwNQd3t4p41FATf1V7wqi81LxiqtZW/Tsm GOe91K+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEd0AAKCRBM4MiGSL8RyitPD/ 0efEUrw2m/O8x3gJ/oGv0ZIRy1b7LKRbefEwUSA+NHPbUR0uaEm2lE+v0T/PVRdMw0tnPnL1cHF6pd QoOSAKXuISU+X7/7jf1CUS3eSqDpT6wv0xPf/MSIgiyBc4dAIQ9DHzjq+2tQQNyFidumh7Dat0F5Ha JU48sWeKRUL+MwHKdYR08BcoRRblqW1HlZ6pSwgK591PyxCoCuC4WlknEEXCiGMvx66exBCsEpcNnA K9hRT5uK0MYI2K/uR1DKnRMDX7rlWTzmRYrczntC13fmGgvXhj2xaOry6c3z0NPGxVjlg4g9c+JZxy njEvh6yIJB6FRVSpQxoJNVBjpy9R6tPsSLE8BQkLNSwsonMhxPTQY8YPmOYAg0YV/NeN5c7uinv8IB FEnNIqLzcSnW5Xgzu3P83a8n45MfFZoFZYia7ZMWRa0hGImc62OyfnZDvjkzLY0+zZV2cMiyPtKD78 LBShX4wBy3OtjfvE8gPvs0kJZ1T5MXdrAjhWFsLJGKChknpgfHJ7mAk4PE0M+/JBqp/jDOSeUdujzB Yx5tHDvCwv4C7yEIHfQi2hBUIPveqrl/aSuNhUgAdAMYjP5AcnUSsbq5XaZOs/TbHFJKt7cH1fssZr Shr5se0LCS+h2iz9rIoBwMmBPnTCBsd9+OqiTyvEFP5crzz+T6JyRIsSjQYA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested and
functional.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 110 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  75 ++++++++++++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +++
 3 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
new file mode 100644
index 000000000000..3b04d3d499d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
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
+		"ERROR: Timeout detected for may_goto instruction",
+	},
+	{
+		offsetof(struct stream, progs.stream_deadlock),
+		"ERROR: AA or ABBA deadlock detected",
+	},
+};
+
+void test_stream_errors(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct stream *skel;
+	int ret, prog_fd;
+	char buf[64];
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
+			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf));
+			ASSERT_EQ(ret, 0, "stream read");
+			continue;
+		}
+#endif
+
+		ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf));
+		ASSERT_EQ(ret, sizeof(buf), "stream read");
+		ASSERT_STRNEQ(stream_error_arr[i].errstr, buf, strlen(stream_error_arr[i].errstr),
+			      "compare error msg");
+	}
+
+	stream__destroy(skel);
+}
+
+void test_stream_syscall(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
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
+	bpf_prog_stream_read(0, 1, buf, sizeof(buf));
+	ret = -errno;
+	ASSERT_EQ(ret, -EINVAL, "bad prog_fd");
+
+	bpf_prog_stream_read(prog_fd, 0, buf, sizeof(buf));
+	ret = -errno;
+	ASSERT_EQ(ret, -ENOENT, "bad stream id");
+
+	bpf_prog_stream_read(prog_fd, 1, NULL, sizeof(buf));
+	ret = -errno;
+	ASSERT_EQ(ret, -EFAULT, "bad stream buf");
+
+	ret = bpf_prog_stream_read(prog_fd, 1, buf, 2);
+	ASSERT_EQ(ret, 2, "bytes");
+	ret = bpf_prog_stream_read(prog_fd, 1, buf, 2);
+	ASSERT_EQ(ret, 2, "bytes");
+	ret = bpf_prog_stream_read(prog_fd, 1, buf, 1);
+	ASSERT_EQ(ret, 0, "no bytes stdout");
+	ret = bpf_prog_stream_read(prog_fd, 2, buf, 1);
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


