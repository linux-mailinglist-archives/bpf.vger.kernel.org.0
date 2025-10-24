Return-Path: <bpf+bounces-72094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF074C06657
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57043AA006
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39331A7F4;
	Fri, 24 Oct 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ueTMeeYE"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378032AE8E;
	Fri, 24 Oct 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310933; cv=none; b=olj7lTAqW1JPe8I6cnZ4e2Pnb16hxBW/3s7IlYnubRuspuIFL0zMEwi6XRREHDGLY+Ab/YfMjIeAe0ts8tHM9p0aY2/0M4z9ICzA3WW5UzZMgkSSdgPmlBRIt7pswcgIUmDjpSXI0M1OMt1vBdn3jDT/IKFNQgu/oZ/WU1d7bkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310933; c=relaxed/simple;
	bh=sWNapAQdiDgKyOmK1F9SQowPxHMep3JI7SQBHBeWmUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnLSpXiYFYrAoib9ZU2ZvGfbg1AQ4QwFLOGWAmcdgReMV1mzFbdnmP4Pdq0d3CpqYDF0SGvuYGAMZ0cG5NTLeOJ0yUTdpxqM/6h1J/PjEfrT9wBj4OKPOGXAJgYnY0Cg+g6TsXlQzzX/gmdhGhEoCfR6qF/M0dZM/7UKCkg5TEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ueTMeeYE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KIzxo1I8zroSVihAvyvbWPNv07jZePh2BUEf0mtEhks=; b=ueTMeeYEqebx8NRI0fTJD7ctYh
	N6dJVOJoczHU3Z6e9VjrXI3DEYHcV4zcaAefAyyP6gSUzQlGP+oWEj3fF5wjFPqo47yrw3+P8SV2p
	Ti9cS+SF1Iz+a2DW5GcukXJz7DQpyLVLKF8aEdcZdMozYStgnLh0jZ/2LozhRyTFaR4I/F7UiHCoj
	A3NH8qjpKbOhIShkU8EilPT4wThJmBhVXlHuvRUTAuTOZ/bDcMHNr2pXkEUZ45MtOd5Sx8lrQV3uf
	0c4M4COHxaYNRCsBoGtWuyGyONk1udDbE4D2Ey39PhpdPTetzHHu1mgX8Mf6+oTsDfwQcyDzIbrEr
	TIm3oygA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHQg-00000000sUc-1NtR;
	Fri, 24 Oct 2025 13:02:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2745C300323; Fri, 24 Oct 2025 15:02:03 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:02:03 +0200
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
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
Message-ID: <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
References: <20250908175319.841517121@kernel.org>
 <20250908175430.639412649@kernel.org>
 <20251002134938.756db4ef@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002134938.756db4ef@gandalf.local.home>

On Thu, Oct 02, 2025 at 01:49:38PM -0400, Steven Rostedt wrote:
> On Mon, 08 Sep 2025 13:53:23 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> > +					    const struct perf_tool *tool,
> > +					    union  perf_event *event,
> > +					    struct perf_sample *sample,
> > +					    struct machine *machine)
> > +{
> > +	struct deferred_event *de, *tmp;
> > +	struct evsel *evsel;
> > +	int ret = 0;
> > +
> > +	if (!tool->merge_deferred_callchains) {
> > +		evsel = evlist__id2evsel(evlist, sample->id);
> > +		return tool->callchain_deferred(tool, event, sample,
> > +						evsel, machine);
> > +	}
> > +
> > +	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> > +		struct perf_sample orig_sample;
> 
> orig_sample is not initialized and can then contain junk.
> 
> > +
> > +		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
> > +		if (ret < 0) {
> > +			pr_err("failed to parse original sample\n");
> > +			break;
> > +		}
> > +
> > +		if (sample->tid != orig_sample.tid)
> > +			continue;
> > +
> > +		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
> > +			sample__merge_deferred_callchain(&orig_sample, sample);
> 
> The sample__merge_deferred_callchain() initializes both
> orig_sample.deferred_callchain and the callchain. But now that it's not
> being called, it can cause the below free to happen with junk as the
> callchain. This needs:
> 
> 		else
> 			orig_sample.deferred_callchain = false;

Ah, so I saw crashes from here and just deleted both free()s and got on
with things ;-)

> > +
> > +		evsel = evlist__id2evsel(evlist, orig_sample.id);
> > +		ret = evlist__deliver_sample(evlist, tool, de->event,
> > +					     &orig_sample, evsel,> machine); +
> > +		if (orig_sample.deferred_callchain)
> > +			free(orig_sample.callchain);
> > +
> > +		list_del(&de->list);
> > +		free(de);
> > +
> > +		if (ret)
> > +			break;
> > +	}
> > +	return ret;
> > +}
> 
> -- Steve

