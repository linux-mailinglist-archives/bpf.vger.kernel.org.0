Return-Path: <bpf+bounces-68148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E368B536C6
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0A0565A72
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFC34F473;
	Thu, 11 Sep 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXkWYj5E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDE2E888A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602714; cv=none; b=G7WLlna8Lr/Ilsx4JLh0sPSKLpgjzZnxJAQcWIYM8Z3dKvZIAFqbhCEhD8q1PdB/3mZ/ap0aGGmwxnlEJw9LOBxKMd8pndmlhLXObIOMKtYExqHojXcnOP03Y4vpNJhil8tfbbyvjtvVjD0IPSuXVrbesQe+22Xn/tjO50UGOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602714; c=relaxed/simple;
	bh=nlxB2UbmQVioH8qyvAEGEzXT7e6zFv5gyuqzDaoTW6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiTr6HQhOSPwL46bQv+bTore2EAMcpe6nX/Yc8wHlDDDPn7xYvfyQYn8UkECZ18D+Nma/sKI82CeuFdGHFeaiLHvQITPNTCj9XRqi1SovtOb41Vf4SebTlnofEKvbjcK4oC/Wx839f6zAqMERejQq0HsJnq8iGVY/fbM7PtIN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXkWYj5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DFBC4CEF8;
	Thu, 11 Sep 2025 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602713;
	bh=nlxB2UbmQVioH8qyvAEGEzXT7e6zFv5gyuqzDaoTW6o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cXkWYj5EpACDLrPsqAZhxnWdTPXWR3RFo+btVrXjiBXPe7ksRs8h92dmryHZlg+It
	 bB454WXLwDA0kwXO7cOVVpcDGrmWmnzkv7nz/SM5scLlnF166X8HPKy5INacrCC5wK
	 l2mlRdKzKIGxb+5VKfJX4hKqIswy/nH5X37MytRGHxfzkAFO+++kwK6+ewjxsjMgou
	 h3oHndDbqEYYBVErp/WitHJadsb/6oVrc9HraxD3Imj52P4Rg5pYd80y6zkoi45upq
	 +1a3FfAJZVTE8j8motP4ME2mpsp32q5WMmImD2FcBAkv7QzwGlRnIJJ01FxI5T8BF4
	 kbPI9mWrGm3lA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v7 5/6] selftests: bpf: use __stderr in stream error tests
Date: Thu, 11 Sep 2025 14:58:04 +0000
Message-ID: <20250911145808.58042-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start using __stderr directly in the bpf programs to test the reporting
of may_goto timeout detection and spin_lock dead lock detection.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 82 -------------------
 tools/testing/selftests/bpf/progs/stream.c    | 17 ++++
 2 files changed, 17 insertions(+), 82 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 9d0e5d93edee..6f8eac5ccb65 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include <sys/mman.h>
-#include <regex.h>
 
 #include "stream.skel.h"
 #include "stream_fail.skel.h"
@@ -18,87 +17,6 @@ void test_stream_success(void)
 	return;
 }
 
-struct {
-	int prog_off;
-	const char *errstr;
-} stream_error_arr[] = {
-	{
-		offsetof(struct stream, progs.stream_cond_break),
-		"ERROR: Timeout detected for may_goto instruction\n"
-		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
-		"Call trace:\n"
-		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
-		"|[ \t]+[^\n]+\n)*",
-	},
-	{
-		offsetof(struct stream, progs.stream_deadlock),
-		"ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock\n"
-		"Attempted lock   = (0x[0-9a-fA-F]+)\n"
-		"Total held locks = 1\n"
-		"Held lock\\[ 0\\] = \\1\n"  // Lock address must match
-		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
-		"Call trace:\n"
-		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
-		"|[ \t]+[^\n]+\n)*",
-	},
-};
-
-static int match_regex(const char *pattern, const char *string)
-{
-	int err, rc;
-	regex_t re;
-
-	err = regcomp(&re, pattern, REG_EXTENDED | REG_NEWLINE);
-	if (err)
-		return -1;
-	rc = regexec(&re, string, 0, NULL, 0);
-	regfree(&re);
-	return rc == 0 ? 1 : 0;
-}
-
-void test_stream_errors(void)
-{
-	LIBBPF_OPTS(bpf_test_run_opts, opts);
-	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
-	struct stream *skel;
-	int ret, prog_fd;
-	char buf[1024];
-
-	skel = stream__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
-		return;
-
-	for (int i = 0; i < ARRAY_SIZE(stream_error_arr); i++) {
-		struct bpf_program **prog;
-
-		prog = (struct bpf_program **)(((char *)skel) + stream_error_arr[i].prog_off);
-		prog_fd = bpf_program__fd(*prog);
-		ret = bpf_prog_test_run_opts(prog_fd, &opts);
-		ASSERT_OK(ret, "ret");
-		ASSERT_OK(opts.retval, "retval");
-
-#if !defined(__x86_64__) && !defined(__s390x__) && !defined(__aarch64__)
-		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
-		if (i == 0) {
-			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
-			ASSERT_EQ(ret, 0, "stream read");
-			continue;
-		}
-#endif
-
-		ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
-		ASSERT_GT(ret, 0, "stream read");
-		ASSERT_LE(ret, 1023, "len for buf");
-		buf[ret] = '\0';
-
-		ret = match_regex(stream_error_arr[i].errstr, buf);
-		if (!ASSERT_TRUE(ret == 1, "regex match"))
-			fprintf(stderr, "Output from stream:\n%s\n", buf);
-	}
-
-	stream__destroy(skel);
-}
-
 void test_stream_syscall(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc87..bb465dad8247 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -37,7 +37,15 @@ int stream_exhaust(void *ctx)
 }
 
 SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__arch_s390x
 __success __retval(0)
+__stderr("ERROR: Timeout detected for may_goto instruction")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 int stream_cond_break(void *ctx)
 {
 	while (can_loop)
@@ -47,6 +55,15 @@ int stream_cond_break(void *ctx)
 
 SEC("syscall")
 __success __retval(0)
+__stderr("ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock")
+__stderr("{{Attempted lock   = (0x[0-9a-fA-F]+)\n"
+"Total held locks = 1\n"
+"Held lock\\[ 0\\] = \\1}}")
+__stderr("...")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
 int stream_deadlock(void *ctx)
 {
 	struct bpf_res_spin_lock *lock, *nlock;
-- 
2.47.3


