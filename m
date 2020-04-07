Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29221A172C
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 23:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDGVHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 17:07:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43618 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGVHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 17:07:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id o70so2573336ybg.10
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2020 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ln1J4HLCvYePGk7h/HscAk7E6sJChIv8z+WKVadV84=;
        b=USkdpWBAbkGHHiwPnCElDQ/7MaoUxrZSRjwCFTFmUeHyOY+QQPoMvJviDVSEZ6CSJB
         qNAspn2K5sTsp9r+rvozAWidCK9iEkJuznEbqVlnEMuuGGYawLHzXwqgVKmxTBGlIqPA
         Q9JP7HLX8pXTgO+lnWP2bCmLMylr3TntK2fCCm5yjHNfhlSCXMlBHyD3bqZSIU0AFO7J
         pN5OFanZd6UUB8L+2KWnd3AVf5YRmSMhNT3tQtHZMlugmkb6ovhCAWk1Ll1D46u1aHVV
         ZfP3EbJrxl1+Lk47fq5YjEQKRTDSfPan8kasBvdZB8STwaRdzLvI41PclipNxEqvGxt+
         i1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ln1J4HLCvYePGk7h/HscAk7E6sJChIv8z+WKVadV84=;
        b=R67mlKreSMfyIdeosfX6D55qG8oPIhOk1Q3Fowl1HXYqqnG3jxqGPlT4rNEecmUNXc
         epqjPcVfsNaMDjTdHtmNlah2NC7Yvx2AWmmB0XMmabHAM28q+HZaOKNiG8NXJdGE1yJa
         pzjRcOJQQ2uXxs2yOLLlHCzvB+8NKEpXE8IXKr0CUVO2B9u7xRvPl3Jw7L+6JzHGvyO2
         tape73fZVQVaF0YCqCu75lzj7Spq+Z3nQoEwwwKocEUZVb1jnaoWSpNpxN0PgJpIOKTZ
         SBeyRxHXG4xxO7XTizpZkAoJbX7qxFtiu8okGTTG102MEt926jl21a+dOYYALPOA8ucX
         /0dA==
X-Gm-Message-State: AGi0PuYxNk0mtWvt//8XuIMvnMDzYFVQ5yFARgY68CPMAgBmPknDIobD
        WyB6OeqXYJ6urbgRpf2AKLrSBGTNRI0GLXChdWB3LA==
X-Google-Smtp-Source: APiQypLIAb4EI27sc6PKVLT94TJx7MkmZq9281WyY8zIiI20U0/uwQAZD5PzcH8j5IXAy0VG0lMOrF273YRbjvXve9o=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr6950478ybs.286.1586293653426;
 Tue, 07 Apr 2020 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200407064018.158555-1-irogers@google.com> <20200407202508.GA3210726@krava>
In-Reply-To: <20200407202508.GA3210726@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Apr 2020 14:07:22 -0700
Message-ID: <CAP-5=fUQBDUKL3AXXzERfFLSRtK=P6waA+bv68Lp526aBLWo4g@mail.gmail.com>
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

On Tue, Apr 7, 2020 at 1:25 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Apr 06, 2020 at 11:40:18PM -0700, Ian Rogers wrote:
> > From: Stephane Eranian <eranian@google.com>
> >
> > This patch links perf with the libpfm4 library if it is available and
> > NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
> > event tables for all processors supported by perf_events. It is a helper
> > library that helps convert from a symbolic event name to the event
> > encoding required by the underlying kernel interface. This
> > library is open-source and available from: http://perfmon2.sf.net.
> >
> > With this patch, it is possible to specify full hardware events
> > by name. Hardware filters are also supported. Events must be
> > specified via the --pfm-events and not -e option. Both options
> > are active at the same time and it is possible to mix and match:
> >
> > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> >
> > v7 rebases and adds fallback code for libpfm4 events.
> >    The fallback code is to force user only priv level in case the
> >    perf_event_open() syscall failed for permissions reason.
> >    the fallback forces a user privilege level restriction on the event string,
> >    so depending on the syntax either u or :u is needed.
> >
> >    But libpfm4 can use a : or . as the separator, so simply searching
> >    for ':' vs. '/' is not good enough to determine the syntax needed.
> >    Therefore, this patch introduces a new evsel boolean field to mark events
> >    coming from  libpfm4. The field is then used to adjust the fallback string.
>
> heya,
> I made bunch of comments for v5, not sure you saw them:
>   https://lore.kernel.org/lkml/20200323235846.104937-1-irogers@google.com/
>
> jirka

Sorry for missing this, I will work on fixing these and thanks!

Ian

> > v6 is a rebase.
> > v5 is a rebase.
> > v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >    branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
> >    missed in v3.
> > v3 is against acme/perf/core and removes a diagnostic warning.
> > v2 of this patch makes the --pfm-events man page documentation
> > conditional on libpfm4 behing configured. It tidies some of the
> > documentation and adds the feature test missed in the v1 patch.
> >
>
> SNIP
>
