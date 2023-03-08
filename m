Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35C16AFC76
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCHBld convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 20:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHBlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:41:32 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328CA17EE;
        Tue,  7 Mar 2023 17:41:31 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id v13so13348344ybu.0;
        Tue, 07 Mar 2023 17:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678239691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TppUL57H0OWtGYAgk5sVPvgNVPqvGJNjviqBBu28EEw=;
        b=FwkqQX6z1NI+yr5R+LWFynwuoCR4oMoelP1FnLy+1gYyczHIgwpiNUi3jI/g/5ny4b
         68flz9YAY55vb8cA3jBjbfLcp0VxVxLDxM4rR3qpbjl46xnRo6Llu5L3M4/PdrgS/rV8
         GVABnNYMorKoQy4gj7WsKgMMdFFzQ4lNjXS5XS6ndVEVfgq1UJoNd8tq+nAiSv34Bav6
         DsV/jbVMxY7GfPanmGOMUQpAew8V22AL8JMP9iE79/IWqiRJyHmRivHOLlPeP57VfUBd
         FHx7YaHU2GUTqWZo/aSDe90WNlgpAvdiWZwzjVKarRLZTNnPOUFaHNhuAeifDmbrjJqM
         2uXA==
X-Gm-Message-State: AO0yUKVHdvB4vOfshUoaJ1AndT61MFilC4RRirpRKSymCVyZIxneW88k
        jfyJc1H9T7eMXlOAnrqXojjX1B26+uVQ/ppFyFM=
X-Google-Smtp-Source: AK7set+Q6VggA+AbQUocaBGV7QKqq/nDBfJowhUBW2747W0DPy1t9DC7OJ0knURikkdpl5fNwDsi32GXFz0gJWqaCiI=
X-Received: by 2002:a25:8b8f:0:b0:906:307b:1449 with SMTP id
 j15-20020a258b8f000000b00906307b1449mr9919126ybl.5.1678239690961; Tue, 07 Mar
 2023 17:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20230308003020.3653271-1-irogers@google.com>
In-Reply-To: <20230308003020.3653271-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Mar 2023 17:41:19 -0800
Message-ID: <CAM9d7ciyGagEiM6zSVjh9VpsiShLeRBUFjfGGLrzoqTD+hT9KA@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Fix builtin detection
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 4:30 PM Ian Rogers <irogers@google.com> wrote:
>
> __has_builtin was passed the macro rather than the actual builtin
> feature. The builtin test isn't sufficient and a clang version test
> also needs to be performed.
>
> Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index e6007eaeda1a..141b36d13b19 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -182,7 +182,13 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
>                 struct mutex *mutex = (void *)lock;
>                 owner = BPF_CORE_READ(mutex, owner.counter);
>         } else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
> -#if __has_builtin(bpf_core_type_matches)
> +       /*
> +        * Support for the BPF_TYPE_MATCHES argument to the
> +        * __builtin_preserve_type_info builtin was added at some point during
> +        * development of clang 15 and it's what is needed for
> +        * bpf_core_type_matches.
> +        */
> +#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
>                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
>                         struct rw_semaphore___old *rwsem = (void *)lock;
>                         owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
