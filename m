Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D51A4EC1
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDKHsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 03:48:43 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38713 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgDKHsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 03:48:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id 204so2371840ybw.5
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8GPvFi7lFIoD5ol+jzlnBX/spU1So+9ApIXttQKDmY=;
        b=WnPrTZr4eRY50oaP6lpML/FERExXMgAy3Rr3VAq8lzECh80UHW0hm46QEPdVUIERiM
         mL6O5Um4lBhZPmVzMXLq5RVU+FsClIGaytR7gqgTwvpmYHwaHfmD+EfXfRSEMidAbUnK
         osj4czJURJbxl56nqTqyRevpPNYB2IttS58uL4NQn2QYIZXJ0zO1LoIrjIR1ehJx68Wi
         2s7sNgHxEXpl+94pAAX0pEHtz3AQw6/4LgMKjjdS4JuE/PY7By6ql+NAzXwqCuBm38oC
         xDKuZwDued4UivyZnOQLu9naiJtrjQMeYJzJe/JEfMvrQ8evYdRaHgT36galla+2OZ3y
         7SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8GPvFi7lFIoD5ol+jzlnBX/spU1So+9ApIXttQKDmY=;
        b=INLfHGw0V94k37skjGMTmRKkGVNF0REpzf8Lf6NR8Ad7VnZkV0VB7a/zchrRb0EqoE
         rKgG1Q1jY03R7y/DHNxm90W+kwZHPfsdIJCEvzHmGvhuYgNoRKBKsRJTpd0CDbZGeveB
         H5SXciBkSqRcXcturP7USwETboS2Tr96drnl+Ky89FDXMUpXDyyTDeY4WqZbVuPMA6dY
         qZML0mR2Mm11X95jN87w1gkwaEgtfafNewbpjH12A98BnLRHSL9XJgr74U4QOUECC4yj
         eD3aYqk82bnI+P9QRrUljJEgO2U5uiS/AkfQKbdYrmd+YVq5gnhG7QN7GUcTt9OzIDsj
         +i5Q==
X-Gm-Message-State: AGi0Pua2mnT7/ovsGiA7JDr3fSw16JxJQxiQCNzrP+qbflUXyrHo/pMH
        xwQYj9FU9SsdbQ8flw5lINwJLjpzoSQowJP5uh9CJg==
X-Google-Smtp-Source: APiQypJoANYPoMMfDUJ1war3eL3RAToX/v/fNHiECFMk7VIOpuyp64iLBN2966YbqWFSCHTu63g+Yr5rlZYeEAIbERY=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr13011592ybs.286.1586591321840;
 Sat, 11 Apr 2020 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200407064018.158555-1-irogers@google.com> <20200407202508.GA3210726@krava>
 <CAP-5=fUQBDUKL3AXXzERfFLSRtK=P6waA+bv68Lp526aBLWo4g@mail.gmail.com>
In-Reply-To: <CAP-5=fUQBDUKL3AXXzERfFLSRtK=P6waA+bv68Lp526aBLWo4g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 11 Apr 2020 00:48:30 -0700
Message-ID: <CAP-5=fUZK1MkKNeJXJY3+ua8U7cfqbMhZtiGB0JyeiNt5=gh2Q@mail.gmail.com>
Subject: Re: [PATCH v7] perf tools: add support for libpfm4
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 7, 2020 at 2:07 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Apr 7, 2020 at 1:25 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Apr 06, 2020 at 11:40:18PM -0700, Ian Rogers wrote:
> > > From: Stephane Eranian <eranian@google.com>
> > >
> > > This patch links perf with the libpfm4 library if it is available and
> > > NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
> > > event tables for all processors supported by perf_events. It is a helper
> > > library that helps convert from a symbolic event name to the event
> > > encoding required by the underlying kernel interface. This
> > > library is open-source and available from: http://perfmon2.sf.net.
> > >
> > > With this patch, it is possible to specify full hardware events
> > > by name. Hardware filters are also supported. Events must be
> > > specified via the --pfm-events and not -e option. Both options
> > > are active at the same time and it is possible to mix and match:
> > >
> > > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> > >
> > > v7 rebases and adds fallback code for libpfm4 events.
> > >    The fallback code is to force user only priv level in case the
> > >    perf_event_open() syscall failed for permissions reason.
> > >    the fallback forces a user privilege level restriction on the event string,
> > >    so depending on the syntax either u or :u is needed.
> > >
> > >    But libpfm4 can use a : or . as the separator, so simply searching
> > >    for ':' vs. '/' is not good enough to determine the syntax needed.
> > >    Therefore, this patch introduces a new evsel boolean field to mark events
> > >    coming from  libpfm4. The field is then used to adjust the fallback string.
> >
> > heya,
> > I made bunch of comments for v5, not sure you saw them:
> >   https://lore.kernel.org/lkml/20200323235846.104937-1-irogers@google.com/
> >
> > jirka
>
> Sorry for missing this, I will work on fixing these and thanks!
>
> Ian

v8 is available now:
https://lore.kernel.org/lkml/20200411074631.9486-1-irogers@google.com/T/#t

Thanks,
Ian

> > > v6 is a rebase.
> > > v5 is a rebase.
> > > v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > >    branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
> > >    missed in v3.
> > > v3 is against acme/perf/core and removes a diagnostic warning.
> > > v2 of this patch makes the --pfm-events man page documentation
> > > conditional on libpfm4 behing configured. It tidies some of the
> > > documentation and adds the feature test missed in the v1 patch.
> > >
> >
> > SNIP
> >
