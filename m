Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5676602DD
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjAFPPo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjAFPPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:15:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF22831A9
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:15:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1273158wmp.3
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IrpeNaKIi3qbKYOhoMFV4jENmjXkfJ5Lw7UV5vUFUN4=;
        b=qJVAXTrh0UjDONukH929lXDALK24r7/cE4bqo2NO7Y8TlhhQB5CMSXCgwDI3H+TOHg
         3p9IARqukaJCsglnoHuVLP2LQSAuZkpvpuAXqi6viFalp//hXzY5cKJ+gf0kYFFCYkX1
         Q3OIG9e/3/MU9KwJb3+a8/5XwnJYJGyYYYLWxFGjAwtApJgrIu/9MPcJEHFFjzSP23N/
         ke6h8yy5As/NFHQ9aR0V54JoHpy61oc5fou3IsdTosMNbH5G14uQtdr5tUqbhqUGedb8
         6YjwWJEO3Za9wZQgSuZs6LtDGLU7EwEA+9tvdPxUpFkTiObFJ+oBIpKrxQVd24Whr6Bl
         Ndhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrpeNaKIi3qbKYOhoMFV4jENmjXkfJ5Lw7UV5vUFUN4=;
        b=Mx6i0RUsDRfl8N0udfulON6o5JX7qd8/c4SRqyZzRS+fA+Nri/ta9cXB8U8lvvYMvW
         Uoyi4yIWZidTKFl7oJnKUzixaUKB76SU6Gz29duKeh7H17xMGyKP36RiBWVib6k5X52n
         GdrBPI2sf1z67n7BUc548aDZcWJzJ672pd51dMjOmcTUGgW4DFPn2ol0R//E7lyLeYW1
         /eGyg5PXz1k5Bi4p18TlDsqUKoa/LzjRbYyGogW5FFQVg0dCNCtfi4D0qQJEhvq+QLOq
         wb0krstjrY9sqAx3TdjDSr8pF5MJgBtXA5JfVuTDV1TwEFpGblFhf9MIcUTOFJNj0xxd
         IpWA==
X-Gm-Message-State: AFqh2krdmKmtoU3XCtz+VXLlNwHQZqxRzvZyC0bL4w2YnRVP8tlX/6s5
        6JEz+t786J8vS+S/U+7mV8A8vhn72DfEl/8c1T03ZR4wdRc6Qg==
X-Google-Smtp-Source: AMrXdXs7rXE6Zem5ylaRY2fbqQ17dRvTnicAFsBgMmxxmOxjHwHeIulFBaGuonpnb/3AJO/Ar/OgXxcoigaJzssTANU=
X-Received: by 2002:a05:600c:217:b0:3c6:c109:2d9 with SMTP id
 23-20020a05600c021700b003c6c10902d9mr3663191wmi.149.1673018098956; Fri, 06
 Jan 2023 07:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20230106142537.607399-1-irogers@google.com> <Y7g2YXNaP0VM+F1o@kernel.org>
 <CAJ9a7Vg5-7c_p=6ga0my7cU2P9=N2N8YNMzUrd3kV18eX+ba2w@mail.gmail.com>
In-Reply-To: <CAJ9a7Vg5-7c_p=6ga0my7cU2P9=N2N8YNMzUrd3kV18eX+ba2w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 Jan 2023 07:14:46 -0800
Message-ID: <CAP-5=fX+VYjdGZXTXE35N2a_3TLPEWM9WH0M001p7B5xSe34dA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf build: Properly guard libbpf includes
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 7:12 AM Mike Leach <mike.leach@linaro.org> wrote:
>
> On Fri, 6 Jan 2023 at 14:55, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Fri, Jan 06, 2023 at 06:25:36AM -0800, Ian Rogers escreveu:
> > > Including libbpf header files should be guarded by
> > > HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> > > under HAVE_BPF_SKEL.
> > >
> > > Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> > > Reported-by: Mike Leach <mike.leach@linaro.org>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Can this be done in a way that reduces patch size?
> >
> > - Arnaldo

Done in v3. Thanks,

Ian

> >
> > > ---
> > >  tools/perf/builtin-trace.c    |  2 +
> > >  tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
> > >  2 files changed, 46 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 86e06f136f40..d21fe0f32a6d 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -16,7 +16,9 @@
> > >
> > >  #include "util/record.h"
> > >  #include <api/fs/tracing_path.h>
> > > +#ifdef HAVE_LIBBPF_SUPPORT
> > >  #include <bpf/bpf.h>
> > > +#endif
> > >  #include "util/bpf_map.h"
> > >  #include "util/rlimit.h"
> > >  #include "builtin.h"
> > > diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> > > index 4dbf26408b69..9113c8bf5cb0 100644
> > > --- a/tools/perf/util/bpf_counter.h
> > > +++ b/tools/perf/util/bpf_counter.h
> > > @@ -4,9 +4,12 @@
> > >
> > >  #include <linux/list.h>
> > >  #include <sys/resource.h>
> > > +
> > > +#ifdef HAVE_LIBBPF_SUPPORT
> > >  #include <bpf/bpf.h>
> > >  #include <bpf/btf.h>
> > >  #include <bpf/libbpf.h>
> > > +#endif
> > >
> > >  struct evsel;
> > >  struct target;
> > > @@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
> > >  void bpf_counter__destroy(struct evsel *evsel);
> > >  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
> > >
> > > +static inline __u32 bpf_link_get_id(int fd)
> > > +{
> > > +     struct bpf_link_info link_info = { .id = 0, };
> > > +     __u32 link_info_len = sizeof(link_info);
> > > +
> > > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > > +     return link_info.id;
> > > +}
> > > +
> > > +static inline __u32 bpf_link_get_prog_id(int fd)
> > > +{
> > > +     struct bpf_link_info link_info = { .id = 0, };
> > > +     __u32 link_info_len = sizeof(link_info);
> > > +
> > > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > > +     return link_info.prog_id;
> > > +}
> > > +
> > > +static inline __u32 bpf_map_get_id(int fd)
> > > +{
> > > +     struct bpf_map_info map_info = { .id = 0, };
> > > +     __u32 map_info_len = sizeof(map_info);
> > > +
> > > +     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > > +     return map_info.id;
> > > +}
> > > +
> > > +/* trigger the leader program on a cpu */
> > > +static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > > +{
> > > +     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > > +                         .ctx_in = NULL,
> > > +                         .ctx_size_in = 0,
> > > +                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > > +                         .cpu = cpu,
> > > +                         .retval = 0,
> > > +             );
> > > +
> > > +     return bpf_prog_test_run_opts(prog_fd, &opts);
> > > +}
> > > +
> > >  #else /* HAVE_BPF_SKEL */
> > >
> > >  #include <linux/err.h>
> > > @@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
> > >       setrlimit(RLIMIT_MEMLOCK, &rinf);
> > >  }
> > >
> > > -static inline __u32 bpf_link_get_id(int fd)
> > > -{
> > > -     struct bpf_link_info link_info = { .id = 0, };
> > > -     __u32 link_info_len = sizeof(link_info);
> > > -
> > > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > > -     return link_info.id;
> > > -}
> > > -
> > > -static inline __u32 bpf_link_get_prog_id(int fd)
> > > -{
> > > -     struct bpf_link_info link_info = { .id = 0, };
> > > -     __u32 link_info_len = sizeof(link_info);
> > > -
> > > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > > -     return link_info.prog_id;
> > > -}
> > > -
> > > -static inline __u32 bpf_map_get_id(int fd)
> > > -{
> > > -     struct bpf_map_info map_info = { .id = 0, };
> > > -     __u32 map_info_len = sizeof(map_info);
> > > -
> > > -     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > > -     return map_info.id;
> > > -}
> > > -
> > > -/* trigger the leader program on a cpu */
> > > -static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > > -{
> > > -     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > > -                         .ctx_in = NULL,
> > > -                         .ctx_size_in = 0,
> > > -                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > > -                         .cpu = cpu,
> > > -                         .retval = 0,
> > > -             );
> > > -
> > > -     return bpf_prog_test_run_opts(prog_fd, &opts);
> > > -}
> > > -
> > >  #endif /* __PERF_BPF_COUNTER_H */
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> >
>
> Tested-by: Mike Leach <mike.leach@linaro.org>
>
> > --
> >
> > - Arnaldo
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
