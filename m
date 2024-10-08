Return-Path: <bpf+bounces-41165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94B993BBF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 02:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6C71C24700
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 00:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67513AC1;
	Tue,  8 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiRqa2NP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086DF4ED;
	Tue,  8 Oct 2024 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347162; cv=none; b=dlAKXvybZUNYGTJMAcc67x8l3PcJQRZcDPr96cAml8awxjEKGUqliqOJpiyj5AbBNnnD+mbyKH4EohkJ4s3M9jcgvkyXUhiFDQk5vBq+1OMPAHZQH8+GhDuh1lF8uK6ND2Tw3+L7KVvZe8IB0WVIwUqcPwYP1b5dBgSoYEXVpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347162; c=relaxed/simple;
	bh=Lg0x7C0q2rO5pnOZ+01w6HfkiuBN6RNtGSmxJuP/TEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0c6E0WkGIau9M2YW8VHsFEUCRD+vPZcF8HIHAhkPIBL8ekwWTezC1SAXIEPVopJ+NaYP3TNqYRxE1z2Z2fg7aMheXGu8ZF2aq+1rTRBs0sA+PyNhIv5lZx+lpaEEpZnOVsDqKsqe5v+kiYbHNvn0v6CFFV2YtVPYXmwBVJ84nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiRqa2NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D369C4CECD;
	Tue,  8 Oct 2024 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347162;
	bh=Lg0x7C0q2rO5pnOZ+01w6HfkiuBN6RNtGSmxJuP/TEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiRqa2NPuDnDSoTdfV4eO7wbkEYEjryu9SKUrhi3HgBGDk2K4/j3ZB79u21+t64HT
	 I8Jv+uZiUP0kfTogLoNT5MpuPlHithjmVD5lkyew+8x0yKfB4RWZE3z+mlDHfcaO7v
	 JBn+vpBlupDw0GQ6NZp/5X+salzFUZcnw/nuz57ouIPl9bgpJX1R4hkaRWQTLgU/iC
	 lEH+Zh7wRIgv6Xrl+GC7aytZxwZlIzDnAEU54daadezp5YayjnLbMDE3jACgyRrgyG
	 YBvas6AJROhufioaUohHDVqlqBb9myWmHiZ/PDoxVQqIuw8ilAjjuR0e6/Wv6x0t9W
	 3KABotvNm5oAQ==
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
Subject: [PATCH v2 tip/perf/core 1/2] uprobes: allow put_uprobe() from non-sleepable softirq context
Date: Mon,  7 Oct 2024 17:25:55 -0700
Message-ID: <20241008002556.2332835-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008002556.2332835-1-andrii@kernel.org>
References: <20241008002556.2332835-1-andrii@kernel.org>
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

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a2e6a57f79f2..9d3ab472200d 100644
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
 	unsigned long		flags;
@@ -627,10 +631,9 @@ static void uprobe_free_rcu(struct rcu_head *rcu)
 	kfree(uprobe);
 }
 
-static void put_uprobe(struct uprobe *uprobe)
+static void uprobe_free_deferred(struct work_struct *work)
 {
-	if (!refcount_dec_and_test(&uprobe->ref))
-		return;
+	struct uprobe *uprobe = container_of(work, struct uprobe, work);
 
 	write_lock(&uprobes_treelock);
 
@@ -654,6 +657,15 @@ static void put_uprobe(struct uprobe *uprobe)
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


