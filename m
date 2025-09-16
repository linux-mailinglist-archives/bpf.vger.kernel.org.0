Return-Path: <bpf+bounces-68561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E8B5A450
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33B61C04563
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD38320A38;
	Tue, 16 Sep 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMlJ+Yzj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297F285C95;
	Tue, 16 Sep 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059639; cv=none; b=tA2wyxndbSN84eHxzm/qQwu9owzoNIEDvvXlhxpFqRdb3JUXh7ksz6EjGLk3XCKpKcYGuMFvyyhMMNCS9cmtZWAKKO8loaxU5l24i+1OvoI116TUuN+HiZVDPy2tSlGkvsQt0wO7TPiXONM0iDmXgHbKeL/WDjnOcgli0Cyo0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059639; c=relaxed/simple;
	bh=yZmUc8dAaJ6kpzj+rfiloC/S5Y3mRiKr3Ww/w18JtC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAguhxoZzPvl86izkVQuoPHZ+YLVlS4sZhvpl6h0tMblT3Z8+GvTPs3XFz+Yf0GDItrthH3SzHdr4aZp/Gq/Dm+eJh0d3pnYsJ7W6rI9Xb13lCNqGaYEt3Wh1l2btz4XVlXfdM3+hy8pwjsCNq6ELclXMzL9UwsU72S9N5oIAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMlJ+Yzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A945C4CEEB;
	Tue, 16 Sep 2025 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059638;
	bh=yZmUc8dAaJ6kpzj+rfiloC/S5Y3mRiKr3Ww/w18JtC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMlJ+Yzj9HgmQly4UF0abtRdn7DvOoGkTLS646Rrh8BiaEavF0y9UIBNzYSAdPK7n
	 PNmuOTxJrW6IY4pWq+1EJW4XB5SZU1bN6D6Zk231mlQ+Swa9xheaNLR7UooUkDBUQ3
	 U935aEX2llXcRTvM3zqHkisa160wK7kMj1zxleTSY0ntEu+V3WjBkXGOGj5wkgUrZ8
	 X8AfEvLOFWGPOkoJjK/P0BTc/4PNyo7yD6ji5UxS0f3yekF+iBx35M2SxBGXjotzEW
	 3fdDKnuRr4f4OuFAmjxlXdRVSGDYviFpVM1pb5r/U8IqcDUJwdD5qIUQnERAKb4cb6
	 iH7bKlO6nYYGg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 bpf-next 4/6] selftests/bpf: Add uprobe context ip register change test
Date: Tue, 16 Sep 2025 23:52:59 +0200
Message-ID: <20250916215301.664963-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
References: <20250916215301.664963-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can change the application execution
through instruction pointer change through uprobe program.

It's x86_64 specific test.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/uprobe.c | 42 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c | 14 +++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index 19dd900df188..86404476c1da 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -190,10 +190,52 @@ static void regs_common(void)
 	test_uprobe__destroy(skel);
 }
 
+static noinline unsigned long uprobe_regs_change_ip_1(void)
+{
+	return 0xc0ffee;
+}
+
+static noinline unsigned long uprobe_regs_change_ip_2(void)
+{
+	return 0xdeadbeef;
+}
+
+static void regs_ip(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct test_uprobe *skel;
+	unsigned long ret;
+
+	skel = test_uprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->my_pid = getpid();
+	skel->bss->ip = (unsigned long) uprobe_regs_change_ip_2;
+
+	uprobe_opts.func_name = "uprobe_regs_change_ip_1";
+	skel->links.test_regs_change_ip = bpf_program__attach_uprobe_opts(
+						skel->progs.test_regs_change_ip,
+						-1,
+						"/proc/self/exe",
+						0 /* offset */,
+						&uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.test_regs_change_ip, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	ret = uprobe_regs_change_ip_1();
+	ASSERT_EQ(ret, 0xdeadbeef, "ret");
+
+cleanup:
+	test_uprobe__destroy(skel);
+}
+
 static void test_uprobe_regs_change(void)
 {
 	if (test__start_subtest("regs_change_common"))
 		regs_common();
+	if (test__start_subtest("regs_change_ip"))
+		regs_ip();
 }
 #else
 static void test_uprobe_regs_change(void) { }
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/testing/selftests/bpf/progs/test_uprobe.c
index 9437bd76a437..12f4065fca20 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
@@ -82,4 +82,18 @@ int BPF_UPROBE(test_regs_change)
 	ctx->si  = regs.si;
 	return 0;
 }
+
+unsigned long ip;
+
+SEC("uprobe")
+int BPF_UPROBE(test_regs_change_ip)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	ctx->ip = ip;
+	return 0;
+}
 #endif
-- 
2.51.0


