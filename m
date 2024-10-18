Return-Path: <bpf+bounces-42398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BB9A3B18
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DE71C22183
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925F2010E3;
	Fri, 18 Oct 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1oymtwu"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57A18452C;
	Fri, 18 Oct 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246615; cv=none; b=kd9/6yGw9s9wMAdVO9SagC8jKyVQ98e07RpERu0wd3s/4Trlzfph/qezHMtZyXfHH1YPHIdeOlOsCgKawAgqv1i/L+XCm/jFB6VTujsKp8PvZtIPs0/CgGE6RopY4WVKCe8s/TLEQ6jEyk+vCOwmb103CWfgG7WKqqWyG1gOsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246615; c=relaxed/simple;
	bh=2X/NA5WrkrDFFUggkz7hMY18q+IxIgaifuftv8eQYnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEqpfYQmbVhoq3CGIN6ln+3jOHL9jxRgI/kST/rBYxnahjR/Zza3qm5xLuwkIn9h/ubOY1ABJmXgSoQoq42YLquyZcFClwIY0AmYalGhjAb52shWNVEj3u5v1KE0b2bon9N8qaRwWEMKtAA10NKwNrMeGok8haD5fi3m8QxkkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L1oymtwu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cYnjQkJGFypCO7ziWpEz2qR2oT5yS8MTKUUqGzUSuTA=; b=L1oymtwuGBnGHAf+9C960gr/sd
	2Bq3noydWWTWFKnI5iUwPSKPtglZ6rpUtuYbUnCX2OFj9P/i8jJSl3nkqFIMfs7sQ5lfQ9MwrEh6x
	VK2oRfv1VHmsQfW5lhnUX/15qlEt7sfN/v9QLrIcDeQXNmzT0OfvxRa1du3AYtFaPGdlwFajgK0U2
	97v78Lwy/Lx6LFgc1g3u8aXrQZiShKWw3o6r22z8T9Px7O6VCuuGFdZ4dLTEQx1px28MfOHyFqJeE
	bbk/pwHEFhWTzkOg1gKvCmcjxHkJWaEkrbGbdSWaqYzJUWYRtHfkeAABmZmbjWMXEBPjCNBr9r3l5
	nMua1dJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1k2J-00000007KmJ-3o73;
	Fri, 18 Oct 2024 10:16:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 418BA3005AF; Fri, 18 Oct 2024 12:16:47 +0200 (CEST)
Date: Fri, 18 Oct 2024 12:16:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <20241018101647.GA36494@noisy.programming.kicks-ass.net>
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008002556.2332835-3-andrii@kernel.org>

On Mon, Oct 07, 2024 at 05:25:56PM -0700, Andrii Nakryiko wrote:

> +/* Initialize hprobe as SRCU-protected "leased" uprobe */
> +static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
> +{
> +	hprobe->state = HPROBE_LEASED;
> +	hprobe->uprobe = uprobe;
> +	hprobe->srcu_idx = srcu_idx;
> +}
> +
> +/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
> +static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
> +{
> +	hprobe->state = HPROBE_STABLE;
> +	hprobe->uprobe = uprobe;
> +	hprobe->srcu_idx = -1;
> +}
> +
> +/*
> + * hprobe_consume() fetches hprobe's underlying uprobe and detects whether
> + * uprobe is SRCU protected or is refcounted. hprobe_consume() can be
> + * used only once for a given hprobe.
> + *
> + * Caller has to call hprobe_finalize() and pass previous hprobe_state, so
> + * that hprobe_finalize() can perform SRCU unlock or put uprobe, whichever
> + * is appropriate.
> + */
> +static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, enum hprobe_state *hstate)
> +{
> +	enum hprobe_state state;
> +
> +	*hstate = xchg(&hprobe->state, HPROBE_CONSUMED);
> +	switch (*hstate) {
> +	case HPROBE_LEASED:
> +	case HPROBE_STABLE:
> +		return hprobe->uprobe;
> +	case HPROBE_GONE:
> +		return NULL; /* couldn't refcnt uprobe, it's effectively NULL */
> +	case HPROBE_CONSUMED:
> +		return NULL; /* uprobe was finalized already, do nothing */
> +	default:
> +		WARN(1, "hprobe invalid state %d", state);
> +		return NULL;
> +	}
> +}
> +
> +/*
> + * Reset hprobe state and, if hprobe was LEASED, release SRCU lock.
> + * hprobe_finalize() can only be used from current context after
> + * hprobe_consume() call (which determines uprobe and hstate value).
> + */
> +static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
> +{
> +	switch (hstate) {
> +	case HPROBE_LEASED:
> +		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> +		break;
> +	case HPROBE_STABLE:
> +		if (hprobe->uprobe)
> +			put_uprobe(hprobe->uprobe);
> +		break;
> +	case HPROBE_GONE:
> +	case HPROBE_CONSUMED:
> +		break;
> +	default:
> +		WARN(1, "hprobe invalid state %d", hstate);
> +		break;
> +	}
> +}
> +
> +/*
> + * Attempt to switch (atomically) uprobe from being SRCU protected (LEASED)
> + * to refcounted (STABLE) state. Competes with hprobe_consume(); only one of
> + * them can win the race to perform SRCU unlocking. Whoever wins must perform
> + * SRCU unlock.
> + *
> + * Returns underlying valid uprobe or NULL, if there was no underlying uprobe
> + * to begin with or we failed to bump its refcount and it's going away.
> + *
> + * Returned non-NULL uprobe can be still safely used within an ongoing SRCU
> + * locked region. It's not guaranteed that returned uprobe has a positive
> + * refcount, so caller has to attempt try_get_uprobe(), if it needs to
> + * preserve uprobe beyond current SRCU lock region. See dup_utask().
> + */
> +static struct uprobe* hprobe_expire(struct hprobe *hprobe)
> +{
> +	enum hprobe_state hstate;
> +
> +	/*
> +	 * return_instance's hprobe is protected by RCU.
> +	 * Underlying uprobe is itself protected from reuse by SRCU.
> +	 */
> +	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> +
> +	hstate = data_race(READ_ONCE(hprobe->state));
> +	switch (hstate) {
> +	case HPROBE_STABLE:
> +		/* uprobe is properly refcounted, return it */
> +		return hprobe->uprobe;
> +	case HPROBE_GONE:
> +		/*
> +		 * SRCU was unlocked earlier and we didn't manage to take
> +		 * uprobe refcnt, so it's effectively NULL
> +		 */
> +		return NULL;
> +	case HPROBE_CONSUMED:
> +		/*
> +		 * uprobe was consumed, so it's effectively NULL as far as
> +		 * uretprobe processing logic is concerned
> +		 */
> +		return NULL;
> +	case HPROBE_LEASED: {
> +		struct uprobe *uprobe = try_get_uprobe(hprobe->uprobe);
> +		/*
> +		 * Try to switch hprobe state, guarding against
> +		 * hprobe_consume() or another hprobe_expire() racing with us.
> +		 * Note, if we failed to get uprobe refcount, we use special
> +		 * HPROBE_GONE state to signal that hprobe->uprobe shouldn't
> +		 * be used as it will be freed after SRCU is unlocked.
> +		 */
> +		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> +			/* We won the race, we are the ones to unlock SRCU */
> +			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> +			return uprobe;
> +		}
> +
> +		/* We lost the race, undo refcount bump (if it ever happened) */
> +		if (uprobe)
> +			put_uprobe(uprobe);
> +		/*
> +		 * Even if hprobe_consume() or another hprobe_expire() wins
> +		 * the state update race and unlocks SRCU from under us, we
> +		 * still have a guarantee that underyling uprobe won't be
> +		 * freed due to ongoing caller's SRCU lock region, so we can
> +		 * return it regardless. The caller then can attempt its own
> +		 * try_get_uprobe() to preserve the instance, if necessary.
> +		 * This is used in dup_utask().
> +		 */
> +		return uprobe;
> +	}
> +	default:
> +		WARN(1, "unknown hprobe state %d", hstate);
> +		return NULL;
> +	}
> +}

So... after a few readings I think I'm mostly okay with this. But I got
annoyed by the whole HPROBE_STABLE with uprobe=NULL weirdness. Also,
that data_race() usage is weird, what is that about?

And then there's the case where we end up doing:

  try_get_uprobe()
  put_uprobe()
  try_get_uprobe()

in the dup path. Yes, it's unlikely, but gah.


So how about something like this?

---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 06ec41c75c45..efb4f5ee6212 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -657,20 +657,19 @@ static void put_uprobe(struct uprobe *uprobe)
 	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
 }
 
-/* Initialize hprobe as SRCU-protected "leased" uprobe */
-static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
+static void hprobe_init(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
 {
-	hprobe->state = HPROBE_LEASED;
-	hprobe->uprobe = uprobe;
-	hprobe->srcu_idx = srcu_idx;
-}
+	enum hprobe_state state = HPROBE_GONE;
 
-/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
-static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
-{
-	hprobe->state = HPROBE_STABLE;
+	if (uprobe) {
+		state = HPROBE_LEASED;
+		if (srcu_idx < 0)
+			state = HPROBE_STABLE;
+	}
+
+	hprobe->state = state;
 	hprobe->uprobe = uprobe;
-	hprobe->srcu_idx = -1;
+	hprobe->srcu_idx = srcu_idx;
 }
 
 /*
@@ -713,8 +712,7 @@ static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
 		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
 		break;
 	case HPROBE_STABLE:
-		if (hprobe->uprobe)
-			put_uprobe(hprobe->uprobe);
+		put_uprobe(hprobe->uprobe);
 		break;
 	case HPROBE_GONE:
 	case HPROBE_CONSUMED:
@@ -739,8 +737,9 @@ static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
  * refcount, so caller has to attempt try_get_uprobe(), if it needs to
  * preserve uprobe beyond current SRCU lock region. See dup_utask().
  */
-static struct uprobe* hprobe_expire(struct hprobe *hprobe)
+static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
 {
+	struct uprobe *uprobe = NULL;
 	enum hprobe_state hstate;
 
 	/*
@@ -749,25 +748,18 @@ static struct uprobe* hprobe_expire(struct hprobe *hprobe)
 	 */
 	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
 
-	hstate = data_race(READ_ONCE(hprobe->state));
+	hstate = READ_ONCE(hprobe->state);
 	switch (hstate) {
 	case HPROBE_STABLE:
-		/* uprobe is properly refcounted, return it */
-		return hprobe->uprobe;
+		uprobe = hprobe->uprobe;
+		break;
+
 	case HPROBE_GONE:
-		/*
-		 * SRCU was unlocked earlier and we didn't manage to take
-		 * uprobe refcnt, so it's effectively NULL
-		 */
-		return NULL;
 	case HPROBE_CONSUMED:
-		/*
-		 * uprobe was consumed, so it's effectively NULL as far as
-		 * uretprobe processing logic is concerned
-		 */
-		return NULL;
-	case HPROBE_LEASED: {
-		struct uprobe *uprobe = try_get_uprobe(hprobe->uprobe);
+		break;
+
+	case HPROBE_LEASED:
+		uprobe = try_get_uprobe(hprobe->uprobe);
 		/*
 		 * Try to switch hprobe state, guarding against
 		 * hprobe_consume() or another hprobe_expire() racing with us.
@@ -778,27 +770,26 @@ static struct uprobe* hprobe_expire(struct hprobe *hprobe)
 		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
 			/* We won the race, we are the ones to unlock SRCU */
 			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
-			return uprobe;
+			break;
 		}
 
 		/* We lost the race, undo refcount bump (if it ever happened) */
-		if (uprobe)
+		if (uprobe && !get) {
 			put_uprobe(uprobe);
-		/*
-		 * Even if hprobe_consume() or another hprobe_expire() wins
-		 * the state update race and unlocks SRCU from under us, we
-		 * still have a guarantee that underyling uprobe won't be
-		 * freed due to ongoing caller's SRCU lock region, so we can
-		 * return it regardless. The caller then can attempt its own
-		 * try_get_uprobe() to preserve the instance, if necessary.
-		 * This is used in dup_utask().
-		 */
+			uprobe = NULL;
+		}
+
 		return uprobe;
-	}
+
 	default:
 		WARN(1, "unknown hprobe state %d", hstate);
 		return NULL;
 	}
+
+	if (uprobe && get)
+		return try_get_uprobe(uprobe);
+
+	return uprobe;
 }
 
 static __always_inline
@@ -1920,9 +1911,8 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
-	for_each_ret_instance_rcu(ri, utask->return_instances) {
-		hprobe_expire(&ri->hprobe);
-	}
+	for_each_ret_instance_rcu(ri, utask->return_instances)
+		hprobe_expire(&ri->hprobe, false);
 }
 
 static struct uprobe_task *alloc_utask(void)
@@ -1975,10 +1965,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 		*n = *o;
 
-		/* see hprobe_expire() comments */
-		uprobe = hprobe_expire(&o->hprobe);
-		if (uprobe) /* refcount bump for new utask */
-			uprobe = try_get_uprobe(uprobe);
+		uprobe = hprobe_expire(&o->hprobe, true);
 
 		/*
 		 * New utask will have stable properly refcounted uprobe or
@@ -1986,7 +1973,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 		 * need to preserve full set of return_instances for proper
 		 * uretprobe handling and nesting in forked task.
 		 */
-		hprobe_init_stable(&n->hprobe, uprobe);
+		hprobe_init(&n->hprobe, uprobe, -1);
 
 		n->next = NULL;
 		rcu_assign_pointer(*p, n);
@@ -2131,7 +2118,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 
 	utask->depth++;
 
-	hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
+	hprobe_init(&ri->hprobe, uprobe, srcu_idx);
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 

