Return-Path: <bpf+bounces-42470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596039A484C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BFF1C2260A
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAD208215;
	Fri, 18 Oct 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlcSv6rB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4618C35F;
	Fri, 18 Oct 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284103; cv=none; b=QzfIh9LyX2Ih4E5p0yxDFqlV7wMpmLBpxntb+FZ+7vRP0ajZnfIcbQg6p1lcRVEo+2xIYyJXoRQm4+vbKCWER4Lzu3DCg0o3r2f62+viMF1U/afBdYUBIFvmnJgJJUd1SYUGXVWSj46ObLMbkU4kM+8iSNfoSeqefHwfq/iem8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284103; c=relaxed/simple;
	bh=1HQNG9iWWO3wV8At9GP/jjQuJFQ7TICtEW1ksq9n0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9GxqxfeKS5lQ80kmdd6oSwLRubyonjZNW7jOIsqecc/jIzoHcIqVoi82HHv7RQ0ogeSWL+YBza8dxEgg4aXaufRQ8dVDAwp9nrkRiVQT+E6Fj7ySfac+kKvXWWfABxCDaWKrOIyudx2h+c2mClv/scqjeeOlgyHeyXU9KjMCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlcSv6rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7DAC4CEC3;
	Fri, 18 Oct 2024 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284103;
	bh=1HQNG9iWWO3wV8At9GP/jjQuJFQ7TICtEW1ksq9n0g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlcSv6rByKSeGI5t1xyThHi3wv/uhdTSddZUpO7unvqsFzXz2q+kYzcfbIV+uhfdG
	 kLznR+hqvwpppSsZpKK3mhdWYq2tbjhIhY75Kr7oPREjrJJQSJFZHcqSa0I+xEhDgZ
	 Q3fewB10CVt72DGeqlZLmqni8FKX1k9+yEu4sFpIdO26Egl4vmntV8P7AJLlZHwOi2
	 11cpxxwQlCwfhMbcu25mGmjKcZk1JGhjUW42JerCSXQ8OZ6b6XJ6KkeafPmh4eJB4Z
	 APFM+U5N06mgn1VDUAvldoyysibASurPcZ+I8TsHSWEOXKyGfm0Ocjsw8uQm46Reo4
	 29AStF+WFTFnA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv8 bpf-next 02/13] bpf: Force uprobe bpf program to always return 0
Date: Fri, 18 Oct 2024 22:40:58 +0200
Message-ID: <20241018204109.713820-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018204109.713820-1-jolsa@kernel.org>
References: <20241018204109.713820-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrii make uprobe multi bpf programs to always return 0,
so they can't force uprobe removal.

Keeping the int return type for uprobe_prog_run, because it will be used
in following session changes.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fdab7ecd8dfa..3c1e5a561df4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3209,7 +3209,6 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
-	int err = 0;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3222,7 +3221,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	migrate_disable();
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
 	migrate_enable();
@@ -3231,7 +3230,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_unlock_trace();
 	else
 		rcu_read_unlock();
-	return err;
+	return 0;
 }
 
 static bool
-- 
2.46.2


