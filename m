Return-Path: <bpf+bounces-54457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6CA6A548
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2F71889B41
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F022333B;
	Thu, 20 Mar 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7RrtL1+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138A1CCEE2;
	Thu, 20 Mar 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471105; cv=none; b=tKTJspUiWTJILDMK8kdQQPeduv/XBNl2FwtJ++3/j1n0GWUrBE65WvQ3Bt9hd7p/j2c5Lrwb5uNsnTvh+LcbLOB2ahnScNFvhAXaHsAUoWRuC8T9xDkY/BotLpLnpjpMNgkCMmXC/sM9QbYqqqwH2LOMf18pTn12Bfwk66+cTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471105; c=relaxed/simple;
	bh=HnXaKDzvalGTV6Udp5z+80hnK6zKMaT+C9F9KB5kc90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehsy4Gumrc/qfhYvYdkDGQiAMpu/du8O8+MlvP3IUPOO5pVNJWTYeraQ19aQFsM1cu+Qu1JcnQmlLuaw8cFyyQi/2BTc/EAtaC9y71l6AU/cdHtqrW9TGArW/UBcnRMCTGEQ1IkL7PogBFB619E3tDTyOYiZE/dV+dDuKGZ/sLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7RrtL1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66EDC4CEDD;
	Thu, 20 Mar 2025 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471105;
	bh=HnXaKDzvalGTV6Udp5z+80hnK6zKMaT+C9F9KB5kc90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7RrtL1+F8+7tum4MiGjEgee4xVywXNRptypBc8beTbEw0eSfzlO4/2e99lPrPF0D
	 DOvR92LT6vt2EsokhzMc34xclYrPKFNFjT1gPDFyTjcJi+sqSTOlbdOghpxpf0g8Ep
	 ReZJptKC7v06LMypwNjBe9+4AViuXiUejUXqmeX2AUVnrhbXDOZfbhy+YZ7mcXGe99
	 PSVc1x0OaOGa+0zODCpfUt4jSMPwcaqoGHF5wAQzwUfC3adIjfGh228tEwRnf4Ae8R
	 4LvPd/s/Yv1ZSc29s4g0Fkz9IgydQ0FV1Nj6JF2N2C5Tm+TjvTu3yTkAJl0Po2Tqhu
	 +92oca4s+ey+Q==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 16/23] selftests/bpf: Add hit/attach/detach race optimized uprobe test
Date: Thu, 20 Mar 2025 12:41:51 +0100
Message-ID: <20250320114200.14377-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that makes sure parallel execution of the uprobe and
attach/detach of optimized uprobe on it works properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index d648bf8eca64..5c10cf173e6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -600,6 +600,78 @@ static void test_uprobe_usdt(void)
 	uprobe_syscall_executed__destroy(skel);
 }
 
+static volatile bool race_stop;
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
+	struct uprobe_syscall_executed *skel;
+	unsigned long rounds = 0, offset;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return NULL;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return NULL;
+
+	while (!race_stop) {
+		skel->links.test_uprobe = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					0, "/proc/self/exe", offset, NULL);
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
+	return NULL;
+}
+
+static void test_uprobe_race(void)
+{
+	int err, i, nr_threads;
+	pthread_t *threads;
+
+	nr_threads = libbpf_num_possible_cpus();
+	if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	threads = malloc(sizeof(*threads) * nr_threads);
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
+	sleep(4);
+
+cleanup:
+	race_stop = true;
+	for (nr_threads = i, i = 0; i < nr_threads; i++)
+		pthread_join(threads[i], NULL);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -618,6 +690,8 @@ static void __test_uprobe_syscall(void)
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


