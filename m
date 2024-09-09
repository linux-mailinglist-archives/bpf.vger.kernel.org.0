Return-Path: <bpf+bounces-39368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24502972571
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572831C2323A
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5318DF8C;
	Mon,  9 Sep 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtPC6RMw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB623741;
	Mon,  9 Sep 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922151; cv=none; b=UVxe2kL0f8ZaCIlTzG1UZvi7YJkUzcO/a8xE5EJOXeUWO8Qozzs3kBxStJzsr0o9OAP1zadfiDBdbsNDJLIE+L4zO0WkSiO+/DWozIONp88nipgl7cU9f3ySaK6UOBpcwT8rg+2iz/Yg+FpDe1EYizOJCrWb7VeiHfJ1olD2JGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922151; c=relaxed/simple;
	bh=zoVReCc/17nWZtG2T0SyXvJwJI8bMpmSZ/W8Nvtbwps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLxgjvKZY079YEiA4Uchea7D4CBDcxcRZchhOQsMMZKtFGKptt/70vCu72iSEfRJNxoFyW41PXh5nJFswZ6bILWkyI3Zt0szR4+cmtlpoKzd+KrxyatOCmE+MQJRPskH4dg/xUUY12Uu5/Z8dAHVBnWXw8cqloOHSqtdr8FDk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtPC6RMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C3C4CEC6;
	Mon,  9 Sep 2024 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922151;
	bh=zoVReCc/17nWZtG2T0SyXvJwJI8bMpmSZ/W8Nvtbwps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtPC6RMwKXW3kTlqUTK6S5eRZ1o48YfVGpHDklhRq2biSIe9JB47yhgpmTq6QsX5D
	 HQAyQmIWS7UPGUeEmdBminL+olyRDgiuf3WIUnNH6KXcnHoA9BKR4c36xhDsC8IRMC
	 PvWFh/+zMBxAGUjQAOh2LYa02r31yrEqbjc2oeAUu25ntreJ4gg72EeqNv7PFwe8op
	 JOYNvh/SDIuAO/eRSaE/To7yVXjVn1zEwdBrsaVPJyLfVah6cHK5nVpOF39y6458IV
	 XtRBlCj53kaLC62opl7imHlTQJKMtWHBmrBdAyfXGb/6lclpuJOLqk5wak0kTq84F6
	 nJxulmb6yvZJQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable softirq context
Date: Mon,  9 Sep 2024 15:49:01 -0700
Message-ID: <20240909224903.3498207-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909224903.3498207-1-andrii@kernel.org>
References: <20240909224903.3498207-1-andrii@kernel.org>
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

To avoid unnecessarily increasing the size of struct uprobe, we colocate
work_struct in parallel with rb_node and rcu, both of which are unused
by the time we get to schedule clean up work.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a2e6a57f79f2..377bd524bc8b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/workqueue.h>
 
 #include <linux/uprobes.h>
 
@@ -54,14 +55,20 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 #define UPROBE_COPY_INSN	0
 
 struct uprobe {
-	struct rb_node		rb_node;	/* node in the rb tree */
+	union {
+		struct {
+			struct rb_node		rb_node;	/* node in the rb tree */
+			struct rcu_head		rcu;
+		};
+		/* work is used only during freeing, rcu and rb_node are unused at that point */
+		struct work_struct work;
+	};
 	refcount_t		ref;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
 	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
-	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
@@ -620,11 +627,28 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
 
+static void uprobe_free_deferred(struct work_struct *work)
+{
+	struct uprobe *uprobe = container_of(work, struct uprobe, work);
+
+	/*
+	 * If application munmap(exec_vma) before uprobe_unregister()
+	 * gets called, we don't get a chance to remove uprobe from
+	 * delayed_uprobe_list from remove_breakpoint(). Do it here.
+	 */
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(uprobe, NULL);
+	mutex_unlock(&delayed_uprobe_lock);
+
+	kfree(uprobe);
+}
+
 static void uprobe_free_rcu(struct rcu_head *rcu)
 {
 	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
 
-	kfree(uprobe);
+	INIT_WORK(&uprobe->work, uprobe_free_deferred);
+	schedule_work(&uprobe->work);
 }
 
 static void put_uprobe(struct uprobe *uprobe)
-- 
2.43.5


