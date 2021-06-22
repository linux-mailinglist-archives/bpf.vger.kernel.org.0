Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12E3B0BE4
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhFVR4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 13:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFVR4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 13:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17C19611CE;
        Tue, 22 Jun 2021 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624384439;
        bh=4sZfDXIMjVtp0HnqMW6N7+qY027W1Ua0nHBRa2Y+c3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUiZX4hdJPtwXgT5i7VzAoAXaNydN5vdBx05wRNNVOCtOxTVqG9cPJ+V0iyCgbZHG
         KlQsGW9iTNlavRW7vVtlEA3UUayBmpl4awSTkv9HlR091sBT8IasKCics//I4eesZ1
         pUxhtsKg0pXkorbsAiZJZC3hewm3KqKlWtvdsYvyvJTooMVJsCFmoleIcXuy9+moDo
         hImVHW4719QVVU29jTP+Evl4ctHpv8R24aFP8rBbg1PsGFCia2XlDjSwMcU/K1dQGn
         m90cX6dmV7SPvXUqRtQ5m/XvX3oCTJ8g4KexAP1gLsJboPLeddxqzqnj4S8zULnrYe
         FBFEwtMCAxaYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9294240B1A; Tue, 22 Jun 2021 14:53:56 -0300 (-03)
Date:   Tue, 22 Jun 2021 14:53:56 -0300
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
Subject: Re: [PATCH v2 1/3] perf test: Pass the verbose option to shell tests
Message-ID: <YNIjtOSoj+aWnQns@kernel.org>
References: <20210621215648.2991319-1-irogers@google.com>
 <YNIhzyKPqfFvvoYs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIhzyKPqfFvvoYs@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 22, 2021 at 02:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jun 21, 2021 at 02:56:46PM -0700, Ian Rogers escreveu:
> > Having a verbose option will allow shell tests to provide extra failure
> > details when the fail or skip.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index cbbfe48ab802..e1ed60567b2f 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -577,10 +577,13 @@ struct shell_test {
> >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> >  {
> >  	int err;
> > -	char script[PATH_MAX];
> > +	char script[PATH_MAX + 3];
> 
> This looks strange, i.e. if it is a _path_ _MAX_, why add 3 chars past
> that max when generating a _path_? I'll drop the above hunk and keep the
> rest, ok?

Oh well, its not a path after all, its something that is passed to
system(), the use of PATH_MAX seems arbitrary, so your patch wasn't
wrong, but since it is arbitrary, I'll keep it at PATH_MAX and reduce
the patch size 8-)

- Arnaldo

> >  	struct shell_test *st = test->priv;
> >  
> > -	path__join(script, sizeof(script), st->dir, st->file);
> > +	path__join(script, sizeof(script) - 3, st->dir, st->file);
> > +
> > +	if (verbose)
> > +		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
> >  
> >  	err = system(script);
> >  	if (!err)

-- 

- Arnaldo
