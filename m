Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC86602CB
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAFPMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjAFPMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:12:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B077D33
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:12:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gq18so1585280pjb.2
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xVMjZC40s+T1CFsdFSwBRfl09heYK9MQl9tX7e5Cpw=;
        b=TnK9hT+c/rFv/XIRV/MbbK/llGR0/XIA4/cwX9DG2PO48vLquZcLeL3uV5YykaK2G8
         lloggGj5Xgufw30fVOPPd9UYXWq05tBAmSKisz2YSa3N6zy8XWcqALUdgRomvzXVAhWp
         n3tP1yC3nU+QVFo+3w5Kb0sPrYw1n1kKDj4WpIeYb4EF5iR1wiWqXDn1LK1LqRjAg+eQ
         dt7k7PBQ9iA3OQTSEOB3NDwhph8dftXqYgL+MqA9o/E78+aeUjVfn5acdXIyTuYINQpo
         gF2CirSEipJtCSGvWtQXt5ys252ipdj5e0eCsXjokt/zmlPP+yqBKaPdBqQFuf7HnECk
         iZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xVMjZC40s+T1CFsdFSwBRfl09heYK9MQl9tX7e5Cpw=;
        b=kj497IauIflzxjG68y44v+t36Hn1Xuc9X2jB0brDvvfSY/rAqVPEMPVjwDsRH3BmNV
         4c7TLr+FWjk5B1RfmkiJYwu1cGbMIug+ezaDvrQb1mwCh7Pw0o+7vAokZwRakehJ2ZWm
         Ay4+jEE2X+MZAwl/sEF85F2tINxybFrsp0TvbnQymw70mL+CTi6HyAKD+bWWhrP4MJt7
         zJs17q5dnlBSnytyieEucNal6/bQ3HFJMH8aC6S0khz8MQ+coqRRa9Byuad1nOL6KBfb
         lM/YwKBdI5soH76HxvxjaQac1Q5KIpcK4e7tuyupI5J/0D3c0KG6CatlJn9rf/rRuw18
         5Qyw==
X-Gm-Message-State: AFqh2kryrxHpTTtGPOjqP6pnCuWiEru14fZ3qqFodb1+HLyvkhTQ8OAv
        T3/Ar/x7WVAFukSEPCvRbRANUmPDDguxy1JxM/FGLg==
X-Google-Smtp-Source: AMrXdXsKXTWBOy1Q8q1m6Ha+wg1bhsOCIfvQ0YA0iW+v80gcwiY6l/mBDuGj9tuGt8DX/JAMnSFdQ6CJTRaOoM/P7A8=
X-Received: by 2002:a17:902:6b05:b0:18c:5dae:6f2 with SMTP id
 o5-20020a1709026b0500b0018c5dae06f2mr3196653plk.24.1673017933757; Fri, 06 Jan
 2023 07:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20230106142537.607399-1-irogers@google.com> <Y7g2YXNaP0VM+F1o@kernel.org>
In-Reply-To: <Y7g2YXNaP0VM+F1o@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Jan 2023 15:12:02 +0000
Message-ID: <CAJ9a7Vg5-7c_p=6ga0my7cU2P9=N2N8YNMzUrd3kV18eX+ba2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf build: Properly guard libbpf includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 6 Jan 2023 at 14:55, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Jan 06, 2023 at 06:25:36AM -0800, Ian Rogers escreveu:
> > Including libbpf header files should be guarded by
> > HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> > under HAVE_BPF_SKEL.
> >
> > Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> > Reported-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Can this be done in a way that reduces patch size?
>
> - Arnaldo
>
> > ---
> >  tools/perf/builtin-trace.c    |  2 +
> >  tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
> >  2 files changed, 46 insertions(+), 41 deletions(-)
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
> > index 4dbf26408b69..9113c8bf5cb0 100644
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
> > @@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
> >  void bpf_counter__destroy(struct evsel *evsel);
> >  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
> >
> > +static inline __u32 bpf_link_get_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = { .id = 0, };
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.id;
> > +}
> > +
> > +static inline __u32 bpf_link_get_prog_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = { .id = 0, };
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.prog_id;
> > +}
> > +
> > +static inline __u32 bpf_map_get_id(int fd)
> > +{
> > +     struct bpf_map_info map_info = { .id = 0, };
> > +     __u32 map_info_len = sizeof(map_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > +     return map_info.id;
> > +}
> > +
> > +/* trigger the leader program on a cpu */
> > +static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > +                         .ctx_in = NULL,
> > +                         .ctx_size_in = 0,
> > +                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > +                         .cpu = cpu,
> > +                         .retval = 0,
> > +             );
> > +
> > +     return bpf_prog_test_run_opts(prog_fd, &opts);
> > +}
> > +
> >  #else /* HAVE_BPF_SKEL */
> >
> >  #include <linux/err.h>
> > @@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
> >       setrlimit(RLIMIT_MEMLOCK, &rinf);
> >  }
> >
> > -static inline __u32 bpf_link_get_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = { .id = 0, };
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.id;
> > -}
> > -
> > -static inline __u32 bpf_link_get_prog_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = { .id = 0, };
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.prog_id;
> > -}
> > -
> > -static inline __u32 bpf_map_get_id(int fd)
> > -{
> > -     struct bpf_map_info map_info = { .id = 0, };
> > -     __u32 map_info_len = sizeof(map_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > -     return map_info.id;
> > -}
> > -
> > -/* trigger the leader program on a cpu */
> > -static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > -{
> > -     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > -                         .ctx_in = NULL,
> > -                         .ctx_size_in = 0,
> > -                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > -                         .cpu = cpu,
> > -                         .retval = 0,
> > -             );
> > -
> > -     return bpf_prog_test_run_opts(prog_fd, &opts);
> > -}
> > -
> >  #endif /* __PERF_BPF_COUNTER_H */
> > --
> > 2.39.0.314.g84b9a713c41-goog
>

Tested-by: Mike Leach <mike.leach@linaro.org>

> --
>
> - Arnaldo


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
