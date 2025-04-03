Return-Path: <bpf+bounces-55248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B477FA7A877
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8F3AA1F8
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79425179D;
	Thu,  3 Apr 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9neEYBT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD72512E0;
	Thu,  3 Apr 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700715; cv=none; b=i1+wXVVBKzpJQ7cMNHmBuZKDYU0V6dGIvWfgwM3EaeLqWXce6jqw3LwhOrEI8WKP4AGL5BzXFhKzl9N+it6T6h8IxX52Bv9xYmJxZ52OjgRv5WBcYsIy0Fkh1DcmEJhj7m+XuHCks40+UMcdNP8LXsfjSCrklJEjmMZxfJahwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700715; c=relaxed/simple;
	bh=JMkDDHBDyKlRbikHBbieyAgNp47h6azH3ZEguardqr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu2U89kfJt4cFVqx0Y23BVAkKVxVS6jc2rbWmNz+CRII2YnzFfOa3bB/WYqGuMF9hF4BXePAAyDjejWANqPvvlmPFSwqDWozF7l+4x0CkZyxgManVGLd2OWkUFAhDRzeDl+uJbzdM2Az5jrl+Y7w6sB4cMM3biZsOsVOVUloGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9neEYBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7585BC4CEE3;
	Thu,  3 Apr 2025 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743700713;
	bh=JMkDDHBDyKlRbikHBbieyAgNp47h6azH3ZEguardqr0=;
	h=From:To:Cc:Subject:Date:From;
	b=A9neEYBT73loDDXOKV+0XL5LIbjctwYCC2zMRgWdPxZGvVx8FliWWjO9o97OWxZ0j
	 TYrST72/sCFHYwJqTUOZrn/G6gzJbOwGbpjp4++4CNv6S0LCbXye9bppbk+XhfcB1x
	 VI0xJeqe7bPmyg9Umnba1CFAcg66lpQr9vepqwR+4vP3ofZ/ZJnFMQF2UM7EOjaEkR
	 IMpfL8wYCaHL9lHOs2YPHcfAeLvmcnt3OcMp+7OperfJcpzsV+uOHPMcgBjQeBY5wf
	 yFakXJ6XiGNK+4oEZSNpfJd0BFcLgOpjRNLiz6xIqHtLcJpifytK0pFmsz9NYeYpkL
	 B55++AQUZ6FlQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	bigeasy@linutronix.de,
	ast@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH tip/perf] uprobes: avoid false lockdep splat in uprobe timer callback
Date: Thu,  3 Apr 2025 10:18:31 -0700
Message-ID: <20250403171831.3803479-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid a false-positive lockdep warning in PREEMPT_RT configuration when
using write_seqcount_begin() in uprobe timer callback by using
raw_write_* APIs. Uprobe's use of timer callback is guaranteed to not
race with itself, and as such seqcount's insistence on having hardirqs
disabled on the writer side is irrelevant. So switch to raw_ variants of
seqcount API instead of disabling hardirqs unnecessarily.

Also, point out in the comments more explicitly why we use seqcount
despite our reader side being rather simple and never retrying. We favor
well-maintained kernel primitive in favor of open-coding our own memory
barriers.

Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com/
Reported-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Sebastian Sewior <bigeasy@linutronix.de>
Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 70c84b9d7be3..6d7e7da0fbbc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1944,6 +1944,9 @@ static void free_ret_instance(struct uprobe_task *utask,
 	 * to-be-reused return instances for future uretprobes. If ri_timer()
 	 * happens to be running right now, though, we fallback to safety and
 	 * just perform RCU-delated freeing of ri.
+	 * Admittedly, this is a rather simple use of seqcount, but it nicely
+	 * abstracts away all the necessary memory barriers, so we use
+	 * a well-supported kernel primitive here.
 	 */
 	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
 		/* immediate reuse of ri without RCU GP is OK */
@@ -2004,12 +2007,18 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
-	write_seqcount_begin(&utask->ri_seqcount);
+	/* See free_ret_instance() for notes on seqcount use.
+	 * We also employ raw API variants to avoid lockdep false-positive
+	 * warning complaining about hardirqs not being disabled. We have
+	 * a guarantee that this timer callback won't race with itself, so no
+	 * need to disable hardirqs.
+	 */
+	raw_write_seqcount_begin(&utask->ri_seqcount);
 
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
-	write_seqcount_end(&utask->ri_seqcount);
+	raw_write_seqcount_end(&utask->ri_seqcount);
 }
 
 static struct uprobe_task *alloc_utask(void)
-- 
2.47.1


