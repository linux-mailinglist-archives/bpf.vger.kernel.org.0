Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590586605A8
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjAFRZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjAFRZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:25:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2C7D9D7;
        Fri,  6 Jan 2023 09:25:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A133CE1DAF;
        Fri,  6 Jan 2023 17:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA64C433EF;
        Fri,  6 Jan 2023 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025908;
        bh=E0AMAcCDFiW3hKyGu+BfqHYfZVwE7Pp21GrhIKvYXUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL95n0g4oKqnBJasaQSHf6Zj1FG/nGZ57LvX/UjhNsZp7C1njL8RJU86DSCdnrSuu
         jnXIJTkHxdDJYXfFXiJ0vbwHvnho0aF66OOwWz7PJC089NC5vk8K/KU7stV218tS/G
         91l+93BoFP+gENAHDh3rdZNLySKc8ZJhKUee9lQUMENWXRfXEehcuRk2Fsmn2/byQL
         l1smFR5EZnaeFg/zVylCgdQgG1kAdx7a6oRr8usb0GdyOwNmtyKTDU2frKCaybAUQF
         Bt1JGPQD1cukLzcJO3OtzQGwjVu/tiukgNXMXSQugLdhFyIaZDXqGsSXovEB9pul31
         IP9h5sD7wXZVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4752C40468; Fri,  6 Jan 2023 14:25:05 -0300 (-03)
Date:   Fri, 6 Jan 2023 14:25:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y7hZccgOiueB31a+@kernel.org>
References: <20230106151320.619514-1-irogers@google.com>
 <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 06, 2023 at 03:28:03PM +0000, Mike Leach escreveu:
> On Fri, 6 Jan 2023 at 15:13, Ian Rogers <irogers@google.com> wrote:
> >
> > Including libbpf header files should be guarded by
> > HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> > under HAVE_BPF_SKEL.
> >
> > Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> > Reported-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

> > ---
> >  tools/perf/builtin-trace.c    | 2 ++
> >  tools/perf/util/bpf_counter.h | 6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 86e06f136f40..d21fe0f32a6d 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -16,7 +16,9 @@
> >
> >  #include "util/record.h"
> >  #include <api/fs/tracing_path.h>
> > +#ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> > +#endif
> >  #include "util/bpf_map.h"
> >  #include "util/rlimit.h"
> >  #include "builtin.h"
> > diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> > index 4dbf26408b69..c6d21c07b14c 100644
> > --- a/tools/perf/util/bpf_counter.h
> > +++ b/tools/perf/util/bpf_counter.h
> > @@ -4,9 +4,12 @@
> >
> >  #include <linux/list.h>
> >  #include <sys/resource.h>
> > +
> > +#ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> >  #include <bpf/btf.h>
> >  #include <bpf/libbpf.h>
> > +#endif
> >
> >  struct evsel;
> >  struct target;
> > @@ -87,6 +90,8 @@ static inline void set_max_rlimit(void)
> >         setrlimit(RLIMIT_MEMLOCK, &rinf);
> >  }
> >
> > +#ifdef HAVE_BPF_SKEL
> > +
> >  static inline __u32 bpf_link_get_id(int fd)
> >  {
> >         struct bpf_link_info link_info = { .id = 0, };
> > @@ -127,5 +132,6 @@ static inline int bperf_trigger_reading(int prog_fd, int cpu)
> >
> >         return bpf_prog_test_run_opts(prog_fd, &opts);
> >  }
> > +#endif /* HAVE_BPF_SKEL */
> >
> >  #endif /* __PERF_BPF_COUNTER_H */
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
> 
> 
> This version builds fine too.
> 
> Mike
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK

-- 

- Arnaldo
