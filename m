Return-Path: <bpf+bounces-63024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A00B01650
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E836760BCB
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502522222A6;
	Fri, 11 Jul 2025 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGj1mKEq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195B20D4FC;
	Fri, 11 Jul 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222773; cv=none; b=ssIE4PJWH+m0zfFLPiymBbiDjaaNk9bJ9DhbDKj74aENnXa4x1DjSV/6Qy8+43j01nqMb/kzVlaH61x/KBGP4klwdaR3PV1ex4XWpzdquCDSpHEicG1ZhHLNCZJcDizmiosBxyWTx8lRzcY/P8/1B8d0FJnkl1ljep1cL+t7EUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222773; c=relaxed/simple;
	bh=6JtT8h6bgmXU9+cgM0teIKW9enKG3uEOY99ZOHlS72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z11wHtl476qCe/+zuUHtNQ3nj1QVULKiM5cfGLRTrTYfALtyCFgcB60Tm7IQSFc8T3d/BNDW4od4sie0fbuGmRqFYCIs4sEEBs9iq4NtjJieo8a2GpXLg2Amv1YDybZbzZibJgz23txZSqGH7cGoVhFrzEtLuZTEdlveoH5CJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGj1mKEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7F2C4CEED;
	Fri, 11 Jul 2025 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222773;
	bh=6JtT8h6bgmXU9+cgM0teIKW9enKG3uEOY99ZOHlS72M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGj1mKEqT5pnojKOJe1eICd2E+v4UKacEObuxU38xO0WXsEryW3MkaiNVNIW5cRpA
	 iDXOP2wPQjzwJWkIP5NtZMaum8T0EcQ9+VMc6mHIjumsUD7tjcd+me8D4d2FyQzdKy
	 0nl7R068n2AGCUnsW5PKfWPeDV7p2lg8Jz3K2218FPfzG9Tmo1EVaNi9ef6wi26Fro
	 ObELeDx32BdMuIl9CpEOpdHUAbYLb+L7dbamUVoBBg/QPfB6F38fFosX5PjY9G2mzE
	 c52xTAmLMHBjIo7Moj5ETEBxqu5ACJ9sJMd9+Xsft4I+TTUp8PgJQ1uk8BEHg0nIBT
	 GHkG8Gmv7JrhQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 perf/core 15/22] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Fri, 11 Jul 2025 10:29:23 +0200
Message-ID: <20250711082931.3398027-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that makes sure parallel execution of the uprobe and
attach/detach of optimized uprobe on it works properly.

By default the test runs for 500ms, which is adjustable by using
BPF_SELFTESTS_UPROBE_SYSCALL_RACE_MSEC env variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 5709dc58f8c2..043570fdbd75 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -15,6 +15,7 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "bpf/libbpf_internal.h"
 
 #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
 #include "usdt.h"
@@ -629,6 +630,111 @@ static void test_uretprobe_shadow_stack(void)
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
 
+static volatile bool race_stop;
+
+static USDT_DEFINE_SEMA(race);
+
+static void *worker_trigger(void *arg)
+{
+	unsigned long rounds = 0;
+
+	while (!race_stop) {
+		uprobe_test();
+		rounds++;
+	}
+
+	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	return NULL;
+}
+
+static void *worker_attach(void *arg)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct uprobe_syscall_executed *skel;
+	unsigned long rounds = 0, offset;
+	const char *sema[2] = {
+		__stringify(USDT_SEMA(race)),
+		NULL,
+	};
+	unsigned long *ref;
+	int err;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return NULL;
+
+	err = elf_resolve_syms_offsets("/proc/self/exe", 1, (const char **) &sema, &ref, STT_OBJECT);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets_sema"))
+		return NULL;
+
+	opts.ref_ctr_offset = *ref;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return NULL;
+
+	skel->bss->pid = getpid();
+
+	while (!race_stop) {
+		skel->links.test_uprobe = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					0, "/proc/self/exe", offset, &opts);
+		if (!ASSERT_OK_PTR(skel->links.test_uprobe, "bpf_program__attach_uprobe_opts"))
+			break;
+
+		bpf_link__destroy(skel->links.test_uprobe);
+		skel->links.test_uprobe = NULL;
+		rounds++;
+	}
+
+	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss->executed);
+	uprobe_syscall_executed__destroy(skel);
+	free(ref);
+	return NULL;
+}
+
+static useconds_t race_msec(void)
+{
+	char *env;
+
+	env = getenv("BPF_SELFTESTS_UPROBE_SYSCALL_RACE_MSEC");
+	if (env)
+		return atoi(env);
+
+	/* default duration is 500ms */
+	return 500;
+}
+
+static void test_uprobe_race(void)
+{
+	int err, i, nr_threads;
+	pthread_t *threads;
+
+	nr_threads = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
+		return;
+	nr_threads = max(2, nr_threads);
+
+	threads = alloca(sizeof(*threads) * nr_threads);
+	if (!ASSERT_OK_PTR(threads, "malloc"))
+		return;
+
+	for (i = 0; i < nr_threads; i++) {
+		err = pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_attach,
+				     NULL);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto cleanup;
+	}
+
+	usleep(race_msec() * 1000);
+
+cleanup:
+	race_stop = true;
+	for (nr_threads = i, i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	ASSERT_FALSE(USDT_SEMA_IS_ACTIVE(race), "race_semaphore");
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -647,6 +753,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_session();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.50.0


