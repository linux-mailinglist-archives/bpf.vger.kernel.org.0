Return-Path: <bpf+bounces-33552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A691EAEA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3B11C21629
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE14171E65;
	Mon,  1 Jul 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9CTBmok"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C317164D;
	Mon,  1 Jul 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873618; cv=none; b=RoH3uFOieh7iSIkJaZ60guLI2tuZEbFNTnGpzq0RsvqLG7A3VdbLOYuF7j+ZFtE7Mjs4wCAsX/cRwdNjp1R6wQeyDjF7CCSkaU885PRJTSzTw2Zf6VyZUBlYgmSdIAH/DZHWveYM1gdeEi3X7Z+FnrG4zG2Lu8axcX4F8UJTGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873618; c=relaxed/simple;
	bh=6fur/3CcOjDft27wS8sm7+8WB1QwLkIDD82RyRkga48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om2WLuwhBaIuIk/46FxrUILhqh/4rLG3WAnYh0RYPXbdATVOiMNvdPBTMQZPElztKuhNFN+R1fQZQ8o9dgjWYM1Qorsu45228H+QLRi8TyK+RbUS9Th2ctMQn/1c5zXYv6LpDOO6E/zF9ulEFiDBIZIuykAW9W07ClGXtdw/mcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9CTBmok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D49C116B1;
	Mon,  1 Jul 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873618;
	bh=6fur/3CcOjDft27wS8sm7+8WB1QwLkIDD82RyRkga48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9CTBmokKxut3G3XjrIGET7XQ1m+PNztOlwOW1Ns9qs8jgVNr76UzPRnAWMd+Xuak
	 zG3D4svs50XTx4TbtnUS8nkDRh8CKYn5xJ91JhmF6CwKP0CBhiYz+gztQPYixR7Sd1
	 xqRkYUp/AAh0bLgjydtvMPOdqzXVb1dzfVIL3185rGah6PIcuv3snnJokcKXQnlVe9
	 btUmKHs1YaKszj95KGUeVrGFmBN9vMn6js+aJ8G30UtKnzVJKQ+wchn5kjPyneeHzb
	 3ib1jsyin8ti3rPaPfv76z4zMsAMAGY7dhpACH0QVlhdM3CCAGsMWDW+hUguOhtk+V
	 uPFlvGpRqAoOQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 12/12] uprobes: switch uprobes_treelock to per-CPU RW semaphore
Date: Mon,  1 Jul 2024 15:39:35 -0700
Message-ID: <20240701223935.3783951-13-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701223935.3783951-1-andrii@kernel.org>
References: <20240701223935.3783951-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all the batch uprobe APIs work we are now finally ready to reap the
benefits. Switch uprobes_treelock from reader-writer spinlock to a much
more efficient and scalable per-CPU RW semaphore.

Benchmarks and numbers time. I've used BPF selftests' bench tool,
trig-uprobe-nop benchmark specifically, to see how uprobe total
throughput scales with number of competing threads (mapped to individual
CPUs). Here are results:

  # threads   BEFORE (mln/s)    AFTER (mln/s)
  ---------   --------------    -------------
  1           3.131             3.140
  2           3.394             3.601
  3           3.630             3.960
  4           3.317             3.551
  5           3.448             3.464
  6           3.345             3.283
  7           3.469             3.444
  8           3.182             3.258
  9           3.138             3.139
  10          2.999             3.212
  11          2.903             3.183
  12          2.802             3.027
  13          2.792             3.027
  14          2.695             3.086
  15          2.822             2.965
  16          2.679             2.939
  17          2.622             2.888
  18          2.628             2.914
  19          2.702             2.836
  20          2.561             2.837

One can see that per-CPU RW semaphore-based implementation scales better
with number of CPUs (especially that single CPU throughput is basically
the same).

Note, scalability is still limited by register_rwsem and this will
hopefully be address in follow up patch set(s).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bb480a2400e1..1d76551e5e23 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
  */
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
-static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+DEFINE_STATIC_PERCPU_RWSEM(uprobes_treelock);	/* serialize rbtree access */
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -684,7 +684,7 @@ static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 		bool destroy;
 
 		if (!tree_locked)
-			write_lock(&uprobes_treelock);
+			percpu_down_write(&uprobes_treelock);
 		/*
 		 * We might race with find_uprobe()->__get_uprobe() executed
 		 * from inside read-locked uprobes_treelock, which can bump
@@ -708,7 +708,7 @@ static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 		if (destroy && uprobe_is_active(uprobe))
 			rb_erase(&uprobe->rb_node, &uprobes_tree);
 		if (!tree_locked)
-			write_unlock(&uprobes_treelock);
+			percpu_up_write(&uprobes_treelock);
 
 		/*
 		 * Beyond here we don't need RCU protection, we are either the
@@ -816,9 +816,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
 
-	read_lock(&uprobes_treelock);
+	percpu_down_read(&uprobes_treelock);
 	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	percpu_up_read(&uprobes_treelock);
 
 	return uprobe;
 }
@@ -1205,7 +1205,7 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
 		up_write(&uprobe->register_rwsem);
 	}
 
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		uc = get_uprobe_consumer(i, ctx);
 		uprobe = uc->uprobe;
@@ -1216,7 +1216,7 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
 		__put_uprobe(uprobe, true);
 		uc->uprobe = NULL;
 	}
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 }
 
 static struct uprobe_consumer *uprobe_consumer_identity(size_t idx, void *ctx)
@@ -1321,7 +1321,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 
 	ret = 0;
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		struct uprobe *cur_uprobe;
 
@@ -1344,7 +1344,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		}
 	}
 unlock_treelock:
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 	if (ret)
 		goto cleanup_uprobes;
 
@@ -1376,7 +1376,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 cleanup_uprobes:
 	/* put all the successfully allocated/reused uprobes */
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		uc = get_uprobe_consumer(i, ctx);
 
@@ -1384,7 +1384,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 			__put_uprobe(uc->uprobe, true);
 		uc->uprobe = NULL;
 	}
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 	return ret;
 }
 
@@ -1492,7 +1492,7 @@ static void build_probe_list(struct inode *inode,
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	read_lock(&uprobes_treelock);
+	percpu_down_read(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
@@ -1510,7 +1510,7 @@ static void build_probe_list(struct inode *inode,
 			list_add(&u->pending_list, head);
 		}
 	}
-	read_unlock(&uprobes_treelock);
+	percpu_up_read(&uprobes_treelock);
 }
 
 /* @vma contains reference counter, not the probed instruction. */
@@ -1601,9 +1601,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	read_lock(&uprobes_treelock);
+	percpu_down_read(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
-	read_unlock(&uprobes_treelock);
+	percpu_up_read(&uprobes_treelock);
 
 	return !!n;
 }
-- 
2.43.0


