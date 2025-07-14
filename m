Return-Path: <bpf+bounces-63162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B7B03CE3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358BC17E3AE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481512459E3;
	Mon, 14 Jul 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="at0T0m9R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pz9Mr1bh"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC323A9BB
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491204; cv=none; b=Tewe+WkYH4SKyfMRrORVKJ4aGCKjiQW6xcDPHsR1eYo4+K1gyChOANFcc7ffBgfgFI9DHjVnAzy7F/JwUDiAY4fRHdOuVHYIim2tHnT2/qnQUvkcALhtHHzJ2Ys5We7/93M6Y35nsU1sGd/pej8i//NlLSjC+C0cLzxmCrXrXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491204; c=relaxed/simple;
	bh=jRluGQynhdoMFll9tYsXYmd1yfKerzPJNsCG+1wG85o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es1MTuZLnYSG2L38hV3YKGBZPt79DYbhEI/pP4ssL15d6s5twQaBAUeQGpEhtlZapl3tjPlzwTZ5tl7XA2DgDuU9vPy4Kp9f5jvaSjlkCp0w/juPHRMdWhi+UKaH+a78QCntR9eFtli/i1przZ8h7pzhiRWbXjB6aWVVkPD7KNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=at0T0m9R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pz9Mr1bh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 13:06:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752491200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAeMljy94torG0RE/zR7wOqaRk7RtPGz5NSK370Hp+c=;
	b=at0T0m9RHqcR8lKW+YjBPxJ72+Px+u8ULawyibBVsS2MHSmRRoZOggCklKypka79izBtFn
	5048iHeIcjWv4BkqrQbsuXzw7e2KCDAkaM5DJ1kPnAsSKyKgBzOBqhLF50jLt5kKc74Sr2
	2BoZUmO5Jn2S5IfGLuloKxUIboeV8no3lDgXLIcG/xxzB5Uhu0Omt6peqnTbo3SPLYwdWV
	lljeMP5/kMI3GFjwogWgssIRk0CQZUFF3qFPBGByK66Hacshf5pGw5Qq8MxGmjqk2R6hPF
	/P5ALTrsPghi3Vdeo47eXpmzqC8agCDdFONBiw0HbfPVdu870k1K0FodExOJlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752491200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAeMljy94torG0RE/zR7wOqaRk7RtPGz5NSK370Hp+c=;
	b=Pz9Mr1bhXR8hOu1fTjp+QiWeQRrQEZeJ56sH926MlFsu0EWc0IMNIDFENOfIbk1261Tthj
	yICWZTJqQf1lxWCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <20250714110639.uOaKJEfL@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>

On 2025-07-11 19:19:26 [-0700], Alexei Starovoitov wrote:
> > If there is no parent check then we could do "normal lock" on both
> > sides.
> 
> How would ___slab_alloc() know whether there was a parent check or not?
> 
> imo keeping local_lock_irqsave() as-is is cleaner,
> since if there is no parent check lockdep will rightfully complain.

what about this:

diff --git a/mm/slub.c b/mm/slub.c
index 7e2ffe1d46c6c..3520d1c25c205 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3693,6 +3693,34 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 	return freelist;
 }
 
+static void local_lock_cpu_slab(struct kmem_cache *s, const gfp_t gfp_flags,
+				unsigned long *flags)
+{
+	bool allow_spin = gfpflags_allow_spinning(gfp_flags);
+
+	/*
+	 * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
+	 * can be acquired without a deadlock before invoking the function.
+	 *
+	 * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
+	 * disabled context. The lock will always be acquired and if needed it
+	 * block and sleep until the lock is available.
+	 *
+	 * On !PREEMPT_RT allocations from any context but NMI are safe. The lock
+	 * is always acquired with disabled interrupts meaning it is always
+	 * possible to it.
+	 * In NMI context it is needed to check if the lock is acquired. If it is not,
+	 * it is safe to acquire it. The trylock semantic is used to tell lockdep
+	 * that we don't spin. The BUG_ON() will not trigger if it is safe to acquire
+	 * the lock.
+	 *
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
+		BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));
+	else
+		local_lock_irqsave(&s->cpu_slab->lock, *flags);
+}
+
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
@@ -3765,7 +3793,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto deactivate_slab;
 
 	/* must check again c->slab in case we got preempted and it changed */
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, gfpflags, &flags);
+
 	if (unlikely(slab != c->slab)) {
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_slab;
@@ -3803,7 +3832,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 deactivate_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, gfpflags, &flags);
 	if (slab != c->slab) {
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_slab;
@@ -3819,7 +3848,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	while (slub_percpu_partial(c)) {
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		local_lock_cpu_slab(s, gfpflags, &flags);
 		if (unlikely(c->slab)) {
 			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			goto reread_slab;
@@ -3947,7 +3976,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 retry_load_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, gfpflags, &flags);
 	if (unlikely(c->slab)) {
 		void *flush_freelist = c->freelist;
 		struct slab *flush_slab = c->slab;
@@ -4003,12 +4032,8 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			p = ERR_PTR(-EBUSY);
 			goto out;
 		}
-		local_lock_lockdep_start(&s->cpu_slab->lock);
-		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
-		local_lock_lockdep_end(&s->cpu_slab->lock);
-	} else {
-		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	}
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 out:
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);


Sebastian

