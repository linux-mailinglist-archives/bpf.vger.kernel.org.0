Return-Path: <bpf+bounces-42376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0499A3878
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBB1C227E4
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417B18E036;
	Fri, 18 Oct 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ote0cm8h"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377D15445B;
	Fri, 18 Oct 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239972; cv=none; b=adlYNHv8js4EliAVqthS9HXIrYBRgp5yf8ItV83tarIz16fvK7o12FG85pDAQrZ6rqeZUKrKhLnAZZXtuFEFvQ7YXoGBKXILxy6HUZHJpe4eYSgwX0GqHRGESBG19HWxUfEY0YYgPuc65JmjbFS5VXomLZonnWc22Ig2hC6oTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239972; c=relaxed/simple;
	bh=9r43XS4+hO3CCCvk2gQSw9q1OhEUnIT0UTONLiSknSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzxIGqj4hngo3UxFyMT7qihs2mZDfdwwUl+mhPFYmzbL7NwHKRF3jAW3HzfYFf50aWErv5kwxzdPAWLhm7723lTqw7UsE4QJK/OsYWYBqAxuGFIUprQRdNeOj3rpBYRf9pDyLAXdsVDcJF2GZGzz7d2UyZHIy5ptVoZS34zqOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ote0cm8h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJboHb/BMbPaOUcsvW06gXD2GtuhaNwdjAM91CMzA8I=; b=Ote0cm8hlN5HfkRMzMjzlIp4r9
	Gc9nZqHlik7uUgyLRW0BRJJW/eDOeYEbXgpr2jRwtpdaJ1lJmK8R/dhFAGkPUoqeSl8oCQPy9JczE
	WUOl1SXPaMKC3ZNRLA+D0HJ4iMV/qPPItcBKarrRAXvaIIrDdKwC1M3VOhhE+rFPF4LcNMJpEduWn
	43GY9EpcNvxhkcijhRjsGdMyicVLB8dmoJ5Om5p+UaOerCWFdH2A7nVLjKmXpOiCce4Qq8kN+cQdO
	hjMXX7et8C+0oPj0nAeFExog5/AqmxKRDbgN/NZdwauacFjSG6VWWlLilw9ojFXieqEALZDnGIZJW
	ZRdbdZ0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1iJB-0000000Civ3-1t6G;
	Fri, 18 Oct 2024 08:26:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 823773005AF; Fri, 18 Oct 2024 10:26:05 +0200 (CEST)
Date: Fri, 18 Oct 2024 10:26:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 1/2] uprobes: allow put_uprobe() from
 non-sleepable softirq context
Message-ID: <20241018082605.GD17263@noisy.programming.kicks-ass.net>
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008002556.2332835-2-andrii@kernel.org>

On Mon, Oct 07, 2024 at 05:25:55PM -0700, Andrii Nakryiko wrote:
> Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> makes it unsuitable to be called from more restricted context like softirq.

This is delayed_uprobe_lock, right?

So can't we do something like so instead? 

---
 kernel/events/uprobes.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2a0059464383..d17a9046de35 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -83,9 +83,11 @@ struct delayed_uprobe {
 	struct list_head list;
 	struct uprobe *uprobe;
 	struct mm_struct *mm;
+	struct rcu_head rcu;
 };
 
-static DEFINE_MUTEX(delayed_uprobe_lock);
+/* XXX global state; use per mm list instead ? */
+static DEFINE_SPINLOCK(delayed_uprobe_lock);
 static LIST_HEAD(delayed_uprobe_list);
 
 /*
@@ -289,9 +291,11 @@ delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct delayed_uprobe *du;
 
-	list_for_each_entry(du, &delayed_uprobe_list, list)
+	guard(rcu)();
+	list_for_each_entry_rcu(du, &delayed_uprobe_list, list) {
 		if (du->uprobe == uprobe && du->mm == mm)
 			return du;
+	}
 	return NULL;
 }
 
@@ -308,7 +312,8 @@ static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
 
 	du->uprobe = uprobe;
 	du->mm = mm;
-	list_add(&du->list, &delayed_uprobe_list);
+	scoped_guard(spinlock, &delayed_uprobe_lock)
+		list_add_rcu(&du->list, &delayed_uprobe_list);
 	return 0;
 }
 
@@ -316,19 +321,21 @@ static void delayed_uprobe_delete(struct delayed_uprobe *du)
 {
 	if (WARN_ON(!du))
 		return;
-	list_del(&du->list);
-	kfree(du);
+	scoped_guard(spinlock, &delayed_uprobe_lock)
+		list_del(&du->list);
+	kfree_rcu(du, rcu);
 }
 
 static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
 {
-	struct list_head *pos, *q;
 	struct delayed_uprobe *du;
+	struct list_head *pos;
 
 	if (!uprobe && !mm)
 		return;
 
-	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+	guard(rcu)();
+	list_for_each_rcu(pos, &delayed_uprobe_list) {
 		du = list_entry(pos, struct delayed_uprobe, list);
 
 		if (uprobe && du->uprobe != uprobe)
@@ -434,12 +441,10 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 			return ret;
 	}
 
-	mutex_lock(&delayed_uprobe_lock);
 	if (d > 0)
 		ret = delayed_uprobe_add(uprobe, mm);
 	else
 		delayed_uprobe_remove(uprobe, mm);
-	mutex_unlock(&delayed_uprobe_lock);
 
 	return ret;
 }
@@ -645,9 +650,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	 * gets called, we don't get a chance to remove uprobe from
 	 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 	 */
-	mutex_lock(&delayed_uprobe_lock);
 	delayed_uprobe_remove(uprobe, NULL);
-	mutex_unlock(&delayed_uprobe_lock);
 
 	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
@@ -1350,13 +1353,18 @@ static void build_probe_list(struct inode *inode,
 /* @vma contains reference counter, not the probed instruction. */
 static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
 {
-	struct list_head *pos, *q;
 	struct delayed_uprobe *du;
+	struct list_head *pos;
 	unsigned long vaddr;
 	int ret = 0, err = 0;
 
-	mutex_lock(&delayed_uprobe_lock);
-	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+	/*
+	 * delayed_uprobe_list is added to when the ref_ctr is not mapped
+	 * and is consulted (this function) when adding maps. And since
+	 * mmap_lock serializes these, it is not possible miss an entry.
+	 */
+	guard(rcu)();
+	list_for_each_rcu(pos, &delayed_uprobe_list) {
 		du = list_entry(pos, struct delayed_uprobe, list);
 
 		if (du->mm != vma->vm_mm ||
@@ -1370,9 +1378,9 @@ static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
 			if (!err)
 				err = ret;
 		}
+
 		delayed_uprobe_delete(du);
 	}
-	mutex_unlock(&delayed_uprobe_lock);
 	return err;
 }
 
@@ -1596,9 +1604,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 {
 	struct xol_area *area = mm->uprobes_state.xol_area;
 
-	mutex_lock(&delayed_uprobe_lock);
 	delayed_uprobe_remove(NULL, mm);
-	mutex_unlock(&delayed_uprobe_lock);
 
 	if (!area)
 		return;

