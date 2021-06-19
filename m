Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E73AD7E2
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 06:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFSEra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Jun 2021 00:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhFSEra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Jun 2021 00:47:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693DC06175F
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 21:45:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n7so13001836wri.3
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 21:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idsAK6GUcXFkxK0P/rvOOxu0Fst33XB043NfWRK/EsI=;
        b=SvnQNhK5Fw2psUOj4KHtI/SAF52lMkQiVEXCSX4RJRXPpY/8BpY60EV/m2Aa9A4g2J
         RmIjnCzLmcmtCV757thEy4OsBlq0DdNvzebs3PeYpiznHTu/bMXWUUf8ULIftJeuibUx
         +I/HE9M+Sb+q8CmGRY034/OZouxVGbl6NkSzhdf0+DFtmNbdt5u+sHhfu7GcYeiOx7m6
         cW1jC5H9O6K7nhAso75Pi60OcHii0DIVHfiwjOxifhA+wn8yCCTXeZ70JPvhfyNEY7hv
         S4GiUyHTZETcOCSdJblRNhoEQdt+PtnpLdIoyvI21Jwc+ebe4iPwcXMocB7Gkc+wzKkQ
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idsAK6GUcXFkxK0P/rvOOxu0Fst33XB043NfWRK/EsI=;
        b=cd9+L13IJIjanrxurWKYbZe96TU7t+d5Hjuo0DbssMOWTGGLq2xWjf2KMs0MooavoX
         kZbsIEGCJveEJ+QYa3MMVUqs4j9KWLmaKFvd3j3czSKO2BWvuE+wCxWRhWQPYtmiOGBx
         MREagfXdcadE0DSPzwXYrOJ7x3KOeuaZmsXoiR5FTJmwHV4ms+0hY4lZx9AmzRrhQKAq
         2zdXFKdVwI8Lk356WCnuYkf5gBlvt7QRMp3FD1mX8KQAXY4Xf89MG8oxTp+mFosBA1V3
         s0fTJS8xQSg92qI431ijI+Zu8DQydkuYzcbWF//UYVGPo2nTgCMHY1Gd2m9qwweyG+l/
         m3Ew==
X-Gm-Message-State: AOAM533i21dK85E/UFBIO76RS2XIw8TuDXDlMOioaRLQXQFutgkgQLwZ
        u5MT1ePhoH5L1xxfDXYikVHK1kh9eOxeHdpqL8jgew==
X-Google-Smtp-Source: ABdhPJzRdAi53rmEs5yNcu8lpH3vJulYPlhvTRikeoGaCYRL/vh2fMrYN5Lb/d6rikq3nOqtev+5bHzoG6T8YTvdB30=
X-Received: by 2002:a05:6000:1c1:: with SMTP id t1mr15550367wrx.282.1624077917613;
 Fri, 18 Jun 2021 21:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com> <20210617184216.2075588-2-irogers@google.com>
 <YMugKlkH7lTWxTQ/@kernel.org> <YMzOpgZPJeC2jGKf@kernel.org>
In-Reply-To: <YMzOpgZPJeC2jGKf@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 18 Jun 2021 21:45:05 -0700
Message-ID: <CAP-5=fXFgOz5V3_yCHEENtRsQdgCDEK=fWMri84FPD1ivC2w+A@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf test: Pass the verbose option to shell tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 9:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jun 17, 2021 at 04:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jun 17, 2021 at 11:42:14AM -0700, Ian Rogers escreveu:
> > > Having a verbose option will allow shell tests to provide extra failure
> > > details when the fail or skip.
> >
> >
> > Thanks, applied to perf/core.
> >
> > - Arnaldo
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/builtin-test.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index cbbfe48ab802..a8160b1684de 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -577,11 +577,14 @@ struct shell_test {
> > >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> > >  {
> > >     int err;
> > > -   char script[PATH_MAX];
> > > +   char script[PATH_MAX + 3];
> > >     struct shell_test *st = test->priv;
> > >
> > >     path__join(script, sizeof(script), st->dir, st->file);
>
> probably you need to add a  '- 3' after the sizeof above, right?

Either way is fine, but -3 is ok with me.

> > >
> > > +   if (verbose)
> > > +           strncat(script, " -v", sizeof(script));
> > > +
>
> Seemed simple enough, but gcc knows better, I'm removing this one:
>
>     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>                                            sizeof(script) - strlen(script) - 1
>     1 error generated.
>     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2
>   77    31.98 ubuntu:21.04                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
>     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>                                            sizeof(script) - strlen(script) - 1
>     1 error generated.
>     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2

Thanks gcc :-) Do you want me to resend the patch?

Ian

> > >     err = system(script);
> > >     if (!err)
> > >             return TEST_OK;
> > > --
> > > 2.32.0.288.g62a8d224e6-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
