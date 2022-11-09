Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710A623448
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 21:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIUMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 15:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 15:12:29 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93A1704C;
        Wed,  9 Nov 2022 12:12:28 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id m204so20022722oib.6;
        Wed, 09 Nov 2022 12:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKyoW91hK5fByGjPEcYj0VDNd5HSZ4pg0JWOuFNomI4=;
        b=fukkBlCRsx816Cc51AuFwGgbHo7kHovR4y8vBeEdBbzPaa0DbdPOlPvkKwxdgLNPk+
         +h7QTdDLEx/TpncfaBNgFAtHYZ+C8s1oBRGb9BrH5zrmM/EfC8qJmqeyPdiEOCwCbw0U
         qkUdj/S0rTuh5ilOGM6MmGlvWUh+0hg2yeCU+rXdP0Fax9UNqEk65Zyuo+zmrmLnax8l
         HnYIS0eJ0SzAVQgwYDOBug9WIgoRnv30HEJeH0/Y/rcooc2eye1ROMgPh6fsehunEwoq
         Z12nuhE2FQtvHvXc38u67c7Jy6+wnv8nKd8ZFPT00jcKrqk+aqZkqI/lPFUGxUUPrTZb
         9yAA==
X-Gm-Message-State: ACrzQf39B1tubrN4I1QRBTw8qHa0dmYE3qLzHxdxmwfwCkG2ZMndPu8q
        u/5Tr/GoNrRczobvrBFeWWhRnpW72f4oBj4n55Q=
X-Google-Smtp-Source: AMsMyM6y7F6nDZtPrY8YdsjcnlNjYOkHvwEGRMxS351hhvHi3/f0JuPiZqMxbJxCFtuD2Mq5XpFtFUNBFTcY85/83G4=
X-Received: by 2002:aca:2805:0:b0:359:e340:d53 with SMTP id
 5-20020aca2805000000b00359e3400d53mr31926337oix.209.1668024747822; Wed, 09
 Nov 2022 12:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com> <20221109184914.1357295-9-irogers@google.com>
In-Reply-To: <20221109184914.1357295-9-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Nov 2022 12:12:16 -0800
Message-ID: <CAM9d7cgpcVcUZo6ExLWis2Pu4V0FXdsNx+ZoKUWrOYqgqyZTiQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] tools lib perf: Add missing install headers
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
>
> Headers necessary for the perf build. Note, internal headers are also
> installed as these are necessary for the build.

Yeah, it's sad we are using those internal headers in perf.
Ideally libperf provides callbacks to associate private data
to each public data structure (e.g. evsel, evlist, etc).  And
external users just use public APIs only.

But that would be a major change.

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 21df023a2103..1badc0a04676 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -189,13 +189,21 @@ install_lib: libs
>
>  install_headers:
>         $(call QUIET_INSTALL, headers) \
> +               $(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
>                 $(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
> -               $(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
> +               $(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644); \
> +               $(call do_install,include/internal/cpumap.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/evlist.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/evsel.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/lib.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/mmap.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/threadmap.h,$(prefix)/include/internal,644); \
> +               $(call do_install,include/internal/xyarray.h,$(prefix)/include/internal,644);
>
>  install_pkgconfig: $(LIBPERF_PC)
>         $(call QUIET_INSTALL, $(LIBPERF_PC)) \
> --
> 2.38.1.431.g37b22c650d-goog
>
