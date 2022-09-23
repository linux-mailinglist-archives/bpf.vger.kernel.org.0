Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D035E73B6
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIWGNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 02:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWGNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 02:13:41 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AEB1191A2;
        Thu, 22 Sep 2022 23:13:39 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1279948d93dso16973530fac.10;
        Thu, 22 Sep 2022 23:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rji+pfwL3rQYH9KftarRBcRHruKKw+WaXEF8zxspQUo=;
        b=t9hB2AnQpXAyZIGpLahKAScyiXXShtXmkUtWe1KFKoAbJ/V3oiNiWPq5jN8PuE32O1
         w01w+vzxcpe2XX4b/1m3jiD907/1ynFP70uFq/QV99kMMteYBaggZRECLjjkCU9zghi7
         VuWWs8T2hC6prOuPiIqo9BmlVQL/pOXua6TFYFXqfurHI+ChFHg4QBLJb8HG3uTO2iLd
         ON1DymnZoAgQEE0SXOmEyC15skeg5lLhj1pdLnPuMT5lAhiDTmD5TGxOStqiDwGgZMyc
         DAMqZUXMNc3h/uNx+vbe+wU4DlvoWeXhGeYshRxLZJDFFXlLvaQ6GLIYTB87jDOZXwvo
         twrw==
X-Gm-Message-State: ACrzQf2CuiYrXNrHtXLl7MYGf4yoEmtyYLYWjdZdIs5KZVSlWtyTObm8
        VAKRIHlxg7W1ZLhkMrCWBUETErWlrjPOABfDPQzh7POr
X-Google-Smtp-Source: AMsMyM7/a5MYAYQQxnQQ6yfKc2MsuXYZzmH6H18gLRP1gNB02M4mT1N94UMS114mCiy8+RmdDKU6GSHPtlKMSUyR4E0=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr4049188oai.209.1663913618712; Thu, 22
 Sep 2022 23:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220922205302.749274-1-namhyung@kernel.org> <CAP-5=fXAS+QpkncLqLeS=MOeqOyrFy3Gev=F8vet4r6xjmCJ4g@mail.gmail.com>
In-Reply-To: <CAP-5=fXAS+QpkncLqLeS=MOeqOyrFy3Gev=F8vet4r6xjmCJ4g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Sep 2022 23:13:27 -0700
Message-ID: <CAM9d7cj_LOi+1aKfw7iFLyyWUiNeH2FXr8RMYumTSBzz2tDnwg@mail.gmail.com>
Subject: Re: [PATCH v3] perf tools: Get a perf cgroup more portably in BPF
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Sep 22, 2022 at 4:55 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Sep 22, 2022 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_cgrp_id can be different on other configurations.
> > To be more portable as CO-RE, it needs to get the cgroup subsys id
> > using the bpf_core_enum_value() helper.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v3 changes)
> >  * check compiler features for enum value
> >
> > v2 changes)
> >  * fix off_cpu.bpf.c too
> >  * get perf_subsys_id only once
> >
> >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c      | 12 ++++++++----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > index 292c430768b5..8e7520e273db 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
> >
> >  int enabled = 0;
> >  int use_cgroup_v2 = 0;
> > +int perf_subsys_id = -1;
> >
> >  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
> >  {
> > @@ -58,7 +59,15 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
> >         int level;
> >         int cnt;
> >
> > -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> > +       if (perf_subsys_id == -1) {
> > +#if __has_builtin(__builtin_preserve_enum_value)
> > +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> > +                                                    perf_event_cgrp_id);
> > +#else
> > +               perf_subsys_id = perf_event_cgrp_id;
> > +#endif
> > +       }
> > +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
> >         level = BPF_CORE_READ(cgrp, level);
> >
> >         for (cnt = 0; i < MAX_LEVELS; i++) {
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > index c4ba2bcf179f..e917ef7b8875 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
> >  const volatile bool needs_cgroup = false;
> >  const volatile bool uses_cgroup_v1 = false;
> >
> > +int perf_subsys_id = -1;
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > @@ -119,11 +121,13 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
> >  {
> >         struct cgroup *cgrp;
> >
> > -       if (uses_cgroup_v1)
> > -               cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> > -       else
> > -               cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> > +       if (!uses_cgroup_v1)
> > +               return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
> > +
> > +       if (perf_subsys_id == -1)
> > +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
>
> Should the "#if __has_builtin(__builtin_preserve_enum_value)" test also be here?

Ouch!  Will send v4.

>
> It feels a shame that bpf_core_enum_value isn't defined something like:
>
> #if __has_builtin(__builtin_preserve_enum_value)
> #define bpf_core_enum_value(enum_type, enum_value) \
> __builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value,
> BPF_ENUMVAL_VALUE)
> #else
> #define bpf_core_enum_value(enum_type, enum_value) enum_value
> #endif

Yeah, that would be much easier to use.

Thanks,
Namhyung


>
> for backward clang compatibility, but I could see why an error would
> be preferable.
>
> Thanks,
> Ian
>
> >
> > +       cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
> >         return BPF_CORE_READ(cgrp, kn, id);
> >  }
> >
> > --
> > 2.37.3.998.g577e59143f-goog
> >
