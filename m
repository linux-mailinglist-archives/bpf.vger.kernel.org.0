Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1D3AD0BC
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhFRQvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 12:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhFRQvz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 12:51:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8A02613EB;
        Fri, 18 Jun 2021 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624034985;
        bh=mTZnpeYyj5Av/AzIIZndE8lb3hBum1ZaDaXOdWjBMfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXpbWO+S3Md/YSfnSYTYwInfGeT2T6j+K0grh7Uog3hSNasVP9V46Z2XayriLrdlT
         Tl+6J4n9RVM9Z4SOq1Ef9xofCKzS0nCZq3WDQ7CnmjszqZGFJ0oHaKjjEtkEyB+3yH
         VyvlHdlaClDAzcfZ9iPPpEtMaIbwwovP97KTbReh5jY+HZO/c9bd3AlZmUQiFRnDcW
         dzKI+7QroiJp3et548rkoWtsNpS+2Qg9ktETlfvSZ8lTUlvVlG7IyJwrKoX7DI1oOD
         hokPk6KeKUVhOSHKzCI3Mj6HZQBUH+S7+jfYtRMDsIDvVDZK0Rj3LIU0jnIqPw7wUJ
         bJyHfJlczmBgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63AD640B1A; Fri, 18 Jun 2021 13:49:42 -0300 (-03)
Date:   Fri, 18 Jun 2021 13:49:42 -0300
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
Message-ID: <YMzOpgZPJeC2jGKf@kernel.org>
References: <20210617184216.2075588-1-irogers@google.com>
 <20210617184216.2075588-2-irogers@google.com>
 <YMugKlkH7lTWxTQ/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMugKlkH7lTWxTQ/@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 04:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jun 17, 2021 at 11:42:14AM -0700, Ian Rogers escreveu:
> > Having a verbose option will allow shell tests to provide extra failure
> > details when the fail or skip.
>  
> 
> Thanks, applied to perf/core.
> 
> - Arnaldo
> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index cbbfe48ab802..a8160b1684de 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -577,11 +577,14 @@ struct shell_test {
> >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> >  {
> >  	int err;
> > -	char script[PATH_MAX];
> > +	char script[PATH_MAX + 3];
> >  	struct shell_test *st = test->priv;
> >  
> >  	path__join(script, sizeof(script), st->dir, st->file);

probably you need to add a  '- 3' after the sizeof above, right?

> >  
> > +	if (verbose)
> > +		strncat(script, " -v", sizeof(script));
> > +

Seemed simple enough, but gcc knows better, I'm removing this one:

    tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
                    strncat(script, " -v", sizeof(script));
                                           ^~~~~~~~~~~~~~
    tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
                    strncat(script, " -v", sizeof(script));
                                           ^~~~~~~~~~~~~~
                                           sizeof(script) - strlen(script) - 1
    1 error generated.
    make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2
  77    31.98 ubuntu:21.04                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
    tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
                    strncat(script, " -v", sizeof(script));
                                           ^~~~~~~~~~~~~~
    tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
                    strncat(script, " -v", sizeof(script));
                                           ^~~~~~~~~~~~~~
                                           sizeof(script) - strlen(script) - 1
    1 error generated.
    make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2


> >  	err = system(script);
> >  	if (!err)
> >  		return TEST_OK;
> > -- 
> > 2.32.0.288.g62a8d224e6-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
