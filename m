Return-Path: <bpf+bounces-72091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E5C0660C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D319950715E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43131987E;
	Fri, 24 Oct 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTPNrRJT"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACC2E091C;
	Fri, 24 Oct 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310740; cv=none; b=BrtR5hMsO6jOzFjjYAZdQBrio7XC3KlM9VXt5XCrjNp/A14+COV5hKl+QuRhvtzP4wjX1TL+vm4KmfSBh4FNRQ8smsI/HxlCzUPzqX/48bmiTEZQCRbKeoo3RnavRh5w1jIVboKGI63iO2YySB6Hbn4T4Z4w4XxSHkrHzdq/2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310740; c=relaxed/simple;
	bh=QvQXlYjL/5HGuJ8prsjglpCUOG11dtLJYaWUIw75hs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsco7F1hziqaw/GDpUlZVBZdrLbKHja+nOunfuZVh38DQ1ixwlbrERUkfHaop/GSnxptuHpGNXnTlcrTp28AuMxBORqNetcp+wipz6xY7j2SS45t6rkrJjAlI7jjmPjJ35pv8otE4pB9D/8W8TP3LvS5d2wN/CzDXA0BfYjXrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTPNrRJT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KbeVfcyQZUP3kW1e2M7Vm/hShqmgI8Ihl8fZeTRvIi0=; b=LTPNrRJTbObElN6F0r7EtD/tzc
	lrBzpm/IvXEVFsdCxCWIOMUBzTrltC9IzoSx+DnegjTgFIdbquDhaSPczA5Qv5A29S3ul9DbQYI9D
	N0ZGu437Tf6K5eMhe3UHXpFykQzR60kAhnrOfVlT1ds8TpQuLGTacDdToIdmAQevrjGQBAOxQUqzH
	ZSCpBR9gH3Sl/Qij0j98G/x5GZYZVBr7By2F5B9Gi3c3OLW66MK8cg7492HvLjsJhT396Fy6CbXnd
	SYrWV5yxhCXWg1GQGxILt4XIgi6CNX2cfijp6Lbwt3Bed/nTNVNeJXI/QMzYjFSR3X+uzIjKVAYuW
	R+9o/VAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHNR-00000000ooe-18YF;
	Fri, 24 Oct 2025 12:58:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E435300323; Fri, 24 Oct 2025 14:58:41 +0200 (CEST)
Date: Fri, 24 Oct 2025 14:58:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <20251024125841.GK4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251023124057.2a6e793a@gandalf.local.home>
 <20251024082656.GS4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024082656.GS4067720@noisy.programming.kicks-ass.net>


Arnaldo, Namhyung,

On Fri, Oct 24, 2025 at 10:26:56AM +0200, Peter Zijlstra wrote:

> > So "perf_iterate_sb()" was the key point I was missing. I'm guessing it's
> > basically a demultiplexer that distributes events to all the requestors?
> 
> A superset. Basically every event in the relevant context that 'wants'
> it.
> 
> It is what we use for all traditional side-band events (hence the _sb
> naming) like mmap, task creation/exit, etc.
> 
> I was under the impression the perf tool would create one software dummy
> event to listen specifically for these events per buffer, but alas, when
> I looked at the tool this does not appear to be the case.
> 
> As a result it is possible to receive these events multiple times. And
> since that is a problem that needs to be solved anyway, I didn't think
> it 'relevant' in this case.

When I use:

  perf record -ag -e cycles -e instructions

I get:

# event : name = cycles, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1, defer_callchain = 1
# event : name = instructions, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0x1 (PERF_COUNT_HW_INSTRUCTIONS), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1, defer_callchain = 1
# event : name = dummy:u, , id = { }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST, exclude_kernel = 1, exclude_hv = 1, mmap = 1, comm = 1, task = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1, build_id = 1, defer_output = 1

And we have this dummy event I spoke of above; and it has defer_output
set, none of the others do. This is what I expected.

*However*, when I use:

  perf record -g -e cycles -e instruction

I get:

# event : name = cycles, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|ID|PERIOD, read_format = ID|LOST, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, sample_id_all = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1, build_id = 1, defer_callchain = 1, defer_output = 1
# event : name = instructions, , id = { }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0x1 (PERF_COUNT_HW_INSTRUCTIONS), { sample_period, sample_freq } = 2000, sample_type = IP|TID|TIME|CALLCHAIN|ID|PERIOD, read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, sample_id_all = 1, defer_callchain = 1

Which doesn't have a dummy event. Notably the first real event has
defer_output set (and all the other sideband stuff like mmap, comm,
etc.).

Is there a reason the !cpu mode doesn't have the dummy event? Anyway, it
should all work, just unexpected inconsistency that confused me. 

