Return-Path: <bpf+bounces-72203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F6C0A158
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 02:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A51118C19BA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CB242D6B;
	Sun, 26 Oct 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoNjnXqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13842611E;
	Sun, 26 Oct 2025 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440310; cv=none; b=C26lv5XE1RZGKniiCM9nM43udTsE76aWcxIaCpyPVp2UR9WYvLXk1dTGg2CQOm26mUn13hZvB2GK52HrPv1G2ri2MY1+nFehX+jcKQNo9SFy8zcdkAoBstFk+fhp5YO7QzZr/NnEZDI8Asc+cBsfQoCL4AhvD6x50leknAxANJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440310; c=relaxed/simple;
	bh=iKNU21p4UOkhzbsU6WfHyfoc71anHD5MgXpTQaxqSvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXTnnb2QI9pa3z1jG93NdhoulLZbisMosVLxGz/JWT3x5AAdQjLP8xq3iFtxuvZsaatATLsexjniSeJUXi5vM45C5FLb053ic5e5l7fN7q9Ga6mwemf3X8TzEUTUxLiA8xjIU17LcBRWP1dywcsaF9yy5JiY9bwrbed4U+SKl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoNjnXqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD662C4CEF5;
	Sun, 26 Oct 2025 00:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761440309;
	bh=iKNU21p4UOkhzbsU6WfHyfoc71anHD5MgXpTQaxqSvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoNjnXqWgDaGFKoPeRTziiKkQt9O08mjcK0iBsx5lSgtOulcik5n7VwHBaJzQ7kgH
	 vRVIf3Ra1QInObf7/23u+ZmsA8/i89WTiRP/RP6bXQCm8cWsNBRKBiaSYfpysCkNTs
	 k9FQnt/VsXhYiC2ZcQ8FcjJho9MmGHNIw/9L0TNEBzXwi1fCcpxnDKMxLO7Rf8ctMa
	 q05cbwUGJtzrUMgpUrttdCV/dQ9ui8w4CJlyKphRVYiEtHsrHKhA6oXuubosBUyO5w
	 1eCrnuXePrr1gRIrhbT+7wmdW5hkj6Df3m/1Qz6c76t37Wvklo6zJUI2Sqsp+QlngB
	 WuT5wELuJFj0A==
Date: Sat, 25 Oct 2025 17:58:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <aP1yM53r1GLS-767@google.com>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251023124057.2a6e793a@gandalf.local.home>
 <20251024082656.GS4067720@noisy.programming.kicks-ass.net>
 <20251024125841.GK4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024125841.GK4068168@noisy.programming.kicks-ass.net>

Hi Peter,

On Fri, Oct 24, 2025 at 02:58:41PM +0200, Peter Zijlstra wrote:
> 
> Arnaldo, Namhyung,
> 
> On Fri, Oct 24, 2025 at 10:26:56AM +0200, Peter Zijlstra wrote:
> 
> > > So "perf_iterate_sb()" was the key point I was missing. I'm guessing it's
> > > basically a demultiplexer that distributes events to all the requestors?
> > 
> > A superset. Basically every event in the relevant context that 'wants'
> > it.
> > 
> > It is what we use for all traditional side-band events (hence the _sb
> > naming) like mmap, task creation/exit, etc.
> > 
> > I was under the impression the perf tool would create one software dummy
> > event to listen specifically for these events per buffer, but alas, when
> > I looked at the tool this does not appear to be the case.
> > 
> > As a result it is possible to receive these events multiple times. And
> > since that is a problem that needs to be solved anyway, I didn't think
> > it 'relevant' in this case.
> 
> When I use:
> 
>   perf record -ag -e cycles -e instructions
> 
> I get:
> 
> # event : name = cycles, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1, defer_callchain = 1
> # event : name = instructions, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0x1 (PERF_COUNT_HW_INSTRUCTIONS), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1, defer_callchain = 1
> # event : name = dummy:u, , id = { }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1, task = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1, build_id = 1, defer_output = 1
> 
> And we have this dummy event I spoke of above; and it has defer_output
> set, none of the others do. This is what I expected.
> 
> *However*, when I use:
> 
>   perf record -g -e cycles -e instruction
> 
> I get:
> 
> # event : name = cycles, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|ID|PERIOD, read_format = ID|LOST, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, sample_id_all = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1, build_id = 1, defer_callchain = 1, defer_output = 1
> # event : name = instructions, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0x1 (PERF_COUNT_HW_INSTRUCTIONS), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|ID|PERIOD, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, sample_id_all = 1, defer_callchain = 1
> 
> Which doesn't have a dummy event. Notably the first real event has
> defer_output set (and all the other sideband stuff like mmap, comm,
> etc.).
> 
> Is there a reason the !cpu mode doesn't have the dummy event? Anyway, it
> should all work, just unexpected inconsistency that confused me. 

Right, I don't remember why.  I think there's no reason doing it for
system wide mode only.

Adrian, do you have any idea?  I have a vague memory that you worked on
this in the past.

Thanks,
Namhyung


