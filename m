Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9303ADA13
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhFSNFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 09:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234109AbhFSNFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Jun 2021 09:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC2246113E;
        Sat, 19 Jun 2021 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624107818;
        bh=J8klIOdPb0WTMekTmGTxcTeRn/X5c92RaU/rKD0XqbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9vyQWxQPOxU2M4dKfPRDgqrUwGgEHxC68MErMaIrYWhkzGnZ7P2KDkXsFFsgtGj4
         074LjSMOdmpMTM3hCuhokgYgQ+RPT6HsLC7bQOd2kTyKT/7EJ3oLViU9oKVOcUrfRY
         1xz08bbjqXEDDWojvfDAjdOHBVHgufhfTAZaO0pyOEAlQLAvgN4Nih3dDqtdUArPQy
         2eK7C8/C1cIry2kYM0sAlNjfRZ6HziO2fCfZSefRVmuwljLeLxI/mnLakzt2j0QSK8
         n8ivNE7VTIq4CyrMxdjOrrSb8cghNWoV5hMQQIgshYel4ftvHKujOT+xU4DM9YfLN/
         tyeejiLLZ2V/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3616740B1A; Sat, 19 Jun 2021 10:03:36 -0300 (-03)
Date:   Sat, 19 Jun 2021 10:03:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] perf test: Pass the verbose option to shell tests
Message-ID: <YM3rKOlh0reN3Uaw@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
 <20210617184216.2075588-2-irogers@google.com>
 <YMugKlkH7lTWxTQ/@kernel.org>
 <YMzOpgZPJeC2jGKf@kernel.org>
 <CAP-5=fXFgOz5V3_yCHEENtRsQdgCDEK=fWMri84FPD1ivC2w+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXFgOz5V3_yCHEENtRsQdgCDEK=fWMri84FPD1ivC2w+A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 18, 2021 at 09:45:05PM -0700, Ian Rogers escreveu:
> On Fri, Jun 18, 2021 at 9:49 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Jun 17, 2021 at 04:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jun 17, 2021 at 11:42:14AM -0700, Ian Rogers escreveu:
> > > > Having a verbose option will allow shell tests to provide extra failure
> > > > details when the fail or skip.
> > >
> > >
> > > Thanks, applied to perf/core.
> > >
> > > - Arnaldo
> > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/tests/builtin-test.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > > index cbbfe48ab802..a8160b1684de 100644
> > > > --- a/tools/perf/tests/builtin-test.c
> > > > +++ b/tools/perf/tests/builtin-test.c
> > > > @@ -577,11 +577,14 @@ struct shell_test {
> > > >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> > > >  {
> > > >     int err;
> > > > -   char script[PATH_MAX];
> > > > +   char script[PATH_MAX + 3];
> > > >     struct shell_test *st = test->priv;
> > > >
> > > >     path__join(script, sizeof(script), st->dir, st->file);
> >
> > probably you need to add a  '- 3' after the sizeof above, right?
> 
> Either way is fine, but -3 is ok with me.
> 
> > > >
> > > > +   if (verbose)
> > > > +           strncat(script, " -v", sizeof(script));
> > > > +
> >
> > Seemed simple enough, but gcc knows better, I'm removing this one:
> >
> >     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
> >                     strncat(script, " -v", sizeof(script));
> >                                            ^~~~~~~~~~~~~~
> >     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
> >                     strncat(script, " -v", sizeof(script));
> >                                            ^~~~~~~~~~~~~~
> >                                            sizeof(script) - strlen(script) - 1
> >     1 error generated.
> >     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2
> >   77    31.98 ubuntu:21.04                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
> >     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
> >                     strncat(script, " -v", sizeof(script));
> >                                            ^~~~~~~~~~~~~~
> >     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
> >                     strncat(script, " -v", sizeof(script));
> >                                            ^~~~~~~~~~~~~~
> >                                            sizeof(script) - strlen(script) - 1
> >     1 error generated.
> >     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2
> 
> Thanks gcc :-) Do you want me to resend the patch?

In such cases please do,

- Arnaldo
