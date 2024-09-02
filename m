Return-Path: <bpf+bounces-38707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B4968B35
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CADAB21640
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC231A2640;
	Mon,  2 Sep 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qIEvWUu2"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144D1CB51D;
	Mon,  2 Sep 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291830; cv=none; b=PobFxcay5gGzD9rE8TQiYVN3E3HbwUzfCRQ8unyv9J2SPSfjrMN+8jPjDTTL8i7stX05ftnDwnP/d8mH6qbTuLksLBWAX8jykDoU2LzliQEFAelVNxjLEOU2BE4CYiXTbysFotRrhpGT9XCz07xCLOssGfRA99YNPRBIIClQjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291830; c=relaxed/simple;
	bh=p/ziduP6idDY0qvJIEhR3b3LMF5uGVgDgcAHfDP96MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdiyG6ALilCzBENGkYthBh4fpS+Hr4c2vvHGX5ZMZ3ceGDEv9a6CDm2eRXQ1IZXhF4C8sYFqZcQE+Ly/PWlXc5wEg7P6hd12llmr99L5PsknHcNOsbTsw4185S+Y8N03lZwL0LaOaHAXza1ueLY1ICl85dAeP7Vsw+CXzmEQ/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qIEvWUu2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fo3JtNSgEnDqg8YlNSSixwkDr/LZX4dg7x2z5VanSmk=; b=qIEvWUu2BZMBtdRph8WC4tyfMa
	YCNGDlpl5XY64jaVfkbOC69FDIJckB6Whp5frRITtczct3+rkyu/F/1RWe1mx+K1fVI6CPM6M8mjx
	jBUxSpDdujZ8GKKnWf+mk4AnKagwTAqjs1C+ZF+xy2lpVHehOA940KELRQYCuw5OeC9kqxnMjE73b
	FCC6esRJ21DcGfdNHdnsxxOgsEecd9WwPf9Hgr+X/bA1myFpvIRoSD+ofnLqtJD6BG/ZMjC+JL7gG
	W9eYUzQfHXsxodMgvZTCP5IiTUJtWVrYuhjm0OIAd1sfxD88pkvPyPT38sQV6DS5ZQklQAhNYxoBL
	I+/BeI0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sl9DL-00000006pZ0-1DPA;
	Mon, 02 Sep 2024 15:43:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4B6EF30058E; Mon,  2 Sep 2024 17:43:34 +0200 (CEST)
Date: Mon, 2 Sep 2024 17:43:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
Message-ID: <20240902154334.GH4723@noisy.programming.kicks-ass.net>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828143719.828968-3-mathieu.desnoyers@efficios.com>

On Wed, Aug 28, 2024 at 10:37:19AM -0400, Mathieu Desnoyers wrote:
> To cover scenarios where the scope of the guard differs from the scope
> of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().
> 
> Here is an example use for a conditionally activated guard variable:
> 
> void func(bool a)
> {
> 	DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);
> 
> 	[...]
> 	if (a) {
> 		might_sleep();
> 		activate_guard(preempt_notrace, myguard)();
> 	}
> 	[ protected code ]
> }

So... I more or less proposed this much earlier:

  https://lore.kernel.org/all/20230919131038.GC39346@noisy.programming.kicks-ass.net/T/#mb7b84212619ac743dfe4d2cc81decce451586b27

and Linus took objection to similar patterns. But perhaps my naming
wasn't right.

