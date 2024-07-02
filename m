Return-Path: <bpf+bounces-33615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4E923CF6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF2283954
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49415B153;
	Tue,  2 Jul 2024 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8r+VV/0"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023171DFD8;
	Tue,  2 Jul 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921297; cv=none; b=uP3uWynwcm0oNcSpMjlwrljsH6uw7kVkLl4FT+BIQKtWM9salUS4TWGQVGBZ61NWiXz+0UWaq0JmzwY2ntiBRpby9oFY0OLKE71NTaQWoRxuyNss6IW9p3jIpabKuAgZ3ugx+aK0Pq69cwdrIIWvCY6bSdRgD+tPRV7Yjlf4ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921297; c=relaxed/simple;
	bh=rNcI9WAwJLfST7zxjrhIs1uKlJYxYHjP5PFmZEBw0us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmamLUEEXBlXis2REZ3FOopW7kF3Ybp3HrrQtWHnQUHLw76UFbI48xB4FeQVWDGgz2Emu6NKsMPuSw1u6uhFYc7E4c3ToU/0Uf2+1M+itoLmKDydSRtldLHdeX3Fu/dUw7suSJ4C5s5L5EZWN6K0BKbsvB21ITjqY+JB5IIGnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u8r+VV/0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W5+1pkYUfssEUxhFH+k/bV6mkTwNmU7jab8KfThNUF4=; b=u8r+VV/0QkBFa3UZRjC2MUQzFt
	DwAOnTVr3x9WWa8GVdiy++hqI3Ow0R+OHZ+YP9QeWKdcEbpu9tLiOT+0Tz1tkYjgLDZJKGfKRZS9b
	ycBmPcIScabWRF0N7QLy6SNylSI355yg8vCRlS/BXIUgE2dmGL/PHdXoAqFAbiii+MEjga5Knqv2O
	jtrup9ZLCXSRMkNufaBKmviXZ16l7ZkPvWulVvAbFkZLQmNWPao8dhTtLVAfxJbcwZcdMe6mbflu9
	BmkdcCAL1IFz0rvKOzENyVD4NIOhHhv5BHCAaKFaQ9vc/Pd5Uxh+jUCk1BGO3No9NNRrcCxGWnsAl
	2vEFyiQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOc5x-00000000k39-38Ol;
	Tue, 02 Jul 2024 11:54:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 73169300694; Tue,  2 Jul 2024 13:54:47 +0200 (CEST)
Date: Tue, 2 Jul 2024 13:54:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240702115447.GA28838@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702102353.GG11386@noisy.programming.kicks-ass.net>


+LKML

On Tue, Jul 02, 2024 at 12:23:53PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 01, 2024 at 03:39:23PM -0700, Andrii Nakryiko wrote:
> > This patch set, ultimately, switches global uprobes_treelock from RW spinlock
> > to per-CPU RW semaphore, which has better performance and scales better under
> > contention and multiple parallel threads triggering lots of uprobes.
> 
> Why not RCU + normal lock thing?

Something like the *completely* untested below.

---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..03b38f3f7be3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -40,6 +40,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -54,6 +55,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
+	struct rcu_head		rcu;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
@@ -67,7 +69,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
 	return uprobe;
 }
 
+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -604,7 +612,8 @@ static void put_uprobe(struct uprobe *uprobe)
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		kfree(uprobe);
+
+		call_rcu(&uprobe->rcu, uprobe_free_rcu);
 	}
 }
 
@@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
+	unsigned seq;
 
-	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	guard(rcu)();
 
-	return uprobe;
+	do {
+		seq = read_seqcount_begin(&uprobes_seqcount);
+		uprobes = __find_uprobe(inode, offset);
+		if (uprobes) {
+			/*
+			 * Lockless RB-tree lookups are prone to false-negatives.
+			 * If they find something, it's good. If they do not find,
+			 * it needs to be validated.
+			 */
+			return uprobes;
+		}
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
+
+	/* Really didn't find anything. */
+	return NULL;
 }
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
@@ -702,7 +724,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	struct uprobe *u;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u = __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 
 	return u;
@@ -936,7 +960,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 		return;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);

