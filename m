Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F623B0CB3
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhFVSTw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSTv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 14:19:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324BC06175F
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 11:17:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j2so14204098wrs.12
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUjNFgJbMc3n/4UpR024/4xgXFRMOO3TLXFoCvUi2LM=;
        b=ZCaB6t+mhREkhR2OvNFoApIE1ei48vRy96ybHQvvpa0MUrNGm/D8CtXEAmf2AckYqc
         +8phSg2DOhfIRbX6xyLwluGh2a3zgUgofsBBEpCEXFq71BRAvUNhHnNqz2y2K45pjodr
         vSZiL6w+/RuM2lVCluoiuATe1Evwl+5YPqOSpYAipU+eVTaiZFd11jVOiAarRbPybAKQ
         FOJndxr8aMZYOiCaGRsiSRWSWRQYHHwbPpM3an9YVhxoUtvr9cf9WXbCR6LofyEhQ9qo
         Y7vzKUv20I87Pv5KGp0y9ZO5TEZarChFNwgw9ZrLTo8aA/PEWFFi7qT4zSno74UaNHZR
         G+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUjNFgJbMc3n/4UpR024/4xgXFRMOO3TLXFoCvUi2LM=;
        b=bMpyFPaduyZw8aTPjO8af7FlSYNVg+7AsP4LyIfDG1fBZKwFldq2P+TODE8j3D301n
         yUwku7RwknWfXONM6uyNqWekN4Gq6dtz24nqKa/gn94zqv6dLp9CjYi0hZIjmLhXpYoZ
         GwqamBMCXvqpWpLXLx66EtpSzYXNIgd+/DLFaPB1NAbSkEJ74anJkevFjD9Tv7DgLNZw
         4SHUSdks87935OafhuJ6knrjnvh5eeJ/NHpdEzH4j0LGencgfiZR1cV1c1ZQNssJRII0
         q/hfTjpmdunuCo1iF3MbDRBVqqNwsZ+j0aMvxx5clT7fCcW/IJQAyqYR9tjabFsKCXF1
         uIBg==
X-Gm-Message-State: AOAM531w1T1TaB4wgFrxi1pEPd0RwHeD4wj/tPsgk8bwWHgNDPoovt6F
        VqPpGUHegje3mNPl/TqdyG9QRP3k/n1GQUpDdDxthQ==
X-Google-Smtp-Source: ABdhPJyyD07iHLTvYxa9U4h3OlVZ8XIGjNQEW31my+3kcgwEcINQJUt+bKV/AuDvHglyJgtyk90UVOSS0U0MHI7/gOQ=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr6318395wro.119.1624385853745;
 Tue, 22 Jun 2021 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com> <YNIhzyKPqfFvvoYs@kernel.org>
 <YNIjtOSoj+aWnQns@kernel.org>
In-Reply-To: <YNIjtOSoj+aWnQns@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 11:17:21 -0700
Message-ID: <CAP-5=fUtE_9=dYaazUJYzDGz2+nGcWjJoCxGb6b5oSbU6Z02AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf test: Pass the verbose option to shell tests
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

On Tue, Jun 22, 2021 at 10:54 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 22, 2021 at 02:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jun 21, 2021 at 02:56:46PM -0700, Ian Rogers escreveu:
> > > Having a verbose option will allow shell tests to provide extra failure
> > > details when the fail or skip.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/builtin-test.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index cbbfe48ab802..e1ed60567b2f 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -577,10 +577,13 @@ struct shell_test {
> > >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> > >  {
> > >     int err;
> > > -   char script[PATH_MAX];
> > > +   char script[PATH_MAX + 3];
> >
> > This looks strange, i.e. if it is a _path_ _MAX_, why add 3 chars past
> > that max when generating a _path_? I'll drop the above hunk and keep the
> > rest, ok?
>
> Oh well, its not a path after all, its something that is passed to
> system(), the use of PATH_MAX seems arbitrary, so your patch wasn't
> wrong, but since it is arbitrary, I'll keep it at PATH_MAX and reduce
> the patch size 8-)
>
> - Arnaldo

Works for me. Thanks,

Ian

> > >     struct shell_test *st = test->priv;
> > >
> > > -   path__join(script, sizeof(script), st->dir, st->file);
> > > +   path__join(script, sizeof(script) - 3, st->dir, st->file);
> > > +
> > > +   if (verbose)
> > > +           strncat(script, " -v", sizeof(script) - strlen(script) - 1);
> > >
> > >     err = system(script);
> > >     if (!err)
>
> --
>
> - Arnaldo
