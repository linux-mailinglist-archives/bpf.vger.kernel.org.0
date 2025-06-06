Return-Path: <bpf+bounces-59921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A41AD08DF
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169473B0C97
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98E21770D;
	Fri,  6 Jun 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIRFdNx1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDE1A08A6;
	Fri,  6 Jun 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240082; cv=none; b=OXMHUicJHlNzQMvT3FsyeZAGQlFQL3x2VbUUyd9UTwQq8e3QEiBkK1wOhahl052263CzthWWSEqEOEKnKosjPsNepYP/F2jG/jXhKeYGJDcKD7rWNSJJOiGlEVszLr1Y1x5BKuPho0N8DA1gIGv6MMzqtFEHkWSQovvQbLLI938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240082; c=relaxed/simple;
	bh=Sp4TNaHObF2aJO/x8zKPUqwQR3sTUTk9f8QtmlJIzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu4s6XMyy52Gb6vMKwuaWvN0WpdqvOya3Uz5F/vV/xAEgZAkoFK1V4BDnpyiauAzOx4sVCWKcFo2gcyC3H4aEeqD5mjggdptujyhBU9yoaWNPuCO3U20OFReCuB785NHx735BjrVRf6s8/rbszTXgBuryWuiuCukJzImBxUxDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIRFdNx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF4C4CEEB;
	Fri,  6 Jun 2025 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240081;
	bh=Sp4TNaHObF2aJO/x8zKPUqwQR3sTUTk9f8QtmlJIzoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIRFdNx1ZYWYPVJyYIZpkuh7pWg8MtiUcN3BFkZ/Af173WuQj0eoodHwq0pOEBpo1
	 DEtOPZ/xdS43nB59ej7ohAMpcn39hVQSNu8T77g2LiBqXwPXw9Vhj8fiEVq4+xq17v
	 sSEpTUI3lIwdNxgMVJL/gC/MQ1BTbJm8EMbY1x9YL2byDNIgHEDYbSIjuUd9ulS9/X
	 mQWC5ZFqwXcm4L2k/mqJ+rUXsbcSDV1sGP4sRESpiCXFnQxJMTyWcZ61VFXOY/6FDM
	 CUQ216bnUeh+1M/ODIIIsByiv46gMShKdyvRjmid07C7RAHQNmpTbK+pf1bjjH/89A
	 7IMIOvtr56Erw==
Date: Fri, 6 Jun 2025 13:01:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>,
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 03/10] perf parse-events: Add parse_uid_filter helper
Message-ID: <aENJDpD7QhqURQzz@google.com>
References: <20250604174545.2853620-1-irogers@google.com>
 <20250604174545.2853620-4-irogers@google.com>
 <aEMoSj0kmWo9LEaF@google.com>
 <CAP-5=fWDaJwC6uzkbmcT1tD1jOuPT8rNEaAuO+MSq6X8BH7shw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWDaJwC6uzkbmcT1tD1jOuPT8rNEaAuO+MSq6X8BH7shw@mail.gmail.com>

On Fri, Jun 06, 2025 at 11:13:10AM -0700, Ian Rogers wrote:
> On Fri, Jun 6, 2025 at 10:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jun 04, 2025 at 10:45:37AM -0700, Ian Rogers wrote:
> > > Add parse_uid_filter filter as a helper to parse_filter, that
> > > constructs a uid filter string. As uid filters don't work with
> > > tracepoint filters, add a is_possible_tp_filter function so the
> > > tracepoint filter isn't attempted for tracepoint evsels.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events.c | 33 ++++++++++++++++++++++++++++++++-
> > >  tools/perf/util/parse-events.h |  1 +
> > >  2 files changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index d96adf23dc94..7f34e602fc08 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -25,6 +25,7 @@
> > >  #include "pmu.h"
> > >  #include "pmus.h"
> > >  #include "asm/bug.h"
> > > +#include "ui/ui.h"
> > >  #include "util/parse-branch-options.h"
> > >  #include "util/evsel_config.h"
> > >  #include "util/event.h"
> > > @@ -2561,6 +2562,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
> > >       return 0;
> > >  }
> > >
> > > +/* Will a tracepoint filter work for str or should a BPF filter be used? */
> > > +static bool is_possible_tp_filter(const char *str)
> > > +{
> > > +     return strstr(str, "uid") == NULL;
> > > +}
> > > +
> > >  static int set_filter(struct evsel *evsel, const void *arg)
> > >  {
> > >       const char *str = arg;
> > > @@ -2573,7 +2580,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
> > >               return -1;
> > >       }
> > >
> > > -     if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
> > > +     if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
> > >               if (evsel__append_tp_filter(evsel, str) < 0) {
> > >                       fprintf(stderr,
> > >                               "not enough memory to hold filter string\n");
> > > @@ -2609,6 +2616,30 @@ int parse_filter(const struct option *opt, const char *str,
> > >                                         (const void *)str);
> > >  }
> > >
> > > +int parse_uid_filter(struct evlist *evlist, uid_t uid)
> >
> > It failed to build on alpine 3.18.
> >
> > util/parse-events.h:48:45: error: unknown type name 'uid_t'
> >    48 | int parse_uid_filter(struct evlist *evlist, uid_t uid);
> >       |                                             ^~~~~
> >
> > I'll add this.
> 
> Thanks Namhyung! I see this in tmp.perf-tools-next so I'll assume
> there's no need for a v5.

Right, I've updated the branch with the fix.

Thanks,
Namhyung


