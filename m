Return-Path: <bpf+bounces-70198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9EBB463C
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B4419C518F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCC2327A3;
	Thu,  2 Oct 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDPsa1vF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E74228C99;
	Thu,  2 Oct 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419973; cv=none; b=qdbd8G76AJe1YlOReJn24N2Sufuo7XFEUPMF5X4EFxTtJjja17GU9bh/h4zRCi/Et0vopzSv5l1dUs3Kjo7pPstxtVWrmScj1WO8mGgdPramF2cWXhYjR3S0JDv4QFaMSPf3N5fGL/7v+6HvNOIpZ4NO+2r3ecDEd6qrXtJiof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419973; c=relaxed/simple;
	bh=4CLzShF5RIJyNi4NFhoaXpGPdvX8vc3yLN1v6Fum6es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZNXICRhgZY16TZCIxte/i8DX+lNSXyaDGzlqG0hxzIVFLa/jB5W0kh6R6TixQ6UBIO0OYnCKpstCwE7dlZY0Ygs/UHU7Z981QJkPooq7olocxRL8RmN73BM6KJkTGUERNIQKxU4r0RTX3Mcl3Gobrb0diQHspbpOcblfSd+9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDPsa1vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C491AC4CEF4;
	Thu,  2 Oct 2025 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419973;
	bh=4CLzShF5RIJyNi4NFhoaXpGPdvX8vc3yLN1v6Fum6es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDPsa1vF1kBbQYp4jb7XpH/DTJEhyWkvrSHRql5UDJjCofAWicEnEg2F/nnhEu03J
	 L88vF1LbCZRL9a+FzDEBKqL+GqotW1SgTa0TalVs9PHQJguq9wO8FKWmkK/Ak5dcAX
	 0HymDIJqU2VIVuhACvJRvWEH6OWReLSZk38PceTr9PD5f97XsWByFpi1BIMO5ipYZp
	 JhQXHl3ywelIwQuBJRQn48uiRBNe5jdTBvg+V2DWImLRLU1fTGvrrVsaMX58V/yNor
	 s9s+NalpY149uI59y7rnMY43e6PmF5FqYtCVVJxpzzNUN8ky4O9y1TaiKuku8QmfBM
	 7TmnSeoXZn7oQ==
Date: Thu, 2 Oct 2025 17:46:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 02/21] rcu: Re-implement RCU Tasks Trace in terms of
 SRCU-fast
Message-ID: <aN6eQuTbdwAAhxIj@localhost.localdomain>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001144832.631770-2-paulmck@kernel.org>

Le Wed, Oct 01, 2025 at 07:48:13AM -0700, Paul E. McKenney a écrit :
> This commit saves more than 500 lines of RCU code by re-implementing
> RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> more code that does not cause problems by its presence, but that is no
> longer required.
> 
> This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> be removed on common-case architectures in a later commit.

The changelog doesn't mention what this is ordering :-)

> 
> [ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]
> [ paulmck: Split out Tiny SRCU fixes per Andrii Nakryiko feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
[...]
> @@ -50,12 +50,14 @@ static inline void rcu_read_lock_trace(void)
>  {
>  	struct task_struct *t = current;
>  
> -	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
> -	barrier();
> -	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
> -	    t->trc_reader_special.b.need_mb)
> -		smp_mb(); // Pairs with update-side barriers
> -	rcu_lock_acquire(&rcu_trace_lock_map);
> +	if (t->trc_reader_nesting++) {
> +		// In case we interrupted a Tasks Trace RCU reader.
> +		rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> +		return;
> +	}
> +	barrier();  // nesting before scp to protect against interrupt handler.
> +	t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> +	smp_mb(); // Placeholder for more selective ordering

Mysterious :-)

>  }
>  
>  /**
> @@ -69,26 +71,75 @@ static inline void rcu_read_lock_trace(void)
>   */
>  static inline void rcu_read_unlock_trace(void)
>  {
> -	int nesting;
> +	struct srcu_ctr __percpu *scp;
>  	struct task_struct *t = current;
>  
> -	rcu_lock_release(&rcu_trace_lock_map);
> -	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
> -	barrier(); // Critical section before disabling.
> -	// Disable IPI-based setting of .need_qs.
> -	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
> -	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
> -		WRITE_ONCE(t->trc_reader_nesting, nesting);
> -		return;  // We assume shallow reader nesting.
> -	}
> -	WARN_ON_ONCE(nesting != 0);
> -	rcu_read_unlock_trace_special(t);
> +	smp_mb(); // Placeholder for more selective ordering

Bizarre :-)

> +	scp = t->trc_reader_scp;
> +	barrier();  // scp before nesting to protect against interrupt handler.

What is it protecting against interrupt?

> +	if (!--t->trc_reader_nesting)
> +		srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
> +	else
> +		srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
> +}

Thanks (very happy to see all the rest of the code going away!)

-- 
Frederic Weisbecker
SUSE Labs

