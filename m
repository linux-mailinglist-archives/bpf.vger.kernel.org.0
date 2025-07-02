Return-Path: <bpf+bounces-62048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABDAF0925
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0192D4A569D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6850A148827;
	Wed,  2 Jul 2025 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OODRfyE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F431DEFC5
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426283; cv=none; b=TKBdMYLKOpVJc53gpjOc/uL1o/7UC6e5hEnMx46SUPY3kUB128+hGkGQX/0YmbT1iTjLFd0bnlxmatjVfERbq2Vk3R4puiZj4naxcmdSn03RLfwvcpbyKd0NNogMjDPtkfJuPVnU9UR05QetFs/2AUzaX9en3/aVbajbCRPpZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426283; c=relaxed/simple;
	bh=RcjdzBXvpANJW2my5bf2HgX4123P4kJG+3/cXgv41ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqmiP+WUf/x0zcCVOgqseVgl5XdtSLpZSgNiQzMAZMxgujri4V71poNgMR610PnTVaaow8rIwBvYH9765Cg1VrRI7d/435zZ2XhJfa2fWjLWtEaZCIsip1VBnxJSQY5RMZnaTgqPuZwNkaTwA1LiZXyQjr9BilDZbPcftmeiE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OODRfyE4; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so1102709566b.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426279; x=1752031079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cthJAfDAtH1cW2GNAUVyW3bs+c8v+yubhEnO1Ve6Ff0=;
        b=OODRfyE4sB9GrfUQls0DythsuFEFfDSHDSaATmWDo2uI6Mn/TQ9DIEiJsxIcbBJz3i
         sEWGC+gaxQtc8LQMrBqXO8+rxh/hsz/KM3ZugH/32zQiNa/VJvfHzpaIHgHymJT/LEWx
         mtnGR9nOPCeFsX4mbJ3t//SYQG+6eRy5LF4VBxYly00UU4+hdby0baaLayngPrxfsk/V
         u0flzkQeAD64LAJ9JLr0hioiJXrzCRdqARL5ZWp4eenrahOmbcMDY4CIKqASWAqnucLJ
         QuaBrH6PK/5HUje4ESMmZ9c/JjCTPPjZ35VGxBH6XrHYYpmzy60oH/8SiRw33LuFtN3k
         NblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426279; x=1752031079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cthJAfDAtH1cW2GNAUVyW3bs+c8v+yubhEnO1Ve6Ff0=;
        b=Xwss18QCrT8IWT4zuugqiziW94EnqtKf1xN551AdbczmNYMd015ToEdavs84207qdW
         znQpq7Ckg7+9ke65gnr2I8PN8JahJtstpgTvPJLq518QOjGos35898O+9yM41R86q51t
         5pDQ2tpGEhsrLbPHoqhBfLm8ukRY3qZnQT7aYPQtbuKcBv8AlWaeUqIOD5/nVnUJYaHd
         TIYO4bMpyxD2QJ0K9bonHosAfKPHhb2SO0v4vFxiGJSpMqOyM6jpXzUYLRKV0k1z44B3
         s9qfExnbAsX5HY0oxo8HBKg1Uv9tQXKesEJBgCUHjpgaNYVf5H2yw8CXqYwwa6X0riPt
         GGgg==
X-Gm-Message-State: AOJu0Yx7iPGgjVJVBGqL2twPva053CgnybImUyTRBLeD8HdhYMhuUHmr
	A1tl+EWh+b6ayhC0T09iSJoEp4QvSkfVgfmPpbE2guPaxt0N/KKC/jjEtMYvtpFvULs=
X-Gm-Gg: ASbGncvhkVBH9IS2DRafhuFlh1OVYH8d89vq7AOXVMo0yI/GGJ7Nz6qQG4GQRbMJmyJ
	jBNuf9c56oHWV696hcL+TmYDfrTA9X28gfEDR6VHE9zLYzEggyAe4KHh255J16VD4JPP8XzWefE
	uSvR+P+KEoqdwOiCKMdkrREd2p7hxB3XvUwUaicSP9fXnjkPyjluNJUZ2E/BFbDLUdKOhrwGE/Z
	eFV5MwH3WuiWC8DoB+dCiO5YoAc+XPKsE+l7V0JidKbKvynfvkNG/lrNp/KDHvnAgx7fz6FDGKt
	rWcqfhqM1mXzHiZ4/Q47sMwmClCFtoj9NJV36Qd4i1Uk45JRJ30=
X-Google-Smtp-Source: AGHT+IFeg9gIoPFxYapXguNXh9GP637m9eJBb2GIPIJnuP1kCrNXbuNiYdkDb0ZAlDnfhmAWUl1Ovg==
X-Received: by 2002:a17:907:6d0b:b0:ae3:5784:2b44 with SMTP id a640c23a62f3a-ae3c2d0e802mr92976066b.33.1751426278857;
        Tue, 01 Jul 2025 20:17:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bb5csm981361166b.112.2025.07.01.20.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 12/12] selftests/bpf: Add tests for prog streams
Date: Tue,  1 Jul 2025 20:17:37 -0700
Message-ID: <20250702031737.407548-13-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7781; h=from:subject; bh=RcjdzBXvpANJW2my5bf2HgX4123P4kJG+3/cXgv41ac=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFSD5ALQRDfo9qHgx9j7rQFY+RZDpP8lkyZRLsP Sr0kmwWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUgAKCRBM4MiGSL8RykN1D/ 9rPYMvt2qvfh93P6qWCioSOLWfciaWxEdJS+nY/PaEQz3LJhbovKDOIMAsy4rZ6206KArP+1jNZDe/ WVkkFIguMBpwSYUGrOl0n3wi80dqGoCrkr0j3xnv/4xf2ZrxAfQc5nzM5xfcncmRw9WhaGOKrIF7Cc Fi0/dV4nQ4ZSty92w/hku1npLmgJhRucpaOGoMBg2/hyvjweE/J6UcA8ROmKFsQvwTuedmJ3Hk0Mop PEXPCZY8QBxlO+rmK2teRAjvoHQ7FtqfrtXTWKQVNK+brhsQb4wa4UwMC34tTksDHAhyq2neypP+2E GUqWBar+MCJdNt9qITYexRTy/Oyr3Rd7W4D6GZHgoWfHx6DnVAc4aajCge/mr+eCpv/Qt1v+0Ie25w 0ajV0ZZTED684VB+OtntizUT8XBKhK+sf8yqcD9hE7OQgdpQB7vK2NhHJyuUpJCu6sd/ZSh2/K1MSw Sdo3g7IJMRC2hEi9wkALONl03we809QYLZxhKJgAuY1nUTgP8lg4/u/2w+OSd3P0fGKrFdHOtNDOeJ ThmSNKgMxoyERGYeobbcxA/S2QVT/T4smH6U9iaxFMI9FXk54hZ1oB7Dl7pITxWD1pfKOAUEZb3j7d ucRJKe7vKceKdaXK/kL2GnIKJEAyQ7kdt+DiZm78Onc5zGSX3GghwqyNSUQw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested and
functional.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 141 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  81 ++++++++++
 .../testing/selftests/bpf/progs/stream_fail.c |  17 +++
 3 files changed, 239 insertions(+)
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
index 000000000000..ae163a656082
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -0,0 +1,81 @@
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


