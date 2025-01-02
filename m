Return-Path: <bpf+bounces-47774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3909FFFA6
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AEC1883F76
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1D1922F2;
	Thu,  2 Jan 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nH4rCHW3"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352D28FD;
	Thu,  2 Jan 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847309; cv=none; b=VBXgtMidSYFKxYEJLy89LS289n0tTiofjw8rn3m+k7yOi4Ds8qTjJOFtx9Xl9HhE/CvSobMJxrkHUCqnWzuYAUA/BIWyf9XYL34h14Trv+YVGic8pfYnVw+ay98rsO0ggQ6v5ZG+4kBRq7M9UAuuhN+6BvGXzbhchcYqqVWpLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847309; c=relaxed/simple;
	bh=2uok9huLpw73MUIppy9f+XyUkz6zWNkYJfa5KJAWJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf4HUQRmcV1/DmwDTcTws2nufdGTJNRkZ3ssa8JAlBP4gu6ipVVPVgx1TrxzHVUScEpt6MZ1ubDnd4za3Ug/IaYTBMrTVIsJC59DUZzOyjJw7CJnCm+3UZ/vDHD3VTW+mjm+2zLOZEkNm7wLKwk3hViEU/E4d2Ps6ccRXG+jSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nH4rCHW3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4tbMKezulSIHBjmrUnIK115gVnZpRR5pfboqp3CApvo=; b=nH4rCHW3dj0Xoqa9YzFsCyC+er
	M/UVAE34cVsscsNAgqvGEdwAeKQWaL3thRRjsVbi2TwvTPckuMWP0Z+9K9C9LHPNEqrDTHM1pJxRB
	6PWdX2Fj6WfwAN4izHjg7QyeXtcNSzsF/iRGHkhjxR4OQJV6yk3Uht23d7Z+hv9/QFOtgj+ytoicp
	N9Q0z/n94xOqg4v7mbDtiUOK1BjgXjzfMjzOLza2gH4M6XCf9ZvDOUNPYzxRKv++n683cJyypsWGo
	Ir4ABRi0kUBRBmcHJtMzr5sZZkFXwdk3RXAl8Iuwi7ESqgZE3hUhySzfXU39Ryp/GXYmWSZ9yhFyU
	97rghRDw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTRB2-00000008Eq5-0435;
	Thu, 02 Jan 2025 19:48:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F25F3005D6; Thu,  2 Jan 2025 20:48:15 +0100 (CET)
Date: Thu, 2 Jan 2025 20:48:14 +0100
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
Message-ID: <20250102194814.GA7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102190105.506164167@goodmis.org>

On Thu, Jan 02, 2025 at 01:58:59PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When a function is annotated as "weak" and is overridden, the code is not
> removed. If it is traced, the fentry/mcount location in the weak function
> will be referenced by the "__mcount_loc" section. This will then be added
> to the available_filter_functions list. Since only the address of the
> functions are listed, to find the name to show, a search of kallsyms is
> used.
> 
> Since kallsyms will return the function by simply finding the function
> that the address is after but before the next function, an address of a
> weak function will show up as the function before it. This is because
> kallsyms does not save names of weak functions. This has caused issues in
> the past, as now the traced weak function will be listed in
> available_filter_functions with the name of the function before it.
> 
> At best, this will cause the previous function's name to be listed twice.
> At worse, if the previous function was marked notrace, it will now show up
> as a function that can be traced. Note that it only shows up that it can
> be traced but will not be if enabled, which causes confusion.
> 
>  https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> 
> The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> adding weak function") was a workaround to this by checking the function
> address before printing its name. If the address was too far from the
> function given by the name then instead of printing the name it would
> print: __ftrace_invalid_address___<invalid-offset>
> 
> The real issue is that these invalid addresses are listed in the ftrace
> table look up which available_filter_functions is derived from. A place
> holder must be listed in that file because set_ftrace_filter may take a
> series of indexes into that file instead of names to be able to do O(1)
> lookups to enable filtering (many tools use this method).
> 
> Even if kallsyms saved the size of the function, it does not remove the
> need of having these place holders. The real solution is to not add a weak
> function into the ftrace table in the first place.
> 
> To solve this, the sorttable.c code that sorts the mcount regions during
> the build is modified to take a "nm -S vmlinux" input, sort it, and any
> function listed in the mcount_loc section that is not within a boundary of
> the function list given by nm is considered a weak function and is zeroed
> out. Note, this does not mean they will remain zero when booting as KASLR
> will still shift those addresses.
> 

*sigh*.. can we please just either add the 'hole' symbols in symtab, or
fix symtab to have entry size?

You're just fixing your one problem and leaving everybody else that has
extra data inside the dead weak things up a creek :/

Eg. if might make sense to also ignore alternative / static_branch /
static_call patching for such 'dead' code. Yes, that's not an immediate
problem atm, but just fixing __mcount_loc seems very short sighted.

