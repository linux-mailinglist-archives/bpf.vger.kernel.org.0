Return-Path: <bpf+bounces-2903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5A73667E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6891C203B2
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF37C2CA;
	Tue, 20 Jun 2023 08:39:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B538BA5E
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5125CC433C0;
	Tue, 20 Jun 2023 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250378;
	bh=C9fj0XTGA3jjWVIvAT6IjRtMLUYrz6Od3vyBHjYLMPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFgB+jj/MdYVUXjLlmfKug6hpzdamkDvC+GsKslVnMWOnu6a+Jr9GgCtzV2j8AokZ
	 T51QAEpoduwZDBaJxqW078GslCV9xwIu21PVt2b9UGcTT0UZb7YVzyGPheZbrHfEjS
	 Tf4uVuFORZF6bLpxQHtTPDX5HUEnxD5Prcv+KPG+Jm56MrxnHs1t5VrlghYYI/oI38
	 HCsf55XNrRlFO4deZGhJhdI3YevmJPQ4909zjp770pdXe3m2slrrFF1y57QAsp92Am
	 goa3xefirYltUPmXBDLgzWg7AuWTFUKoDvl3QcLRJll6a9abI+AoIKFBta1Ala/EPr
	 Km/8QDezkOHsA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 23/24] selftests/bpf: Add uprobe_multi pid filter tests
Date: Tue, 20 Jun 2023 10:35:49 +0200
Message-ID: <20230620083550.690426-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running api and link tests also with pid filter and checking
the probe gets executed only for specific pid.

Spawning extra process to trigger attached uprobes and checking
we get correct counts from executed programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 131 ++++++++++++++++--
 .../selftests/bpf/progs/uprobe_multi.c        |   6 +-
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index a9d5a1773407..efa7b5d49940 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -23,14 +23,86 @@ noinline void uprobe_multi_func_3(void)
 	asm volatile ("");
 }
 
-static void uprobe_multi_test_run(struct uprobe_multi *skel)
+struct child {
+	int go[2];
+	int pid;
+};
+
+static void release_child(struct child *child)
+{
+	int child_status;
+
+	if (!child)
+		return;
+	close(child->go[1]);
+	close(child->go[0]);
+	if (child->pid > 0)
+		waitpid(child->pid, &child_status, 0);
+}
+
+static void kick_child(struct child *child)
+{
+	char c = 1;
+
+	if (child) {
+		write(child->go[1], &c, 1);
+		release_child(child);
+	}
+	fflush(NULL);
+}
+
+static struct child *spawn_child(void)
+{
+	static struct child child;
+	int err;
+	int c;
+
+	/* pid filter */
+	if (!ASSERT_OK(pipe(child.go), "pipe"))
+		return NULL;
+
+	child.pid = fork();
+	if (child.pid < 0) {
+		release_child(&child);
+		return NULL;
+	}
+
+	/* child */
+	if (child.pid == 0) {
+		close(child.go[1]);
+		fflush(NULL);
+		/* wait for parent's kick */
+		err = read(child.go[0], &c, 1);
+		if (!ASSERT_EQ(err, 1, "child_read_pipe"))
+			exit(err);
+
+		uprobe_multi_func_1();
+		uprobe_multi_func_2();
+		uprobe_multi_func_3();
+
+		exit(errno);
+	}
+
+	return &child;
+}
+
+static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child)
 {
 	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
 	skel->bss->uprobe_multi_func_2_addr = (__u64) uprobe_multi_func_2;
 	skel->bss->uprobe_multi_func_3_addr = (__u64) uprobe_multi_func_3;
 
 	skel->bss->user_ptr = test_data;
-	skel->bss->pid = getpid();
+
+	/*
+	 * Disable pid check in bpf program if we are pid filter test,
+	 * because the probe should be executed only by child->pid
+	 * passed at the probe attach.
+	 */
+	skel->bss->pid = child ? 0 : getpid();
+
+	if (child)
+		kick_child(child);
 
 	/* trigger all probes */
 	uprobe_multi_func_1();
@@ -50,6 +122,9 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel)
 	ASSERT_EQ(skel->bss->uretprobe_multi_func_3_result, 2, "uretprobe_multi_func_3_result");
 
 	ASSERT_EQ(skel->bss->uprobe_multi_sleep_result, 6, "uprobe_multi_sleep_result");
+
+	if (child)
+		ASSERT_EQ(skel->bss->child_pid, child->pid, "uprobe_multi_child_pid");
 }
 
 static void test_skel_api(void)
@@ -65,17 +140,19 @@ static void test_skel_api(void)
 	if (!ASSERT_OK(err, "uprobe_multi__attach"))
 		goto cleanup;
 
-	uprobe_multi_test_run(skel);
+	uprobe_multi_test_run(skel, NULL);
 
 cleanup:
 	uprobe_multi__destroy(skel);
 }
 
 static void
-test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
+__test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts,
+		  struct child *child)
 {
 	struct bpf_link *link1 = NULL, *link2 = NULL;
 	struct bpf_link *link3 = NULL, *link4 = NULL;
+	pid_t pid = child ? child->pid : -1;
 	struct uprobe_multi *skel = NULL;
 
 	skel = uprobe_multi__open_and_load();
@@ -83,30 +160,30 @@ test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi
 		goto cleanup;
 
 	opts->retprobe = false;
-	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe, -1,
+	link1 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe, pid,
 						      binary, pattern, opts);
 	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
 		goto cleanup;
 
 	opts->retprobe = true;
-	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe, -1,
+	link2 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe, pid,
 						      binary, pattern, opts);
 	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
 		goto cleanup;
 
 	opts->retprobe = false;
-	link3 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe_sleep, -1,
+	link3 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uprobe_sleep, pid,
 						      binary, pattern, opts);
 	if (!ASSERT_OK_PTR(link1, "bpf_program__attach_uprobe_multi_opts"))
 		goto cleanup;
 
 	opts->retprobe = true;
-	link4 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe_sleep, -1,
+	link4 = bpf_program__attach_uprobe_multi_opts(skel->progs.test_uretprobe_sleep, pid,
 						      binary, pattern, opts);
 	if (!ASSERT_OK_PTR(link2, "bpf_program__attach_uprobe_multi_opts_retprobe"))
 		goto cleanup;
 
-	uprobe_multi_test_run(skel);
+	uprobe_multi_test_run(skel, child);
 
 cleanup:
 	bpf_link__destroy(link4);
@@ -116,6 +193,22 @@ test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi
 	uprobe_multi__destroy(skel);
 }
 
+static void
+test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi_opts *opts)
+{
+	struct child *child;
+
+	/* no pid filter */
+	__test_attach_api(binary, pattern, opts, NULL);
+
+	/* pid filter */
+	child = spawn_child();
+	if (!child)
+		return;
+
+	__test_attach_api(binary, pattern, opts, child);
+}
+
 static void test_attach_api_pattern(void)
 {
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
@@ -138,7 +231,7 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
-static void test_link_api(void)
+static void __test_link_api(struct child *child)
 {
 	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
 	LIBBPF_OPTS(bpf_link_create_opts, opts);
@@ -159,6 +252,7 @@ static void test_link_api(void)
 	opts.uprobe_multi.path = path;
 	opts.uprobe_multi.offsets = offsets;
 	opts.uprobe_multi.cnt = ARRAY_SIZE(syms);
+	opts.uprobe_multi.pid = child ? child->pid : 0;
 
 	skel = uprobe_multi__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
@@ -187,7 +281,7 @@ static void test_link_api(void)
 	link4_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_GE(link2_fd, 0, "link4_fd"))
 		goto cleanup;
-	uprobe_multi_test_run(skel);
+	uprobe_multi_test_run(skel, child);
 
 cleanup:
 	if (link1_fd >= 0)
@@ -203,6 +297,21 @@ static void test_link_api(void)
 	free(offsets);
 }
 
+void test_link_api(void)
+{
+	struct child *child;
+
+	/* no pid filter */
+	__test_link_api(NULL);
+
+	/* pid filter */
+	child = spawn_child();
+	if (!child)
+		return;
+
+	__test_link_api(child);
+}
+
 static inline __u64 get_time_ns(void)
 {
 	struct timespec t;
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index cd73139dc881..1086312b5d1e 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -21,6 +21,8 @@ __u64 uretprobe_multi_func_3_result = 0;
 __u64 uprobe_multi_sleep_result = 0;
 
 int pid = 0;
+int child_pid = 0;
+
 bool test_cookie = false;
 void *user_ptr = 0;
 
@@ -34,7 +36,9 @@ static __always_inline bool verify_sleepable_user_copy(void)
 
 static void uprobe_multi_check(void *ctx, bool is_return, bool is_sleep)
 {
-	if (bpf_get_current_pid_tgid() >> 32 != pid)
+	child_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid && child_pid != pid)
 		return;
 
 	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
-- 
2.41.0


