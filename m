Return-Path: <bpf+bounces-63198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6294FB040BE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E424173875
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380D2594AA;
	Mon, 14 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WkhC9Ud1"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96142580F7;
	Mon, 14 Jul 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501411; cv=none; b=MqRggS8Vyo96coJ3/KhM6Bcm+aOgYGevJn3M6Tj54NX1CPj7dJygc9U5whMH7k1fYe5BeqWd6JgPdqnw4yUEIDV21IBrqxN5JM0fJhXdnX889lqkbDI6ZebGBdwOCDCAyFnOdLTEKPIa7N/GeetFQuQ9m1rvhpPrKVEW+WARh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501411; c=relaxed/simple;
	bh=MlE8252+KP78YDkF+Nc2zLmb4D0AJx0GRBStApfzprk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5ysmYshEDJL92oP7J3WlmD7pIbknKiWuk+ozZD69udsUSaRDo1ipTXgs5LeCNljKY1B3nHjXk7sc2BVpbjSN/rZZCUGSMJGapAqFCK3jLRqyyyEvLs42j36sVDQ423zktVb8F8vbvgUQifBOvfIVUTxeL5v4Uo3B2e5Nf2x6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WkhC9Ud1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rJfNwhvDwBdRdwUftFwhy6EVQXSWL+4MqfUGTAPT3b0=; b=WkhC9Ud1STBCVebdnVnk9lb+iE
	8LVYgZHqJJqG8ZydHrqWJYCYLlvxftl4mPeFnnpU00HYwSpbajCZG1yrObIVUtPi5wMW6S15yVsUZ
	+zt/9BpAfOqpzj9jOlJVWxxAjO5Z6uoghr3ueSuo3pQasnb4geHnaZH9pTla0Yt0lK1rAkqmnxrC8
	tZKOc6X9jkypK+1FMQaEUSayJvbybCwFVmmqVf22/vonPN6jVYnnKMgitoGAsJkoc35hgelyid8X1
	BCD5wmDP0qbnuVG5MP4keUG0VkFsthCg+lZk5zEvHbudEufJE7FlEfyI+IH8xhq3tWuJBoYU3GNEM
	q+yv+2fQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJfb-00000009luO-19Ot;
	Mon, 14 Jul 2025 13:56:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8623300186; Mon, 14 Jul 2025 15:56:38 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:56:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 09/14] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250714135638.GC4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.172959778@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708012359.172959778@kernel.org>

On Mon, Jul 07, 2025 at 09:22:48PM -0400, Steven Rostedt wrote:

> @@ -143,6 +144,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  	struct unwind_stacktrace trace;
>  	struct unwind_work *work;
>  	u64 cookie;
> +	int idx;
>  
>  	if (WARN_ON_ONCE(!local_read(&info->pending)))
>  		return;
> @@ -161,13 +163,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  
>  	cookie = info->id.id;
>  
> -	guard(mutex)(&callback_mutex);
> -	list_for_each_entry(work, &callbacks, list) {
> +	idx = srcu_read_lock(&unwind_srcu);
> +	list_for_each_entry_srcu(work, &callbacks, list,
> +				 srcu_read_lock_held(&unwind_srcu)) {
>  		if (test_bit(work->bit, &info->unwind_mask)) {
>  			work->func(work, &trace, cookie);
>  			clear_bit(work->bit, &info->unwind_mask);
>  		}
>  	}
> +	srcu_read_unlock(&unwind_srcu, idx);
>  }

Please; something like so:

--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -524,4 +524,9 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_st
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
+		    _T->idx = srcu_read_lock_lite(_T->lock),
+		    srcu_read_unlock_lite(_T->lock, _T->idx),
+		    int idx)
+
 #endif
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -165,7 +165,7 @@ static void unwind_deferred_task_work(st
 
 	cookie = info->id.id;
 
-	guard(mutex)(&callback_mutex);
+	guard(srcu_lite)(&unwind_srcu);
 	list_for_each_entry(work, &callbacks, list) {
 		work->func(work, &trace, cookie);
 	}

