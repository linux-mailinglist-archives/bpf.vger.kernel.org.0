Return-Path: <bpf+bounces-74440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C003C5A2F3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 22:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEB33B94AD
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62E324B38;
	Thu, 13 Nov 2025 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG42Nn5x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B13128AE;
	Thu, 13 Nov 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070181; cv=none; b=AoSvnv1xxDdkE+Ilxe4UStNOTDbzSqiS/nJcggpfhMHAkQczyQFsDy0QnV31h7ToBUJnytJohLt9IvEW2ViwWuy1PDKueOY7h2buiU8j2yLB1fHo5ULxyw3ECcNvvWyi/hHOFHxn/XdaZrPRCiAPhzG9bRRPtMdEQddvHhHUjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070181; c=relaxed/simple;
	bh=Sy8fSwsiCqo2MUBArmak9vO3BmeKFB1GLq51Nm5ahBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcMKOkNtMGR+mggB9sLXVmQ2GlEr0DWvzP7+pE0S1sWJEJAvNFHudqsA6RLXH73EGI1ThKsmZfh7vZZ6EEuB6oRIhFpCuKavgVBIl9Z7FIOpuGiVXcZ9zwrIHdGBXbvuQ4fL1rdDvbWgqLgGvhAGYakRVDy1tXxf0A93dj+4SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG42Nn5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D536C16AAE;
	Thu, 13 Nov 2025 21:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763070181;
	bh=Sy8fSwsiCqo2MUBArmak9vO3BmeKFB1GLq51Nm5ahBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WG42Nn5xugxIcRbkicAE1uHbMQehF5xPJaqAPNy6PlDOD9UEHUp4dnBgY8PZJ+INi
	 CiQQF2bn9eNj+KsNQsP4hi0Jt9BMddX7qbZ1k8PLI/khh8Y8yMIy/X8bvJOodeimyz
	 lOsveQQYc3ynBzw2ABMaGp3RM2SyArXIYzE4jaaUUHtVzihlH64HVrXeRDYfuqQs6j
	 b/ZfO6A1+Vr1j39eo9F51h98nGCyukXGDqX+Urb2F2EhYyq5UElf40K0TZG1mmsL6k
	 pydPJzGfC7xXZVt5BrKbg6+uYLOgcObpJKUGIOVYdGJpY2bYab1LuJ2u6No5eEeteE
	 cbjQFRuvdJrBw==
Date: Thu, 13 Nov 2025 13:42:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v16 4/4] perf tools: Merge deferred user callchains
Message-ID: <aRZQ4PMG0zmoF-rQ@google.com>
References: <20250908175319.841517121@kernel.org>
 <20250908175430.639412649@kernel.org>
 <20251002134938.756db4ef@gandalf.local.home>
 <20251024130203.GC3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024130203.GC3245006@noisy.programming.kicks-ass.net>

Hello,

Sorry for the delay.  And I'm happy that the kernel part is merge to the
tip tree! :)

On Fri, Oct 24, 2025 at 03:02:03PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 01:49:38PM -0400, Steven Rostedt wrote:
> > On Mon, 08 Sep 2025 13:53:23 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> > 
> > > +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> > > +					    const struct perf_tool *tool,
> > > +					    union  perf_event *event,
> > > +					    struct perf_sample *sample,
> > > +					    struct machine *machine)
> > > +{
> > > +	struct deferred_event *de, *tmp;
> > > +	struct evsel *evsel;
> > > +	int ret = 0;
> > > +
> > > +	if (!tool->merge_deferred_callchains) {
> > > +		evsel = evlist__id2evsel(evlist, sample->id);
> > > +		return tool->callchain_deferred(tool, event, sample,
> > > +						evsel, machine);
> > > +	}
> > > +
> > > +	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> > > +		struct perf_sample orig_sample;
> > 
> > orig_sample is not initialized and can then contain junk.

Yep.

> > 
> > > +
> > > +		ret = evlist__parse_sample(evlist, de->event, &orig_sample);

But here you call evlist__parse_sample() and evsel__parse_sample() which
should initialize the sample properly.


> > > +		if (ret < 0) {
> > > +			pr_err("failed to parse original sample\n");
> > > +			break;
> > > +		}
> > > +
> > > +		if (sample->tid != orig_sample.tid)
> > > +			continue;
> > > +
> > > +		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
> > > +			sample__merge_deferred_callchain(&orig_sample, sample);
> > 
> > The sample__merge_deferred_callchain() initializes both
> > orig_sample.deferred_callchain and the callchain. But now that it's not
> > being called, it can cause the below free to happen with junk as the
> > callchain. This needs:
> > 
> > 		else
> > 			orig_sample.deferred_callchain = false;
> 
> Ah, so I saw crashes from here and just deleted both free()s and got on
> with things ;-)

I don't understand how it can have the garbage.  But having the else
part would be safer.

Thanks,
Namhyung

> > > +
> > > +		evsel = evlist__id2evsel(evlist, orig_sample.id);
> > > +		ret = evlist__deliver_sample(evlist, tool, de->event,
> > > +					     &orig_sample, evsel,> machine); +
> > > +		if (orig_sample.deferred_callchain)
> > > +			free(orig_sample.callchain);
> > > +
> > > +		list_del(&de->list);
> > > +		free(de);
> > > +
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +	return ret;
> > > +}
> > 
> > -- Steve

