Return-Path: <bpf+bounces-62342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D727BAF821D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D59E4A844A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213C2BEC3C;
	Thu,  3 Jul 2025 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G73+HnKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59F2BE626
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575724; cv=none; b=g3vtH30U2YlV3SOOOCpmYO0xBYniHpYCBxqOxs/vUZ5YIETTJu8EsJttW64P6hv2mnK006mBc38aOnAaIO3UcgzmrvMf4OI2YcRKrQwjld1/C2ag8A4gwE8czHLy3RvirwLbNehnYnNIPeT0vlj8Bu/+C5DmpJ+M1jVkzlaLnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575724; c=relaxed/simple;
	bh=6k8WhsGB6FrXTcFMRhoY3wuN7GNmYEfqQ7Z3DTLhrXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmdYyXyOu1BruDWy9j06jiQTQq24bUkQ8qx0BES+6HLWN5FoCjwjI5obMZA5vPrI0NhULky5lrlbyEcPip3ffqbrF08KdtzhZsrBNUCgvjYiZQOg/awkhmBwHq/u/eATZO36iAcL45sxIW5iUC4VeGR5MhnZf3ymkTRWfoawY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G73+HnKE; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-addda47ebeaso59180566b.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575721; x=1752180521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhFHy6rp2P+xPD4C6vye1Lj9wtZm5DgPCycs8tt/uOs=;
        b=G73+HnKEkisUDPUhZqemD4MA40RiQyJ2lbULB7Fhh6h1iTff2dcVG2dQjdJ7N+/AYI
         P4r+78oce/PC1mDB0wnvAeYEwcLGLJ4HCxCr+JHaIttx7mX513wUlCk/Jxsvt2G9oAQl
         oJV71yTxPWhODjZspweLfNahBDOOciZjD+KF6e99fmM/ChTiMgay7kCMx28o/cwt0yAV
         EDcB3V7PChtJbYUyDi+IskkplR/jVJSulIzb3JxQFXUQDJzsFvHAq1/HsdQpLV4jGKCX
         gbATuYfVHm4FT6Wd4SaSNo3Mx/N7PKgB7Da2OPp2kAPT8u3fZokZ/tPMY2kPaSgBicUc
         PTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575721; x=1752180521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhFHy6rp2P+xPD4C6vye1Lj9wtZm5DgPCycs8tt/uOs=;
        b=t6BCAeYLIaMuzovhCQfiqWO9yM4h/MVUQiUcEnDVQ7RkRyiLylBwfAFyCyRkGMESYd
         MMfpL9GFnGfivK3CM1UC6oVdRkXUNPlCG37KWFG4mz4XJGrlc4chTUcE2tEmt1pNiDMx
         rSrg6x4hWV05wGLLUCuYOMQOXWVnmeIPsVLrOoQLJEs0Oq7G//QWPxx61YUgBblfxTI6
         jhCt3d/bus4j5Hqf0lzEeYZJyU88e8KFLp89lp2A0s/BJKM0Ayyw8O5ZpQFwmqp4fnRJ
         D73WuN2vJkIwyhEBtz2LIhgxuXMzXycxWD15qYbOAa5JPZl9asoq51b3ou6oVFzW9Mwt
         I40A==
X-Gm-Message-State: AOJu0Ywcr9LYJqp53LlJSipDNwXcyZTtZohJiyHS77rfvs++GnONJ365
	CEqz8kEwdywQMUlCSjZpc4nYExpt9hUiL8xaNzuzd5w3yTikh1H8L+HlWhyllqJ2SiA=
X-Gm-Gg: ASbGnct1QI2gpuYOZXJ9lENXSmBipQnJ6jqwqGc6dk8HaFS6TmK+7s60suoTH9+uA9g
	UD6MQU2LrrNESzh8V58HzSd/us5LQpvRgSHjyo5ZP+hFkn5SSWZrb9lSzVTg0J77nJri5+hkHZP
	HOJFrco67zAIT7AFDF3iCjKOEA79A36XD/VcldjRWayLYbgR2afUG51ahqArGUCSky7UBtacPXE
	2i4DPbwZcOabyW939oT1wRHCpr8IwSHNBtHzTkLclMevvMQbH3Rzk4Pmvzll9YsAaP6J0Lwojwx
	tbPWshwqDFB5kqauQBBQQWFWUVBZLi0thlZUGn70pD/Fh2XkHhJx
X-Google-Smtp-Source: AGHT+IFKeGsJf9IPvv7VckVFE3ARbUAzssAC3ZZCTybMsaGL0O6W2bXS7AiuM13OYBebibEBJ0nYEg==
X-Received: by 2002:a17:907:970a:b0:ae3:6a82:e6a2 with SMTP id a640c23a62f3a-ae3d89ae417mr545694266b.29.1751575720400;
        Thu, 03 Jul 2025 13:48:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f69231d3sm38161566b.41.2025.07.03.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 12/12] selftests/bpf: Add tests for prog streams
Date: Thu,  3 Jul 2025 13:48:18 -0700
Message-ID: <20250703204818.925464-13-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8172; h=from:subject; bh=6k8WhsGB6FrXTcFMRhoY3wuN7GNmYEfqQ7Z3DTLhrXo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudMGLZwz8qHRO7xWeD5SoiSLPwd71vlqs1tXmzg oIOi6KiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8RygNLEA CEMgsyUc7BN4uqaWyTln2xWCeObTur4lEztspyoEVnA3s4ioO1sNeZcXD5la86cOjuFRHW0GNxwoKf yOY+MS8LCet0NmpwhBdMUBad/NrynHFvOmsxnyTe0HqOKKos7PjL6WdoWcaWLu6UtijETAQc4Yu6n9 x1RixgTktrL4FMorNzpqER/NJZ7C9vTEhzDWsn4p3GezYQPHW5+0sC0Fv1qZS0+yMFTTAgD0NTm/1Z zdCVSxHfILvswPrer4XeoFa3Ws84u/8pKEXGAyhXe4oDU04c7yYi10RotjJwVF9JV6guj5PPvSzOlm vnrgBQqBQEnoB/TSvhZTTVU5if2wcURY6py1IoorsPtIqVI6kfuX/2rMQ10kcx53M6qzmeyg9o4Uuf OAoFLsp5Nd7wOuXh3pzx4ly4tsVy/5hEwuqpBayxKilWhfYEGDvLHEHlaAXipzAX5da//A9Ur3auSQ TjjyHAabweef+taZuOTgVKwoYFwI3/0iQSFbLarZ2d9H8Im1650HVa1sQuFhzJ5pjbuZvTK60wURHy Lj7XUISwGlOY1ny+dMVxQIRiyPfRng24tBVteJqOxhVwlgtLn0z7IfbVInsT7jR7cnBc/rocEyCwZH 2zMDQR9Si/23AQuLAD1df9Zrule3aM8QuujeXx0AIC/MIkW0w34OLOQGVTNw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested and
functional.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 141 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  79 ++++++++++
 .../testing/selftests/bpf/progs/stream_fail.c |  33 ++++
 3 files changed, 253 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
new file mode 100644
index 000000000000..d9f0185dca61
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -0,0 +1,141 @@
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
+		"ERROR: Timeout detected for may_goto instruction\n"
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
+		"Call trace:\n"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+		"|[ \t]+[^\n]+\n)*",
+	},
+	{
+		offsetof(struct stream, progs.stream_deadlock),
+		"ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock\n"
+		"Attempted lock   = (0x[0-9a-fA-F]+)\n"
+		"Total held locks = 1\n"
+		"Held lock\\[ 0\\] = \\1\n"  // Lock address must match
+		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
+		"Call trace:\n"
+		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+		"|[ \t]+[^\n]+\n)*",
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
+	struct stream *skel;
+	int ret, prog_fd;
+	char buf[1024];
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
+		if (!ASSERT_TRUE(ret == 1, "regex match"))
+			fprintf(stderr, "Output from stream:\n%s\n", buf);
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
+	ASSERT_EQ(ret, 1, "bytes");
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 1, &ropts);
+	ASSERT_EQ(ret, 0, "no bytes stdout");
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, 1, &ropts);
+	ASSERT_EQ(ret, 0, "no bytes stderr");
+
+	stream__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
new file mode 100644
index 000000000000..35790897dc87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -0,0 +1,79 @@
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
+int size;
+
+SEC("syscall")
+__success __retval(0)
+int stream_exhaust(void *ctx)
+{
+	/* Use global variable for loop convergence. */
+	size = 0;
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC && size == 99954)
+			return 0;
+		size += sizeof(_STR) - 1;
+	}
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
+		return 1;
+	nlock = bpf_map_lookup_elem(&arrmap, &(int){0});
+	if (!nlock)
+		return 1;
+	if (bpf_res_spin_lock(lock))
+		return 1;
+	if (bpf_res_spin_lock(nlock)) {
+		bpf_res_spin_unlock(lock);
+		return 0;
+	}
+	bpf_res_spin_unlock(nlock);
+	bpf_res_spin_unlock(lock);
+	return 1;
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
index 000000000000..b4a0d0cc8ec8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -0,0 +1,33 @@
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
+SEC("syscall")
+__failure __msg("R3 type=scalar expected=")
+int stream_vprintk_scalar_arg(void *ctx)
+{
+	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0, NULL);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("arg#1 doesn't point to a const string")
+int stream_vprintk_string_arg(void *ctx)
+{
+	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0, NULL);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


