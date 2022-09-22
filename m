Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B85E705A
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIVXzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIVXzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:55:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A6AC243
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:55:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n15so11006384wrq.5
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pEWu0cZtC5bQpAC76TrU39sQH99ByOhozrqgLO6bDiY=;
        b=VbDDokghUbDy1JsHhqfa5yfdgJSLZ3Zmy3hLc51e8fTubphxO+9Kx5uT6HpTyl07XU
         mvn/zOgEdbQiQE46fEE3ttFLIJmdlsVwErTFarnQwHzO98VEgaTaM901wB/JzYkndOpJ
         xtT/rLZIpPXY3j/re8io1Od+IgjlvCkpjnN/dleCybU1IpQ52MjVAtgnBvGB/nuRTa6n
         A8GDTTnWnWUO7eIFSDkWkYNjLhe+HXfcOuTeHMHrTvRYB4wvORri4cjFF5rvEeRI32ET
         0XshsKczKYPZY2prXjhbOpJSDkagtNXdQ3BP740Tr1Iui75SwL2L8AyQFHz5vESZHBaW
         MNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pEWu0cZtC5bQpAC76TrU39sQH99ByOhozrqgLO6bDiY=;
        b=VsvIdcbgv473zYL6+TSl58Lx0Wc80lpAz1rgTv3VuY43KanIhSZXzCtPhaVbUbsTTs
         e3C67rIyIrza3YJbR+tJmjHbtdgFqtUSzsCfoCH2i3r+SBNcCcAo0lcFXUwK8c0nltUx
         jlt47qos9kKwVVk3z3Ibop5Ec4vy2kwJw2BeJ0TzNKLodCxCQ+Mju026iqQFTyGLt+NP
         P/ePVtfx+UmuNyGVwurit1XvJNWiFLicbGVi2RMl7E2PG52P1cNcEVZeEdGJ2b4eYbU7
         PSk6OOfB+eUD5MITDaA6vcEh/kZjj1egm3zUkrTdeFLIbWEXqv52XXAj8Om6M7IPLyrg
         Zycg==
X-Gm-Message-State: ACrzQf3lwSthEsyqJdqMAjTUo1/Iefv9R0wKowKy0V0vrgr62iRNpXKl
        AwFKsMbwyS5+nZN6FLlzhgv6+0U2NfvlTUqEg6/0XQ==
X-Google-Smtp-Source: AMsMyM5Qi2LT6ix2nu/U4IhNet2x4RTrWqRtFFV77MrwTaOEvv3GkW+VUYr+2y0IZOBSSUdcGRhIJcxQVyOgcFdbwc4=
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr3377917wrm.300.1663890914444; Thu, 22
 Sep 2022 16:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220922205302.749274-1-namhyung@kernel.org>
In-Reply-To: <20220922205302.749274-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Sep 2022 16:55:02 -0700
Message-ID: <CAP-5=fXAS+QpkncLqLeS=MOeqOyrFy3Gev=F8vet4r6xjmCJ4g@mail.gmail.com>
Subject: Re: [PATCH v3] perf tools: Get a perf cgroup more portably in BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
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

On Thu, Sep 22, 2022 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v3 changes)
>  * check compiler features for enum value
>
> v2 changes)
>  * fix off_cpu.bpf.c too
>  * get perf_subsys_id only once
>
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c      | 12 ++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> index 292c430768b5..8e7520e273db 100644
> --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> @@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
>
>  int enabled = 0;
>  int use_cgroup_v2 = 0;
> +int perf_subsys_id = -1;
>
>  static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>  {
> @@ -58,7 +59,15 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
>         int level;
>         int cnt;
>
> -       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
> +       if (perf_subsys_id == -1) {
> +#if __has_builtin(__builtin_preserve_enum_value)
> +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
> +                                                    perf_event_cgrp_id);
> +#else
> +               perf_subsys_id = perf_event_cgrp_id;
> +#endif
> +       }
> +       cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
>         level = BPF_CORE_READ(cgrp, level);
>
>         for (cnt = 0; i < MAX_LEVELS; i++) {
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index c4ba2bcf179f..e917ef7b8875 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
>  const volatile bool needs_cgroup = false;
>  const volatile bool uses_cgroup_v1 = false;
>
> +int perf_subsys_id = -1;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> @@ -119,11 +121,13 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
>  {
>         struct cgroup *cgrp;
>
> -       if (uses_cgroup_v1)
> -               cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
> -       else
> -               cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
> +       if (!uses_cgroup_v1)
> +               return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
> +
> +       if (perf_subsys_id == -1)
> +               perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);

Should the "#if __has_builtin(__builtin_preserve_enum_value)" test also be here?

It feels a shame that bpf_core_enum_value isn't defined something like:

#if __has_builtin(__builtin_preserve_enum_value)
#define bpf_core_enum_value(enum_type, enum_value) \
__builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value,
BPF_ENUMVAL_VALUE)
#else
#define bpf_core_enum_value(enum_type, enum_value) enum_value
#endif

for backward clang compatibility, but I could see why an error would
be preferable.

Thanks,
Ian

>
> +       cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
>         return BPF_CORE_READ(cgrp, kn, id);
>  }
>
> --
> 2.37.3.998.g577e59143f-goog
>
