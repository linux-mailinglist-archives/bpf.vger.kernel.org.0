Return-Path: <bpf+bounces-74548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B870C5EFC7
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6825D3AFF52
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E80C2E7647;
	Fri, 14 Nov 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXWGyI0D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F10299A85;
	Fri, 14 Nov 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147243; cv=none; b=kUAkOMVSexzSWi5IwW4BstLgX4ftnmQ0eXC/wT9N6NvGOjgSZgrf5lfo95OMP+W834vmE41J9IZAHL3G/5WGFWaf6B6aiqKn3amF3ibasG6/oWcVIlKhqOM/JfhouYYPAstFTipcD0/Tq/3fM8hbQQfyRjQb8my/AsgZHJK/YP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147243; c=relaxed/simple;
	bh=T+6m79C1S+qXKvbd8TIafPQij3gEVwY7boGCZm9bvEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+Jobv0Sje2/5oWLoMTfdinAU2ZJ2xZ0ec4j/cGZP3CJYkAhBVMbT90K2zs/U48kZlqJbR3cLRJsVg//Ph6YkOUS9ikozeR1gSST77L1bXaIerenAMwUxhMYvMio0+U2z9C4D13IrqSqC48boqigE4Iaj9bfcb0WWZpFbRygWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXWGyI0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74813C19425;
	Fri, 14 Nov 2025 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763147243;
	bh=T+6m79C1S+qXKvbd8TIafPQij3gEVwY7boGCZm9bvEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXWGyI0D6uUean14VZhXESSeZSO5Ep42W1SS2MLi9x9MtRlqyuSzHrp3Yqh5XhkuY
	 P1+rQx1xeGIJ19coVzan6eKBm0efl3pC/7uicHO/uR/U+ho0z2ofoZYasIRJbfjlJA
	 aPnfWR9y1qt/phSI3esM+2J4cF8Bug5Wue3En/4B8bmCpYqXE1ZSnDRsVePnaKcPRG
	 WLC4Thp0wQ+Qm4W5BRsn/adamRp/ePAeQvGc8zGmyafyoQtJCKi6Z77PEbqxuxD/IH
	 cBTPs1r7w9VJGOpZMnKgN6gScjCFuGIaWfyf4PdUfoqZDhDF6SGqmDM3cZNWe2z1d3
	 +WCSkU+8qzldw==
Date: Fri, 14 Nov 2025 11:07:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/5] perf tools: Minimal DEFERRED_CALLCHAIN support
Message-ID: <aRd96Ue-k9z_hC2K@google.com>
References: <20251114070018.160330-1-namhyung@kernel.org>
 <20251114070018.160330-3-namhyung@kernel.org>
 <CAP-5=fVrpBjsJ7=BZQmhXKcaN+OYTY5_gOVj-Qs+33cH0gft7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVrpBjsJ7=BZQmhXKcaN+OYTY5_gOVj-Qs+33cH0gft7Q@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:52:41AM -0800, Ian Rogers wrote:
> On Thu, Nov 13, 2025 at 11:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a new event type for deferred callchains and a new callback for the
> > struct perf_tool.  For now it doesn't actually handle the deferred
> > callchains but it just marks the sample if it has the PERF_CONTEXT_
> > USER_DEFFERED in the callchain array.
> >
> > At least, perf report can dump the raw data with this change.  Actually
> > this requires the next commit to enable attr.defer_callchain, but if you
> > already have a data file, it'll show the following result.
> >
> >   $ perf report -D
> >   ...
> >   0x2158@perf.data [0x40]: event: 22
> >   .
> >   . ... raw event: size 64 bytes
> >   .  0000:  16 00 00 00 02 00 40 00 06 00 00 00 0b 00 00 00  ......@.........
> >   .  0010:  03 00 00 00 00 00 00 00 a7 7f 33 fe 18 7f 00 00  ..........3.....
> >   .  0020:  0f 0e 33 fe 18 7f 00 00 48 14 33 fe 18 7f 00 00  ..3.....H.3.....
> >   .  0030:  08 09 00 00 08 09 00 00 e6 7a e7 35 1c 00 00 00  .........z.5....
> >
> >   121163447014 0x2158 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 2312/2312: 0xb00000006
> >   ... FP chain: nr:3
> >   .....  0: 00007f18fe337fa7
> >   .....  1: 00007f18fe330e0f
> >   .....  2: 00007f18fe331448
> >   : unhandled!
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/include/perf/event.h       |  8 ++++++++
> >  tools/perf/util/event.c                   |  1 +
> >  tools/perf/util/evsel.c                   | 19 +++++++++++++++++++
> >  tools/perf/util/machine.c                 |  1 +
> >  tools/perf/util/perf_event_attr_fprintf.c |  2 ++
> >  tools/perf/util/sample.h                  |  2 ++
> >  tools/perf/util/session.c                 | 20 ++++++++++++++++++++
> >  tools/perf/util/tool.c                    |  1 +
> >  tools/perf/util/tool.h                    |  3 ++-
> >  9 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index aa1e91c97a226e1a..769bc48ca85c0eb8 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -151,6 +151,13 @@ struct perf_record_switch {
> >         __u32                    next_prev_tid;
> >  };
> >
> > +struct perf_record_callchain_deferred {
> > +       struct perf_event_header header;
> > +       __u64                    cookie;
> 
> Could we add a comment that this value is used to match user and
> kernel stack traces together? I don't believe that intent is
> immediately obvious from the word "cookie".

Sounds good, will add.

> 
> > +       __u64                    nr;
> > +       __u64                    ips[];
> > +};
> > +
> >  struct perf_record_header_attr {
> >         struct perf_event_header header;
> >         struct perf_event_attr   attr;
> > @@ -523,6 +530,7 @@ union perf_event {
> >         struct perf_record_read                 read;
> >         struct perf_record_throttle             throttle;
> >         struct perf_record_sample               sample;
> > +       struct perf_record_callchain_deferred   callchain_deferred;
> >         struct perf_record_bpf_event            bpf;
> >         struct perf_record_ksymbol              ksymbol;
> >         struct perf_record_text_poke_event      text_poke;
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index fcf44149feb20c35..4c92cc1a952c1d9f 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -61,6 +61,7 @@ static const char *perf_event__names[] = {
> >         [PERF_RECORD_CGROUP]                    = "CGROUP",
> >         [PERF_RECORD_TEXT_POKE]                 = "TEXT_POKE",
> >         [PERF_RECORD_AUX_OUTPUT_HW_ID]          = "AUX_OUTPUT_HW_ID",
> > +       [PERF_RECORD_CALLCHAIN_DEFERRED]        = "CALLCHAIN_DEFERRED",
> >         [PERF_RECORD_HEADER_ATTR]               = "ATTR",
> >         [PERF_RECORD_HEADER_EVENT_TYPE]         = "EVENT_TYPE",
> >         [PERF_RECORD_HEADER_TRACING_DATA]       = "TRACING_DATA",
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 989c56d4a23f74f4..244b3e44d090d413 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3089,6 +3089,20 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >         data->data_src = PERF_MEM_DATA_SRC_NONE;
> >         data->vcpu = -1;
> >
> > +       if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
> > +               const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
> > +
> > +               data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
> > +               if (data->callchain->nr > max_callchain_nr)
> > +                       return -EFAULT;
> > +
> > +               data->deferred_cookie = event->callchain_deferred.cookie;
> > +
> > +               if (evsel->core.attr.sample_id_all)
> > +                       perf_evsel__parse_id_sample(evsel, event, data);
> > +               return 0;
> > +       }
> > +
> >         if (event->header.type != PERF_RECORD_SAMPLE) {
> >                 if (!evsel->core.attr.sample_id_all)
> >                         return 0;
> > @@ -3219,6 +3233,11 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >                 if (data->callchain->nr > max_callchain_nr)
> >                         return -EFAULT;
> >                 sz = data->callchain->nr * sizeof(u64);
> > +               if (evsel->core.attr.defer_callchain && data->callchain->nr >= 2 &&
> > +                   data->callchain->ips[data->callchain->nr - 2] == PERF_CONTEXT_USER_DEFERRED) {
> > +                       data->deferred_cookie = data->callchain->ips[data->callchain->nr - 1];
> > +                       data->deferred_callchain = true;
> > +               }
> 
> It'd be nice to have a comment saying what is going on here. I can see
> that if there are 2 stack slots and the 2nd is a magic value then the
> first should be read as the "cookie". At a first look this code is
> difficult to parse so a comment would add value.

Will add the comment.

Thanks,
Namhyung

 
> >                 OVERFLOW_CHECK(array, sz, max_size);
> >                 array = (void *)array + sz;
> >         }

