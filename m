Return-Path: <bpf+bounces-59744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A010ACF07E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527DF163F6A
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB5F23C506;
	Thu,  5 Jun 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwA1Vb/W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB26235050;
	Thu,  5 Jun 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130012; cv=none; b=ieIAd8dfkAb5ZGOflfmpKQjtFUb6D0MidXhsMwDm33JvVAG+6J5gE8NE776WG6Tmnr2l3ik9ZypimjX8WYHBy2RKusR2GxSSHcKRR9Lbdib5RWlPjhq/RK36sDQFXDc+pgcNB8N989HT9HtPu2F5oo1wCVuH9fc20JDg5/hDylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130012; c=relaxed/simple;
	bh=qH9weWjH85FHL7kQQznCoblt91x8H9fViCICnprD92c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OodLVX//WuvorB6hAHkvd5w22j/s6Lyn4u1USQWy4LNNvniudWEHJO14SaXgHtlzwJNFzfsa1IBCgK3t+3qtdaJ+uaVNPyfBotGFkMi8xijFtey46MdKCz02X9bSEPi+YqAyMtaiyy9BUhNfeDyYf+gANg8nrxeQLKwl9qmPEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwA1Vb/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7541EC4CEE7;
	Thu,  5 Jun 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130011;
	bh=qH9weWjH85FHL7kQQznCoblt91x8H9fViCICnprD92c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwA1Vb/Weh+sG4yvsFltv8nJqaEfIUbSab7H0a20nnQOPXGLhhO0VqLrBN0YVjRx/
	 hHq1KzxW947quCmfOrd7UvnCeD2+X6jD1sYaTKbkwiXDSLW9l3ylDD1x4ubl2IVSSV
	 SUrJqONmeaJx3MAFpU3JRQfvAGH9+48H7LVMjikqyqjUZa8AlUJXXLqOS04WWfoyRV
	 PdDXgN/5Ols0zDVTlSGauQPTDEBWirhAfQX67JPRBD0s3/e8dby83dbRxEzHx3Otnv
	 p6aTYWna5jpoYBNmuCmt0XImx4YwVzPol1uxrMyRiyoAMm3fQvewRlk6JK62g6qylV
	 n46caNxckmVZg==
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
Subject: [PATCHv3 perf/core 15/22] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Thu,  5 Jun 2025 15:23:42 +0200
Message-ID: <20250605132350.1488129-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605132350.1488129-1-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
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
index b9152ca8cdf5..792ff7d411d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -15,6 +15,7 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "bpf/libbpf_internal.h"
 
 #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
 #include "usdt.h"
@@ -634,6 +635,111 @@ static void test_uretprobe_shadow_stack(void)
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
@@ -652,6 +758,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_session();
 	if (test__start_subtest("uprobe_usdt"))
 		test_uprobe_usdt();
+	if (test__start_subtest("uprobe_race"))
+		test_uprobe_race();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.49.0


