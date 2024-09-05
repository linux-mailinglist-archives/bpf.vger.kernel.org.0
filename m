Return-Path: <bpf+bounces-38999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D396D799
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28A0B263A1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276D19A2B0;
	Thu,  5 Sep 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOBn3XMN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98781991DD;
	Thu,  5 Sep 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537101; cv=none; b=kRWvF8w7zEyCh4xcaLQxPaL/2EYBukYVkE7b9ayy2LXzL1TtwXh3IXzBfdE5mzB/2tCXZr+F0fuUwDqonx0A3tlwT3dDlQgQWuOBrPQb0hfM+O8lnqN8nGdWy4yfKsLZaYZPwFtW8au4mkZmSPJn71M+E/4WEAjb5zml0G+MwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537101; c=relaxed/simple;
	bh=3GHkxBiuhbvmrdo2hRad8iYorzmZ7YUX8YGFybxOZFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW7nkf87iutIhWhsWLfSAoEwptXmxRJhUAwqZio3ndUNqPit9rG6YMCxpcKq0mj8nmbbJgBomwg6idB/WpeIIXWiZ4h2JuX4Z10WmscwUiSs+i2N+Rj4MlpeiPfWVhvkZ8+w98m7GV+y7++QE6Ujwv5y0wqoefCpi6LkK4knAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOBn3XMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C74C4CEC4;
	Thu,  5 Sep 2024 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537100;
	bh=3GHkxBiuhbvmrdo2hRad8iYorzmZ7YUX8YGFybxOZFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOBn3XMNzUbeLjXbSesPxgzz/yBpjJcQyFrMYFJhaM4Pe2bbm8PSezJ6P6kgJqEBu
	 9Cys3l7bSFRCIqphDc5fYvRLmdZyWomb8ZsK4+Nygys21j2IVcQAFoZN+x1S7GT3yS
	 22E/x9nk6veK77lFV1R0NORYlFccRvWnpYDBYPYXm05GH04/TObk9kBZcQ9jZcLIQw
	 xTUvIixy/AL8j4EnMbUlFDdRetES3UtlPiRBsV+jrPe+oGeKGUqQ/+uNqc8TDanJB1
	 7k9+wBeNsD3wMaEA3dNyv3EpiZzivdz/dSGtX0y8zI+SoZwXJRjZ6HaQjpMe4JC2vr
	 6HxNPsqSyF5WQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 1/4] bpf: Fix uprobe multi pid filter check
Date: Thu,  5 Sep 2024 14:51:21 +0300
Message-ID: <20240905115124.1503998-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905115124.1503998-1-jolsa@kernel.org>
References: <20240905115124.1503998-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprobe multi link does its own process (thread leader) filtering before
running the bpf program by comparing task's vm pointers.

But as Oleg pointed out there can be processes sharing the vm (CLONE_VM),
so we can't just compare task->vm pointers, but instead we need to use
same_thread_group call.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b69a39316c0c..98e395f1baae 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3207,7 +3207,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
-	if (link->task && current->mm != link->task->mm)
+	if (link->task && !same_thread_group(current, link->task))
 		return 0;
 
 	if (sleepable)
-- 
2.46.0


