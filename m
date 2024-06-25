Return-Path: <bpf+bounces-32971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45E915AF6
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F29F1C212A3
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F18F6E;
	Tue, 25 Jun 2024 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZObdriyw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7D79DC;
	Tue, 25 Jun 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274941; cv=none; b=Q5x+3J48WtdOkYYIp1UoOGezATgMD2h0CC+WLpanRv7sHyptxNrxqJy92PFhtnlCIbybeLxm7l8HLnLL6ES9P5uOfff8Mzy0jDtWO7gmkkQVUxsKArQztfwbFo//hPAVpShsRrsW7/f6TVWnCcbM5zlJphOq9YN1NktqQCvcGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274941; c=relaxed/simple;
	bh=9yfRZ8rZwijfRG1yFfk15X+gMkgcTyqcUkdtj3vZycc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOZI7Nb37zOfahtzMSLb2cOM4OHQ03SeNbAn+8JKwVj73Pr7hhSwxoS0llnVxKrhFLGhQGUK/K1kblmhVW/u2ITR0ZQc8SQ5jntMXV4M2WwQmjGgmPVPgzO8DBb93gJbFSqMqwLh0DZJV97yDQzQjSpkllkMErSAUKzD1DDeyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZObdriyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5B8C2BBFC;
	Tue, 25 Jun 2024 00:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274941;
	bh=9yfRZ8rZwijfRG1yFfk15X+gMkgcTyqcUkdtj3vZycc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZObdriywB4tmhWB3q2sJUwx0uNkcFsZUTEimeiizEsy0Z04umu9EysNja+/yF4cdr
	 wjJNK5l66F42pEJ1UGIOLkYjt0AnD3WyCWAB1gW2XnXpAZHzVXfmzrZT/djFPv/zcI
	 1WaC7aY2OWgCfSDkbJdsGssT26/Fr9Mx1c63iKoNOvQbzO41BqxZmakJRFQUuQQSUZ
	 6iQOy3dk9zQ4e50rwCgyJSrXfYqR86GMXrCQ3fChTCdGA1I9ObwUzYbl0kt/AlURP3
	 NOAaqRB3HQAm4kGrL3obAFSZ5bo4t5hmDECmxlFKMPBOnrpgSJg2lMoTl4PYqtpmeP
	 DzEnuq5Fika7A==
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
Subject: [PATCH 09/12] uprobes: batch uprobes_treelock during registration
Date: Mon, 24 Jun 2024 17:21:41 -0700
Message-ID: <20240625002144.3485799-10-andrii@kernel.org>
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
index 5e98e179d47d..416f408cbed9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -657,7 +657,7 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
 
-static void put_uprobe(struct uprobe *uprobe)
+static void __put_uprobe(struct uprobe *uprobe, bool tree_locked)
 {
 	s64 v;
 
@@ -666,7 +666,8 @@ static void put_uprobe(struct uprobe *uprobe)
 	if (unlikely((u32)v == 0)) {
 		bool destroy;
 
-		write_lock(&uprobes_treelock);
+		if (!tree_locked)
+			write_lock(&uprobes_treelock);
 		/*
 		 * We might race with find_uprobe()->__get_uprobe() executed
 		 * from inside read-locked uprobes_treelock, which can bump
@@ -689,7 +690,8 @@ static void put_uprobe(struct uprobe *uprobe)
 		destroy = atomic64_read(&uprobe->ref) == v;
 		if (destroy && uprobe_is_active(uprobe))
 			rb_erase(&uprobe->rb_node, &uprobes_tree);
-		write_unlock(&uprobes_treelock);
+		if (!tree_locked)
+			write_unlock(&uprobes_treelock);
 
 		/* uprobe got resurrected, pretend we never tried to free it */
 		if (!destroy)
@@ -718,6 +720,11 @@ static void put_uprobe(struct uprobe *uprobe)
 		(void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63));
 }
 
+static void put_uprobe(struct uprobe *uprobe)
+{
+	__put_uprobe(uprobe, false);
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)
@@ -817,21 +824,6 @@ static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
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
@@ -1291,6 +1283,8 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 		uc->uprobe = uprobe;
 	}
 
+	ret = 0;
+	write_lock(&uprobes_treelock);
 	for (i = 0; i < cnt; i++) {
 		struct uprobe *cur_uprobe;
 
@@ -1298,19 +1292,24 @@ int uprobe_register_batch(struct inode *inode, int cnt,
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
@@ -1340,12 +1339,14 @@ int uprobe_register_batch(struct inode *inode, int cnt,
 	}
 cleanup_uprobes:
 	/* put all the successfully allocated/reused uprobes */
+	write_lock(&uprobes_treelock);
 	for (i = cnt - 1; i >= 0; i--) {
 		uc = get_uprobe_consumer(i, ctx);
 
-		put_uprobe(uc->uprobe);
+		__put_uprobe(uc->uprobe, true);
 		uc->uprobe = NULL;
 	}
+	write_unlock(&uprobes_treelock);
 	return ret;
 }
 
-- 
2.43.0


