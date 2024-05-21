Return-Path: <bpf+bounces-30127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE31A8CB23A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B87E1F218B5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4721442E3;
	Tue, 21 May 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6/pnjrH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC417F49A;
	Tue, 21 May 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309248; cv=none; b=UFexAvAvJrW7GQBKNCrNLJwQzc0/eATTWFqMVq9Yo0I35+a1Hh58v8+ELgtOGif6HAF8fJMpRploeBKeTH+tzoAbeJUBhY4aivGY6Qq+FQO91//IzZkFsZtxQoboeZmH5U0diCD9+TF4zhd2RyRo0AvAdI+1rK7dcb/94JisMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309248; c=relaxed/simple;
	bh=H9fGkZFd1ODphe/7btOkZWzp5B/Y0DZC4PW8bEKrqAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV9xrtOSBlEmabxqjv/OUANvTSnYlXh7zFH9GtbPf5gzyNfAtdP4AC3zHG0B2G1HINdiap+bJRGLbNjP8NaOgn84xH26Y6mxOOLahcUPxCI5DululAPUuCi4jgYrbSzPgG0MByydqJAehvz1kAkjYv7/XQx67j3r3DB58LMR3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6/pnjrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA142C2BD11;
	Tue, 21 May 2024 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309247;
	bh=H9fGkZFd1ODphe/7btOkZWzp5B/Y0DZC4PW8bEKrqAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6/pnjrH0TcIZOP5lHkTEEHUtXL0MRhrecFqPF8lqdB92rhNOlA9EDD4F5rMZABPl
	 cFYISCD7MXziwTDJT9HW3gIiI1hcg8b0SXYZGSKAz8EufVFwycVyuxKB5jAy5h207j
	 XKrbHw8xyMwewIOkzB+1kN09ehJ4T0RlyxJKRXlaJZkdf2zIaskMsEeZvbjPAvEuX0
	 LT6BnnA5xYxsgxJT1w+/gr30TkDYXGLJ/G6jyEtOwCNaJNYNvtuL/6b+mm4WztkJOL
	 Bh2qeSq+o/mqrzM6I5x3XIEXY1WrMOTWbD/R5UB4Yh5LYQqCViBRgct6DeBeZFh9Th
	 144Lm7h7QZDJQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf 1/5] bpf: fix multi-uprobe PID filtering logic
Date: Tue, 21 May 2024 09:33:57 -0700
Message-ID: <20240521163401.3005045-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521163401.3005045-1-andrii@kernel.org>
References: <20240521163401.3005045-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of PID filtering logic for multi-uprobes in
uprobe_prog_run() is filtering down to exact *thread*, while the intent
for PID filtering it to filter by *process* instead. The check in
uprobe_prog_run() also differs from the analogous one in
uprobe_multi_link_filter() for some reason. The latter is correct,
checking task->mm, not the task itself.

Fix the check in uprobe_prog_run() to perform the same task->mm check.

While doing this, we also update get_pid_task() use to use PIDTYPE_TGID
type of lookup, given the intent is to get a representative task of an
entire process. This doesn't change behavior, but seems more logical. It
would hold task group leader task now, not any random thread task.

Last but not least, given multi-uprobe support is half-broken due to
this PID filtering logic (depending on whether PID filtering is
important or not), we need to make it easy for user space consumers
(including libbpf) to easily detect whether PID filtering logic was
already fixed.

We do it here by adding an early check on passed pid parameter. If it's
negative (and so has no chance of being a valid PID), we return -EINVAL.
Previous behavior would eventually return -ESRCH ("No process found"),
given there can't be any process with negative PID. This subtle change
won't make any practical change in behavior, but will allow applications
to detect PID filtering fixes easily. Libbpf fixes take advantage of
this in the next patch.

Cc: stable@vger.kernel.org
Acked-by: Jiri Olsa <jolsa@kernel.org>
Fixes: b733eeade420 ("bpf: Add pid filter support for uprobe_multi link")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c                                  | 8 ++++----
 .../testing/selftests/bpf/prog_tests/uprobe_multi_test.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..1baaeb9ca205 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3295,7 +3295,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
-	if (link->task && current != link->task)
+	if (link->task && current->mm != link->task->mm)
 		return 0;
 
 	if (sleepable)
@@ -3396,8 +3396,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
 	cnt = attr->link_create.uprobe_multi.cnt;
+	pid = attr->link_create.uprobe_multi.pid;
 
-	if (!upath || !uoffsets || !cnt)
+	if (!upath || !uoffsets || !cnt || pid < 0)
 		return -EINVAL;
 	if (cnt > MAX_UPROBE_MULTI_CNT)
 		return -E2BIG;
@@ -3421,10 +3422,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error_path_put;
 	}
 
-	pid = attr->link_create.uprobe_multi.pid;
 	if (pid) {
 		rcu_read_lock();
-		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
+		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
 		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 8269cdee33ae..38fda42fd70f 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -397,7 +397,7 @@ static void test_attach_api_fails(void)
 	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_ERR(link_fd, "link_fd"))
 		goto cleanup;
-	ASSERT_EQ(link_fd, -ESRCH, "pid_is_wrong");
+	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
 
 cleanup:
 	if (link_fd >= 0)
-- 
2.43.0


