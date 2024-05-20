Return-Path: <bpf+bounces-30064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB88CA534
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E717B2246C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AD1384AC;
	Mon, 20 May 2024 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaPJnOBE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AF137C35
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248847; cv=none; b=Gsa1HoRar0nisPOMS+uIHwaYwqlpHGrYbbc5bJYv0nA/ffSArHblNMojhNA6lhmret9KvIw4QxgVVbRVK2RforWGriN4/zWHdVZgW43fxkp/r4JWK6Ecx7x1yAH6KV0BTLu99/qjYjXfaFNP+wmI4TuGG7QNvVZ46ZxSgz2WjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248847; c=relaxed/simple;
	bh=YH6QGO7X5ZJrIHcEfARh6RyZ3k1bGm11BPyiShxdHB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmJXY7tEUmw62a82gyHOsO6P3dGQMAPC00rEbULM5px6cWOq6IWa8Yj/ygWymIDNK2q/pM4n7Lk9VhBOXsA+8gDIXPeOEzyK8bGHViHRyTa42lDlnMf4mWI/pnX3a8SWgaRJOaGcUbEDZ0+hjAVtUUj/H4SH/0Mrm4t62gmpUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaPJnOBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C292C2BD10;
	Mon, 20 May 2024 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248846;
	bh=YH6QGO7X5ZJrIHcEfARh6RyZ3k1bGm11BPyiShxdHB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaPJnOBETYM61Grt65GwtzVx/5nHFzAniUErfYxN5RODdi5knvvbCAmvN+Yqsstyp
	 stsqjHVHJb9e+hmesr+2nLroF+FjTFKRyf5E0EmHO2eQWVXmgvS98kjCfum3o35tpy
	 fji4fnSB7IiIp0P92ZCN8FvcycZAPgDAOGRAc37A1jtPdFIU4/T/z15BBP0oMFSade
	 6jR3l4aQnhu0RjRwSgyYe+WfTlQ3Z1Vf/ZjOlF43hrhUWSyqoKtXtIJJz2Uru5L28h
	 45u65oI/SdGwya6Dq9pDMs+9TpqjpQz6e6814j6H6K60Te/hBCz5yjISvyQULtuxMQ
	 f4c6Dd03T4GiA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 1/5] bpf: fix multi-uprobe PID filtering logic
Date: Mon, 20 May 2024 16:47:16 -0700
Message-ID: <20240520234720.1748918-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520234720.1748918-1-andrii@kernel.org>
References: <20240520234720.1748918-1-andrii@kernel.org>
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


