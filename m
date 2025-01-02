Return-Path: <bpf+bounces-47786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9ADA00036
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC907A1FCA
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625E1B4F17;
	Thu,  2 Jan 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITjWwByO"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4F187346;
	Thu,  2 Jan 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850896; cv=none; b=kiWuGAeaBn5/LqGP7VTSehdiwQNRovF/id3VGQbadj6RwZQjDoFsDUwS+lXXA/l20Wo2pM1xOdayvrhEBROhYGMtPl/tGuPKoLwb6N0eGkEnOcuBmr/eR5pS9j3yrFDbmD2dSD6t4KD8f27X8IgJzj64lcfin+TOiAKrLlHxtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850896; c=relaxed/simple;
	bh=P4p/mVwpoQXVZgH40HlQwOT2F9v5Xn1lR7zl9aMvU80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID1Si1pnJ462ZY1OIDfAFMSmlZWx8b4v4AKCQeSgzrJ6/LDcdYPvw5BIxMeT0e5yY3coasFbPzTcuh2KZPU/foVx2srFttt3ZH8lCruE1hJh907XHvgDBXU9qxtUB4GaL5955xJR3YVp2Tkr/2UUdPLYFOWjFWsAn5KwUkxbktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ITjWwByO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JOJ7qRrAuaF9rvai5AqQgmKnlHo0fJkBdfPcmsIRNaY=; b=ITjWwByO05hKFLWckMLWAkpQu0
	3IqsZ4NhNo5DoSGNh/8AIAIIZaX8a31Hfah6xFbhk9sIShqc0E+KU8f/YPw7IkVAY4V7gXliIkh4C
	wjaH6EB7MRvGnex1PyoZUwKvvYu44R1CAR9WscQL8dBWzZiycti8Dq+Ve4Bfb0SZ1caIilPDl7GRL
	sZy2Ycefo+oifEdKCyI7itki9Cwko+u24qmbeKOLANxu0n9q1kD8+Aiw2h+xQ1aQ+Bcue/aVsenIp
	IQ1NfPgii5eOdvOdQM4o1SyWe1ibYBky8MzGMOYBZz0eKvdOVDBH4g/7IqaQfmI0YpHaY8N5EhSTx
	zXrzGlBQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTS6v-00000008FMf-180F;
	Thu, 02 Jan 2025 20:48:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CFA113005D6; Thu,  2 Jan 2025 21:48:04 +0100 (CET)
Date: Thu, 2 Jan 2025 21:48:04 +0100
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
Message-ID: <20250102204804.GG7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
 <20250102194814.GA7274@noisy.programming.kicks-ass.net>
 <20250102145501.3e821c56@gandalf.local.home>
 <20250102150356.1372a947@gandalf.local.home>
 <20250102203200.GE7274@noisy.programming.kicks-ass.net>
 <20250102154146.1d5e8f9c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102154146.1d5e8f9c@gandalf.local.home>

On Thu, Jan 02, 2025 at 03:41:46PM -0500, Steven Rostedt wrote:
> On Thu, 2 Jan 2025 21:32:00 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > This is quite the insane interface -- but whatever. I still feel
> > strongly you should fix kallsyms so that we can all deal more sanely
> > with the weak crap.
> 
> Question about fixing kallsyms, which I would like done too. I guess an
> invisible place holder for weak functions may be best. Saving the size of
> all functions could be memory wasteful. As there are a lot of functions:
> 
>  # wc -l /proc/kallsyms 
>  207126 /proc/kallsyms

IIRC the vast majority of space is taken up by the actual symbol names
-- and rust is only making that *way* worse.

> What would be best? To add a placeholder where weak functions are, but they
> would not be printed in /proc/kallsyms?  If a lookup occurs, and it lands
> on one of theses functions, to return "not found"?

Placeholder yes -- ideally the toolchain itself would not erase the
symbol, but instead mangle it in a well defined way (eg.
<symname>.weak.# or somesuch)

Not printing in kallsyms, I'm not sure, by not printing them it becomes
impossible for userspace consumers of kallsyms to do the same, eg. they
will trip over these same 'holes'.

Default lookup might indeed be best served by returning as if not found.

There's patches out there doing much of the above IIRC.

