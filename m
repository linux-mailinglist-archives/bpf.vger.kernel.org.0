Return-Path: <bpf+bounces-36181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB70943831
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FB11C2194F
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECC16E89E;
	Wed, 31 Jul 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT835U9k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A016E886;
	Wed, 31 Jul 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462203; cv=none; b=VVLD2CSke1FXC3dxKexO+X6sENLFyZfcYcxDduWsuNJHp9gRUlvlYKp2CBCtk4U46iwPavBtkwda2tgnGW6KvtGaH70TFXDRVK7LrvpNioXuGGDwYHEr/4Swpn8pBkmFD+azXuW9HI0WvRYdLfF0Pyo3NMPA7ZJMAZVFG4RpMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462203; c=relaxed/simple;
	bh=5GeZEp8PznaubjQl93ECJEIBV/h1fnH1QHosJHQmZP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW69tl7QKeyiYsRGPraKzQ9PijN1w9sl9hOC+dezVOn2QcfExrI/sWMl3L6sAyg2fwC4gVMbFw3UMbggS2Dt6b4XlB0KBMsR0DKfd4cc+fUfSxbqqSnf53x2LIM/evbcnusVnv4VcBiGepFz9LSt9I6oDS/F1EAXg3xyNHffwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT835U9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8CAC4AF0C;
	Wed, 31 Jul 2024 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462203;
	bh=5GeZEp8PznaubjQl93ECJEIBV/h1fnH1QHosJHQmZP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT835U9keYgrAF4L03HpEIGiZTt9wXd56wbjrw4tsr5VC1nuox1APEuuuiLJE1EHs
	 u3ch59V4ZM7cU2YgdqczaHE9+BF8bXt3GI4K634IGdKcEHZWQKdiypQKKwEaDWDWNq
	 YJJxhGODiUeY6Cn8Abh7BnxlSpk41HNPSDAhQV6fIT99GpAfOZUIQIvsGny0JAMsXk
	 YSYd1Ik48AD9Oj3SRlo+6X1MvmvAsDy8/EWnuKshzJfURhX2btpH767Zrr2zfl2myQ
	 nO4Ut7Uz0CoOmPzTS8USAhhSA8wB3Q/9oGnyT9MQOZX5VP5cX5/UQXhYJ7zdj6fEZH
	 FT4HnjF/oS95Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree lookup
Date: Wed, 31 Jul 2024 14:42:55 -0700
Message-ID: <20240731214256.3588718-8-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Another big bottleneck to scalablity is uprobe_treelock that's taken in
a very hot path in handle_swbp(). Now that uprobes are SRCU-protected,
take advantage of that and make uprobes_tree RB-tree look up lockless.

To make RB-tree RCU-protected lockless lookup correct, we need to take
into account that such RB-tree lookup can return false negatives if there
are parallel RB-tree modifications (rotations) going on. We use seqcount
lock to detect whether RB-tree changed, and if we find nothing while
RB-tree got modified inbetween, we just retry. If uprobe was found, then
it's guaranteed to be a correct lookup.

With all the lock-avoiding changes done, we get a pretty decent
improvement in performance and scalability of uprobes with number of
CPUs, even though we are still nowhere near linear scalability. This is
due to SRCU not really scaling very well with number of CPUs on
a particular hardware that was used for testing (80-core Intel Xeon Gold
6138 CPU @ 2.00GHz), but also due to the remaning mmap_lock, which is
currently taken to resolve interrupt address to inode+offset and then
uprobe instance. And, of course, uretprobes still need similar RCU to
avoid refcount in the hot path, which will be addressed in the follow up
patches.

Nevertheless, the improvement is good. We used BPF selftest-based
uprobe-nop and uretprobe-nop benchmarks to get the below numbers,
varying number of CPUs on which uprobes and uretprobes are triggered.

BASELINE
========
uprobe-nop      ( 1 cpus):    3.032 ± 0.023M/s  (  3.032M/s/cpu)
uprobe-nop      ( 2 cpus):    3.452 ± 0.005M/s  (  1.726M/s/cpu)
uprobe-nop      ( 4 cpus):    3.663 ± 0.005M/s  (  0.916M/s/cpu)
uprobe-nop      ( 8 cpus):    3.718 ± 0.038M/s  (  0.465M/s/cpu)
uprobe-nop      (16 cpus):    3.344 ± 0.008M/s  (  0.209M/s/cpu)
uprobe-nop      (32 cpus):    2.288 ± 0.021M/s  (  0.071M/s/cpu)
uprobe-nop      (64 cpus):    3.205 ± 0.004M/s  (  0.050M/s/cpu)

uretprobe-nop   ( 1 cpus):    1.979 ± 0.005M/s  (  1.979M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.361 ± 0.005M/s  (  1.180M/s/cpu)
uretprobe-nop   ( 4 cpus):    2.309 ± 0.002M/s  (  0.577M/s/cpu)
uretprobe-nop   ( 8 cpus):    2.253 ± 0.001M/s  (  0.282M/s/cpu)
uretprobe-nop   (16 cpus):    2.007 ± 0.000M/s  (  0.125M/s/cpu)
uretprobe-nop   (32 cpus):    1.624 ± 0.003M/s  (  0.051M/s/cpu)
uretprobe-nop   (64 cpus):    2.149 ± 0.001M/s  (  0.034M/s/cpu)

SRCU CHANGES
============
uprobe-nop      ( 1 cpus):    3.276 ± 0.005M/s  (  3.276M/s/cpu)
uprobe-nop      ( 2 cpus):    4.125 ± 0.002M/s  (  2.063M/s/cpu)
uprobe-nop      ( 4 cpus):    7.713 ± 0.002M/s  (  1.928M/s/cpu)
uprobe-nop      ( 8 cpus):    8.097 ± 0.006M/s  (  1.012M/s/cpu)
uprobe-nop      (16 cpus):    6.501 ± 0.056M/s  (  0.406M/s/cpu)
uprobe-nop      (32 cpus):    4.398 ± 0.084M/s  (  0.137M/s/cpu)
uprobe-nop      (64 cpus):    6.452 ± 0.000M/s  (  0.101M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.055 ± 0.001M/s  (  2.055M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.677 ± 0.000M/s  (  1.339M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.561 ± 0.003M/s  (  1.140M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.291 ± 0.002M/s  (  0.661M/s/cpu)
uretprobe-nop   (16 cpus):    5.065 ± 0.019M/s  (  0.317M/s/cpu)
uretprobe-nop   (32 cpus):    3.622 ± 0.003M/s  (  0.113M/s/cpu)
uretprobe-nop   (64 cpus):    3.723 ± 0.002M/s  (  0.058M/s/cpu)

Peak througput increased from 3.7 mln/s (uprobe triggerings) up to about
8 mln/s. For uretprobes it's a bit more modest with bump from 2.4 mln/s
to 5mln/s.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b0488d356399..d03962cc96de 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -40,6 +40,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
 
 DEFINE_STATIC_SRCU(uprobes_srcu);
 
@@ -629,8 +630,11 @@ static void put_uprobe(struct uprobe *uprobe)
 
 	write_lock(&uprobes_treelock);
 
-	if (uprobe_is_active(uprobe))
+	if (uprobe_is_active(uprobe)) {
+		write_seqcount_begin(&uprobes_seqcount);
 		rb_erase(&uprobe->rb_node, &uprobes_tree);
+		write_seqcount_end(&uprobes_seqcount);
+	}
 
 	write_unlock(&uprobes_treelock);
 
@@ -696,14 +700,26 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
 		.offset = offset,
 	};
 	struct rb_node *node;
+	unsigned int seq;
 
 	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
-	read_lock(&uprobes_treelock);
-	node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
-	read_unlock(&uprobes_treelock);
+	do {
+		seq = read_seqcount_begin(&uprobes_seqcount);
+		node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
+		/*
+		 * Lockless RB-tree lookups can result only in false negatives.
+		 * If the element is found, it is correct and can be returned
+		 * under RCU protection. If we find nothing, we need to
+		 * validate that seqcount didn't change. If it did, we have to
+		 * try again as we might have missed the element (false
+		 * negative). If seqcount is unchanged, search truly failed.
+		 */
+		if (node)
+			return __node_2_uprobe(node);
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
 
-	return node ? __node_2_uprobe(node) : NULL;
+	return NULL;
 }
 
 /*
@@ -725,7 +741,7 @@ static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
 	struct rb_node *node;
 again:
-	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	node = rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node) {
 		struct uprobe *u = __node_2_uprobe(node);
 
@@ -750,7 +766,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	struct uprobe *u;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u = __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 
 	return u;
-- 
2.43.0


