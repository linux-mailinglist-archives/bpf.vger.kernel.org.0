Return-Path: <bpf+bounces-47780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE379FFFF7
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4972F162C00
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B61B6CF4;
	Thu,  2 Jan 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQTmG9zI"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF137E782;
	Thu,  2 Jan 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849463; cv=none; b=goGxsL824ElSCOoz0VnyrtiZqgc7u1U3MUqb31RRvLjzCaPnXLdxqbLO0QIHFG0ek9zBLnUYsrQtpFeb9MRm0+18hpUSRiji/3TmTtHPQ/EX6Af1sJ8BfdOodagVx3V21IRdXPnG3sKNZYe3+5znVfe5C0n6bGOBZe7mv8MLzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849463; c=relaxed/simple;
	bh=HaJO6HN0mmyZkae/WwlssxgealcaCHnYk96Gl7wZWpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0kWLluELKv1yXiDOSb1R+UStJQoL0qDLPBz3h4y1gihYXNKBUMqvSTTMl5S4gAC05CslGYLMGzfdLT0jqRsg8Ta9Mi5n2J8OCn1n3v5WQxJhu0bIXKLjfqaKHu/E++q44T2yjkTqyYrK0MxmS6V+2bQzHxGQFblq8xd7JkSpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQTmG9zI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xv/nF1T4OzFqp/VaO1iqvYW4NweLPvFxzbhk/bUxdWk=; b=XQTmG9zI57U+eM6s9xxe1iSr7T
	/Zf/6/PxlVFe7DGniF93JJ7IRTh3pF1pI3SB/4+gPRoJrgVANUYvvKfy6kFE72RAv6SFDGAvVDdOQ
	NOreZd2SU7Nj0omIX/fOBK5THhWMsbsO6bXj7/E4Z0IgcPvcrgPe8Lw0Uo0MQWhKXtHPGmMLFe2NF
	NEqZiCmlRpf6s4W4CYztlb3M/ipW5yqY/vcSBI31DZqTrDwgBP4ZQHgAj2g2GgtJ6RjCYPtqEbJgZ
	cmdTxPq3q7u5LskVqgDKAQmx/wWe/GDSlven2xbh9+in59Kb5kIK2yyY0xkpYK9SGGyRk7ZTqArGw
	TMMD2UZw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTRjh-00000003u8w-0OXA;
	Thu, 02 Jan 2025 20:24:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E17963005D6; Thu,  2 Jan 2025 21:24:04 +0100 (CET)
Date: Thu, 2 Jan 2025 21:24:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102202404.GD7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <20250102194814.GA7274@noisy.programming.kicks-ass.net>
 <20250102145501.3e821c56@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102145501.3e821c56@gandalf.local.home>

On Thu, Jan 02, 2025 at 02:55:01PM -0500, Steven Rostedt wrote:
> On Thu, 2 Jan 2025 20:48:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > *sigh*.. can we please just either add the 'hole' symbols in symtab, or
> > fix symtab to have entry size?
> > 
> > You're just fixing your one problem and leaving everybody else that has
> > extra data inside the dead weak things up a creek :/
> > 
> > Eg. if might make sense to also ignore alternative / static_branch /
> > static_call patching for such 'dead' code. Yes, that's not an immediate
> > problem atm, but just fixing __mcount_loc seems very short sighted.
> 
> Read my reply to the email that I forgot to add to the cover letter (but
> mention in the last patch). Fixing kallsyms does not remove the place
> holders in the available_filter_functions. This has nothing to do with
> kallsyms. I need to remove the fentry/mcount references in the mcount_loc
> section.
> 
> The kallsyms is a completely different issue.

It is not. If kallsyms is fixed, you can use that to tell which
fentry/mcount sites are 'invalid'.

Better yet, other people can then also tell if their things are inside
dead weak code or not.

