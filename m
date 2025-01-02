Return-Path: <bpf+bounces-47777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D449FFFC2
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC241627E3
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF71B4152;
	Thu,  2 Jan 2025 20:02:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FA1DFD1;
	Thu,  2 Jan 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848162; cv=none; b=nbiJvvtvqqcTRDyNcSLgOaJBnfJPnb0oRIdHL6zsLFmMszs+VMu8n9hBgMQXXmK7paRxGXklrTgpxVgXxRf+dGXyfUViLH2kJ0SnnBzHYsuA5Wfk7EusLbFHl0iXeIlzaHYqng8Kmp4KxmBgB5LDUN7BE8o7xmsLkUW7vyehX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848162; c=relaxed/simple;
	bh=4Q4jCO12eC6+ybBJOm62KTy7r+b4laSfmxEN9SnD4mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvLEFXjUVxSDMuGpbKtSL/IdhoEXw+acAsioLZBUjhBwHj70nTNFtHlA5qTB4PhF9Z1fS49ig5GEQWA7aSWQnfT74clG8H+3kdMTHhJPwHSlXs8eJAkmFnCFGdyhd1ZiDTXPvcLRod4omVs6Gi5N9iltfTnT66ODZiRa0xGqK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A29AC4CED0;
	Thu,  2 Jan 2025 20:02:40 +0000 (UTC)
Date: Thu, 2 Jan 2025 15:03:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102150356.1372a947@gandalf.local.home>
In-Reply-To: <20250102145501.3e821c56@gandalf.local.home>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<20250102194814.GA7274@noisy.programming.kicks-ass.net>
	<20250102145501.3e821c56@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 14:55:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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

Maybe I misunderstood you, if you are not talking about kallsyms, but for
static calls or anything else that references weak functions.

The reference is not a problem I'm trying to address. The problem with
mcount_loc, is that it is used to create the ftrace_table that is exposed
to user space, and I can't remove entries once they are added.

To set filter functions you echo names into set_ftrace_filter. If you want
to enabled 5000 filters, that can take over a minute complete. That's
because echoing in names to set_ftrace_filter is an O(n^2) operation. It
has to search every address, call kallsyms on the address then compare it
to every function passed in. If you have 40,000 functions total, and pass
in 5,000 functions, that's 40,000 * 5,000 compares!

Since tooling is what does add these large number of filters, a shortcut
was added. If a number written into set_ftrace_filter, it doesn't do a
kallsyms lookup, it will enable the nth function in
available_filter_functions. This turns into a O(1) operation.

libtracefs() will read the available_filter_functions, figure out what to
enable from that, and then write the indexes of all the functions it wants
to enable. This is a much faster operation then echoing the names one at a
time.

This is where the weak functions becomes an issue. If I just ignore them,
and do not add a place holder in the mcount section. Then the index will be
off, and will break.

When the issue first came about, I simply ignored the weak functions, but
then my libtracefs self tests started to fail.

So yes, this is just fixing mcount_loc, but I believe it's the only one
that has a user interface issue.

-- Steve

