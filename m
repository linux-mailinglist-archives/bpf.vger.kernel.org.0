Return-Path: <bpf+bounces-55350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D3A7C430
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 21:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC99617A1EF
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587125E806;
	Fri,  4 Apr 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyrh9fQW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBF25E47A;
	Fri,  4 Apr 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796133; cv=none; b=CNWvbxCXB2Ah/z5bir8x4NI/lkWZgeNTqzHNaETKdnzfRf4Xg1FGwRskjUdRxwsVUlk4tv2fj6+jQQIGtVr2f3Wp4vht3UGu4r3huxHA0657/ANnrk6A0P6BVCcPDkAFDLdcm1GSAJ46IwzVFqwRLkPTBkYg8JMC4eQjcmA8KW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796133; c=relaxed/simple;
	bh=w/HltpRhBBVQFwjgzs/dYbYhW/3xO9NUtumk3pY68d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVAZdd1qZM25N4jbGW2AjIi2xnRUw502w7sB/ledjocv6y5viQ4yWFUgI96XEUIYPNMxJ09+F7BKFXsm5wwuh1v9uZ0WKVxuVjxz36Sd2qyIs9fZUSsZ8gVe1XJUsKCbpleklttOyb+1Vu+QqWvrhyH7kwSmb4TYQNagdS4pQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyrh9fQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF9C4CEDD;
	Fri,  4 Apr 2025 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743796132;
	bh=w/HltpRhBBVQFwjgzs/dYbYhW/3xO9NUtumk3pY68d0=;
	h=From:To:Cc:Subject:Date:From;
	b=dyrh9fQWxEcLRlBytymZ+hhNHJ+zSpk02rNCp7ayQUMwBSp3xvusjtnqr2EZ4r+20
	 eZT9dUWtMhKhmjsTztcjF3DUzs2kCaa6Tf8/3zGjnWZ1nonK9IqF+9rbR+5ASFdPol
	 YyFBssEdXrP48kh5BtyKoP9vh8vDANujBpzwwotZH3TMn0KYKFg2uAD+l/JZmfbMuT
	 UCKha2PsnS7RHxXq5cDOglMi8zr4TGS0lLAmIruXzt+BIjr5mDvh1mh/VUwtFPtHUc
	 6W9bORxc5bXA9vGIRKDSVdYzjes5T2toynAmFk6Fc6MFawSKu4QqYYkWjumHH99/GG
	 6I1yKg/2ZLflw==
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
Subject: [PATCH v2 tip/perf] uprobes: avoid false lockdep splat in uprobe timer callback
Date: Fri,  4 Apr 2025 12:48:48 -0700
Message-ID: <20250404194848.2109539-1-andrii@kernel.org>
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
race with itself for a given uprobe_task, and as such seqcount's
insistence on having preemption disabled on the writer side is
irrelevant. So switch to raw_ variants of seqcount API instead of
disabling preemption unnecessarily.

Also, point out in the comments more explicitly why we use seqcount
despite our reader side being rather simple and never retrying. We favor
well-maintained kernel primitive in favor of open-coding our own memory
barriers.

Link: https://lore.kernel.org/bpf/CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com/
Reported-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Sebastian Siewior <bigeasy@linutronix.de>
Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - fix comment style and s/hardirqs/preemption/ (Sebastian);
  - improved added comment based on Sebastian's suggestions.

 kernel/events/uprobes.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 70c84b9d7be3..0f05bae49827 100644
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
@@ -2004,12 +2007,20 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
-	write_seqcount_begin(&utask->ri_seqcount);
+	/*
+	 * See free_ret_instance() for notes on seqcount use.
+	 * We also employ raw API variants to avoid lockdep false-positive
+	 * warning complaining about enabled preemption. The timer can only be
+	 * invoked once for a uprobe_task. Therefore there can only be one
+	 * writer. The reader does not require an even sequence count to make
+	 * progress, so it is OK to remain preemptible on PREEMPT_RT.
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


