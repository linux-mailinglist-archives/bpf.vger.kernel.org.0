Return-Path: <bpf+bounces-32974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC516915AF9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4FC1C2158E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA0184;
	Tue, 25 Jun 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaVSIQp7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAC8BE0;
	Tue, 25 Jun 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274951; cv=none; b=AyGVYyU4MTN2R40ygMn8xkz/Bzk0ZQYqcEL+zJY/7o+E6SmqlQpPxOk6lHFpbTIcg0GwXKFrhQX8kHW8tOIPHST6Kcgy/2aDOHlhYijozY9NE2gXHo5wvnFSxpLz07xwHGTlEWD+7QiOdGtPNQiQO6IqE4OGeLAAMPBYLrqyYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274951; c=relaxed/simple;
	bh=7KOGfwnNmRNzgylcfP4g7ZG1nXle8IM9MtBH4MPVbLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYovMzo8YUnfTPbd5jichpCnQDbTgYMcFcgihjVU6kNbGsVwUqtK7zbW9okgS0pKdqeh9R29K/uthl5j7ZhQ8lO+r8845IlVjOkiwDKyTA+h63u1cM5CrGgMMjqJrF2mie/pwA6DKtgrx+vIHnMtpe2RGFijx0GCxeeZyAup0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaVSIQp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC379C2BBFC;
	Tue, 25 Jun 2024 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274951;
	bh=7KOGfwnNmRNzgylcfP4g7ZG1nXle8IM9MtBH4MPVbLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaVSIQp7q6zGE1IOJeuyn+yFYFW1YkZU6CZv07Qavmz8jrTDTZG53U/kt0r3pNwGR
	 +pYCpCel9tp9Bv0KxQHkb8bh+8kEgELIZNEKMK2nC5fu9iR68/PC2IyhmS+4iBriTr
	 zyAxRDQ3XUxTDHG+CZgX+iK938MnwEEBogYWQs7yn0z6+znsZn+ohw+D5KQ6LolEFt
	 i6IBBMiX81bVQGQsWvbQ60VUiBYizUsy8OM3M5h1phhBZsh7tBZugL8CIbhDoYjILK
	 a5Gk0GwPc3wUth3gP/dofrM/nXpy/newOr8cyQcCRk6G5O9aRvey0ebrBLXED+XSNR
	 NcEkL1iXePWNg==
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
Subject: [PATCH 12/12] uprobes: switch uprobes_treelock to per-CPU RW semaphore
Date: Mon, 24 Jun 2024 17:21:44 -0700
Message-ID: <20240625002144.3485799-13-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625002144.3485799-1-andrii@kernel.org>
References: <20240625002144.3485799-1-andrii@kernel.org>
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
index 7e94671a672a..e24b81b0e149 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
  */
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
-static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+DEFINE_STATIC_PERCPU_RWSEM(uprobes_treelock);	/* serialize rbtree access */
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -667,7 +667,7 @@ static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 		bool destroy;
 
 		if (!tree_locked)
-			write_lock(&uprobes_treelock);
+			percpu_down_write(&uprobes_treelock);
 		/*
 		 * We might race with find_uprobe()->__get_uprobe() executed
 		 * from inside read-locked uprobes_treelock, which can bump
@@ -691,7 +691,7 @@ static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 		if (destroy && uprobe_is_active(uprobe))
 			rb_erase(&uprobe->rb_node, &uprobes_tree);
 		if (!tree_locked)
-			write_unlock(&uprobes_treelock);
+			percpu_up_write(&uprobes_treelock);
 
 		/* uprobe got resurrected, pretend we never tried to free it */
 		if (!destroy)
@@ -789,9 +789,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
 
-	read_lock(&uprobes_treelock);
+	percpu_down_read(&uprobes_treelock);
 	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	percpu_up_read(&uprobes_treelock);
 
 	return uprobe;
 }
@@ -1178,7 +1178,7 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
 		up_write(&uprobe->register_rwsem);
 	}
 
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		uc = get_uprobe_consumer(i, ctx);
 		uprobe = uc->uprobe;
@@ -1189,7 +1189,7 @@ void uprobe_unregister_batch(struct inode *inode, int cnt, uprobe_consumer_fn ge
 		__put_uprobe(uprobe, true);
 		uc->uprobe = NULL;
 	}
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 }
 
 static struct uprobe_consumer *uprobe_consumer_identity(size_t idx, void *ctx)
@@ -1294,7 +1294,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 
 	ret = 0;
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		struct uprobe *cur_uprobe;
 
@@ -1317,7 +1317,7 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		}
 	}
 unlock_treelock:
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 	if (ret)
 		goto cleanup_uprobes;
 
@@ -1349,14 +1349,14 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 cleanup_uprobes:
 	/* put all the successfully allocated/reused uprobes */
-	write_lock(&uprobes_treelock);
+	percpu_down_write(&uprobes_treelock);
 	for (i = cnt - 1; i >= 0; i--) {
 		uc = get_uprobe_consumer(i, ctx);
 
 		__put_uprobe(uc->uprobe, true);
 		uc->uprobe = NULL;
 	}
-	write_unlock(&uprobes_treelock);
+	percpu_up_write(&uprobes_treelock);
 	return ret;
 }
 
@@ -1464,7 +1464,7 @@ static void build_probe_list(struct inode *inode,
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	read_lock(&uprobes_treelock);
+	percpu_down_read(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
@@ -1482,7 +1482,7 @@ static void build_probe_list(struct inode *inode,
 			list_add(&u->pending_list, head);
 		}
 	}
-	read_unlock(&uprobes_treelock);
+	percpu_up_read(&uprobes_treelock);
 }
 
 /* @vma contains reference counter, not the probed instruction. */
@@ -1573,9 +1573,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
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


