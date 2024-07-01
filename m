Return-Path: <bpf+bounces-33549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BC91EAE7
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2851C21AB0
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E6171E60;
	Mon,  1 Jul 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilFO+4rL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C3171E4B;
	Mon,  1 Jul 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873608; cv=none; b=g4bXbOtLbmYUvp8ox+5p2Ag4r9ZSRZMn9BOCAtyo31GriSDVL0oU6lGv2pUVGQBz6lEC25BnnU2L23QDjbQOBo5S68oPWq3pnPCAGXolkP37aur+y2ecicJ1l2zk6Ob6W5yBoGFbu6k0l9yuXkvPq0sJSiBs9CD8BbYEKHytM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873608; c=relaxed/simple;
	bh=I4Eo38mmIesrQ77ZzSoxqm6W+ydpRlm53vqTuFQpouQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3wkez4hkdD2zdeXxs06EFkEdlh3FNxfu9c+ptLBULQaQW/hZNztW9pDtHaSqMI2bxV86f+jifSHxlAK7ZcWLuMJ2xYfLpR0dEiPmRoMsJbicCIpDYJrC5unOeFcE9NpFUSMrdMwpFCV95twRnB2MqBdCTfQfUgqmhYHfkHfpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilFO+4rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BC4C116B1;
	Mon,  1 Jul 2024 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873608;
	bh=I4Eo38mmIesrQ77ZzSoxqm6W+ydpRlm53vqTuFQpouQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilFO+4rL4icjqX3iDeTY8fJcAvtkaeDOkCED6DAqKE3373rc/DwoIga39QBGcKV43
	 kxZmhV4SL7eqOitpwmegIIy2D9N2oEMfEBFYCyHdLk4TBgtU4dx2jXmzPttYaD6P3c
	 W/sMaJfH0iJqObgr9DS1FPciUGAeBABYNRJgngsSkeyCOR8uX+46LDvY44clTm7hyy
	 8hgT3/4OXE2uPhJ0ebiDG6T1InmpGsGBWW8p+1O3287srHrQ+b6etUhjmeQFrhgLgR
	 GhvDgZKNxI0t16InlzlR0uw9aont3bS1QauVB6s/pF6fPyRWMGzEbv9KFcQUdUXCpp
	 MvpmsKH8g1Gwg==
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
Subject: [PATCH v2 09/12] uprobes: batch uprobes_treelock during registration
Date: Mon,  1 Jul 2024 15:39:32 -0700
Message-ID: <20240701223935.3783951-10-andrii@kernel.org>
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

Now that we have a good separate of each registration step, take
uprobes_treelock just once for relevant registration step, and then
process all relevant uprobes in one go.

Even if writer lock introduces a relatively large delay (as might happen
with per-CPU RW semaphore), this will keep overall batch attachment
reasonably fast.

We teach put_uprobe(), though __put_uprobe() helper, to optionally take
or not uprobes_treelock, to accommodate this pattern.

With these changes we don't need insert_uprobe() operation that
unconditionally takes uprobes_treelock, so get rid of it, leaving only
lower-level __insert_uprobe() helper.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 45 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 128677ffe662..ced85284bbf4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -665,7 +665,7 @@ static void uprobe_free_rcu(struct rcu_head *rcu)
 	kfree(uprobe);
 }
 
-static void put_uprobe(struct uprobe *uprobe)
+static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 {
 	s64 v;
 
@@ -683,7 +683,8 @@ static void put_uprobe(struct uprobe *uprobe)
 	if (unlikely((u32)v == 0)) {
 		bool destroy;
 
-		write_lock(&uprobes_treelock);
+		if (!tree_locked)
+			write_lock(&uprobes_treelock);
 		/*
 		 * We might race with find_uprobe()->__get_uprobe() executed
 		 * from inside read-locked uprobes_treelock, which can bump
@@ -706,7 +707,8 @@ static void put_uprobe(struct uprobe *uprobe)
 		destroy = atomic64_read(&uprobe->ref) == v;
 		if (destroy && uprobe_is_active(uprobe))
 			rb_erase(&uprobe->rb_node, &uprobes_tree);
-		write_unlock(&uprobes_treelock);
+		if (!tree_locked)
+			write_unlock(&uprobes_treelock);
 
 		/*
 		 * Beyond here we don't need RCU protection, we are either the
@@ -745,6 +747,11 @@ static void put_uprobe(struct uprobe *uprobe)
 	rcu_read_unlock_trace();
 }
 
+static void put_uprobe(struct uprobe *uprobe)
+{
+	__put_uprobe(uprobe, false);
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)
@@ -844,21 +851,6 @@ static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
-/*
- * Acquire uprobes_treelock and insert uprobe into uprobes_tree
- * (or reuse existing one, see __insert_uprobe() comments above).
- */
-static struct uprobe *insert_uprobe(struct uprobe *uprobe)
-{
-	struct uprobe *u;
-
-	write_lock(&uprobes_treelock);
-	u = __insert_uprobe(uprobe);
-	write_unlock(&uprobes_treelock);
-
-	return u;
-}
-
 static void
 ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
 {
@@ -1318,6 +1310,8 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		uc->uprobe = uprobe;
 	}
 
+	ret = 0;
+	write_lock(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		struct uprobe *cur_uprobe;
 
@@ -1325,19 +1319,24 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		uprobe = uc->uprobe;
 
 		/* add to uprobes_tree, sorted on inode:offset */
-		cur_uprobe = insert_uprobe(uprobe);
+		cur_uprobe = __insert_uprobe(uprobe);
 		/* a uprobe exists for this inode:offset combination */
 		if (cur_uprobe != uprobe) {
 			if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
 				ref_ctr_mismatch_warn(cur_uprobe, uprobe);
-				put_uprobe(cur_uprobe);
+
+				__put_uprobe(cur_uprobe, true);
 				ret = -EINVAL;
-				goto cleanup_uprobes;
+				goto unlock_treelock;
 			}
 			kfree(uprobe);
 			uc->uprobe = cur_uprobe;
 		}
 	}
+unlock_treelock:
+	write_unlock(&uprobes_treelock);
+	if (ret)
+		goto cleanup_uprobes;
 
 	for (i = 0; i < cnt; i++) {
 		uc = get_uprobe_consumer(i, ctx);
@@ -1367,13 +1366,15 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 cleanup_uprobes:
 	/* put all the successfully allocated/reused uprobes */
+	write_lock(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		uc = get_uprobe_consumer(i, ctx);
 
 		if (uc->uprobe)
-			put_uprobe(uc->uprobe);
+			__put_uprobe(uc->uprobe, true);
 		uc->uprobe = NULL;
 	}
+	write_unlock(&uprobes_treelock);
 	return ret;
 }
 
-- 
2.43.0


