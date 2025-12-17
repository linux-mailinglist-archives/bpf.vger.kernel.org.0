Return-Path: <bpf+bounces-76872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F629CC8E04
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E61630146D7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BDF3559F9;
	Wed, 17 Dec 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEISZCaI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C966355818;
	Wed, 17 Dec 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987207; cv=none; b=sxARZNWRQL5kqAIyh24rgQREBwt5jXyi4Wq686hObIQGZyOnbPN14MKAUxE7WY0rP4JZWr6aAVwZJWo2rbons5dWRxfIegWjzgbCDoppCuWEvhsHVuXpdo87fX3q7ssP57HeH1dv5rZ5HrW/H+fzGdEd8aemOM7u+cEBWhp7XME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987207; c=relaxed/simple;
	bh=8ULpIijsMTIWJpZCYyksJj4tQxYZ8z5XaFLNHmt/XvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv8ShiC+GwybcssNtnTGuMz31hMOr5IUBsCu0VgVT0aadjEvr/+i+jVLiYku+YUyryTiOeqlhlCIdlpGR+xS+KSs5F/BMhXOozhFojt9EDY9z7MRe9qRkTbyc0Idz3kbSvvKTy2jDgFuDmMH4QpI93u27R80HpaTW8+L6V/Ri8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEISZCaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27B1C113D0;
	Wed, 17 Dec 2025 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765987204;
	bh=8ULpIijsMTIWJpZCYyksJj4tQxYZ8z5XaFLNHmt/XvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEISZCaIzLHWb+/T+GVDyrm53XKVXfOQrcEybo/bu4RPoysKJwqz0U6/RmDzaQqsj
	 HFwVl3izeMJy3kHKekyBSGuA7ProiCiarlOVGoWgN3ZqQvC3yiMY+rCmFWX6itUest
	 JbtM5VnQx6tevNSTBCeSsZv3A8o4bvAVFzi66J345CxI2gig+0O0v7Ps2IOJAIxtRR
	 WMBwsvsf3/0thsL0DJJ4Fhbjt3SEKufNYnn0BUHiYsZqoRobi9YOt3ljmNhTAR8Nly
	 G6lr1eTxFs4gIq1/j1R8KMODsuQnwLS/R8az2W4K0rUbdG+IiSs4xb6h17pa91FX3U
	 hbjfu+zD4/vlg==
Date: Wed, 17 Dec 2025 08:00:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] perf script: Display
 PERF_RECORD_CALLCHAIN_DEFERRED
Message-ID: <aULTgNTtO2z1Gc70@google.com>
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-5-namhyung@kernel.org>
 <9fe12698-2fd5-41fe-8505-735d73eae0a2@linux.ibm.com>
 <aUDkpsW-WH3IPIhh@google.com>
 <024b7bb4-731e-4da4-8480-4789f5912977@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <024b7bb4-731e-4da4-8480-4789f5912977@linux.ibm.com>

Hello!

On Tue, Dec 16, 2025 at 10:29:28AM +0100, Jens Remus wrote:
> Hello Namhyung!
> 
> On 12/16/2025 5:48 AM, Namhyung Kim wrote:
> > On Fri, Dec 12, 2025 at 01:11:38PM +0100, Jens Remus wrote:
> 
> >> following is an observation from my attempt to enable unwind user fp on
> >> s390 using s390 back chain instead of frame pointer and relaxing the
> >> s390-specific IP validation check.
> >>
> >> When capturing call graphs of a Java application the list of "unwound"
> >> user space IPs may contain invalid entries, such as 0x0, 0xdeaddeaf,
> >> and 0xffffffffffffff.  IPs that exceed PERF_CONTEXT_MAX, such as the
> >> latter, cause perf not to display any deferred (or merged) call chain.
> >> Note that this is not caused by your patch series.
> > 
> > Right, it's not a real IP so perf ABI treats them as a magic context.
> > 
> >>
> >> While re-adding the s390-specific IP checks would "hide" those, I found
> >> that the call graphs look good otherwise.  That is the back chain seems
> >> to be intact.  It is just the user space application (e.g. Java JRE) not
> >> correctly adhering to the ABI and saving the return address to the
> >> specified location on the stack, causing bogus IPs to be reported.
> >>
> >> Could perf be improved to handle those user space IPs that exceed
> >> PERF_CONTEXT_MAX?
> > 
> > Ideally we should not have them in the first place.  Is it a JRE issue
> > or your s390 unwinder issue?  Is it possible to ignore them in the
> > unwinder?
> 
> Stack tracing using frame pointer is virtually impossible on s390, as
> the ABI does not designate a specific register as FP register, does not
> specify a fixed register save area layout, nor does mandate a FP to be
> setup early.  Compilers usually setup a FP late, that is after static
> stack allocation.
> 
> An alternative is the s390-specific back chain, which is basically a
> frame pointer on stack.  The ABI specifics that *(SP+0) has the pointer
> to the previous frame and *(BC-48) has the return address (RA), if a
> back chain is used (e.g. compiler option -mbackchain is used).  This is
> why I implemented unwind user fp on s390 using back chain.  Note that
> the back chain can be correctly followed, even if the saved RAs are
> bogus.  That is what can be observed in case of this specific Java JRE.
> Apparently it correctly maintains the back chain stack slot, but does
> not correctly maintain the RA stack slot.  So the RA stack save slot may
> contain any random value.

Thanks for the explanation.

> 
> The s390-implementation of unwind user fp could check whether the return
> address is a valid IP.  This is how it is implemented in the existing
> stack tracer in arch/s390/kernel/stacktrace.c:
> 
> static inline bool ip_invalid(unsigned long ip)
> {
> 	/* ABI requires IPs to be 2-byte aligned */
> 	if (ip & 1)
> 		return true;
> 	if (ip < mmap_min_addr)
> 		return true;
> 	if (ip >= current->mm->context.asce_limit)
> 		return true;
> 	return false;
> }
> 
> It could then either stop or return some magic value
> (e.g. PERF_CONTEXT_MAX - 1) to indicate that the IP is invalid and
> continue.  Actually I would prefer to continue so that a user an see
> that there is something odd with the stack trace.

Agreed.

> 
> Alternatively such a check could possibly also be implemented in the
> common undwind user, if the address space limits are known in common
> code, or as an architecture-specific hook.  In general I tend to at
> least add a check whether the IP is zero, as this is used on several
> architectures as indication for outermost frames (usually in
> combination with a FP of zero).

Not sure about the address space limits across archs.  It'd be easier if
the kernel returns any invalid value like PERF_CONTEXT_MAX - 1 or simply
0. :)

> 
> >>
> >> Is there otherwise guidance how unwind user and/or the s390
> >> implementation should deal with such IPs?  Should it stop taking the
> >> deferred calltrace?  Should it substitute those with e.g 0, so that
> >> perf can display them?
> 
> 
> >> Sample for IP == ffffffffffffff (perf does not display any call chain):
> ...
> >> # perf report -D
> >> ...
> >> 44004346257 0x17718 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 1082/1084: 0x3ffa3e413aa period: 1001001 addr: 0
> >> ... FP chain: nr:2
> >> .....  0: fffffffffffffd80
> >> .....  1: 0000000400000079
> >> ...... (deferred)
> >>  ... thread: java:1084
> >>  ...... dso: /tmp/perf-1082.map
> >>
> >> 0x17758@perf.data [0xd0]: event: 22
> >> .
> >> . ... raw event: size 208 bytes
> ...
> >>
> >> 44004348864 0x17758 [0xd0]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 1082/1084: 0x400000079
> >> ... FP chain: nr:21
> >> .....  0: 000003ffa3e413aa
> >> .....  1: 000003ff3809e2d0
> >> .....  2: 000003ff3809e130
> >> .....  3: 000003ffb95fdf68
> >> .....  4: 0000000000000000
> >> .....  5: 000003ffb95fe128
> >> .....  6: 000003ffb95fe1d0
> >> .....  7: 005780888e7647a5
> >> .....  8: 000003ffa3e437f2
> >> .....  9: ffffffffffffffff <-- !
> >> ..... 10: 000003ffa3e4a1fc
> >> ..... 11: 0000000000000000
> >> ..... 12: 000003ffa3e37900
> >> ..... 13: 000003ffa3e41080
> >> ..... 14: 000003ffb9dd11de
> >> ..... 15: 000003ffb9e8df92
> >> ..... 16: 000003ffb9e90e86
> >> ..... 17: 000003ffbab8b07e
> >> ..... 18: 000003ffbab8e040
> >> ..... 19: 000003ffba8abbd8
> >> ..... 20: 000003ffba92b950
> >> : unhandled!
> >>
> >> ...
> >> [next entry]
> >>
> >>
> >> On 11/21/2025 12:48 AM, Namhyung Kim wrote:
> 
> >>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >>
> >>> +static int process_deferred_sample_event(const struct perf_tool *tool,
> >>> +					 union perf_event *event,
> >>> +					 struct perf_sample *sample,
> >>> +					 struct evsel *evsel,
> >>> +					 struct machine *machine)
> >>> +{
> >>
> >>> +	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
> >>> +				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
> >>> +	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
> >>> +		(unsigned long long)event->callchain_deferred.cookie);
> >>> +
> >>> +	if (PRINT_FIELD(IP)) {
> >>> +		struct callchain_cursor *cursor = NULL;
> >>> +
> >>> +		if (symbol_conf.use_callchain && sample->callchain) {
> >>> +			cursor = get_tls_callchain_cursor();
> >>> +			if (thread__resolve_callchain(al.thread, cursor, evsel,
> >>> +						      sample, NULL, NULL,
> >>> +						      scripting_max_stack)) {
> >>
> >> thread__resolve_callchain()
> >> calls __thread__resolve_callchain()
> >> calls thread__resolve_callchain_sample():
> >>
> >>         for (i = first_call, nr_entries = 0;
> >>              i < chain_nr && nr_entries < max_stack; i++) {
> >> ...
> >>                 ip = chain->ips[j];
> >>                 if (ip < PERF_CONTEXT_MAX)   <-- IP=ff..ff is greater than PERF_CONTEXT_MAX
> >>                        ++nr_entries;
> > 
> > Right.
> > 
> >> ...
> >>                 err = add_callchain_ip(thread, cursor, parent,
> >>                                        root_al, &cpumode, ip,
> >>                                        false, NULL, NULL, 0, symbols);
> >>
> >>                 if (err)
> >>                         return (err < 0) ? err : 0;
> >>
> >> calls add_callchain_ip:
> >>
> >>                if (ip >= PERF_CONTEXT_MAX) {
> >>                        switch (ip) {
> >>                        case PERF_CONTEXT_HV:
> >>                                *cpumode = PERF_RECORD_MISC_HYPERVISOR;
> >>                                break;
> >>                        case PERF_CONTEXT_KERNEL:
> >>                                *cpumode = PERF_RECORD_MISC_KERNEL;
> >>                                break;
> >>                        case PERF_CONTEXT_USER:
> >>                        case PERF_CONTEXT_USER_DEFERRED:
> >>                                *cpumode = PERF_RECORD_MISC_USER;
> >>                                break;
> >>                        default:
> >>                                pr_debug("invalid callchain context: "  <-- IP=ff..ff reaches default case
> >>                                         "%"PRId64"\n", (s64) ip);
> > 
> > We may skip -1 if it's Java and *cpumode is already USER and it's s390.
> > But I'd like to understand the situation first.
> 
> Let's better not add any weird architecture-specific handling.  This is
> also not limited to -1 (and 0), as Java may have used the stack save
> area in any way, so it may be any random value.

I see.  Thanks again for your explanation.

Namhyung

> 
> >>                                /*
> >>                                 * It seems the callchain is corrupted.
> >>                                 * Discard all.
> >>                                 */
> >>                                callchain_cursor_reset(cursor);
> >>                                err = 1;
> >>                                goto out;
> >>                        }
> >>
> >>> +				pr_info("cannot resolve deferred callchains\n");
> >>> +				cursor = NULL;
> >>> +			}
> >>> +		}
> >>> +
> >>> +		fputc(cursor ? '\n' : ' ', fp);
> >>> +		sample__fprintf_sym(sample, &al, 0, output[type].print_ip_opts,
> >>> +				    cursor, symbol_conf.bt_stop_list, fp);
> >>> +	}
> 
> Thanks and regards,
> Jens
> -- 
> Jens Remus
> Linux on Z Development (D3303)
> +49-7031-16-1128 Office
> jremus@de.ibm.com
> 
> IBM
> 
> IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
> IBM Data Privacy Statement: https://www.ibm.com/privacy/
> 

