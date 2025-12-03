Return-Path: <bpf+bounces-75933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64CC9D61E
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 01:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A03D3A9635
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E32AC17;
	Wed,  3 Dec 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwqPV71+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07C36D4EC;
	Wed,  3 Dec 2025 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764720102; cv=none; b=JB5ISHrs4eTy8prM8upU7y08gDCYc/BJtFWy1YGOrat80DtO+JD2pXyEE3Oxzex6sc4hd9wllMy0YA98xzEupKgmkhtxuzeVcl39NZT/ebdsFicW3NwmDTZE00njBZPFw8JlaCCEWgU5N8EjZO6AaJyVh03HpGriBTa6eQJOqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764720102; c=relaxed/simple;
	bh=yt2dmbYs+Z7tHAiBz+WK3bg9EVIZKUbEQYiUbaOzt58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAOLXNgS7cwSGqyGAq0pGnSfM4V8eGR5wvPH8cUe7HApCQ/k0CEPuLTx+GnGrjXW9sQQIFT5QIGV+cyRLnuWtRIyzrmpFxO6R2yTYMGsp2sZsfzNmmIb7yR4pFHvl1jznIOGqBtHXl8kl971JXalggYW6w1Q9iNGmJifrZErSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwqPV71+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C9C4CEF1;
	Wed,  3 Dec 2025 00:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764720101;
	bh=yt2dmbYs+Z7tHAiBz+WK3bg9EVIZKUbEQYiUbaOzt58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwqPV71+1oBkhUFc5MV1PMnNLSaXtrTCLPwS/isqTr7vzpmRTHooFaInuWZU/1+BA
	 PtTrzvsxNkoNcrVFON4pZqMEVotMzBPNkM/eqqZg1FTOsJ3/6gNufUQ6a87fYtrvT5
	 +OOnS/46jxIBPIMW21ERuDmUldmiBq4T/ZhxDrHerFLUwg+ZVyXn49vCaAkNcdmez2
	 OX4qm81zg/1tvzTAR/0yjspNTM6MUS474vXLMltBwiKZ7uZ0jAqjv8zAIWCboFrcD/
	 Zwf1Hz9K3KALESDLGk7PjAdABeDAMS+g+fzl3Lw4OsRk6UDxZ9lj5EoJZ814xMiJVL
	 WzR/nnUBlOeCg==
Date: Tue, 2 Dec 2025 16:01:38 -0800
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
Subject: Re: [PATCH v6 5/6] perf tools: Merge deferred user callchains
Message-ID: <aS994rls5y5xP1br@google.com>
References: <20251120234804.156340-1-namhyung@kernel.org>
 <20251120234804.156340-6-namhyung@kernel.org>
 <CAP-5=fUVgxHn-oxQNQBJKDo=k8VPXBKA5BkJ5LbUF-UOm9t8Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVgxHn-oxQNQBJKDo=k8VPXBKA5BkJ5LbUF-UOm9t8Xw@mail.gmail.com>

On Tue, Dec 02, 2025 at 03:14:31PM -0800, Ian Rogers wrote:
> On Thu, Nov 20, 2025 at 3:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Save samples with deferred callchains in a separate list and deliver
> > them after merging the user callchains.  If users don't want to merge
> > they can set tool->merge_deferred_callchains to false to prevent the
> > behavior.
> >
> > With previous result, now perf script will show the merged callchains.
> >
> >   $ perf script
> >   ...
> >   pwd    2312   121.163435:     249113 cpu/cycles/P:
> >           ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsyms])
> >           ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
> >           ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
> >           ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
> >           ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
> >           ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
> >           ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
> >               7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >               7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >               7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
> >   ...
> >
> > The old output can be get using --no-merge-callchain option.
> > Also perf report can get the user callchain entry at the end.
> >
> >   $ perf report --no-children --stdio -q -S __build_id_parse.isra.0
> >   # symbol: __build_id_parse.isra.0
> >        8.40%  pwd      [kernel.kallsyms]
> >               |
> >               ---__build_id_parse.isra.0
> >                  perf_event_mmap
> >                  mprotect_fixup
> >                  do_mprotect_pkey
> >                  __x64_sys_mprotect
> >                  do_syscall_64
> >                  entry_SYSCALL_64_after_hwframe
> >                  mprotect
> >                  _dl_sysdep_start
> >                  _dl_start_user
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> > ---
> >  tools/perf/Documentation/perf-script.txt |  5 ++
> >  tools/perf/builtin-inject.c              |  1 +
> >  tools/perf/builtin-report.c              |  1 +
> >  tools/perf/builtin-script.c              |  4 ++
> >  tools/perf/util/callchain.c              | 29 +++++++++
> >  tools/perf/util/callchain.h              |  3 +
> >  tools/perf/util/evlist.c                 |  1 +
> >  tools/perf/util/evlist.h                 |  2 +
> >  tools/perf/util/session.c                | 79 +++++++++++++++++++++++-
> >  tools/perf/util/tool.c                   |  2 +
> >  tools/perf/util/tool.h                   |  1 +
> >  11 files changed, 127 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index 28bec7e78bc858ba..03d1129606328d6d 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -527,6 +527,11 @@ include::itrace.txt[]
> >         The known limitations include exception handing such as
> >         setjmp/longjmp will have calls/returns not match.
> >
> > +--merge-callchains::
> > +       Enable merging deferred user callchains if available.  This is the
> > +       default behavior.  If you want to see separate CALLCHAIN_DEFERRED
> > +       records for some reason, use --no-merge-callchains explicitly.
> > +
> >  :GMEXAMPLECMD: script
> >  :GMEXAMPLESUBCMD:
> >  include::guest-files.txt[]
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index bd9245d2dd41aa48..51d2721b6db9dccb 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -2527,6 +2527,7 @@ int cmd_inject(int argc, const char **argv)
> >         inject.tool.auxtrace            = perf_event__repipe_auxtrace;
> >         inject.tool.bpf_metadata        = perf_event__repipe_op2_synth;
> >         inject.tool.dont_split_sample_group = true;
> > +       inject.tool.merge_deferred_callchains = false;
> >         inject.session = __perf_session__new(&data, &inject.tool,
> >                                              /*trace_event_repipe=*/inject.output.is_pipe,
> >                                              /*host_env=*/NULL);
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 2bc269f5fcef8023..add6b1c2aaf04270 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1614,6 +1614,7 @@ int cmd_report(int argc, const char **argv)
> >         report.tool.event_update         = perf_event__process_event_update;
> >         report.tool.feature              = process_feature_event;
> >         report.tool.ordering_requires_timestamps = true;
> > +       report.tool.merge_deferred_callchains = !dump_trace;
> >
> >         session = perf_session__new(&data, &report.tool);
> >         if (IS_ERR(session)) {
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 85b42205a71b3993..62e43d3c5ad731a0 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -4009,6 +4009,7 @@ int cmd_script(int argc, const char **argv)
> >         bool header_only = false;
> >         bool script_started = false;
> >         bool unsorted_dump = false;
> > +       bool merge_deferred_callchains = true;
> >         char *rec_script_path = NULL;
> >         char *rep_script_path = NULL;
> >         struct perf_session *session;
> > @@ -4162,6 +4163,8 @@ int cmd_script(int argc, const char **argv)
> >                     "Guest code can be found in hypervisor process"),
> >         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
> >                     "Enable LBR callgraph stitching approach"),
> > +       OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
> > +                   "Enable merge deferred user callchains"),
> >         OPTS_EVSWITCH(&script.evswitch),
> >         OPT_END()
> >         };
> > @@ -4418,6 +4421,7 @@ int cmd_script(int argc, const char **argv)
> >         script.tool.throttle             = process_throttle_event;
> >         script.tool.unthrottle           = process_throttle_event;
> >         script.tool.ordering_requires_timestamps = true;
> > +       script.tool.merge_deferred_callchains = merge_deferred_callchains;
> >         session = perf_session__new(&data, &script.tool);
> >         if (IS_ERR(session))
> >                 return PTR_ERR(session);
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 2884187ccbbecfdc..71dc5a070065dd2a 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1838,3 +1838,32 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
> >         }
> >         return 0;
> >  }
> > +
> > +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> 
> nit: We use the term deferred rather than original except in this
> context. I think deferred is a little more intention revealing than
> original. Perhaps add a comment capturing that the original sample is
> the deferred kernel sample.

Sure, will add.

Thanks,
Namhyung


