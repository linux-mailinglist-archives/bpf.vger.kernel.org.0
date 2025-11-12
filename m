Return-Path: <bpf+bounces-74335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB77C54BB1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7164B4E4C26
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A62EC0B6;
	Wed, 12 Nov 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTY/Rh8K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214C2EA755;
	Wed, 12 Nov 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987119; cv=none; b=uqiH2podZwTa/mQEtktnFKy5In7hoYUzEHOMuYO48jlIMTufyr+6LBHdQVgfZ1YrEWCDIzAnoFoCjX+LoAayyoDOhna7nlMp2pED8pInoWL+ztHOg86Q9kIdssjfNd6i4J9VzFABTpbSU4Zk0JNN7OoIjAD7HhvzxEPgJ7XgY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987119; c=relaxed/simple;
	bh=o2EQqaZZAsWkT6r39TusYsLK6a8IzHKn3703XsIxWpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8qOjSJlXdNv452/O3+c7Ov8j2LcEYPQi41xPI2NsnxNTaRpMe1mu9C74GfutDvO4BrWCVFgC48/ot5nZdfTWXyIiyKgtAeraaUiqJVKI/eSmMaWJgQ8ccEKIuy6Vz95COQAHb5Bxtb0iBhZEFyZqyGf1oeYKld/BEUDrn5+yQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTY/Rh8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A849C4CEF1;
	Wed, 12 Nov 2025 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987118;
	bh=o2EQqaZZAsWkT6r39TusYsLK6a8IzHKn3703XsIxWpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTY/Rh8KpY36C75hev3BjCBZb7EDXufixbscLxlLsHG9ueTWZLz9RvIRjIs0W7sMY
	 CfW4QMJD3/t1m2IoJqkP9lMlYBdXMyjuMG4ONpEyfwvAg9RTH1udFhHm6hX9zDM52b
	 vyZBzLupt+h9QBFd+9D21T9dNPjCMiznKczjhzE36fxVjLg0yQwW1nPVvuh3SjoudI
	 7DNDpWX5/3NswF/LWKpj9UmCf4uwHFNATj7b71XaZ3QezG/6heLgzBJL+mWWsLEHke
	 sT1/5knwSEb13gskvno39Yvhv7QeU8WrgOKbIWDD+UC+xAcKTfpJO5Yrv6JNZiq7qJ
	 qOAdTkPnBbyZA==
Date: Wed, 12 Nov 2025 14:38:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
Message-ID: <aRUMauhbs_jJ6-3P@google.com>
References: <20250908175319.841517121@kernel.org>
 <20250908175430.639412649@kernel.org>
 <20251002134938.756db4ef@gandalf.local.home>
 <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
 <f543231e-a71c-4600-9cf3-f999ca104d86@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f543231e-a71c-4600-9cf3-f999ca104d86@linux.ibm.com>

Hello,

On Wed, Nov 12, 2025 at 11:05:59AM +0100, Jens Remus wrote:
> Hello Namhyung,
> 
> could you please adapt your patches from this series to Peter's latest
> changes to unwind user and related perf support, especially his new
> version c69993ecdd4d ("perf: Support deferred user unwind") available
> at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

Sure, will take a look.

Thanks,
Namhyung

> 
> On 10/24/2025 3:02 PM, Peter Zijlstra wrote:
> > On Thu, Oct 02, 2025 at 01:49:38PM -0400, Steven Rostedt wrote:
> >> On Mon, 08 Sep 2025 13:53:23 -0400
> >> Steven Rostedt <rostedt@kernel.org> wrote:
> >>
> >>> +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> >>> +					    const struct perf_tool *tool,
> >>> +					    union  perf_event *event,
> >>> +					    struct perf_sample *sample,
> >>> +					    struct machine *machine)
> >>> +{
> >>> +	struct deferred_event *de, *tmp;
> >>> +	struct evsel *evsel;
> >>> +	int ret = 0;
> >>> +
> >>> +	if (!tool->merge_deferred_callchains) {
> >>> +		evsel = evlist__id2evsel(evlist, sample->id);
> >>> +		return tool->callchain_deferred(tool, event, sample,
> >>> +						evsel, machine);
> >>> +	}
> >>> +
> >>> +	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> >>> +		struct perf_sample orig_sample;
> >>
> >> orig_sample is not initialized and can then contain junk.
> >>
> >>> +
> >>> +		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
> >>> +		if (ret < 0) {
> >>> +			pr_err("failed to parse original sample\n");
> >>> +			break;
> >>> +		}
> >>> +
> >>> +		if (sample->tid != orig_sample.tid)
> >>> +			continue;
> >>> +
> >>> +		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
> >>> +			sample__merge_deferred_callchain(&orig_sample, sample);
> >>
> >> The sample__merge_deferred_callchain() initializes both
> >> orig_sample.deferred_callchain and the callchain. But now that it's not
> >> being called, it can cause the below free to happen with junk as the
> >> callchain. This needs:
> >>
> >> 		else
> >> 			orig_sample.deferred_callchain = false;
> > 
> > Ah, so I saw crashes from here and just deleted both free()s and got on
> > with things ;-)
> 
> This needs to be properly resolved.  In the meantime I am using Steven's
> suggestion above to continue my work on unwind user sframe (s390).
> 
> > 
> >>> +
> >>> +		evsel = evlist__id2evsel(evlist, orig_sample.id);
> >>> +		ret = evlist__deliver_sample(evlist, tool, de->event,
> >>> +					     &orig_sample, evsel,> machine); +
> >>> +		if (orig_sample.deferred_callchain)
> >>> +			free(orig_sample.callchain);
> >>> +
> >>> +		list_del(&de->list);
> >>> +		free(de);
> >>> +
> >>> +		if (ret)
> >>> +			break;
> >>> +	}
> >>> +	return ret;
> >>> +}
> >>
> >> -- Steve
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

