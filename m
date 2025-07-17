Return-Path: <bpf+bounces-63632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA58B091B1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7DD3B86FB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F92FCE2D;
	Thu, 17 Jul 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a48SC85F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121062FCE12;
	Thu, 17 Jul 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769656; cv=none; b=rj+dIc6D8OQloIAuno1VE9WKfwhQwL7FWfmNFfSAP/tF3KM81Kxh5rR73FDQZ3SbuMShkiEvacABP2zTm1OTk7Sl+Cdgt3OP5NaH1EywRErI8OWRLjSyspiFWGG56q6OF8PmSDk6Yz0qGN1lqaWXYJxAXsdGRhre6jtjDHdlBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769656; c=relaxed/simple;
	bh=T6IDN6DNaQO447cutHK+OtFjUXY+Qu5JPigU282jM1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuryVaMU+Afk2YtmCj1cgipF9vINjFckfO07w5Oqby0lpjwmWKPSdBdcuhkIOCehxxJ/Vh9ijmRVunFzGjtrZyBzuC6o5+oXNDB6nL3wrq2NwA7VoXY9GfvVVpcltADjd5lWVCQ4BZ+L4J4biAQnYGaHMwh6s8pVdxtDbfwJ1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a48SC85F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561A8C4CEF0;
	Thu, 17 Jul 2025 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769655;
	bh=T6IDN6DNaQO447cutHK+OtFjUXY+Qu5JPigU282jM1s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=a48SC85FDMY07QgHo+q3jYkPuas5/szTj/achK2TFqdIYUOk8ZIyP1DCknSlhBznK
	 BmhGrTP17YC4dqchFuTIb5r/gsE3SyYl90+gCDVk0zzXeW5g4Ou4HCgo2U5rwLa89q
	 uj8U+SvRQHtzBuL1L2LXoanfYwNURPntUI0BjCtZP8z8I0C6g/AzBFtCwvqWVj2HEk
	 WXZZPO0ABVVhgxLQSXFWHPVUYIndL0moMJJElgTNyPomfSmtCFdmn8VvdLpHdblh05
	 K/W5mOpS3+QdQ9XPoJOTumGOLZkmyow2vFIbArVicnOAy81hjR3cV/BqAnEwoxorRb
	 hNcEWuXYjSq/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CDF26CE09F5; Thu, 17 Jul 2025 09:27:34 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:27:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <a9bdf195-e9b2-4cd0-88ba-b6f68b3b72b3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250717004910.297898999@kernel.org>
 <20250717004957.918908732@kernel.org>
 <47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
 <20250717082526.7173106a@gandalf.local.home>
 <41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
 <20250717121010.4246366a@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717121010.4246366a@batman.local.home>

On Thu, Jul 17, 2025 at 12:10:10PM -0400, Steven Rostedt wrote:
> On Thu, 17 Jul 2025 08:48:40 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > So if there is some reason that you absolutely cannot immediately convert
> > to SRCU-fast, let's please discuss.
> 
> There's two reasons I wouldn't add it immediately.
> 
> One, is the guard(srcu_fast) isn't in mainline yet. I would either need
> to open code it, or play the tricks of basing code off your tree.

Fair point!  But guard(srcu_fast) isn't in my tree, either, just
guard(srcu_fast_nopreempt).  So why not add guard(srcu_fast) in your
tree, and we can ack it.  Yes, that means we will have a merge conflict
at some point, but it will be a trivial one.

> Two, I'm still grasping at the concept of srcu_fast (and srcu_lite for
> that matter), where I rather be slow and safe than optimize and be
> unsafe. The code where this is used may be faulting in user space
> memory, so it doesn't need the micro-optimizations now.

Straight-up SRCU and guard(srcu), then?  Both are already in mainline.

Or are those read-side smp_mb() calls a no-go for this code?

							Thanx, Paul

