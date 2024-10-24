Return-Path: <bpf+bounces-43010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54759ADB01
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104E01C217AF
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355616D9AF;
	Thu, 24 Oct 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUFJ5KJR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A3155308;
	Thu, 24 Oct 2024 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744926; cv=none; b=LSe17if4S5u/mXzZdm3zvU9tgfrD0SRnNH5yZOzRWiMFFQlHSdchN9DJcaTkNL5V2UmkEbuNkg8gblAwlk9NK8CrB6EbIn1b6M8nS/bkI9btmc3WubwmcthQ3QmqYxd/DDcrERtLfzgPDqihb1nGoNEXIsMGBeLp7BnQgPC7AaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744926; c=relaxed/simple;
	bh=qxdeLmS88RTlcJ2/gkJB2e6Py7R8rZS7YIxGfYTXtUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHGJySIIEZl99WmgZ7VBKKjEJQfHSUM+BFdJ6CAm2zgN7uophVe/AnXLE0QWsxPAbbxySMB7nghv0BbTMvuWHxyATHiWsRsKrCme7Lrcyrej97KoNdKFyUWTYDKRGbd84qq2ge9DKxtrLwnibKeYPOC0PEGZUQhSQ8oNpqGvs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUFJ5KJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E048CC4CEC7;
	Thu, 24 Oct 2024 04:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729744926;
	bh=qxdeLmS88RTlcJ2/gkJB2e6Py7R8rZS7YIxGfYTXtUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUFJ5KJRLyqhjeIARG9R4XTt/gp6Qi9eLME3jYX30jUzd0DVMUOBDgKKe0Gi9HLTu
	 cPDjwHTGxoxOnLu0Edr9qlPgA/VC7d7J6IzdDGErUUfsfO5hOq6dFk+QirNDOofPQZ
	 dyeArngbb1v5L+TmhVCm+iCnraOSxB/ZwUIbbbLeHJAD0hGYvxBWFqN+Nx+29IoZ4I
	 9aQUYX6BPJZ8KCGkl3rJbvPEfMf1MnRFfoBdv3KM41HcTHWSHv2LeODxdo/7j255j+
	 5jWqyGGUYEkCFvi2Hfkuqn1CPB5zItRDGl5Fc5AOJGD7w0ZBmxGlAMjQ8O0Mx94nQb
	 eu7Wx0ngh0QPw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 tip/perf/core 1/2] uprobes: allow put_uprobe() from non-sleepable softirq context
Date: Wed, 23 Oct 2024 21:41:58 -0700
Message-ID: <20241024044159.3156646-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024044159.3156646-1-andrii@kernel.org>
References: <20241024044159.3156646-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
makes it unsuitable to be called from more restricted context like softirq.

Let's make put_uprobe() agnostic to the context in which it is called,
and use work queue to defer the mutex-protected clean up steps.

RB tree removal step is also moved into work-deferred callback to avoid
potential deadlock between softirq-based timer callback, added in the
next patch, and the rest of uprobe code.

We can rework locking altogher as a follow up, but that's significantly
more tricky, so warrants its own patch set. For now, we need to make
sure that changes in the next patch that add timer thread work correctly
with existing approach, while concentrating on SRCU + timeout logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4ef4b51776eb..d7e489246608 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/workqueue.h>
 
 #include <linux/uprobes.h>
 
@@ -61,7 +62,10 @@ struct uprobe {
 	struct list_head	pending_list;
 	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
-	struct rcu_head		rcu;
+	union {
+		struct rcu_head		rcu;
+		struct work_struct	work;
+	};
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;		/* "unsigned long" so bitops work */
@@ -625,10 +629,9 @@ static void uprobe_free_rcu(struct rcu_head *rcu)
 	kfree(uprobe);
 }
 
-static void put_uprobe(struct uprobe *uprobe)
+static void uprobe_free_deferred(struct work_struct *work)
 {
-	if (!refcount_dec_and_test(&uprobe->ref))
-		return;
+	struct uprobe *uprobe = container_of(work, struct uprobe, work);
 
 	write_lock(&uprobes_treelock);
 
@@ -652,6 +655,15 @@ static void put_uprobe(struct uprobe *uprobe)
 	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
 
+static void put_uprobe(struct uprobe *uprobe)
+{
+	if (!refcount_dec_and_test(&uprobe->ref))
+		return;
+
+	INIT_WORK(&uprobe->work, uprobe_free_deferred);
+	schedule_work(&uprobe->work);
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)
-- 
2.43.5


