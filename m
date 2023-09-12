Return-Path: <bpf+bounces-9788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05379DA3A
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5009E281DB0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594BDAD5E;
	Tue, 12 Sep 2023 20:47:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA39470
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 20:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FB2C433C8;
	Tue, 12 Sep 2023 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694551654;
	bh=VVtwekb5c6SImWXWuWHyxmTmEMM/b8uhPzUHF1OjzCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXIi5uB6dxKea+sfVj3+f4RSYhz+XDKjyaolBDqisWYnrhdI6gscakENj8CqP0ctz
	 dVqb4WMM9VNUw1dTSdlUkgiGHfi7P+ULq+d0FwJR26/6tBzoWEYvl0D+LBIxp3G7f4
	 3na3pQPfOdbhy2OzuJxmbPImk4/Hk2cgkKA884wBLkvBak2xddo/qu1I6IPuiqmnjM
	 Htih/LU9503YfJB81p2fi9xtWsB3n1fjk/dKxmQilO7bhhU4rZ4jEYnYEF59BnF5Xb
	 z+pKjaCYQKJXo83UczMwh9cfWLWydcWgHmxsqucARU6xKDJyWk5QVD+YOGzlu+cml9
	 sH66xoj/BpGrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id AC4D2403F4; Tue, 12 Sep 2023 17:47:31 -0300 (-03)
Date: Tue, 12 Sep 2023 17:47:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/5] perf parse-events: Remove unused header files
Message-ID: <ZQDOY1z5dEGhpFDM@kernel.org>
References: <20230911170559.4037734-1-irogers@google.com>
 <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg4nc5rpW9jL-RPJP7w4Rg8h7t4A-EkHTE9rWF=Nm6bBQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Sep 11, 2023 at 10:58:18PM -0700, Namhyung Kim escreveu:
> On Mon, Sep 11, 2023 at 10:06 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The fnmatch header is now used in the PMU matching logic in pmu.c.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>



Thanks, applied the series.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/util/parse-events.y | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 21bfe7e0d944..ef03728b7ea3 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -9,11 +9,8 @@
> >  #define YYDEBUG 1
> >
> >  #include <errno.h>
> > -#include <fnmatch.h>
> > -#include <stdio.h>
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > -#include <linux/zalloc.h>
> >  #include "pmu.h"
> >  #include "pmus.h"
> >  #include "evsel.h"
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

-- 

- Arnaldo

